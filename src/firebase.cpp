#include "firebase.h"

#include <QMap>

#include "push/firebaseqtapp.h"
#include "push/firebaseqtmessaging.h"

Firebase::Firebase(QObject *parent)
    : QObject{parent}
{
    auto *firebase = new FirebaseQtApp(this);
    auto *messaging = new FirebaseQtMessaging(firebase);
    connect(messaging, &FirebaseQtMessaging::tokenReceived, this, &Firebase::tokenReceived, Qt::QueuedConnection);
    connect(messaging, &FirebaseQtMessaging::messageReceived, this, &Firebase::messageReceived, Qt::QueuedConnection);

    firebase->initialize();
}

void Firebase::tokenReceived(const QByteArray &token)
{
    m_token = QString::fromLatin1(token);
    emit tokenChanged(m_token);
}

void Firebase::messageReceived(const QMap<QString, QString> &data)
{
    QVariantMap varData;
    for (auto kv = data.begin(); kv != data.end(); ++kv) {
        varData[kv.key()] = kv.value();
    }
    emit newMessage(varData);
}
