#include <QObject>
#include <QQmlEngine>
#include <QJsonArray>

class PatientManager: public QObject
{
    Q_OBJECT
    QML_ELEMENT
    QML_SINGLETON
public:
    PatientManager(QObject* parent=nullptr);
    Q_INVOKABLE QJsonArray loadAllPatients();
    Q_INVOKABLE void newPatient(QJsonObject& patientInfo);
}