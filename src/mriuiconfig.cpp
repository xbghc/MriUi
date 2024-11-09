#include <QDir>
#include <QFile>
#include <QJsonDocument>

#include "include/mriuiconfig.h"

MriUiConfig::MriUiConfig(QObject *parent) : QObject(parent)
{
}

QJsonArray MriUiConfig::loadJsonArray(QString filepath)
{
    QFile file(filepath);
    file.open(QIODevice::ReadOnly);

    QByteArray data = file.readAll();

    QJsonDocument doc = QJsonDocument::fromJson(data);
    return doc.array();
}

QJsonObject MriUiConfig::loadJsonObject(QString filepath)
{
    QFile file(filepath);
    file.open(QIODevice::ReadOnly);

    QByteArray data = file.readAll();

    QJsonDocument doc = QJsonDocument::fromJson(data);
    return doc.object();
}

void MriUiConfig::saveJsonObject(QString filepath, QJsonObject content)
{
    QJsonDocument doc = QJsonDocument();
    doc.setObject(content);

    QFile file(filepath);
    file.open(QIODevice::WriteOnly);

    file.write(doc.toJson());
}

void MriUiConfig::saveJsonArray(QString filepath, QJsonArray content)
{
    QJsonDocument doc = QJsonDocument();
    doc.setArray(content);

    QFile file(filepath);
    file.open(QIODevice::WriteOnly);

    file.write(doc.toJson());
    
}
