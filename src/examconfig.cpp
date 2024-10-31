#include <QFile>
#include <QDir>
#include <QJsonDocument>

#include "include/examconfig.h"

QJsonArray ExamConfig::loadFromJsonFile()
{
    QDir configDir("./config");
    if(!configDir.exists()){
        QDir().mkdir("./config");
    }

    QString configPath = "./config/examSequences.json";
    QFile configFile(configPath);
    if(!configFile.exists()){
        QFile defaultFile(":/config/examSequences.json");
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

ExamConfig::ExamConfig(QObject *parent) : QObject(parent) {

}
