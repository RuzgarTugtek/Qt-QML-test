#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>

#include "sensormodel.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);
    QQmlApplicationEngine engine;

    SensorModel sensorModel;
    engine.rootContext()->setContextProperty("sensorModel", &sensorModel);
    engine.loadFromModule("SensorDashboard", "Main");

    if (engine.rootObjects().isEmpty())
        return -1;
    return app.exec();
}
