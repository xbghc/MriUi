#include <QObject>
#include <QQmlEngine>

class Scanner: public QObject
{
    Q_OBJECT
    QML_ELEMENT
    QML_SINGLETON
public:
    Scanner(QObject *parent = nullptr);
    Q_INVOKABLE int open();
    Q_INVOKABLE int close();
    Q_INVOKABLE int scan(int id, QString data);
signals:
    void scanned(int id, QString data);
};
