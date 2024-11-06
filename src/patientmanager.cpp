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
