import '../../domain/models/task_model.dart';

// Veritabanımız bağlanana kadar arayüzü besleyecek olan Sahte (Mock) Veri Depomuz
class MockTaskRepository {
  
  // Arayüz (UI) bu metodu çağırdığında ona o günkü aktif görevlerin listesini döneceğiz
  List<TaskModel> getDailyTasks() {
    return [
      // 1. Ağır Görev Örneği
      TaskModel(
        id: "t_heavy_01",
        title: "Kardiyo / HIIT",
        type: TaskType.heavy,
        colorTheme: "pixel_red",
        tiers: {
          "easy": TaskTier(label: "15 Dk", xpReward: 20, intensity: 1),
          "medium": TaskTier(label: "30 Dk", xpReward: 45, intensity: 2),
          "hard": TaskTier(label: "1 Saat+", xpReward: 80, intensity: 3),
        },
      ),

      // 2. Bir Kerelik Görev Örneği
      TaskModel(
        id: "t_onetime_01",
        title: "Yatağı Topla",
        type: TaskType.oneTime,
        colorTheme: "pixel_green",
        baseXp: 15,
      ),

      // 3. Tekrar Odaklı Görev Örneği
      TaskModel(
        id: "t_repetitive_01",
        title: "Diş Fırçalama",
        type: TaskType.repetitive,
        colorTheme: "pixel_cyan",
        tiers: {
          "easy": TaskTier(label: "1 Kez", xpReward: 5, intensity: 1),
          "medium": TaskTier(label: "2 Kez", xpReward: 15, intensity: 2),
          "hard": TaskTier(label: "3 Kez+", xpReward: 30, intensity: 3),
        },
      ),

      // 4. Negatif Görev Örneği
      TaskModel(
        id: "t_negative_01",
        title: "Sosyal Medya Limiti",
        type: TaskType.negative,
        colorTheme: "pixel_purple",
        quota: TaskQuota(
          maxAllowed: 2, // Max 2 saat
          baseXp: 30,
          bonusXpUnderLimit: 20,
        ),
      ),
      
      // 5. Periyodik Görev (Bugün Aktif Olan - Duş Almak)
      TaskModel(
        id: "t_periodic_01",
        title: "Duş Almak",
        type: TaskType.periodic,
        colorTheme: "pixel_blue",
        periodicInterval: 2, // 2 günde bir
        nextDueDate: DateTime.now().subtract(const Duration(days: 1)), // Dün veya bugün dolmuş (Yani AKTİF)
      ),

      // 6. Periyodik Görev (Dinlenen/Pasif Olan - Çiçekleri Sulamak)
      TaskModel(
        id: "t_periodic_02",
        title: "Çiçekleri Sulamak",
        type: TaskType.periodic,
        colorTheme: "pixel_green",
        periodicInterval: 3, // 3 günde bir
        nextDueDate: DateTime.now().add(const Duration(days: 2)), // Yapılmasına daha 2 gün var (Yani PASİF)
      ),
    ];
  }
}