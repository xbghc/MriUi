#include <QObject>
#include <QQmlEngine>
#include <QJsonArray>

class ExamConfig : public QObject
{
    Q_OBJECT
    QML_ELEMENT
    QML_SINGLETON
public:
    Q_INVOKABLE static QJsonArray loadFromJsonFile();
    ExamConfig(QObject *parent = nullptr);
};
