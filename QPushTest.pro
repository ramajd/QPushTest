QT += quick qml quickcontrols2

# You can make your code fail to compile if it uses deprecated APIs.
# In order to do so, uncomment the following line.
#DEFINES += QT_DISABLE_DEPRECATED_BEFORE=0x060000    # disables all the APIs deprecated before Qt 6.0.0

SOURCES += \
    src/firebase.cpp \
    src/main.cpp \
    src/notificationclient.cpp

HEADERS += \
    src/firebase.h \
    src/notificationclient.h

RESOURCES += qml/qml.qrc

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Additional import path used to resolve QML modules just for Qt Quick Designer
QML_DESIGNER_IMPORT_PATH =

# Default rules for deployment.
qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target

ANDROID_PACKAGE_SOURCE_DIR = $$PWD/android

android {
    QT += androidextras

    GOOGLE_FIREBASE_SDK = $$getenv(FIREBASE_CPP_SDK)
    !exists($${GOOGLE_FIREBASE_SDK}):error("FIREBASE_CPP_SDK environment variable is not set!")

    INCLUDEPATH += $${GOOGLE_FIREBASE_SDK}/include
    DEPENDPATH += $${GOOGLE_FIREBASE_SDK}/include

    LIBS += -L$${GOOGLE_FIREBASE_SDK}/libs/android/arm64-v8a/ -lfirebase_app -lfirebase_messaging

    PRE_TARGETDEPS += $${GOOGLE_FIREBASE_SDK}/libs/android/arm64-v8a/libfirebase_app.a
    PRE_TARGETDEPS += $${GOOGLE_FIREBASE_SDK}/libs/android/arm64-v8a/libfirebase_messaging.a

    SOURCES += \
       src/push/firebaseqtabstractmodule.cpp \
       src/push/firebaseqtapp.cpp \
       src/push/firebaseqtmessaging.cpp

    HEADERS += \
        src/push/firebaseqtabstractmodule.h \
        src/push/firebaseqtapp.h \
        src/push/firebaseqtapp_p.h \
        src/push/firebaseqtmessaging.h
}

DISTFILES += $$ANDROID_PACKAGE_SOURCE_DIR/AndroidManifest.xml \
             $$ANDROID_PACKAGE_SOURCE_DIR/build.gradle \
             $$ANDROID_PACKAGE_SOURCE_DIR/gradle.properties \
             $$ANDROID_PACKAGE_SOURCE_DIR/settings.gradle \
             $$ANDROID_PACKAGE_SOURCE_DIR/src/io/github/ramajd/pushtest/NotificationClient.java \
             $$ANDROID_PACKAGE_SOURCE_DIR/google-services.json

