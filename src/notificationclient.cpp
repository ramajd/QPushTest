#include "notificationclient.h"

#ifdef Q_OS_ANDROID
#include <QtAndroid>
#endif

NotificationClient::NotificationClient(QObject *parent)
    : QObject{parent}
{
    connect(this, &NotificationClient::notificationChanged,
            this, &NotificationClient::updateAndroidNotification);
}

QString NotificationClient::notification() const
{
    return m_notification;
}

void NotificationClient::setNotification(const QString &newNotification)
{
    if (m_notification == newNotification)
        return;
    m_notification = newNotification;
    emit notificationChanged();
}

void NotificationClient::updateAndroidNotification()
{
#ifdef Q_OS_ANDROID
    QAndroidJniObject jniMessage = QAndroidJniObject::fromString(m_notification);
    QAndroidJniObject::callStaticMethod<void>(
        "io/github/ramajd/pushtest/NotificationClient",
        "notify",
        "(Landroid/content/Context;Ljava/lang/String;)V",
        QtAndroid::androidContext().object(),
        jniMessage.object<jstring>());
#endif
}
