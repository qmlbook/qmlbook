#include <QtGui>
#include <QtQml>

#include "valuemodel.h"
#include "adaptivemodel.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    qmlRegisterType<AdaptiveModel>("org.example", 1, 0, "AdaptiveModel");
    qmlRegisterType<ValueModel>("org.example", 1, 0, "ValueModel");

    QQmlApplicationEngine engine;
    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));

    return app.exec();
}
