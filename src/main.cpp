#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQuickStyle>
#include <QtQuick>

#include "firebase.h"
#include "notificationclient.h"

int main(int argc, char *argv[])
{
#if QT_VERSION < QT_VERSION_CHECK(6, 0, 0)
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
#endif
    QGuiApplication app(argc, argv);
    QQuickStyle::setStyle("material");

    auto *firebase = new Firebase(&app);
    auto *notificationClient = new NotificationClient(&app);

    QObject::connect(firebase, &Firebase::newMessage, [notificationClient](const QVariantMap &data) {
        notificationClient->setNotification(data["body"].toString());
    });

    QQmlApplicationEngine engine;
    const QUrl url(QStringLiteral("qrc:/main.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
        &app, [url](QObject *obj, const QUrl &objUrl) {
            if (!obj && url == objUrl)
                QCoreApplication::exit(-1);
        }, Qt::QueuedConnection);

    engine.rootContext()->setContextProperty("firebase", firebase);
    engine.rootContext()->setContextProperty("notificationClient", notificationClient);
    engine.load(url);

    return app.exec();
}
