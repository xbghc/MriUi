#include <QObject>
#include <QQmlEngine>
#include <QJsonArray>

class StudyConfig : public QObject
{
    Q_OBJECT
    QML_ELEMENT
    QML_SINGLETON
public:
    Q_INVOKABLE static QJsonArray loadFromJsonFile();
    StudyConfig(QObject *parent = nullptr);
};
