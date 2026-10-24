# CLAUDE.md — Coffee Empire (Idle Coffee Simulator)

Bu dosya projenin tek doğruluk kaynağıdır. Her oturumun başında tamamını oku. Burada yazmayan bir şeyi icat etme; belirsizlik varsa "12. Belirsizlik Kuralı" bölümünü uygula.

---

## 1. PROJE ÖZETİ

- Flutter + Flame ile iOS ve Android için tek kod tabanlı, piksel sanat görünümlü kafe işletme oyunu (aktif servis + idle ekonomi).
- Tema: Sokakta bir kahve arabasından başlayıp global franchise imparatorluğuna ulaşmak. Oyuncu kendi amiral gemisi kafesini (flagship) görür, düzenler ve müşterilere bizzat servis yapar; diğer dükkanlar arka planda pasif gelir üretir.
- Görsel dosya (PNG, JPG, SVG, GIF, 3D model) YOK. Piksel sanat kodla üretilir: sprite'lar `assets/sprites/*.json` içinde metin tabanlı piksel ızgaraları olarak tanımlanır ve açılışta `ui.Image`'a çizilip önbelleğe alınır (bölüm 21). Menüler ve paneller Flutter widget'ı + `CustomPainter`. İzinli asset'ler: `assets/config/*.json`, `assets/sprites/*.json`, `lib/l10n/*.arb`.
- Diller: 15 dil (bölüm 19). Faz 1–6 boyunca sadece `en` ve `tr` yazılır; kalan 13 dil Faz 7'de eklenir. Varsayılan dil: cihaz dili, desteklenmiyorsa `en`.
- Para birimi sembolü: `$`.

### Kapsam İÇİ
1. Kahve dükkanları (10 kademe), yöneticiler, ekipman yükseltmeleri
2. Barista servisi: piksel kafede müşterilere sipariş alma, kahve hazırlama (fincan dolumu), teslim + kombo (bölüm 22)
3. Ar-Ge Laboratuvarı (reçete geliştirme) ve Kapsül Makinesi pasif geliri
4. Franchise (30 gerçek şehir, şehir başına 1–5 franchise yuvası) ve Prestij (Golden Bean)
5. Offline kazanç, otomatik kayıt, kayıt versiyonlama
6. Mock monetizasyon (ödüllü reklam + IAP), günlük ödül, yerel bildirimler
7. Tutorial, başarımlar, haptic, ses altyapısı, analitik altyapısı (mock)
8. Kodla çizilen piksel sanat ve Flame kafe sahnesi (bölüm 21)
9. Kafe özelleştirme: ızgaraya mobilya yerleştirme, tema/renk/zemin, görünür ekipman yükseltmesi, barista kıyafeti (bölüm 23)
10. Oyun hissi (game feel): uçan sayılar, yaylanan butonlar, yetersiz nakit geri bildirimi, piksel dükkan haritası (bölüm 14.1)

### Kapsam DIŞI — BUNLARI ASLA YAZMA
- Çekirdek borsası, fiyat grafikleri, al-sat, çekirdek stoğu
- Tarla, kavurma fabrikası, paketleme fabrikası
- Haber motoru, iklim olayları
- Dükkanların hammadde tüketmesi (satış hızı sadece seviye ve çarpanlara bağlıdır)
- Backend, hesap sistemi, bulut kayıt, çok oyunculu özellikler
- Gerçek AdMob / IAP / Firebase entegrasyonu (sadece arayüz + mock)
- Her dükkan için ayrı düzenlenebilir sahne (sadece flagship kafe düzenlenir), çok katlı kafe, serbest dolaşan oyuncu karakteri, NPC diyalogları, başka oyuncuların kafesini ziyaret
- Harici sprite/görsel dosyası, Aseprite/PNG içe aktarma

---

## 2. ÇALIŞMA PROTOKOLÜ (HER FAZ İÇİN AYNI)

Sırayla uygula:

1. Bu dosyayı oku. Sadece istenen fazı yap. Sonraki fazın dosyalarına dokunma.
2. Kod yazmadan önce oluşturacağın/değiştireceğin dosyaları en fazla 10 satırlık liste olarak yaz.
3. Kodu yaz.
4. Sırayla çalıştır ve hepsi temiz geçmeden bitti deme:
   - `dart format .`
   - `flutter analyze` → 0 hata, 0 uyarı, 0 info
   - `flutter test` → hepsi yeşil
5. Faz kabul kriterlerini (bölüm 15) tek tek kontrol et.
6. `git add -A && git commit -m "<faz mesajı>"` yap.
7. Rapor ver (en fazla 10 satır): yapılanlar, çalıştırılan komutların sonucu, varsayımlar (en fazla 3, "Varsayım:" ile başlayan).
8. DUR. Kullanıcı "Devam et" yazana kadar sonraki faza geçme.

Kesin yasaklar:
- Faz dışı refactor yapma.
- Bu dosyada olmayan paket ekleme (gerekirse dur ve sor).
- Çalışan testi silerek veya gevşeterek yeşil yapma.
- Hata alırsan `// ignore` ile bastırma; kök nedeni düzelt.
- Birden fazla faz üst üste yapma.

---

## 3. KOD STİLİ VE YORUM KURALI

- Kod yorumu yazma. Doc comment (`///`) yazma. `TODO` yazma.
- Tek istisna: açık olmayan bir algoritmada en fazla 1 satırlık `//` açıklaması. Dosya başına en fazla 2 tane.
- Adlandırma kendini açıklamalı olmalı. Yorum yerine daha iyi isim kullan.
- Tüm kullanıcıya görünen metinler ARB dosyalarından gelir. Dart dosyasında sabit kullanıcı metni YOK.
- Her dosya tek sorumluluk taşır, 300 satırı geçmez. Geçerse böl.
- `dynamic` ve `!` (bang) operatörü minimum; `as` cast sadece JSON ayrıştırmada.
- Modeller `Equatable` + `copyWith` + elle yazılmış `toJson/fromJson`. `build_runner`, `freezed`, `json_serializable` KULLANMA.
- Dependency injection: `get_it` yok. `main.dart` içinde constructor injection + `RepositoryProvider`/`BlocProvider`.
- Dart 3 özellikleri (sealed class, switch expression, records) kullanılabilir.
- `analysis_options.yaml`: `flutter_lints` dahil et, `prefer_const_constructors`, `avoid_print`, `always_declare_return_types` aç.
- Ekran yönü: sadece dikey (portrait).

---

## 4. PAKETLER

`pubspec.yaml`'a elle sürüm yazma. `flutter pub add` ile güncel uyumlu sürümü ekle.

Çalışma zamanı:
`flutter_bloc`, `equatable`, `intl`, `shared_preferences`, `uuid`, `fl_chart` (sadece Ar-Ge radar grafiği için), `lucide_icons_flutter`, `flutter_local_notifications`, `flutter_localizations` (SDK)

FAZ 8 ve sonrası çalışma zamanı ek: `flame` (kafe sahnesi, sprite animasyonu, kamera, dokunma).

Geliştirme:
`bloc_test`, `mocktail`, `flutter_lints`; FAZ 8 ve sonrası ek: `flame_test`

Kullanma: `hive`, `lucide_icons` (eski), `get_it`, `freezed`, `provider`, `riverpod`, `google_fonts` (internet gerektirir; sistem fontu kullan), `flame_bloc`, `flame_tiled`, `flame_forge2d`, `flutter_animate`, `lottie`, `rive`. Cubit ile Flame arasındaki köprü elle yazılır (bölüm 21.4).

`pubspec.yaml` içinde `flutter: generate: true` ve `assets: - assets/config/` tanımla; FAZ 8'de `- assets/sprites/` eklenir. `l10n.yaml` oluştur (`arb-dir: lib/l10n`, `template-arb-file: app_en.arb`).

---

## 5. KLASÖR YAPISI (BİREBİR UYGULA)

```
lib/
  main.dart
  app/
    app.dart
    theme/
      app_colors.dart
      app_theme.dart
    widgets/                      (FAZ 12)
      game_background.dart
      bouncy_button.dart
      floating_text_layer.dart
      insufficient_funds_flash.dart
  pixel/                          (FAZ 8 — Flutter'a bağlı, Flame'e bağlı değil)
    sprite_definition.dart
    sprite_definition_parser.dart
    palette_set.dart
    sprite_rasterizer.dart
    sprite_atlas.dart
  cafe/                           (FAZ 9+ — Flame dünyası)
    cafe_game.dart
    cafe_bridge.dart
    camera_fit.dart
    world/
      floor_layer.dart
      furniture_component.dart
      machine_component.dart
    actors/
      customer_component.dart
      barista_component.dart
      order_bubble.dart
    edit/                         (FAZ 10)
      edit_mode_controller.dart
      placement_ghost.dart
  core/
    bignumber/
      big_number.dart
    format/
      number_formatter.dart
      duration_formatter.dart
    time/
      clock.dart
    services/
      haptic_service.dart
      sound_service.dart
      analytics_service.dart
      monetization_service.dart
      notification_service.dart
      consent_service.dart
  config/
    economy_config.dart
    economy_config_loader.dart
  engine/
    economy_engine.dart
    shop_math.dart
    lab_math.dart
    prestige_math.dart
    franchise_math.dart
    offline_math.dart
    service_math.dart             (FAZ 9)
    customer_flow.dart            (FAZ 9)
    grid_pathfinding.dart         (FAZ 9)
    layout_rules.dart             (FAZ 10)
    appeal_math.dart              (FAZ 10)
  features/
    game/
      game_state.dart
      game_cubit.dart
      game_tick_service.dart
      save_repository.dart
      save_migrations.dart
    home/
      home_screen.dart
      widgets/
        cash_header.dart
        coffee_cup_painter.dart       (FAZ 9'da brew paneline taşınır)
        barista_tap_area.dart         (FAZ 9'da kafe sahnesiyle değişir)
        bottom_nav.dart
    cafe_hud/                     (FAZ 9)
      brew_panel.dart
      service_hud.dart
    customize/                    (FAZ 10–11)
      furniture_catalog_sheet.dart
      theme_picker.dart
      outfit_picker.dart
    shops/
      widgets/                    (FAZ 12)
        shop_progress_path.dart
        shop_station.dart
        progress_road_painter.dart
    lab/
    growth/
    store/
    daily_reward/
    achievements/
    tutorial/
    settings/
  l10n/
    app_<dilkodu>.arb   (bölüm 19)
assets/
  config/
    economy.json
    achievements.json
    furniture.json                (FAZ 10)
    cosmetics.json                (FAZ 11)
  sprites/                        (FAZ 8)
    palettes.json
    tiles.json
    furniture.json
    machines.json
    characters.json
    ui_icons.json
test/
  core/
  engine/
  features/
tool/
  simulate.dart
```

Kurallar:
- `engine/` içinde Flutter ve Flame importu YOK. Saf Dart. Tüm oyun matematiği (servis ödemesi, müşteri akışı, yol bulma, yerleşim kuralları, çekicilik) burada, tamamı unit testli.
- `cafe/` sadece görselleştirme ve girdi: hesap yapmaz, `engine/`'i ve `GameCubit`'i çağırır.
- `features/*` UI ve Cubit içerir. Matematik içermez; `engine/`'i çağırır.
- Feature klasörleri kullanılana kadar boş bırakılır; fazı gelmeden dosya açma.

---

## 6. BÜYÜK SAYI: BigNumber

Tüm para, gelir, maliyet ve çarpan değerleri `BigNumber` olur. `double` sadece UI animasyonlarında ve 0–1 oranlarda kullanılır.

Gereksinimler (`core/bignumber/big_number.dart`):
- Alanlar: `double mantissa` (1 ≤ |m| < 10 veya 0), `int exponent`. Değişmez (immutable), `Equatable`.
- Fabrikalar: `BigNumber.zero`, `BigNumber.one`, `BigNumber.fromDouble`, `BigNumber.fromInt`, `BigNumber.parse("1.5e12")`.
- Operatörler: `+`, `-`, `*`, `/`, `compareTo`, `<`, `>`, `<=`, `>=`, `==`.
- Metotlar: `pow(double)`, `sqrt()`, `log10()`, `floor()`, `toDouble()` (taşarsa `double.infinity`), `isZero`, `isNegative`, `min`, `max`, `clampMin(BigNumber)`.
- Seri hale getirme: `toJson()` → `"1.5e12"` biçiminde String; `fromJson` aynısını okur.
- Negatif sonuç oyunda hiç oluşmamalı; çıkarmada sonuç 0'ın altına düşerse hata fırlatma, çağıran taraf önce `>=` kontrolü yapar.
- Test (zorunlu): toplama farklı üslerde, çıkarma, çarpma, bölme, pow, sqrt, log10, karşılaştırma, parse/toJson gidiş-dönüş, 1e300 üstü değerler, sıfır kenar durumları.

### NumberFormatter
- `< 1000`: iki ondalık değil, en fazla 2 ondalık, gereksiz sıfırları at (`12.5`, `999`).
- Ekler: `K, M, B, T, Qa, Qi, Sx, Sp, Oc, No, Dc`; sonrası `aa, ab, ac ... az, ba ...`.
- Örnekler: `$1.25K`, `$4.50M`, `$12.4B`. Üç anlamlı hane göster.
- Bilimsel gösterim opsiyonu ayarlarda (`1.25e15`), varsayılan kapalı.
- Rakamlar HER dilde Latin rakamlarıdır (0-9). Ekler (K, M, B...) HER dilde Latin harfidir. `intl` `NumberFormat` KULLANMA; metni elle kur.
- Ondalık ayracı dile göre: virgül → `tr, es, pt, fr, de, it, ru, id, vi`; nokta → `en, hi, ja, ko, zh, ar`. Tablo `core/format/decimal_separators.dart` içinde.
- Para metni (`$1,25K`) RTL dilde de soldan sağa gösterilir (`TextDirection.ltr`).
- Süre formatı: `DurationFormatter` → `1g 4sa`, `12dk 30sn` (tr), `1d 4h`, `12m 30s` (en); birimler ARB'den.

---

## 7. OYUN DÖNGÜSÜ

- `GameTickService`: `Timer.periodic(Duration(seconds: 1))`. Her tick'te `Clock.now()` ile gerçek geçen süreyi hesapla: `delta = now - lastTickAt`. `delta` saniye cinsinden `GameCubit.tick(delta)`'ya gider.
- `delta` negatifse (cihaz saati geri alınmış) 0 kabul et. `delta > 10 sn` ise bu bir arka plan boşluğudur: normal tick yerine offline hesaplamaya yönlendir.
- `AppLifecycleListener` kullan:
  - `paused/inactive/detached` → tick'i durdur, kaydet, bildirimleri planla.
  - `resumed` → geçen süreyi hesapla; 60 sn üstündeyse offline kazanç modalı göster; tick'i başlat.
- Cubit her tick'te state yayar (saniyede 1). UI'da `BlocSelector`/`buildWhen` kullan; sadece değişen widget yeniden çizilsin. Fincan animasyonu kendi `AnimationController`'ında çalışır, Cubit'e bağlı değildir.
- `Clock` soyutlaması (`core/time/clock.dart`): `SystemClock` ve testte `FakeClock`. `DateTime.now()` doğrudan çağrılmaz.

---

## 8. EKONOMİ (config'ten okunur, kodda sabit sayı YOK)

Tüm sayılar `assets/config/economy.json` içinde. `EconomyConfigLoader` bunu açılışta okur, `EconomyConfig` nesnesine çevirir. Ayar değişikliği için kod değil JSON değişir.

### 8.1 Formüller (`engine/` içinde uygulanır)

```
r              = shop.growth                                   // varsayılan 1.15
costOfNext(L)  = baseCost * r^L
costOfN(L, n)  = baseCost * r^L * (r^n - 1) / (r - 1)
maxAffordable  = floor( log( cash*(r-1)/(baseCost*r^L) + 1 ) / log(r) )

shopIncomePerSec = baseIncome * level
                   * milestoneMult(level)
                   * (manager ? managerMult : 1)
                   * equipmentMult

shopsSum    = Σ shopIncomePerSec
capsuleSum  = capsuleMachines * machineIncome * (1 + capsuleBonus)
royaltySum  = Σ_şehir( owned * royaltyShare(şehir) * completionMult(şehir) ) * shopsSum

globalMult  = (1 + goldenBeans * beanBonus)
              * (1 + achievementCount * achievementBonus)
              * labBonusMult
              * boostMult
              * vipMult
              * starterPackMult
              * appealMult                                  // FAZ 10, bölüm 23.2; öncesinde 1

totalIncomePerSec = (shopsSum + capsuleSum + royaltySum) * globalMult
```

- `milestoneMult(level)`: seviye 25, 50, 100, 200, 300, 400'e ulaşıldıkça her biri için ×2 (birikimli).
- `labBonusMult` ve `capsuleBonus`: bölüm 10'da.
- Her tick: `cash += totalIncomePerSec * delta`, `runEarnings += aynı`, `lifetimeEarnings += aynı`.
- Maliyet büyüme oranı, çarpanlar ve tüm sabitler `economy.json`'dan; formüller `engine/shop_math.dart` içinde.

### 8.2 Başlangıç değerleri (ilk taslak; simülasyonla ayarlanacak)

| # | Dükkan (id)           | baseCost | baseIncome/sn (seviye 1) | growth |
|---|------------------------|----------|---------------------------|--------|
| 1 | street_cart            | 4        | 0.5                       | 1.07   |
| 2 | corner_booth           | 60       | 4                         | 1.15   |
| 3 | boutique_cafe          | 720      | 30                        | 1.15   |
| 4 | campus_coworking       | 8.64e3   | 220                       | 1.15   |
| 5 | drive_thru             | 1.04e5   | 1.6e3                     | 1.15   |
| 6 | city_roastery          | 1.24e6   | 1.2e4                     | 1.15   |
| 7 | airport_lounge         | 1.49e7   | 9e4                       | 1.15   |
| 8 | robotic_kiosk          | 1.79e8   | 6.5e5                     | 1.15   |
| 9 | capsule_store          | 2.15e9   | 4.8e6                     | 1.15   |
| 10| global_mega_roastery   | 2.58e10  | 3.5e7                     | 1.15   |

- Başlangıç nakdi: `$5`. Oyun açılışında 1. dükkan seviye 0'dır.
- Yönetici maliyeti: dükkanın `baseCost * 50`; etkisi: o dükkan geliri ×3 (`managerMult`).
- Ekipman: her dükkan için 3 seviye. Maliyetler `baseCost * 100`, `* 1000`, `* 10000`; her biri o dükkan gelirini ×2 yapar (`equipmentMult` = 2^satın alınan sayısı). Ekipman adları ARB'den (örn. espresso makinesi, elmas değirmen, akıllı sistem).
- Dükkan açma kuralı: bir önceki dükkan en az seviye 1 olmalı.

### 8.3 Tıklama (Barista Hustle)

- Her dokunuş fincan doluluğunu `tapFillStep` kadar artırır (varsayılan 0.10). Fincan 1.0 olunca doldu sayılır: ödeme = `tapPayoutSeconds * totalIncomePerSec` (varsayılan 10 sn'lik gelir, en az `$1`).
- Kombo: son dolumdan sonra `comboWindowSeconds` (5 sn) içinde yeni fincan doldurulursa kombo +1; süre aşılırsa 0.
- Kombo 5 olunca "Barista Rush" başlar: `rushDurationSeconds` (15 sn) boyunca dolum adımı ve ödeme ×2.
- Otomatik tıklayıcı (VIP): saniyede `autoTapPerSecond` dokunuş yapar; kombo/rush tetiklemez.
- FAZ 9'dan itibaren: tek başına fincana dokunma kalkar. Fincan dolumu her siparişin hazırlama adımı olur, ödeme müşteriye teslimde alınır; kombo ve Rush servis üzerinden işler (bölüm 22). VIP otomatik tıklayıcı → "VIP barista" (otomatik servis yapan altın kıyafetli barista).

### 8.4 Hedef ilerleme (simülasyon bu aralıkları tutturmalı, ±%30)

Pasif oyuncu = sadece en ucuz yükseltmeyi alan açgözlü bot, tıklama yok, offline sayılmaz.

| Hedef                       | Süre       |
|-----------------------------|-----------|
| 2. dükkan satın alınır      | ≤ 1 dk     |
| 3. dükkan                   | ≤ 4 dk     |
| 4. dükkan                   | ≤ 12 dk    |
| 5. dükkan                   | ≤ 35 dk    |
| 6. dükkan                   | ≤ 2 saat   |
| 7. dükkan                   | ≤ 6 saat   |
| 8. dükkan                   | ≤ 24 saat  |
| 9. dükkan                   | ≤ 48 saat  |
| 10. dükkan                  | ≤ 96 saat  |
| İlk prestij mümkün          | ~ 2. gün   |

`tool/simulate.dart`: `engine/` fonksiyonlarını kullanarak yukarıdaki botu çalıştırır, her dükkanın ilk satın alma anını yazdırır. Süreler hedefin dışındaysa `economy.json`'ı değiştir, kodu değil.

---

## 9. KAYIT SİSTEMİ

- Depo: `shared_preferences`, anahtar `save_current`, yedek anahtar `save_backup`. Değer: JSON String.
- Şema: kökte `schemaVersion` (int, ilk sürüm 1), `savedAt` (ISO8601 UTC), sonra oyun verisi.
- Yazma sırası: önce mevcut `save_current` değerini `save_backup`'a kopyala, sonra yeni değeri yaz.
- Okuma: `save_current` bozuksa (`FormatException` vb.) `save_backup`'ı dene; ikisi de bozuksa yeni oyun başlat ve analitiğe `save_corrupt` olayı gönder.
- `save_migrations.dart`: `Map<int, Map<String,dynamic> Function(Map<String,dynamic>)>`; bir sürümden diğerine zincirleme göç. Her yeni alan için göç yaz. Test: v1 örnek JSON'u en güncel sürüme göç ettir.
- Otomatik kayıt: her 15 sn'de bir, ayrıca her satın alma, prestij, IAP, uygulama `paused` olayında.
- Kayıt edilecek alanlar:
  `cash, runEarnings, lifetimeEarnings, goldenBeans, prestigeCount, shopLevels{id:int}, managers{id:bool}, equipment{id:int}, recipes{id:{bestScore,unlocked}}, activeBrew{recipeId,endsAt,sliders}?, capsuleMachines, franchises{cityId:int}, boosts[{type,endsAt}], achievements[ids], stats{totalTaps,...}, tutorialStep, dailyReward{streak,lastClaimedAt}, settings{locale,sound,haptics,notifications,scientific}, purchases[productIds], rewardedCooldowns{type:endsAt}, savedAt`
- FAZ 9+ ek alanlar (her biri için göç yaz): `stats.ordersServed, stats.perfectServes, stats.customersLost` (FAZ 9); `cafeLayout{roomTier, items[{uid,itemId,x,y,rotation}]}, inventory{itemId:int}` (FAZ 10); `cosmetics{floorId, wallId, signId, lightId, outfits{baristaSlot:outfitId}, unlocked[ids]}` (FAZ 11). Müşteri/kuyruk anlık durumu KAYDEDİLMEZ; açılışta kafe boş başlar.
- BigNumber alanları String olarak yazılır.

### Offline kazanç (`engine/offline_math.dart`)
```
away    = now - savedAt
if away < 60s                      -> modal yok
if away < 0 (saat geri alınmış)    -> kazanç 0
cap     = vip ? 12h : 4h
credited = min(away, cap)
earned   = totalIncomePerSec * credited * offlineEfficiency
```
- `offlineEfficiency` config'ten (varsayılan 1.0). Aktif boost süreleri offline sırasında bitmiş sayılır ve kalan süre hesabına göre çarpana yansıtılır (basitlik için: boost'u offline'da uygulama).
- Açılışta modal: "X sen yokken $Y kazandı", iki buton: "Al" ve "Reklam İzle, 2x Al" (mock rewarded ad). Modal kapanmadan nakit eklenmez.

---

## 10. AR-GE LABORATUVARI

### Reçeteler
- 8 reçete tanımlanır (`economy.json` → `recipes`). Zorluk artar: tolerans düşer, test süresi uzar.
- Her reçetenin gizli hedef profili vardır: `acidity, body, aroma, caffeine` (her biri 0–100 tam sayı). Oyuncu bunları görmez.
- Alanlar: `id, nameKey, unlockCost (BigNumber), target{4 değer}, tolerance, testDurationSeconds, testCostSeconds, maxBonus, isCapsule`.

### Test akışı
1. Oyuncu 4 slider'ı (0–100) ayarlar.
2. "Test Et" → maliyet = `max(testCostFloor, testCostSeconds * totalIncomePerSec)` nakit düşer; `activeBrew` başlar (`testDurationSeconds`).
3. Süre dolunca sonuç: skor + ipucu. Aynı anda tek test çalışır. Test sürerken uygulama kapalı olsa da `endsAt` geçince sonuç hazırdır.
4. "Reklamla Hızlandır" (mock rewarded ad) kalan süreyi bitirir.

### Skor (`engine/lab_math.dart`)
```
d_i       = slider_i - target_i
avgErr    = ortalama(|d_i|)
score     = clamp( round( 100 - max(0, avgErr - tolerance) * 3 ), 0, 100 )
```
- İpucu: en büyük `|d_i|` değerine sahip slider için "çok düşük" veya "çok yüksek" (tolerans içindeyse ipucu "doğru yolda"). Başka slider hakkında bilgi verme.
- `bestScore` her reçete için kalıcıdır; prestijde SIFIRLANMAZ.

### Bonuslar
```
recipeBonus(r)  = r.maxBonus * (r.bestScore / 100)^2
labBonusMult    = 1 + Σ recipeBonus(r)   (isCapsule == false)
capsuleBonus    = Σ recipeBonus(r)       (isCapsule == true)
```
- Reçete UI'ı: 4 slider, `fl_chart` `RadarChart` ile mevcut profil, en iyi skor, son ipucu, geri sayım.

### Kapsül Makinesi (pasif abonelik geliri)
- Açılış koşulu: herhangi bir reçetede `bestScore >= 80` ve `brandHype >= capsuleUnlockHype`.
- Satın alma: `machineBaseCost * 1.12^owned`. Tek tür makine, x1/x10/MAX.
- Gelir bölüm 8.1'deki `capsuleSum`. Prestijde makineler sıfırlanır.

---

## 11. FRANCHISE VE PRESTİJ

### Marka Değeri (Brand Hype)
```
brandHype = floor( 10 * log10(1 + lifetimeEarnings) )
```
Prestijde sıfırlanmaz (lifetime'a bağlı).

### Franchise

Şehirler gerçektir: 30 şehir, toplam 87 franchise yuvası. Her şehirde `slots` kadar franchise verilebilir; oyuncu yuvaları tek tek satın alır. İşletme gideri yoktur, sadece royalty gelir.

`economy.json` → `cities` alanları: `id, countryCode (ISO 3166-1 alpha-2), region, slots, requiredHype, baseCost, royaltyShare`.

| Yuva | royaltyShare (yuva başı) | requiredHype aralığı | Şehirler (id, ülke) |
|------|---------------------------|----------------------|---------------------|
| 5 | 0.010 | 130–150 | `new_york` US, `tokyo` JP, `london` GB, `istanbul` TR, `sao_paulo` BR |
| 4 | 0.008 | 110–130 | `paris` FR, `dubai` AE, `shanghai` CN, `mexico_city` MX, `seoul` KR |
| 3 | 0.006 | 90–110  | `berlin` DE, `madrid` ES, `rome` IT, `toronto` CA, `sydney` AU, `mumbai` IN, `cairo` EG, `jakarta` ID |
| 2 | 0.004 | 70–90   | `amsterdam` NL, `singapore` SG, `bangkok` TH, `buenos_aires` AR, `bogota` CO, `lagos` NG |
| 1 | 0.003 | 50–70   | `vienna` AT, `lisbon` PT, `reykjavik` IS, `addis_ababa` ET, `nairobi` KE, `hanoi` VN |

Bölgeler (`region`): `europe` (istanbul, london, paris, berlin, madrid, rome, amsterdam, vienna, lisbon, reykjavik), `asia_pacific` (tokyo, shanghai, seoul, mumbai, jakarta, sydney, singapore, bangkok, hanoi), `americas` (new_york, sao_paulo, mexico_city, toronto, buenos_aires, bogota), `mea` (dubai, cairo, lagos, addis_ababa, nairobi).

Kurallar (`engine/franchise_math.dart`):
- Şehirde n. franchise (0'dan başlayarak) maliyeti: `baseCost * 1.8^n`.
- Şehir kilidi: `brandHype >= requiredHype`. Aynı aralıktaki şehirlerin `requiredHype` değerleri aralık içinde eşit adımlarla artar.
- `baseCost` yönergesi: `10^(requiredHype/10 - 2)` civarı (şehir açıldığı anda toplam kazancın ~%1'i). Son değeri simülasyonla ayarla.
- Şehirdeki TÜM yuvalar dolunca `completionMult` = 1.5 (config) o şehrin royalty'sine uygulanır; eksikse 1.
- Royalty bölüm 8.1'deki `royaltySum` formülüyle hesaplanır. Tüm yuvalar dolu ve tüm şehirler tamamlandığında toplam royalty ≈ `shopsSum`'ın %90'ı olur; sapma varsa `royaltyShare` değerlerini config'ten ayarla.
- Franchiseler prestijde sıfırlanır.

UI (Büyüme sekmesi, Franchise bölümü):
- Üstte 4 bölge çipi. Liste `requiredHype`'a göre artan sıralı.
- Şehir kartı: bayrak (ülke koduna göre bölgesel gösterge emojisi; asset YOK), şehir adı, ülke adı, yuva noktaları (dolu/boş), sıradaki yuvanın maliyeti, yuva başı royalty, kilitliyse gereken hype.
- Tamamlanan şehir kartı altın kenarlıklı.
- Şehir ve ülke adları ARB'den: `city_<id>`, `country_<KOD>`.

### Prestij (Golden Bean)
```
minRunEarnings = prestigeThreshold          // varsayılan 1e10
gain = floor( prestigeScale * sqrt(runEarnings / prestigeThreshold) )   // prestigeScale varsayılan 5
```
- `runEarnings < prestigeThreshold` ise buton pasif.
- Onay diyaloğu: kazanılacak Golden Bean, yeni toplam çarpan (`1 + beans * beanBonus`, `beanBonus` varsayılan 0.02) gösterilir.
- Sıfırlanan: nakit (başlangıç nakdine döner), `runEarnings`, dükkan seviyeleri, yöneticiler, ekipman, kapsül makineleri, franchiseler, aktif boostlar, aktif test.
- Korunan: `goldenBeans`, `prestigeCount`, `lifetimeEarnings`, reçete `bestScore`ları ve açık reçeteler, başarımlar, satın alımlar (IAP), ayarlar, günlük ödül durumu, tutorial durumu, istatistikler, kafe yerleşimi ve envanter (`cafeLayout`, `inventory`), kozmetikler (`cosmetics`).
- Prestijde oda büyüklüğü (`roomTier`) korunur; ekipman görünümü sıfırlanan ekipman seviyesini izler (bölüm 23.3).
- Prestij sonrası otomatik kaydet.

---

## 12. BELİRSİZLİK KURALI

Bir şey bu dosyada yoksa veya çelişkiliyse:
1. En basit çalışan çözümü seç.
2. Sabit sayıysa `economy.json`'a koy.
3. Raporda "Varsayım:" satırı ile belirt.
4. Faz kapsamını genişletme, soru sormak için durma (sadece derleme engelleyen blokajda dur).

---

## 13. MONETİZASYON, GÜNLÜK ÖDÜL, BİLDİRİM, ANALİTİK (hepsi mock)

Tüm servisler `abstract class` + `Mock...` uygulaması. UI sadece soyut arayüzü bilir.

### MonetizationService
```
Future<bool> showRewardedAd(RewardedAdType type)
Future<PurchaseResult> purchase(String productId)
Future<void> restorePurchases()
bool isOwned(String productId)
```
- Mock: reklam için 2 sn'lik bekleme diyaloğu sonra `true`. Satın alma anında başarılı.
- Interstitial reklam YOK. "Reklamsız" sadece zorunlu reklam olmadığını belirtir; ödüllü reklam isteğe bağlı kalır.

### Ödüllü reklamlar (her biri `rewardedCooldownSeconds` bekleme süresine tabi, config)
| Tür             | Ödül |
|-----------------|------|
| `caffeine_rush` | 4 saat boyunca tüm gelir ×2 (aktifken tekrar izlenirse süre eklenir, toplam en çok 8 saat) |
| `offline_double`| Offline kazancı 2x |
| `emergency_fund`| Anında 10 dk'lık gelir kadar nakit (en az `$100`) |
| `lab_speedup`   | Aktif Ar-Ge testini bitirir |

### IAP ürünleri
| Ürün id               | Tür          | Etki |
|-----------------------|--------------|------|
| `master_roaster_vip`  | kalıcı       | `vipMult` = 2, offline cap 12 saat, otomatik tıklayıcı barista |
| `time_skip_24h`       | tüketilebilir| 24 saatlik `totalIncomePerSec` anında eklenir |
| `starter_pack_espresso`| kalıcı, tek seferlik | `starterPackMult` = 1.25 ve 2 saatlik gelir kadar nakit |

- Satın alımlar kayıt dosyasında `purchases` listesinde tutulur. `restorePurchases` bu listeyi mock'ta olduğu gibi bırakır.

### Günlük ödül
- 7 günlük döngü. `lastClaimedAt`'ten bu yana 20 saat geçmişse "alınabilir"; 48 saat geçmişse seri sıfırlanır.
- Ödül = gün başına `seconds` değeri kadar gelir (config, artan). 7. gün ek olarak 1 Golden Bean.
- Cihaz saati geri alınmışsa (`now < lastClaimedAt`) ödül verilmez.

### Bildirimler (`flutter_local_notifications`)
- İzin, tutorial tamamlandığında istenir; açılışta DEĞİL.
- Üç tür: offline cap doldu (uygulama kapanınca `cap` süre sonrasına planla), günlük ödül hazır, Caffeine Rush bitti.
- Uygulama açılınca planlı bildirimleri iptal et ve yeniden planla. Ayarlardan kapatılabilir.

### ConsentService (mock)
- `Future<bool> requestConsent()` döner `true`. Gerçek UMP/ATT sürüm hazırlığı aşamasında eklenecek; arayüz hazır olsun.

### AnalyticsService (mock: sadece debug konsola yazar, `avoid_print` için `debugPrint`)
Olaylar: `tutorial_step(step)`, `tutorial_complete`, `shop_unlocked(id)`, `manager_hired(id)`, `recipe_brewed(id,score)`, `capsule_unlocked`, `franchise_opened(cityId,slotIndex)`, `prestige(count,gain)`, `rewarded_shown(type)`, `rewarded_completed(type)`, `iap_purchase(id)`, `offline_modal(minutes)`, `daily_reward_claimed(day)`, `save_corrupt`, `session_start`.

### Haptic ve Ses
- `HapticService`: tıklama `selectionClick`, fincan dolunca `lightImpact`, satın alma `mediumImpact`, prestij `heavyImpact`, yetersiz nakit (`denied`) `lightImpact`; FAZ 9+: sipariş alma `selectionClick`, teslim `mediumImpact`, müşteri kaçtı `lightImpact`; FAZ 10+: mobilya yerleşti `selectionClick`, geçersiz yerleşim `lightImpact`. Ayarlardan kapatılabilir.
- `SoundService`: soyut arayüz + `NoopSoundService`. Ses dosyası eklenene kadar hiçbir şey çalmaz; çağrı noktaları hazır olsun (`tap`, `cupFull`, `purchase`, `prestige`, `denied`, `orderTaken`, `serve`, `customerLost`, `place`).
- Haptic ve ses YALNIZCA `GameFeedback.play(FeedbackKind, settings)` üzerinden çağrılır. Widget içinde doğrudan `HapticFeedback.*` çağırma; aksi halde ayarlardaki "titreşim kapalı" seçeneği atlanır.

---

## 14. TEMA

Hedef: finans paneli değil, sıcak ve canlı bir piksel sanat kafe oyunu. Ekranın merkezi menüler değil, kafe sahnesidir; menüler sahnenin üstüne açılan piksel çerçeveli panellerdir. (Palet FAZ 12'de UI'a uygulanır; sprite renkleri `assets/sprites/palettes.json`'dan gelir.)

| Rol                     | Hex      |
|-------------------------|----------|
| backgroundTop           | `#1A120B`|
| backgroundBottom        | `#0D0907`|
| surface                 | `#241911`|
| card                    | `#2E2017`|
| cardHighlight           | `#3A2A1E` (kart gradyanının açık ucu) |
| cardBorder              | karamel, `#8B5A2B` (alfa 0.5) |
| primaryGradientStart    | neon turuncu `#FF8A1F`|
| primaryGradientEnd      | altın sarısı `#FFC93C`|
| gold (prestij)          | `#D4AF37`|
| mint (nakit/kâr)        | `#00E676`|
| copper (üretim)         | `#E65100`|
| danger (yetersiz nakit) | `#FF4D4D`|
| lockedShade             | `#0A0705` (alfa 0.7) |
| textPrimary             | `#F5EBDD`|
| textSecondary           | `#B8A894`|
| textOnPrimary           | `#2A1606` (turuncu/altın buton üstündeki metin) |

- Koyu tema tek tema. Arka plan düz renk değil: `GameBackground` ile `backgroundTop → backgroundBottom` dikey gradyan; tüm sekmeler bunun üstünde durur.
- Kartlar yuvarlak köşeli (20), ince karamel kenarlıklı, `card → cardHighlight` hafif `LinearGradient`, yumuşak gölge. Keskin gri/düz kutu yok.
- Birincil aksiyon butonları (satın al, test et, franchise aç, prestij, mağaza) `primaryGradientStart → primaryGradientEnd` gradyanlı, hafif dış parıltılı, `textOnPrimary` metinli.
- Anlam renkleri korunur: mint = nakit/kâr, gold = prestij/tamamlanma, copper = üretim/Rush, danger = sadece hata/yetersiz nakit.
- `coffee_cup_painter.dart`: `CustomPainter` ile fincan, buhar, dolan kahve seviyesi (0–1). Rush modunda bakır parlama.
- Renkler yalnızca `app_colors.dart`'tan; widget içinde hex yazma.
- Renkler yalnızca `app_colors.dart`'tan; widget içinde hex yazma. İSTİSNA: sprite paletleri `assets/sprites/palettes.json` içinde hex olarak durur.
- FAZ 9'dan itibaren ana ekran: üstte ince HUD (kasa, saniyelik gelir, boost, kombo), ortada tam genişlik Flame kafe sahnesi (`GameWidget`), sahne köşesinde "Düzenle" (FAZ 10) ve "Görünüm" (FAZ 11) piksel butonları, altta 5 sekmeli `NavigationBar`: **Kafe, Dükkanlar, Ar-Ge, Büyüme (Franchise + Prestij), Mağaza (VIP + Günlük ödül + Ayarlar)**. Kafe sekmesi varsayılandır; diğer sekmeler sahnenin üstüne tam ekran panel olarak açılır, sahne arkada duraklatılır (müşteri üretimi durur, pasif gelir sürer).
- UI panelleri ve butonlar piksel stilinde: köşeleri basamaklı (2–3 px adım) çerçeve `CustomPainter` ile çizilir, gölgeler yumuşak blur değil 2–4 px'lik sert offset. Yazılar sistem fontu (bölüm 19); piksel font EKLENMEZ.
- Piksel ölçeği her zaman tam sayı (×2, ×3, ×4...), `FilterQuality.none`; bulanık/ölçeklenmiş piksel YOK.

### 14.1 Oyun Hissi (Game Juice) Kuralları

`flame` dışında yeni paket YOK (`flutter_animate`, `lottie`, `rive` vb. kullanma). Flutter tarafında `AnimationController`, `Tween`, `CustomPainter`, `Overlay`/`Stack`; sahne içinde Flame `Effect`'leri (`MoveEffect`, `ScaleEffect`, `OpacityEffect`, `SequenceEffect`).

- **BouncyButton** (`app/widgets/bouncy_button.dart`): basılınca ~0.94 ölçeğe küçülür, bırakınca hafif yaylanarak (`Curves.elasticOut` veya `easeOutBack`) 1.0'a döner (~150–250 ms). Tüm satın alma ve birincil aksiyon butonları bunu kullanır.
- **Yetersiz nakit** (bu kural FAZ 2'deki "yetersiz nakitte buton pasif" kuralının yerine geçer): buton görsel olarak sönük ama BASILABİLİR kalır. Basılınca satın alma YAPILMAZ; buton yatayda hafifçe sallanır (~300 ms), ekran kenarında `InsufficientFundsFlash` ile `danger` renkli ince çerçeve ~300 ms yanıp söner, `FeedbackKind.denied` çalar. Başarılı satın almada kırmızı efekt ASLA çıkmaz.
- **Sahne içi geri bildirim** (FAZ 9): teslimde müşterinin başından piksel madeni paralar fırlar ve HUD'daki kasaya uçar; `+$1.25K` metni yükselip söner (Flame `TextComponent`, sayı `NumberFormatter`, şablon ARB). Mükemmel serviste ekstra "Perfect!" yıldızları; kaçan müşterinin başında kırık kalp ikonu.
- **Uçan sayılar, UI tarafı** (`app/widgets/floating_text_layer.dart`, FAZ 12): Flutter panellerindeki satın almalarda dokunulan noktadan yukarı ~60–80 px süzülüp ~900 ms'de sönen mint renkli `+$1.25K` metni. Sayı `NumberFormatter` ile, metin şablonu ARB'den (`floatingGain` gibi placeholder'lı anahtar). Para metni RTL dilde de `TextDirection.ltr`. Rush sırasında daha büyük ve bakır tonlu. Aynı anda en fazla 8 uçan yazı; fazlası en eskisini siler.
- **Satın alma efekti**: başarılı satın almada butondan kısa bir bakır/altın parıltı veya küçük `+1` seviye yazısı.
- **Kasa sayacı**: başlıktaki nakit değeri her tick'te sıçramaz; eski değerden yeniye kısa (~400 ms) bir sayma animasyonuyla geçer (sadece görsel; state değişmez).
- **Brew paneli** (FAZ 9): mevcut `coffee_cup_painter.dart` yeniden YAZILMAZ; sipariş hazırlanırken açılan `brew_panel.dart` içinde kullanılır. Makineden fincana akan kahve, dalgalı buhar, Rush'ta bakır parıltı.
- **Kamera sarsıntısı**: Rush başlangıcında ve büyük ödemede sahneye 150 ms'lik 2 px'lik hafif sarsıntı (erişilebilirlik kuralına tabi).
- **Erişilebilirlik**: `MediaQuery.disableAnimationsOf(context)` true ise uçan yazılar, sallanma, parıltı ve sayma animasyonları kapalı veya anlık olur; işlev aynı kalır.
- **Performans**: animasyonlar saniyelik Cubit tick'ine bağlı değildir; kendi controller'larında çalışır. Painter'lar `RepaintBoundary` içinde. Saniyelik tick'te harita ve fincan sahnesi gereksiz yeniden çizilmez (`BlocSelector`/`buildWhen`).
- **Dükkan ilerleme haritası** (FAZ 12): Dükkanlar sekmesindeki kart listesi yerine dikey kaydırılan piksel stilinde bir yol/istasyon haritası; her istasyonda o dükkanın küçük piksel sprite'ı (`assets/sprites/` içinden, dükkan başına 1 bina sprite'ı). 1. dükkan (kahve arabası) en üstte, 10. dükkan (mega kavurma tesisi) en altta; istasyonlar `progress_road_painter.dart` ile çizilen kıvrımlı bir yolla birbirine bağlıdır. Yolun açılmış kısmı sıcak/parlak, kilitli kısmı koyu ve kesikli.
  - Açık istasyon: dükkan piksel sprite'ı, ad, seviye, saniyelik gelir, milestone ilerleme halkası, x1/x10/MAX satın alma, yönetici ve 3 ekipman (istasyona dokununca açılan alt panelde).
  - Kilitli istasyon: `lockedShade` ile koyu siluet, kilit ikonu, ad "???" (ARB), maliyet gizli. Sadece açılabilir olan bir sonraki istasyon maliyetini gösterir.
  - Bir dükkan ilk kez açıldığında istasyonda tek seferlik altın parıltı (glow) + ölçek animasyonu.
  - Dükkan açma kuralı, x1/x10/MAX, yönetici, ekipman, milestone göstergesi ve tüm formüller AYNEN korunur. Tutorial adımlarının (1. ve 2. dükkanı al, yönetici kirala) hedeflediği öğeler haritada da çalışır.

---

## 15. FAZLAR VE KABUL KRİTERLERİ

Her fazın sonunda bölüm 2'deki protokol çalışır. Kabul kriterlerinden biri sağlanmıyorsa faz bitmemiştir.

### FAZ 0 — Temel ve Matematik
Yapılacak:
- `flutter create` ile proje, paketler (bölüm 4), `analysis_options.yaml`, klasör yapısı (sadece bu fazın dosyaları), `l10n.yaml`.
- `BigNumber`, `NumberFormatter`, `DurationFormatter`, `Clock`.
- `engine/shop_math.dart` (maliyet, toplu maliyet, MAX satın alma, gelir, milestone).
- `EconomyConfig` + `economy.json` (10 dükkan, 8 reçete, 30 şehir, ödüller, tüm sabitler) + loader.
- `tool/simulate.dart`.
- `CLAUDE.md`'yi repoya ekle, `.gitignore`, ilk commit.
Kabul:
- `BigNumber`, formatter, shop_math için testler yeşil.
- `dart run tool/simulate.dart` çıktısı tabloda dükkan başına ilk satın alma zamanını yazar; 2–5. dükkanlar bölüm 8.4 hedeflerinin ±%30'unda (değilse JSON'u ayarla).
- `flutter analyze` temiz.
Commit: `phase0: foundation, bignumber, economy config`

### FAZ 1 — Tema, Çekirdek Döngü, Ana Ekran
Yapılacak:
- Tema (bölüm 14), ARB iskeleti (en + tr), `GameState`, `GameCubit`, `GameTickService`, `SaveRepository` + migrations iskeleti, lifecycle yönetimi.
- Ana ekran: başlık, fincan `CustomPainter`, tıklama + kombo + Rush, 4 sekmeli alt gezinme. Sekme içerikleri bu fazda sadece ortalanmış "yakında" metni (ARB'den).
- Tıklama kazancı çalışır; dükkan olmadığı için `totalIncomePerSec` 0'dır. Bu fazda 1. dükkanı satın almak için geçici bir buton OLMAYACAK; sadece tıklama ile nakit birikir.
Kabul:
- Uygulama açılır, fincan dolar, kombo ve Rush çalışır, nakit artar.
- Uygulama kapatılıp açılınca nakit korunur.
- Cihaz saati geri alınınca çökme veya negatif değer yok.
- Testler: tick delta, kombo mantığı, kayıt gidiş-dönüş, bozuk JSON → yedek → yeni oyun.
Commit: `phase1: theme, core loop, home screen`

### FAZ 2 — Dükkanlar, Yöneticiler, Ekipman
Yapılacak:
- Dükkan listesi (10), kilit durumu, x1/x10/MAX seçici, satın alma, milestone göstergesi (bir sonraki çarpana kalan seviye), yönetici kirala, 3 ekipman.
- `GameCubit` satın alma metotları, her satın almada kayıt.
Kabul:
- Tüm formüller bölüm 8.1 ile birebir; testler MAX hesabını ve çoklu satın almayı doğrular.
- Yetersiz nakitte buton pasif; MAX en az 1 alabiliyorsa aktif. (FAZ 12'den itibaren yerini bölüm 14.1'deki "yetersiz nakit" davranışı alır.)
- 25. seviyede gelir ×2 olur (testli).
- Liste 60 FPS'e yakın akar (gereksiz rebuild yok: `buildWhen` kullanıldı).
Commit: `phase2: shops, managers, equipment`

### FAZ 3 — Ar-Ge Laboratuvarı ve Kapsül
Yapılacak:
- Reçete listesi, açma, slider ekranı, `RadarChart`, test akışı, ipucu, geri sayım, `activeBrew` kayıt/okuma, kapsül makinesi.
- `engine/lab_math.dart`.
Kabul:
- Skor ve ipucu testleri (tolerans içi → 100, uzak → düşük, ipucu en kötü slider'ı gösterir).
- Uygulama kapalıyken biten test, açılışta sonuç olarak görünür.
- `labBonusMult` ve `capsuleBonus` gelire doğru yansır (testli).
- Kapsül koşulları (skor ≥ 80 ve hype) sağlanmadan makine alınamaz.
Commit: `phase3: lab, recipes, capsule machines`

### FAZ 4 — Franchise, Prestij, Offline Kazanç
Yapılacak:
- Büyüme sekmesi: bölge çipleri, şehir kartları, yuva bazlı franchise satın alma, royalty gösterimi (`engine/franchise_math.dart`), prestij ekranı ve onay diyaloğu, sıfırlama mantığı (`engine/prestige_math.dart`).
- `offline_math.dart`, açılış modalı, "2x al" butonu (mock reklam bağlanana kadar `MonetizationService` mock'unu kullan; bu fazda mock servis arayüzü eklenir).
Kabul:
- Prestij formülü ve sıfırlama/koruma listesi testli (korunanlar korunuyor, sıfırlananlar sıfırlanıyor).
- Offline: 30 sn → modal yok, 5 saat → 4 saat sayılır, VIP → 12 saat, negatif süre → 0 (hepsi testli).
- Prestij sonrası `globalMult` doğru artar.
- Franchise testleri: n. yuva maliyeti, hype kilidi, şehir tamamlanınca ×1.5, tüm şehirler için toplam yuva = 87, her şehirde `slots` aşılamaz.
- Prestijde franchise sayıları sıfırlanır, `brandHype` korunur.
Commit: `phase4: franchise, prestige, offline`

### FAZ 5 — Monetizasyon, Günlük Ödül, Bildirim
Yapılacak:
- Tam `MonetizationService` mock'u, Mağaza sekmesi (VIP, paketler, restore), ödüllü reklam butonları + cooldown + boost sistemi, günlük ödül, `NotificationService`, `ConsentService`, `AnalyticsService` ve olay çağrıları.
Kabul:
- 4 ödüllü reklam türü çalışır, cooldown'lar kayıtlıdır.
- VIP satın alınca çarpan, offline cap ve otomatik tıklayıcı etkin olur.
- Günlük ödül seri/sıfırlama mantığı testli.
- Bildirim planlama, uygulama açılınca iptal ve yeniden planlama çalışır.
Commit: `phase5: monetization, daily reward, notifications`

### FAZ 6 — Tutorial, Başarımlar, Cila, Hazırlık
Yapılacak:
- Tutorial (6 adım, atlanabilir, `tutorialStep` kayıtlı): 1) fincana dokun, 2) 1. dükkanı al, 3) 2. dükkanı al, 4) yönetici kirala, 5) Ar-Ge sekmesini aç, 6) bitir + bildirim izni iste.
- `achievements.json` (20 başarım: toplam kazanç, dükkan seviyesi, reçete ustalığı, franchise, prestij sayısı, tıklama sayısı) ve UI.
- Haptic/ses çağrıları, sayfa geçiş animasyonları, ayarlar ekranı (dil, ses, titreşim, bildirim, bilimsel gösterim, kayıt sıfırla).
- `en` ve `tr` ARB dosyalarının anahtar kümelerinin eşit olduğunu doğrulayan test.
- Sürüm hazırlık listesi: uygulama adı/ikon yer tutucusu, gizlilik politikası URL alanı, yaş derecelendirmesi notu (README'ye).
Kabul:
- Yeni kurulumda tutorial akar, atlanabilir, tekrar çıkmaz.
- `en` ve `tr` ARB anahtarları birebir aynı.
- Tüm testler yeşil, `flutter analyze` temiz.
- Boş bir cihazda sıfırdan kuruluma karşı 10 dakikalık manuel akış sorunsuz.
Commit: `phase6: tutorial, achievements, polish`

### FAZ 7 — Dil Genişletme (15 dil)
Yapılacak:
- Bölüm 19'daki 13 yeni dilin ARB dosyalarını `app_en.arb` kaynak alınarak oluştur (tr zaten var). Şehir ve ülke adları dahil tüm anahtarlar çevrilir.
- Ayarlar ekranına dil seçici (ana dilin kendi adıyla, "Sistem" seçeneği ile).
- RTL (ar) düzeltmeleri, metin taşma düzeltmeleri.
- Bildirimleri seçili dile göre üret.
- Çeviri doğrulama testleri (bölüm 19).
Kabul:
- 15 ARB dosyasının anahtar kümesi, placeholder'ları ve plural yapıları `app_en.arb` ile aynı; boş değer yok.
- Ana ekran, Dükkanlar, Ar-Ge, Büyüme ve Mağaza sekmeleri `de`, `ru`, `ar`, `ja`, `hi` dillerinde ve 1.3 metin ölçeğinde widget testinde taşma hatası vermez (`tester.takeException` null).
- `ar` seçilince düzen sağdan sola döner; para ve rakam metinleri soldan sağa kalır.
- `flutter analyze` ve tüm testler temiz.
- README'ye "Çeviriler makine çevirisidir, yayından önce anadil kontrolü gerekir" notu eklenir.
Commit: `phase7: 15 languages, rtl`

### FAZ 8 — Piksel Sanat Altyapısı
Kapsam: Sprite formatı, çizici, önbellek ve temel sprite seti. Oyun ekranı bu fazda DEĞİŞMEZ.
Yapılacak:
- `flutter pub add flame` ve `flutter pub add --dev flame_test`; `assets/sprites/` pubspec'e.
- `lib/pixel/`: `SpriteDefinition` modeli, JSON ayrıştırıcı, `PaletteSet` (palet takası), `SpriteRasterizer` (ızgara → `ui.Image`, `PictureRecorder` ile 1 px = 1 `drawRect`), `SpriteAtlas` (açılışta tüm sprite'ları bir kez çizip id + palet anahtarıyla önbellekler).
- Temel sprite seti (bölüm 21.3): zemin ve duvar karoları, kapı, tezgah, kasa, espresso makinesi (4 görünüm seviyesi, 0–3), masa, sandalye, bitki, tabela, 4 müşteri tipi, barista (yürüme/bekleme/hazırlama), sipariş balonu ve 6 içecek ikonu, madeni para, kalp, yıldız, kilit; 10 dükkan bina sprite'ı.
- Sadece debug modda açılan "Sprite Galerisi" ekranı (tüm sprite'lar, tüm paletler, animasyonlar oynar); release derlemede erişilemez.
Kabul:
- Sprite doğrulama testleri: her sprite'ın tüm satırları beyan edilen genişlikte, tüm kareler aynı boyutta, kullanılan her palet karakteri palette tanımlı, her palet seti tüm slotları içeriyor, id'ler benzersiz.
- Rasterizer testi: bilinen 4×4 ızgara → beklenen piksel renkleri (`toByteData` ile).
- Galeride tüm sprite'lar ×4 ölçekte keskin (bulanık değil) görünür; açılış süresine eklenen önbellekleme < 300 ms (debug log).
Commit: `phase8: pixel art pipeline and base sprites`

### FAZ 9 — Kafe Sahnesi ve Servis Döngüsü
Kapsam: Ana ekranın kalbi. Ekonomi formülleri (bölüm 8.1) DEĞİŞMEZ; sadece tıklama ödemesi servis ödemesine dönüşür (bölüm 22).
Yapılacak:
- `CafeGame` (Flame) + `GameWidget`; Kafe sekmesi (5 sekmeli gezinme, bölüm 14). Varsayılan başlangıç yerleşimi (`furniture.json` → `defaultLayout`): kapı, tezgah, makine, 2 masa, 4 sandalye.
- `engine/grid_pathfinding.dart` (4 yönlü BFS/A*), `engine/customer_flow.dart` (gelme aralığı, kuyruk, sabır, oturma/gitme durum makinesi), `engine/service_math.dart` (ödeme, bahşiş, mükemmel servis, kombo).
- Müşteri akışı ve oyuncu servisi (bölüm 22.1–22.3), sipariş balonu, brew paneli (mevcut fincan painter'ı ile), teslim, sahne içi ödül efektleri (bölüm 14.1).
- Baristalar: işe alınan yönetici sayısına göre sahnede barista NPC'leri otomatik servis yapar (bölüm 22.4). VIP barista.
- `CafeBridge` (bölüm 21.4); kayıt göçü (stats alanları); tutorial adım 1 "fincana dokun" → "ilk müşteriye servis yap" olarak güncellenir.
Kabul:
- Engine testleri: yol bulma (engel etrafından dolaşma, ulaşılamaz hedef → null), müşteri durum makinesi (sabır bitince gider, kuyruk sınırı aşılmaz), servis ödemesi (min `$1`, mükemmel servis bonusu, Rush ×2, kombo penceresi).
- Müşteriler kapıdan girer, kuyruğa yürür, sipariş verir; oyuncu müşteriye → brew paneline → teslime dokunarak servis yapar; para kasaya uçar. Sabrı biten müşteri kalp kırık ikonuyla çıkar, kombo sıfırlanır.
- Yönetici kiralanınca sahnede barista belirir ve oyuncu dokunmadan servis yapar.
- Sahne ≥ 55 FPS (orta seviye cihaz, profil modu); saniyelik Cubit tick'i sahneyi yeniden kurmaz.
- Diğer sekme açıkken müşteri üretimi durur; uygulama arka plandan dönünce kafe boş başlar, offline kazanç modalı eskisi gibi çalışır.
- `ar` dilinde HUD/paneller aynalanır, kafe sahnesi aynalanmaz (bölüm 21.5).
Commit: `phase9: cafe scene and customer service loop`

### FAZ 10 — Kafe Düzenleme (Yerleşim Modu)
Yapılacak:
- `furniture.json` kataloğu (bölüm 23.1), Düzenle modu: ızgara çizgileri, katalog alt paneli, sürükle-bırak, döndür, depoya kaldır, satın al.
- `engine/layout_rules.dart` (çakışma, sınır, ulaşılabilirlik), `engine/appeal_math.dart` (`appealMult`, müşteri gelme hızına etkisi).
- Oda büyümesi: dükkan kademeleri açıldıkça `roomTier` artar, oda genişler (bölüm 23.1).
- Kayıt göçü: `cafeLayout`, `inventory`.
Kabul:
- Engine testleri: çakışan yerleşim reddedilir; kapıdan tezgaha veya herhangi bir sandalyeye yolu kapatan yerleşim reddedilir; `appealMult` üst sınırı aşılmaz; oda büyüyünce mevcut eşyalar yerinde kalır.
- Geçersiz konumda "hayalet" kırmızı görünür ve bırakılamaz; geçerli konumda yeşil.
- Düzenle modundan çıkınca müşteriler yeni yerleşime göre yol bulur.
- Yerleşim kayıt-yükleme gidiş-dönüşü ve prestijde korunması testli.
Commit: `phase10: cafe layout editor`

### FAZ 11 — Görünüm Özelleştirme
Yapılacak:
- `cosmetics.json` (bölüm 23.2): zemin, duvar, tabela, ışık temaları; barista kıyafetleri. Görünüm paneli (önizlemeli), kilit/açma koşulları.
- Görünür ekipman yükseltmesi: tezgahtaki makine sprite'ı dükkan ekipman seviyesini izler (bölüm 23.3).
- Kayıt göçü: `cosmetics`.
Kabul:
- Tema değişince sahne anında yeni paletle çizilir (palet takası, yeni sprite çizimi yok); seçim kayıtlı.
- Kilitli kozmetik seçilemez, açma koşulu görünür; Golden Bean ile açılanlar bean düşer.
- Ekipman satın alınınca makine sprite'ı sahnede değişir ve kısa parıltı oynar.
- Kozmetikler prestijde korunur (testli).
Commit: `phase11: themes, outfits, visible equipment`

### FAZ 12 — Oyun Hissi Cilası ve Piksel Dükkan Haritası
Yapılacak:
- Bölüm 14 paletini `app_colors.dart`/`app_theme.dart`'a uygula; piksel çerçeveli paneller, `GameBackground`.
- `BouncyButton`, `InsufficientFundsFlash`, UI `FloatingTextLayer`, kasa sayacı animasyonu, kamera sarsıntısı (bölüm 14.1); `FeedbackKind.denied`.
- Dükkanlar sekmesi → piksel ilerleme haritası (bölüm 14.1).
Kabul:
- `BouncyButton` küçülüp döner; yetersiz nakitte satın alma yapılmaz ve flash görünür, başarılı satın almada görünmez; uçan yazı 8 ile sınırlı; `disableAnimations` true iken sarsıntı/uçan yazı/sallanma yok (widget testleri).
- Haritada kilitli istasyon maliyet göstermez; ilk açılış glow'u bir kez oynar; tutorial haritada akar.
- FAZ 2 testleri değişmeden yeşil; kodda doğrudan `HapticFeedback.` sadece `haptic_service.dart` içinde; titreşim kapalıyken hiç haptic yok.
Commit: `phase12: game feel polish and pixel shop map`

Tüm FAZ 8–12 için ortak kabul: mevcut testler yeşil, `flutter analyze` temiz, l10n testleri geçer (yeni anahtarlar 15 dilde), `de/ru/ar/ja/hi` + 1.3 metin ölçeğinde taşma testi geçer.

---

## 16. TEST KURALLARI

- Her `engine/` dosyası için unit test zorunlu. Cubit için `bloc_test`.
- Zaman gerektiren her testte `FakeClock`.
- Rastgelelik gerekiyorsa (bu projede yok) enjekte edilebilir `Random` kullan.
- Bir hata düzeltmesi, önce onu yakalayan başarısız bir test yazılarak yapılır.

---

## 17. GIT

- Dal: `main`. Her faz sonunda tek commit (bölüm 15'teki mesajlar).
- Commit öncesi `dart format .`, `flutter analyze`, `flutter test` yeşil olmalı.
- Faz ortasında commit yok; faz bozulursa `git reset --hard` ile önceki faza dönülür.

---

## 18. KOMUTLAR

```
flutter pub get
dart format .
flutter analyze
flutter test
dart run tool/simulate.dart
flutter gen-l10n
flutter run
```

---

## 19. DİLLER VE YERELLEŞTİRME

Desteklenen 15 dil (ARB kodu, yerel ad, yön):

| Kod | Yerel ad | Yön |
|-----|----------|-----|
| `en` | English | LTR (kaynak dil) |
| `tr` | Türkçe | LTR |
| `es` | Español | LTR |
| `pt` | Português (Brasil) | LTR |
| `fr` | Français | LTR |
| `de` | Deutsch | LTR |
| `it` | Italiano | LTR |
| `ru` | Русский | LTR |
| `ar` | العربية | RTL |
| `hi` | हिन्दी | LTR |
| `id` | Bahasa Indonesia | LTR |
| `ja` | 日本語 | LTR |
| `ko` | 한국어 | LTR |
| `zh` | 简体中文 | LTR |
| `vi` | Tiếng Việt | LTR |

Kurallar:
- Kaynak dosya `app_en.arb`. Yeni metin önce `en` ve `tr`'ye eklenir. Faz 1–6'da diğer 13 dile dokunulmaz. FAZ 7 ve sonrasında (FAZ 8–12 dahil) her yeni anahtar aynı fazda 15 dilin hepsine eklenir. Eşya, içecek ve kozmetik adları `furniture_<id>`, `drink_<id>`, `cosmetic_<id>` anahtarlarıyla.
- ARB'de çoğul/cinsiyet için ICU `plural`/`select` kullan; metin birleştirme (`a + b`) yok.
- Cihaz dili desteklenenler arasında değilse `en`. Kullanıcı seçimi ayarlarda saklanır (`settings.locale`, "system" varsayılan).
- Dil seçicide dil adı kendi dilinde yazılır, bayrak kullanılmaz.
- Font: sistem fontu. Arapça, Hintçe, CJK için sistem yedek fontları devreye girer; özel font ekleme.
- RTL: `EdgeInsets.only(left/right)`, `Alignment.centerLeft`, `Positioned(left/right)` YAZMA; `EdgeInsetsDirectional`, `AlignmentDirectional`, `PositionedDirectional` kullan. Yön gerektiren ikonlar (geri ok vb.) `matchTextDirection` ile.
- Taşma: buton ve başlık metinlerine `maxLines`, `overflow: TextOverflow.ellipsis` veya `FittedBox(fit: BoxFit.scaleDown)` uygula; sabit genişlikli metin kutusu yok.
- Bildirimler `BuildContext`'siz üretildiği için üretilen `lookupAppLocalizations(Locale)` ile yerelleştirilir.
- Tarih ve saat `intl` `DateFormat` ile, süreler ARB'deki kısa birimlerle (`DurationFormatter`).
- Ülke ve şehir adları ARB'de `city_<id>`, `country_<KOD>` anahtarlarıyla çevrilir.

Doğrulama testleri (`test/l10n/`):
1. Tüm ARB'lerin anahtar kümesi `app_en.arb` ile aynı.
2. Hiçbir değer boş veya sadece boşluk değil.
3. Her anahtarın `{placeholder}` kümesi `en` ile aynı.
4. Çeviri olmayan (değeri `en` ile birebir aynı) anahtarlar için `ar, ru, ja, ko, zh, hi` dillerinde uyarı listesi yazdır; test başarısız olmasın, sadece raporla.

---

## 20. BAŞLATMA

FAZ 0–7 tamamlandı. Sıradaki faz: FAZ 8. Yeni oturumda yalnızca şunu yap: bu dosyayı oku, sıradaki fazı bölüm 2 protokolüyle uygula, durup onay bekle. "Devam et" gelince bir sonraki faza geç (8 → 9 → 10 → 11 → 12).

---

## 21. PİKSEL SANAT SİSTEMİ (FAZ 8+)

### 21.1 Sprite formatı (`assets/sprites/*.json`)
```json
{
  "sprites": [
    {
      "id": "customer_a",
      "width": 16,
      "height": 24,
      "anchor": "bottomCenter",
      "fps": 6,
      "palette": { "o": "outline", "s": "skin", "h": "hair", "t": "shirt", "p": "pants" },
      "animations": {
        "idle_down": [["................", "......hhhh......", "..."], ["..."]],
        "walk_down": [["..."], ["..."], ["..."], ["..."]],
        "walk_up":   [["..."], ["..."], ["..."], ["..."]],
        "walk_side": [["..."], ["..."], ["..."], ["..."]]
      }
    }
  ]
}
```
- `.` saydam piksel. Diğer her karakter `palette` içinde bir SLOT adına eşlenir; renk sprite'ta değil palet setinde durur.
- Her kare = `height` adet satır, her satır tam `width` karakter. Tek kareli sprite'lar `"default": [[...]]` kullanır.
- Sol yön ayrı çizilmez: `walk_side` yatay aynalanır.

### 21.2 Paletler (`assets/sprites/palettes.json`)
- `slots`: tüm slot adları (`outline, skin, hair, shirt, pants, apron, wood_dark, wood_light, floor_a, floor_b, wall_a, wall_b, metal, metal_light, coffee, milk, leaf, accent ...`).
- `sets`: `{ "base": {slot: "#RRGGBB"}, "floor_marble": {floor_a:..., floor_b:...}, "outfit_red": {apron:..., shirt:...} ... }`. `base` tüm slotları tanımlar; diğer setler sadece değiştirdiği slotları içerir ve `base` üstüne bindirilir.
- `SpriteAtlas.get(spriteId, animation, frame, paletteKey)`; `paletteKey` bindirilen setlerin sıralı listesidir (örn. `base+floor_marble+light_warm`). Aynı anahtar ikinci kez çizilmez (önbellek).

### 21.3 Stil ve ölçüler
- Görünüm: üstten 3/4 (klasik RPG/Stardew tarzı), ışık sol üstten.
- Karo 16×16. Karakter 16×24. Masa 16×16 (1×1 karo) veya 32×16 (2×1). Tezgah 16'nın katları. Makine 16×24. Dükkan bina sprite'ı 32×32. İkonlar 8×8 / 12×12.
- Malzeme başına en fazla 3–4 ton; dış hat 1 px koyu kahve (`outline`), saf siyah değil. Anti-aliasing yok, gradyan yok, tek pikselli "gürültü" yok.
- Animasyon: 6–8 fps; yürüme 4 kare; bekleme 2 kare (nefes/kıpırdama); barista "hazırlama" 4 kare; buhar 3 kare.
- Müşteri çeşitliliği: 4 gövde tipi × palet takasıyla (saç/ten/kıyafet) en az 16 görünüm.

### 21.4 Cubit ↔ Flame köprüsü (`cafe/cafe_bridge.dart`)
- `GameCubit` tek doğruluk kaynağıdır (nakit, yöneticiler, ekipman, yerleşim, kozmetik). Müşteri konumları, kuyruk ve animasyon durumu SADECE Flame tarafında yaşar ve kaydedilmez.
- Köprü cubit stream'ini dinler; yalnızca sahneyi etkileyen alanlar değişince (yönetici sayısı, ekipman seviyesi, `cafeLayout`, `cosmetics`, boost/Rush) ilgili component'i günceller. Saniyelik nakit değişimi sahneyi yeniden kurmaz.
- Sahne olaylarını cubit komutlarına çevirir: `serveOrder(drinkId, patienceRatio, byBarista)`, `customerLost()`. Para hesabını cubit + `engine/service_math.dart` yapar.

### 21.5 Kamera, dokunma, RTL
- Oda ızgarası ekrana TAM SAYI ölçekle sığdırılır: `scale = max(2, floor(min(w / (cols*16), h / (rows*16))))`. Sığmazsa yatay/dikey sürükleyerek kaydırma (pan) açılır; yakınlaştırma (pinch zoom) YOK.
- Dokunma hedefi en az 44×44 mantıksal px; sprite küçükse görünmez isabet kutusu büyütülür.
- Z-sıralama: ayak y koordinatına göre (`priority = y`), karakterler masaların önünden/arkasından doğru geçer.
- RTL (`ar`): HUD ve paneller aynalanır; kafe dünyası ve sprite'lar AYNALANMAZ.

### 21.6 Performans
- Aynı anda en fazla `service.maxCustomers` müşteri (config, varsayılan 8).
- Tüm sprite'lar `SpriteAtlas` önbelleğinden; frame başına yeni `ui.Image` üretimi YOK.
- Kafe sekmesi görünür değilken `CafeGame` duraklatılır (`pauseEngine`).

---

## 22. SERVİS DÖNGÜSÜ (FAZ 9+)

Tüm sabitler `economy.json` → `service` bloğunda: `baseArrivalSeconds (6), minArrivalSeconds (2), queueCapacity (5), patienceSeconds (20), seatSeconds (12), orderValueSeconds (10), perfectPatienceRatio (0.7), perfectTipRatio (0.5), autoServeSeconds (8), autoServeEfficiency (0.5), vipAutoServeEfficiency (0.75), maxVisibleBaristas (3), maxCustomers (8), drinks[]`.

### 22.1 Müşteri gelişi (`engine/customer_flow.dart`)
```
arrivalSeconds = max(minArrivalSeconds, baseArrivalSeconds / (1 + appeal * arrivalAppealBonus))
```
- Sadece Kafe sekmesi açıkken müşteri gelir. Kuyruk `queueCapacity` doluysa yeni müşteri gelmez.
- Durum makinesi: `entering → queueing → ordering → (served → seated | takeaway) → leaving` veya `ordering → (sabır 0) → leavingAngry`.
- Sabır yalnızca `ordering` durumunda azalır; balonun altında piksel sabır çubuğu (yeşil → sarı → kırmızı).
- Servisten sonra boş ve ulaşılabilir sandalye varsa oturur, `seatSeconds` içer, çıkar; yoksa paket alıp çıkar.

### 22.2 İçecekler
- 6 içecek: `espresso, americano, latte, cappuccino, mocha, cold_brew`. Alanlar: `id, nameKey, iconSpriteId, drinkMult, unlockShopIndex`. Sipariş, açık içecekler arasından seçilir (enjekte edilebilir `Random`).
- Yeni dükkan kademeleri yeni içecekleri açar (örn. 1: espresso, americano; 3: latte; 5: cappuccino; 7: mocha; 9: cold_brew).

### 22.3 Oyuncu servisi (`engine/service_math.dart`)
- Oyuncunun baristası tezgahta durur, odada yürümez.
- Akış: kuyruğun başındaki müşteriye dokun (sipariş alındı) → brew paneli açılır, fincan her dokunuşta `tapFillStep` kadar dolar → dolunca panel kapanır, barista fincanı tezgaha koyar → müşteriye dokun (teslim).
- Oyuncu aynı anda tek sipariş hazırlar. Brew paneli açıkken diğer müşterilerin sabrı akmaya devam eder.
```
payout = max($1, orderValueSeconds * totalIncomePerSec * drinkMult)
perfect = patienceRemaining / patienceSeconds >= perfectPatienceRatio
payout *= perfect ? (1 + perfectTipRatio) : 1
payout *= rushActive ? 2 : 1
```
- Kombo: teslimden sonra `comboWindowSeconds` içinde yeni teslim → kombo +1; 5 kombo → Barista Rush (bölüm 8.3 sabitleri). Müşteri kaçarsa kombo 0.

### 22.4 Baristalar (otomatik servis)
- Sahnedeki NPC barista sayısı = `min(işe alınmış yönetici sayısı, maxVisibleBaristas)`.
- Her barista, oyuncunun almadığı bir siparişi alır, makineye yürür, hazırlar, teslim eder; süre `autoServeSeconds / (1 + 0.1 * (yöneticiSayısı - 1))`.
- Otomatik servis ödemesi `payout * autoServeEfficiency`; perfect bonusu ve kombo yok.
- VIP (`master_roaster_vip`): ek altın kıyafetli VIP barista, verimlilik `vipAutoServeEfficiency`. Eski "otomatik tıklayıcı" bunun yerine geçer.

### 22.5 Analitik ek olaylar
`order_served(drinkId, perfect, byBarista)`, `customer_lost`, `layout_changed(itemCount)`, `furniture_bought(itemId)`, `cosmetic_unlocked(id)`, `cosmetic_equipped(id)`.

---

## 23. KAFE ÖZELLEŞTİRME (FAZ 10+)

### 23.1 Mobilya ve oda (`assets/config/furniture.json`)
- Alanlar: `id, nameKey, spriteId, footprint{w,h}, category (seating|table|decor|counter|lighting), appeal, costMult, unlockShopIndex, isSeat, rotatable`.
- Fiyat: `shops[unlockShopIndex].baseCost * costMult` (BigNumber). Satın alınan eşya envantere girer; yerleştirilir veya depoya kaldırılır (ücretsiz). Satış yok.
- En az 24 eşya: 6 oturma, 5 masa, 8 dekor (bitki, tablo, raf, halı, kitaplık, plak çalar, akvaryum, neon tabela), 3 aydınlatma, 2 tezgah uzantısı.
- Sabit öğeler: kapı, ana tezgah, kasa ve makine taşınamaz; tezgah önündeki `queueCapacity` karoluk kuyruk şeridi bloklanamaz.
- Oda: `roomTier = 1 + floor(açılmış dükkan sayısı / 2)` (en çok 6). Tier 1 = 8×10 karo (sütun×satır), her tier +1 sütun +1 satır. `roomTier` kayıtlı ve ulaşılan en yüksek değer korunur (prestijde küçülmez).
- `layout_rules.dart`: eşya oda sınırı içinde, başka eşyayla çakışmıyor; kapıdan kuyruk şeridine ve her sandalyeye 4 yönlü yol var. Geçersizse yerleşim reddedilir.

### 23.2 Çekicilik ve kozmetik
```
appeal     = Σ yerleşik eşya.appeal + Σ aktif tema.appeal
appealMult = 1 + min(appealCap, appeal * appealBonus)        // varsayılan appealCap 0.5 → en çok ×1.5
```
- `appealMult` bölüm 8.1 `globalMult`'a girer ve müşteri gelme hızını etkiler (22.1). Depodaki eşyalar sayılmaz.
- `assets/config/cosmetics.json`: `id, nameKey, type (floor|wall|sign|light|outfit), paletteSetId, appeal, unlock{kind: default|shopIndex|achievement|goldenBeans|vip, value}`.
- En az: 6 zemin, 6 duvar, 4 tabela, 4 ışık (renk tonu + yoğunluk), 8 barista kıyafeti. Kıyafetler barista slotu başına seçilir (oyuncu baristası + 3 NPC slotu).
- Tüm kozmetikler palet takasıyla uygulanır; kozmetik başına yeni sprite çizilmez (tabela hariç: tabela metni değil şekli değişir).

### 23.3 Görünür ekipman
- Tezgahtaki makine sprite'ı, açık dükkanlar arasında en yüksek kademeli dükkanın ekipman seviyesini (0–3) izler: 4 görünüm (basit makine → çift gruplu → parlak krom → altın). Prestijde ekipman sıfırlanınca görünüm de 0'a döner.
- Ekipman alındığında makinede parıltı + kısa buhar patlaması.
