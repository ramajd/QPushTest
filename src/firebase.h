#ifndef FIREBASE_H
#define FIREBASE_H

#include <QObject>
#include <QVariant>

class Firebase: public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString token MEMBER m_token NOTIFY tokenChanged)
public:
    explicit Firebase(QObject *parent = nullptr);

    void tokenReceived(const QByteArray &token);
    void messageReceived(const QMap<QString, QString> &data);

signals:
    void tokenChanged(const QString &token);
    void newMessage(const QVariantMap &data);

private:
    QString m_token;
};

#endif // FIREBASE_H
