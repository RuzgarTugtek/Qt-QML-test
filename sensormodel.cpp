#include "sensormodel.h"

#include <QDateTime>
#include <QRandomGenerator>

SensorModel::SensorModel(QObject *parent) : QObject(parent)
{
    connect(&m_timer, &QTimer::timeout, this, &SensorModel::updateValues);
    m_timer.start(2500);
    updateValues();
}

QString SensorModel::status() const
{
    if (m_airQuality > 55 || m_co2 > 1100 || m_temperature > 28.0)
        return "Dikkat gerekli";
    return "Sistem sağlıklı";
}

void SensorModel::refresh()
{
    updateValues();
}

void SensorModel::toggleMonitoring()
{
    if (m_timer.isActive())
        m_timer.stop();
    else
        m_timer.start(2500);
    emit dataChanged();
}

void SensorModel::updateValues()
{
    auto *random = QRandomGenerator::global();
    m_temperature = 22.0 + random->bounded(70) / 10.0;
    m_humidity = 38 + random->bounded(25);
    m_airQuality = 10 + random->bounded(55);
    m_co2 = 480 + random->bounded(750);
    m_lastUpdated = QDateTime::currentDateTime().toString("HH:mm:ss");
    emit dataChanged();
}
