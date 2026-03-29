enum TaskType { heavy, oneTime, continuous, repetitive, negative }

// KADEME (TIER) MODELİ: Kolay, Orta, Zor seçenekleri için
class TaskTier {
  final String label; // Örn: "30 Dk", "2 Kez"
  final int xpReward; // Kazanılacak XP
  final int intensity; // Isı haritası için renk yoğunluğu (1, 2, 3)

  TaskTier({required this.label, required this.xpReward, required this.intensity});
}

// KOTA (QUOTA) MODELİ: Negatif görevler için (Örn: Max 2 saat sosyal medya)
class TaskQuota {
  final int maxAllowed;
  final int baseXp; // Sınırda kalınırsa verilecek XP
  final int bonusXpUnderLimit; // Sınırın altında kalınırsa verilecek ekstra XP

  TaskQuota({
    required this.maxAllowed, 
    required this.baseXp, 
    required this.bonusXpUnderLimit
  });
}

// ANA GÖREV (TASK) MODELİ
class TaskModel {
  final String id;
  final String title;
  final TaskType type;
  final String colorTheme; // Isı haritasında hangi renkte yanacağı (Örn: "pixel_blue")

  // Opsiyonel Alanlar (Sondaki '?' işareti bu verilerin boş olabileceğini belirtir)
  final int? baseXp; // Sadece "Bir Kerelik" görevler için
  final Map<String, TaskTier>? tiers; // Ağır, Sürekli ve Tekrar Odaklı görevler için (easy, medium, hard)
  final TaskQuota? quota; // Sadece Negatif görevler için

  TaskModel({
    required this.id,
    required this.title,
    required this.type,
    required this.colorTheme,
    this.baseXp,
    this.tiers,
    this.quota,
  });
}