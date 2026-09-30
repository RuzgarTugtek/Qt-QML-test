# SenseWatch — Qt/QML ortam izleme paneli

Bu proje, Qt/QML ile UI geliştirmeye temel seviyede aşina olduğunuzu göstermek için hazırlanmış küçük bir masaüstü demonstrasyonudur. Laboratuvar ortamından gelen sıcaklık, nem, hava kalitesi ve CO₂ verilerini izleyen bir paneli canlandırır.

## Neyi gösteriyor?

- **QML:** responsive yerleşim (`RowLayout`, `GridLayout`), yeniden kullanılabilir `MetricCard` bileşeni, veri bağlama ve buton etkileşimleri.
- **C++ / Qt:** `QObject`, `Q_PROPERTY`, signal/slot, `QTimer` ve QML'e context property aktarımı.
- **Tasarım fikri:** donanım/embedded uygulamalarda arayüzün, altyapıdan gelen veriyi gösterim katmanına dönüştürmesi.

Şu an veri kaynağı simülasyondur. Gerçek projede `SensorModel::updateValues()` yerine MQTT, seri port veya REST katmanı eklenebilir; QML ekranı değişmeden kalır.

## Çalıştırma

Gereksinim: Qt 6.5+ (Quick modülü) ve CMake 3.16+.

```powershell
cmake -S . -B build
cmake --build build
.\build\appSensorDashboard.exe
```

## Telefonda kısa anlatım

“Qt/QML'i anlamak için küçük bir ortam izleme paneli yaptım. C++ tarafında `Q_PROPERTY` ile telemetri verisini yayınlıyorum; QML de binding kullanarak ekranı otomatik güncelliyor. Simülasyondaki timer yerine gerçek bir MQTT ya da seri haberleşme katmanı konursa ekran aynı kalacak şekilde tasarladım. Böylece UI ile veri kaynağını ayırmış oldum.”

### Olası takip soruları

**QML neden?** Deklaratif olduğu için arayüzü hızlı kurup veri değişimlerine binding ile doğal tepki vermesini sağlıyor.

**Signal/slot ne işe yarıyor?** C++ nesnesindeki değişiklikleri bağlı katmanlara duyuruyor; burada `dataChanged` QML bindinglerini güncelliyor.

**Gerçek veriye nasıl bağlardın?** Haberleşmeyi ayrı bir C++ servis katmanına alır, veriyi `SensorModel` üzerinden UI'a sunardım. Bağlantı kopması ve son geçerli veri gibi durumları da modelde yönetirdim.
