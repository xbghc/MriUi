#include <QGuiApplication>
#include <QQmlApplicationEngine>

#include <QIcon>
#include <QLocale>
#include <QTranslator>

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    QTranslator translator;
    const QStringList uiLanguages = QLocale::system().uiLanguages();
    for (const QString &locale : uiLanguages) {
        const QString baseName = "MriUi_" + QLocale(locale).name();
        if (translator.load(":/i18n/" + baseName)) {
            app.installTranslator(&translator);
            break;
        }
    }

    QQmlApplicationEngine engine;
    // const QUrl url(QStringLiteral("qrc:/main.qml"));
    QObject::connect(
        &engine,
        &QQmlApplicationEngine::objectCreationFailed,
        &app,
        []() { QCoreApplication::exit(-1); },
        Qt::QueuedConnection);
    // engine.load(url);
    engine.loadFromModule("MriUi", "Main");
    // engine.load("ui/Main.qml");

    QIcon icon(":/icons/logo");
    app.setWindowIcon(icon);

    return app.exec();
}
