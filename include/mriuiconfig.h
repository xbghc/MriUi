#include <QObject>
#include <QQmlEngine>
#include <QJsonObject>
#include <QJsonArray>
#include <QString>

class MriUiConfig : public QObject
{
    Q_OBJECT
    QML_ELEMENT
    QML_SINGLETON
public:
    MriUiConfig(QObject *parent = nullptr);
    // basic io
    Q_INVOKABLE QJsonObject loadJsonObject(QString filepath);
    Q_INVOKABLE QJsonArray loadJsonArray(QString filepath);
    Q_INVOKABLE void saveJsonObject(QString filepath, QJsonObject content);
    Q_INVOKABLE void saveJsonArray(QString filepath, QJsonArray content);

    // study
    Q_INVOKABLE QJsonArray loadStudyConfig();
};