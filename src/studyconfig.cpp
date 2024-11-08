#include <QDir>

#include "include/mriuiconfig.h"

QJsonArray MriUiConfig::loadStudyConfig()
{
    // 确保config文件夹存在
    QDir configDir("./config");
    if (!configDir.exists())
    {
        if (!configDir.mkpath("."))
        {
            qDebug() << "Failed to create configuration directory";
        }
    }

    // 如果配置文件不存在则创建
    QString filePath = "./config/studies.json";
    QFile configFile(filePath);
    if (!configFile.exists())
    {
        QFile::copy(":/config/defaultStudies.json", filePath);
    }

    return loadJsonArray(filePath);
}

int MriUiConfig::createStudyId()
{
    QString path = "./config/id.json";
    QFile configFile(path);
    if (!configFile.exists())
    {
        QFile::copy(":/config/id.json", path);
    }

    QJsonObject config = MriUiConfig::loadJsonObject(path);
    int id = config["nextId"].toInt();

    config["nextId"] = id + 1;
    MriUiConfig::saveJsonObject(path, config);

    return id;
}