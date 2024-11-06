#include <QObject>
#include <QQmlEngine>
#include <QJsonArray>

class PatientManager : public QObject
{
    Q_OBJECT
    QML_ELEMENT
    QML_SINGLETON
public:
    PatientManager(QObject *parent = nullptr);
    Q_INVOKABLE QJsonArray loadPatients();
    Q_INVOKABLE void savePatients(QJsonArray patients);
};