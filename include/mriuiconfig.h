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
    // basic json io
    Q_INVOKABLE static QJsonObject loadJsonObject(QString filepath);
    Q_INVOKABLE static QJsonArray loadJsonArray(QString filepath);
    Q_INVOKABLE static void saveJsonObject(QString filepath, QJsonObject content);
    Q_INVOKABLE static void saveJsonArray(QString filepath, QJsonArray content);

    // study
    Q_INVOKABLE QJsonArray loadStudyConfig();
    Q_INVOKABLE int createStudyId();
};