#include <QDir>

#include "include/mriuiconfig.h"
#include "include/patientmanager.h"

PatientManager::PatientManager(QObject *parent) : QObject(parent)
{
}

QJsonArray PatientManager::loadPatients()
{
    // 文件不存在则返回空
    QString path = "./patients/patients.json";
    QFile file(path);
    if (!file.exists())
    {
        return QJsonArray();
    }

    return MriUiConfig::loadJsonArray(path);
}

void PatientManager::savePatients(QJsonArray patients)
{
    // 确保config文件夹存在
    QDir configDir("./patients");
    if (!configDir.exists())
    {
        if (!configDir.mkpath("."))
        {
            qDebug() << "Failed to create configuration directory";
        }
    }

    MriUiConfig::saveJsonArray("./patients/patients.json", patients);
}

bool PatientManager::exists(QJsonObject patient)
{
    QJsonArray patients = loadPatients();
    for (auto p : patients)
    {
        if (p.toObject()["id"] == patient["id"])
        {
            return true;
        }
    }
    return false;
}

int PatientManager::createPatientId()
{
    QString path = "./config/id.json";
    QFile configFile(path);
    if (!configFile.exists())
    {
        QFile::copy(":/config/id.json", path);
        QFile::setPermissions(path, QFileDevice::ReadOwner | QFileDevice::WriteOwner | QFileDevice::ReadUser | QFileDevice::WriteUser);
    }

    QJsonObject config = MriUiConfig::loadJsonObject(path);
    int id = config["nextPatientId"].toInt();

    config["nextPatientId"] = id + 1;
    MriUiConfig::saveJsonObject(path, config);

    return id;
}
