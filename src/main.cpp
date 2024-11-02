#include <QGuiApplication>
#include <QQmlApplicationEngine>

#include <QIcon>
#include <QLocale>
#include <QTranslator>
#include <QQmlEngine>

#include "include/examconfig.h"
#include "include/scanner.h"

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
    QObject::connect(
        &engine,
        &QQmlApplicationEngine::objectCreationFailed,
        &app,
        []() { QCoreApplication::exit(-1); },
        Qt::QueuedConnection);

    // QScopedPointer<Scanner> scanner(new Scanner);
    // QScopedPointer<ExamConfig> examConfig(new ExamConfig);
    // qmlRegisterSingletonInstance("cn.cqu.mri.model", 1, 0, "Scanner", scanner.get());
    // qmlRegisterSingletonInstance("cn.cqu.mri.model", 1, 0, "ExamConfig", examConfig.get());
    
    engine.loadFromModule("cn.cqu.mri", "Main");

    QIcon icon(":/icons/logo");
    app.setWindowIcon(icon);

    return app.exec();
}
