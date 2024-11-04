#include <QFile>
#include <QDir>
#include <QJsonDocument>

#include "include/studyconfig.h"

QJsonArray StudyConfig::loadFromJsonFile()
{
    QDir configDir("./config");
    if(!configDir.exists()){
        QDir().mkdir("./config");
    }

    QString configPath = "./config/defaultStudies.json";
    QFile configFile(configPath);
    if(!configFile.exists()){
        QFile defaultFile(":/config/defaultStudies.json");
        defaultFile.copy(configPath);
    }
    QFile::setPermissions(configPath,
                          QFile::ReadOwner | QFile::WriteOwner |
                              QFile::ReadUser | QFile::WriteUser);

    // maybe need catch error
    configFile.open(QIODevice::ReadOnly);

    QByteArray data = configFile.readAll();
    QJsonDocument doc = QJsonDocument::fromJson(data);
    return doc.array();
}

StudyConfig::StudyConfig(QObject *parent) : QObject(parent) {

}
