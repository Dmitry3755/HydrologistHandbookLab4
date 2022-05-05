#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include "riverlistsql.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;
    QQmlContext *context = engine.rootContext();

    RiverListSql viewModel(&app);
    context->setContextObject(&viewModel);

    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));

    return app.exec();
}

//#if QT_VERSION < QT_VERSION_CHECK(6, 0, 0)
//    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
//#endif
/* const QUrl url(QStringLiteral("qrc:/main.qml"));
 QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                  &app, [url](QObject *obj, const QUrl &objUrl) {
     if (!obj && url == objUrl)
         QCoreApplication::exit(-1);
 }, Qt::QueuedConnection);
 engine.load(url); */
