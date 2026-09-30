import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

ApplicationWindow {
    id: root
    visible: true
    width: 1120
    height: 720
    minimumWidth: 860
    minimumHeight: 600
    title: "SenseWatch | Ortam İzleme Paneli"
    color: "#f6f8fb"

    property color navy: "#14213d"
    property color teal: "#00a896"
    property color muted: "#64748b"
    property bool healthy: sensorModel.status === "Sistem sağlıklı"

    component MetricCard: Rectangle {
        required property string label
        required property string value
        required property string unit
        required property string icon
        required property color accent
        Layout.fillWidth: true
        Layout.preferredHeight: 142
        radius: 16
        color: "white"
        border.color: "#e6ebf2"

        Column {
            anchors.fill: parent
            anchors.margins: 18
            spacing: 7
            Text { text: icon; font.pixelSize: 25 }
            Text { text: label; color: root.muted; font.pixelSize: 14; font.weight: Font.DemiBold }
            Row {
                spacing: 5
                Text { text: value; color: root.navy; font.pixelSize: 31; font.weight: Font.Bold }
                Text { text: unit; color: root.muted; font.pixelSize: 14; anchors.baseline: parent.children[0].baseline }
            }
        }
        Rectangle { anchors.left: parent.left; anchors.bottom: parent.bottom; width: parent.width; height: 4; radius: 2; color: accent }
    }

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 32
        spacing: 22

        RowLayout {
            Layout.fillWidth: true
            Text { text: "SenseWatch"; color: root.navy; font.pixelSize: 28; font.weight: Font.Bold }
            Text { text: "Ortam izleme paneli"; color: root.muted; font.pixelSize: 15; Layout.leftMargin: 10; Layout.alignment: Qt.AlignBottom }
            Item { Layout.fillWidth: true }
            Rectangle {
                width: 165; height: 36; radius: 18
                color: root.healthy ? "#dcfce7" : "#fef3c7"
                Text { anchors.centerIn: parent; text: root.healthy ? "●  Sistem sağlıklı" : "●  Dikkat gerekli"; color: root.healthy ? "#15803d" : "#a16207"; font.weight: Font.DemiBold }
            }
        }

        Rectangle {
            Layout.fillWidth: true; Layout.preferredHeight: 112; radius: 16; color: root.navy
            RowLayout {
                anchors.fill: parent; anchors.margins: 24
                ColumnLayout {
                    Text { text: "Laboratuvar A-12"; color: "white"; font.pixelSize: 21; font.weight: Font.Bold }
                    Text { text: "Son güncelleme: " + sensorModel.lastUpdated + "  •  Veri kaynağı: MQTT simülasyonu"; color: "#cbd5e1"; font.pixelSize: 14 }
                }
                Item { Layout.fillWidth: true }
                Button { text: "↻  Yenile"; onClicked: sensorModel.refresh(); palette.buttonText: root.navy }
                Button { text: sensorModel.monitoring ? "İzlemeyi durdur" : "İzlemeyi başlat"; onClicked: sensorModel.toggleMonitoring(); palette.buttonText: root.navy }
            }
        }

        GridLayout {
            Layout.fillWidth: true; columns: width > 920 ? 4 : 2; columnSpacing: 16; rowSpacing: 16
            MetricCard { label: "Sıcaklık"; value: sensorModel.temperature.toFixed(1); unit: "°C"; icon: "🌡"; accent: "#f97316" }
            MetricCard { label: "Nem"; value: sensorModel.humidity; unit: "%"; icon: "💧"; accent: "#0ea5e9" }
            MetricCard { label: "Hava kalitesi"; value: sensorModel.airQuality; unit: "AQI"; icon: "◌"; accent: "#8b5cf6" }
            MetricCard { label: "Karbondioksit"; value: sensorModel.co2; unit: "ppm"; icon: "CO₂"; accent: "#00a896" }
        }

        Rectangle {
            Layout.fillWidth: true; Layout.fillHeight: true; radius: 16; color: "white"; border.color: "#e6ebf2"
            ColumnLayout {
                anchors.fill: parent; anchors.margins: 22; spacing: 12
                Text { text: "Son olaylar"; color: root.navy; font.pixelSize: 18; font.weight: Font.Bold }
                Repeater {
                    model: ["09:42  •  Sensör verisi başarıyla alındı", "09:40  •  Hava kalitesi normal aralıkta", "09:37  •  Otomatik izleme etkin"]
                    delegate: Rectangle {
                        Layout.fillWidth: true; Layout.preferredHeight: 43; radius: 8; color: "#f8fafc"
                        Text { anchors.verticalCenter: parent.verticalCenter; anchors.left: parent.left; anchors.leftMargin: 14; text: modelData; color: root.muted; font.pixelSize: 14 }
                    }
                }
                Item { Layout.fillHeight: true }
                Text { text: "Demo notu: değerler C++ tarafında üretilir; QML yalnızca arayüz ve etkileşimi yönetir."; color: root.muted; font.italic: true }
            }
        }
    }
}
