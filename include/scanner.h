// 以后将这个类拆分为两个，一个面向QML，一个面向外部驱动的接口
#include <QObject>
#include <QJsonObject>
#include <QString>
#include <QQmlEngine>

class Scanner : public QObject
{
    Q_OBJECT
    QML_ELEMENT
    QML_SINGLETON
public:
    Scanner(QObject *parent = nullptr);
    Q_INVOKABLE int open();
    Q_INVOKABLE int close();
    Q_INVOKABLE void scan(int id, QJsonObject study);
    Q_INVOKABLE bool isAvaliable();
    void writeAndWait(std::shared_ptr<unsigned char[]> buf, int length);
    void processResult(unsigned char *header, unsigned char *data, int dataSize);
signals:
    void scanned(int id, QString data); // 获取到返回的结果
private:
    bool status;
};
