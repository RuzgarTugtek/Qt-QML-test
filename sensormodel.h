#pragma once

#include <QObject>
#include <QTimer>

class SensorModel : public QObject
{
    Q_OBJECT
    Q_PROPERTY(double temperature READ temperature NOTIFY dataChanged)
    Q_PROPERTY(int humidity READ humidity NOTIFY dataChanged)
    Q_PROPERTY(int airQuality READ airQuality NOTIFY dataChanged)
    Q_PROPERTY(int co2 READ co2 NOTIFY dataChanged)
    Q_PROPERTY(QString status READ status NOTIFY dataChanged)
    Q_PROPERTY(QString lastUpdated READ lastUpdated NOTIFY dataChanged)
    Q_PROPERTY(bool monitoring READ monitoring NOTIFY dataChanged)
public:
    explicit SensorModel(QObject *parent = nullptr);

    double temperature() const { return m_temperature; }
    int humidity() const { return m_humidity; }
    int airQuality() const { return m_airQuality; }
    int co2() const { return m_co2; }
    QString status() const;
    QString lastUpdated() const { return m_lastUpdated; }

    Q_INVOKABLE void refresh();
    Q_INVOKABLE void toggleMonitoring();
    bool monitoring() const { return m_timer.isActive(); }

signals:
    void dataChanged();

private:
    void updateValues();
    double m_temperature = 23.6;
    int m_humidity = 48;
    int m_airQuality = 18;
    int m_co2 = 620;
    QString m_lastUpdated;
    QTimer m_timer;
};
