# mini-to-do-but-game - Nightly Reflection & Gamified Habit Tracker

![Version](https://img.shields.io/badge/version-1.0.0-blue.svg)
![Platform](https://img.shields.io/badge/platform-Android-green.svg)
![License](https://img.shields.io/badge/license-MIT-purple.svg)

[Uygulama Adı], kullanıcıların gün boyunca sürekli bildirimlerle rahatsız edilmediği, yalnızca gün sonunda (Nightly Reflection) 16-bit retro estetiği eşliğinde günlük aktivitelerini değerlendirdiği oyunlaştırılmış bir alışkanlık ve görev takip uygulamasıdır.

## 🌟 Temel Özellikler

* **Gece Değerlendirmesi (Nightly Reflection):** Gün içinde uygulamaya girmek yok. Akşamları bir kez girip günün özetini "Quest Turn-in" (Görev Teslimi) mantığıyla yapın.
* **Gelişmiş Görev Motoru (Quest Engine):** 5 farklı görev dinamiği desteklenir:
    * **Ağır (Heavy):** Kısa süre, yüksek efor (Örn: Spor).
    * **Bir Kerelik (One-Time):** Tamamla ve geç.
    * **Sürekli (Continuous):** Uzun süreli odak (Örn: Ders çalışma).
    * **Tekrar Odaklı (Repetitive):** Günlük rutinler (Örn: Diş fırçalama).
    * **Negatif (Vice/Limit):** Kötü alışkanlık kotaları. Limitin altında kalarak XP kazanın.
    * **Günaşırı (Every Other Day):** Birkaç günde bir yapılması gereken görevler.
* **Oyunlaştırma (Gamification):** Tamamlanan her görev, zorluk derecesine göre XP kazandırır. Seviye atlayın ve RPG tarzı unvanlar açın.
* **Piksel Isı Haritası (Pixel Heatmap):** Aylık aktivite yoğunluğunuzu renkli, 16-bit tarzı bir ısı haritasında görselleştirin.
* **Gizlilik Odaklı Sosyal Lonca:** Özel "Friend Code" sistemiyle arkadaşlarınızı ekleyin. Hangi görevlerin yapıldığı gizli kalır, sadece kazanılan XP ve gösterilen irade "Sosyal Akışta" paylaşılır.
* **Günlük Boss Savaşları:** Her gün belirli saatte Boss ile dövüşün. Boss'u yenmek için görevleri tamamlayın. Boss'u yenerseniz başarımlar ve XP kazanın.

## 📸 Ekran Görüntüleri

| Profil | Ana Sayfa | Sosyal (Lonca) |
|:---:|:---:|:---:|
| <img src="screenshots/profile.png" width="250"> | <img src="screenshots/home.png" width="250"> | <img src="screenshots/social.png" width="250"> |

*(Not: Ekran görüntüleri uygulama geliştirildikçe güncellenecektir.)*

## 🏗️ Mimari ve Teknolojiler

Proje, **Clean Architecture** prensipleri benimsenerek geliştirilmiştir.

* **UI/UX:** [Kullanılacak Framework: Örn. Jetpack Compose / .NET MAUI / Flutter]
* **Veritabanı (Lokal):** [Örn. Room DB / SQLite]
* **Backend (Sosyal Senkronizasyon):** [Örn. Firebase / Supabase]
* **Mimari Desen:** MVVM (Model-View-ViewModel)
