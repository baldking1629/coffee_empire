# CLAUDE.md — Coffee Empire (Idle Coffee Simulator)

Bu dosya projenin tek doğruluk kaynağıdır. Her oturumun başında tamamını oku. Burada yazmayan bir şeyi icat etme; belirsizlik varsa "12. Belirsizlik Kuralı" bölümünü uygula.

---

## 1. PROJE ÖZETİ

- Flutter ile iOS ve Android için tek kod tabanlı idle/clicker oyunu.
- Tema: Sokakta bir kahve arabasından başlayıp global franchise imparatorluğuna ulaşmak.
- Görsel asset (PNG, JPG, SVG, 3D model) YOK. Her şey `Container`, `LinearGradient`, `CustomPainter`, ikonlarla çizilir. Tek istisna: `assets/config/*.json` ve `lib/l10n/*.arb` dosyaları.
- Diller: 15 dil (bölüm 19). Faz 1–6 boyunca sadece `en` ve `tr` yazılır; kalan 13 dil Faz 7'de eklenir. Varsayılan dil: cihaz dili, desteklenmiyorsa `en`.
- Para birimi sembolü: `$`.

### Kapsam İÇİ
1. Kahve dükkanları (10 kademe), yöneticiler, ekipman yükseltmeleri
2. Barista tıklama (fincan dolumu + kombo)
3. Ar-Ge Laboratuvarı (reçete geliştirme) ve Kapsül Makinesi pasif geliri
4. Franchise (30 gerçek şehir, şehir başına 1–5 franchise yuvası) ve Prestij (Golden Bean)
5. Offline kazanç, otomatik kayıt, kayıt versiyonlama
6. Mock monetizasyon (ödüllü reklam + IAP), günlük ödül, yerel bildirimler
7. Tutorial, başarımlar, haptic, ses altyapısı, analitik altyapısı (mock)

### Kapsam DIŞI — BUNLARI ASLA YAZMA
- Çekirdek borsası, fiyat grafikleri, al-sat, çekirdek stoğu
- Tarla, kavurma fabrikası, paketleme fabrikası
- Haber motoru, iklim olayları
- Dükkanların hammadde tüketmesi (satış hızı sadece seviye ve çarpanlara bağlıdır)
- Backend, hesap sistemi, bulut kayıt, çok oyunculu özellikler
- Gerçek AdMob / IAP / Firebase entegrasyonu (sadece arayüz + mock)

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

Geliştirme:
`bloc_test`, `mocktail`, `flutter_lints`

Kullanma: `hive`, `lucide_icons` (eski), `get_it`, `freezed`, `provider`, `riverpod`, `google_fonts` (internet gerektirir; sistem fontu kullan).

`pubspec.yaml` içinde `flutter: generate: true` ve `assets: - assets/config/` tanımla. `l10n.yaml` oluştur (`arb-dir: lib/l10n`, `template-arb-file: app_en.arb`).

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
        coffee_cup_painter.dart
        barista_tap_area.dart
        bottom_nav.dart
    shops/
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
test/
  core/
  engine/
  features/
tool/
  simulate.dart
```

Kurallar:
- `engine/` içinde Flutter importu YOK. Saf Dart. Tüm oyun matematiği burada, tamamı unit testli.
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
- Korunan: `goldenBeans`, `prestigeCount`, `lifetimeEarnings`, reçete `bestScore`ları ve açık reçeteler, başarımlar, satın alımlar (IAP), ayarlar, günlük ödül durumu, tutorial durumu, istatistikler.
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
- `HapticService`: tıklama `selectionClick`, fincan dolunca `lightImpact`, satın alma `mediumImpact`, prestij `heavyImpact`. Ayarlardan kapatılabilir.
- `SoundService`: soyut arayüz + `NoopSoundService`. Ses dosyası eklenene kadar hiçbir şey çalmaz; çağrı noktaları hazır olsun (`tap`, `cupFull`, `purchase`, `prestige`).

---

## 14. TEMA

| Rol                | Hex      |
|--------------------|----------|
| background         | `#120E0A`|
| surface            | `#1E1812`|
| card               | `#2A211B`|
| cardBorder         | karamel, `#8B5A2B` (alfa 0.5) |
| gold (prestij)     | `#D4AF37`|
| mint (nakit/kâr)   | `#00E676`|
| copper (üretim)    | `#E65100`|
| textPrimary        | `#F5EBDD`|
| textSecondary      | `#B8A894`|

- Koyu tema tek tema. Kartlar yuvarlak köşeli (16), ince karamel kenarlıklı, hafif `LinearGradient` ile.
- `coffee_cup_painter.dart`: `CustomPainter` ile fincan, buhar, dolan kahve seviyesi (0–1). Rush modunda bakır parlama.
- Renkler yalnızca `app_colors.dart`'tan; widget içinde hex yazma.
- Ana ekran: üstte sabit başlık (Kasa bakiyesi, saniyelik gelir, boost göstergesi), altında tıklama alanı + fincan, altta 4 sekmeli `NavigationBar`: **Dükkanlar, Ar-Ge, Büyüme (Franchise + Prestij), Mağaza (VIP + Günlük ödül + Ayarlar)**.

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
- Yetersiz nakitte buton pasif; MAX en az 1 alabiliyorsa aktif.
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
- Kaynak dosya `app_en.arb`. Yeni metin önce `en` ve `tr`'ye eklenir. Diğer 13 dile SADECE Faz 7'de eklenir; Faz 1–6'da onlara dokunma.
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

İlk mesajda yalnızca şunu yap: bu dosyayı oku, "FAZ 0"ı bölüm 2 protokolüyle uygula, durup onay bekle.