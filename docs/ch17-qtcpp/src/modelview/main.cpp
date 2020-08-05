#include <QtGui>
#include <QtQml>

#include "dataentrymodel.h"
#include "roleentrymodel.h"
#include "dynamicentrymodel.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    // register the type DataEntryModel
    // under the url "org.example" in version 1.0
    // under the name "DataEntryModel"
    qmlRegisterType<DataEntryModel>("org.example", 1, 0, "DataEntryModel");
    qmlRegisterType<RoleEntryModel>("org.example", 1, 0, "RoleEntryModel");
    qmlRegisterType<DynamicEntryModel>("org.example", 1, 0, "DynamicEntryModel");
    QQmlApplicationEngine engine;
    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));

    return app.exec();
}
