#include "include/scanner.h"
#include "include/mriuiconfig.h"

#include "include/fakedevice.h"

#include <QtConcurrent/QtConcurrent>
#include <memory>

namespace
{
    int getSeqCode(QString seqName)
    {
        QJsonObject seqCodeMap = MriUiConfig::loadJsonObject(":/config/seqCodeMap.json");

        return seqCodeMap[seqName.toLower()].toString().toInt(nullptr, 16);
    }

    int calcBufSize(QJsonObject study)
    {
        int code = getSeqCode(study["seq"].toString());
        int size;
        switch (code)
        {
        case 0x01: // stop
            size = 1;
            break;
        case 0x02: // tune
            size = 1;
            break;
        case 0x03: // rfopt
            size = 1;
            break;
        case 0x04: // shim
            size = 1;
            break;
        case 0x05: // t1
            size = 1;
            break;
        case 0x06: // t2
            size = 16 + 32 + 24 * study["noSlices"].toInt();
            break;
        default:
            size = 1;
            break;
        }

        return size;
    }

    void _memcpy(std::shared_ptr<unsigned char[]> dst, int offset, int v)
    {
        memcpy(dst.get() + offset, &v, 4);
    }

    void _memcpy(std::shared_ptr<unsigned char[]> dst, int offset, double v)
    {
        float floatV = static_cast<float>(v);
        memcpy(dst.get() + offset, &floatV, 4);
    }

    std::shared_ptr<unsigned char[]> encode(QJsonObject study)
    {
        int size = calcBufSize(study);

        auto buf = std::make_shared<unsigned char[]>(size);

        buf[0] = 'N';
        buf[1] = 'M';
        buf[2] = 'R';
        buf[3] = 1; // 版本号

        int i = 1;
        memcpy(buf.get() + 4, &i, 4);

        buf[8] = 0;
        buf[9] = 0;
        buf[10] = getSeqCode(study["seq"].toString());
        buf[11] = 1;

        _memcpy(buf, 12, size - 16);
        _memcpy(buf, 16, study["observeFrequency"].toDouble());
        _memcpy(buf, 20, study["noSamples"].toInt());
        _memcpy(buf, 24, study["noViews"].toInt());
        _memcpy(buf, 28, study["viewsPerSegment"].toInt());
        _memcpy(buf, 32, study["noAverages"].toInt());
        _memcpy(buf, 36, study["sliceThickness"].toInt());
        _memcpy(buf, 40, study["fov"].toInt());

        int noSlices = study["noSlices"].toInt();
        _memcpy(buf, 44, noSlices);

        QJsonArray slices = study["slices"].toArray();
        for (int i = 0; i < noSlices; i++)
        {
            QJsonObject sli = slices[i].toObject();
            _memcpy(buf, 24 * i + 48, sli["xAngle"].toDouble());
            _memcpy(buf, 24 * i + 52, sli["yAngle"].toDouble());
            _memcpy(buf, 24 * i + 56, sli["zAngle"].toDouble());
            _memcpy(buf, 24 * i + 60, sli["xOffset"].toDouble());
            _memcpy(buf, 24 * i + 64, sli["yOffset"].toDouble());
            _memcpy(buf, 24 * i + 68, sli["zOffset"].toDouble());
        }
        return buf;
    }

} // namespace

Scanner::Scanner(QObject *parent) : QObject(parent), status(false)
{
}

int Scanner::open()
{
    auto i = FakeDevice::open();
    status = (i == 0);
    return i;
}

int Scanner::close()
{
    return FakeDevice::close();
}

void Scanner::scan(int id, QJsonObject study)
{
    auto buf = encode(study);
    int size = calcBufSize(study);

    QFuture<void> future = QtConcurrent::run([this, buf, size]()
                                             { this->writeAndWait(buf, size); });
}

bool Scanner::isAvaliable()
{
    return status;
}

void Scanner::writeAndWait(std::shared_ptr<unsigned char[]> buf, int length)
{
    if (FakeDevice::write(buf.get(), length) != length)
    {
        qDebug() << "write error";
    };

    auto header = std::make_shared<unsigned char[]>(16);
    FakeDevice::read(header.get(), 16);

    int id;
    memcpy(&id, header.get() + 4, 4);

    int dataSize;
    memcpy(&dataSize, header.get() + 12, 4);

    auto data = std::make_shared<unsigned char[]>(dataSize);
    FakeDevice::read(data.get(), dataSize);

    processResult(header.get(), data.get(), dataSize);
}

void Scanner::processResult(unsigned char *header, unsigned char *data, int dataSize)
{

    emit scanned(1, "hello");
}