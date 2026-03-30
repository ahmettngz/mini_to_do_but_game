import 'package:flutter/material.dart';
import '../../domain/models/task_model.dart';

class TaskDetailScreen extends StatelessWidget {
  final TaskModel task;
  final Function(String) onDelete; // Silme işlemi için fonksiyon

  const TaskDetailScreen({
    super.key,
    required this.task,
    required this.onDelete,
  });

  // Görev tipine göre dinamik seçenekler sunan widget
  Widget _buildDifficultySelector() {
    if (task.type == TaskType.oneTime) {
      return ElevatedButton(
        style: ElevatedButton.styleFrom(backgroundColor: Colors.green, padding: const EdgeInsets.all(16)),
        onPressed: () {}, // İleride XP kazandırma kodu buraya gelecek
        child: Text("Tamamlandı (+${task.baseXp} XP)", style: const TextStyle(fontSize: 18, color: Colors.white)),
      );
    } 
    
    if (task.type == TaskType.negative && task.quota != null) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text("Kota: Max ${task.quota!.maxAllowed}", style: const TextStyle(color: Colors.grey, fontSize: 16)),
          const SizedBox(height: 10),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.deepPurpleAccent),
            onPressed: () {},
            child: const Text("Kotanın Altında Kaldım (Bonus XP!)", style: TextStyle(color: Colors.white)),
          ),
          const SizedBox(height: 8),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
            onPressed: () {},
            child: const Text("Tam Sınırda Kaldım (Normal XP)", style: TextStyle(color: Colors.white)),
          ),
          const SizedBox(height: 8),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent),
            onPressed: () {},
            child: const Text("Kotayı Aştım (0 XP)", style: TextStyle(color: Colors.white)),
          ),
        ],
      );
    }

    if (task.tiers != null) {
      // Ağır, Sürekli ve Tekrar odaklı görevler için Kademeler (Tiers)
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: task.tiers!.entries.map((entry) {
          final tier = entry.value;
          return Expanded(
            child: Card(
              color: Colors.deepPurple[800],
              child: InkWell(
                onTap: () {}, // İleride XP kazandırma kodu
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 8),
                  child: Column(
                    children: [
                      Text(tier.label, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                      const SizedBox(height: 8),
                      Text("+${tier.xpReward} XP", style: const TextStyle(color: Colors.tealAccent)),
                    ],
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      );
    }

    return const SizedBox(); // Hiçbiri değilse boşluk döndür
  }


    // String renk ismini gerçek Flutter rengine çeviren yardımcı fonksiyon
    Color _getBaseColor(String theme) {
      switch (theme) {
        case "pixel_red": return Colors.red;
        case "pixel_green": return Colors.green;
        case "pixel_cyan": return Colors.cyan;
        case "pixel_blue": return Colors.blue;
        case "pixel_purple": return Colors.deepPurpleAccent;
        default: return Colors.deepPurple;
      }
    }

    // Dinamik Isı Haritası Çizici
    Widget _buildMockHeatmap() {
      Color baseColor = _getBaseColor(task.colorTheme); // Görevin kendi rengini aldık!

      return Wrap(
        spacing: 4,
        runSpacing: 4,
        children: List.generate(30, (index) {
          int intensity = (index % 4 == 0) ? 0 : (index % 3) + 1;
          Color boxColor;
        
          // Yoğunluğa göre o rengin opaklığını (solukluğunu) ayarlıyoruz
          if (intensity == 0) boxColor = Colors.grey[800]!;
          else if (intensity == 1) boxColor = baseColor.withOpacity(0.4);
          else if (intensity == 2) boxColor = baseColor.withOpacity(0.7);
          else boxColor = baseColor; // Full yoğunluk

          return Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              color: boxColor,
              borderRadius: BorderRadius.circular(4),
            ),
          );
        }),
      );
    }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // 1. Görev Tipi
            Text(
              task.type.name.toUpperCase(),
              style: const TextStyle(color: Colors.deepPurpleAccent, letterSpacing: 2, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            
            // 2. Görev İsmi
            Text(
              task.title,
              style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 32),

            // 3. Soru
            const Text(
              "Bugün bu görevi nasıl tamamladın?",
              style: TextStyle(fontSize: 18, color: Colors.white70),
            ),
            const SizedBox(height: 16),

            // 4. Görev Zorluklarını Seçme Alanı (Dinamik)
            _buildDifficultySelector(),

            const Spacer(), // Ekranın ortasını boş bırakıp aşağı iter

            // 5. Görevin Kendi Isı Haritası
            const Text("Son 30 Günlük Aktivite", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey)),
            const SizedBox(height: 12),
            _buildMockHeatmap(),
            
            const SizedBox(height: 32),

            // 6. Sil Butonu (En Altta)
            TextButton.icon(
              onPressed: () {
                onDelete(task.id); // Viewmodel'daki silme fonksiyonunu tetikler
                Navigator.pop(context); // Ekranı kapatıp listeye geri döner
              },
              icon: const Icon(Icons.delete, color: Colors.redAccent),
              label: const Text("Bu Görevi Sil", style: TextStyle(color: Colors.redAccent, fontSize: 16)),
              style: TextButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 16)),
            )
          ],
        ),
      ),
    );
  }
}