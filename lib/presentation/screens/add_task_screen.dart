import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart'; // iPhone (iOS) tarzı widgetlar için gerekli
import '../../domain/models/task_model.dart';

class AddTaskScreen extends StatefulWidget {
  final Function(TaskModel) onTaskCreated;

  const AddTaskScreen({super.key, required this.onTaskCreated});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final TextEditingController _titleController = TextEditingController();
  
  // Varsayılan seçimimiz
  TaskType _selectedType = TaskType.continuous; 

  // Görev Tiplerinin Türkçe İsimlerini Döndüren Yardımcı Fonksiyon
  String _getTypeName(TaskType type) {
    switch (type) {
      case TaskType.heavy: return "Ağır Görev";
      case TaskType.oneTime: return "Bir Kerelik";
      case TaskType.continuous: return "Sürekli";
      case TaskType.repetitive: return "Tekrar Odaklı";
      case TaskType.negative: return "Negatif Görev";
      case TaskType.periodic: return "Periyodik Görev";
    }
  }

  // Seçilen Görev Tipinin Dinamik Açıklamasını Döndüren Fonksiyon
  String _getTypeDescription(TaskType type) {
    switch (type) {
      case TaskType.heavy:
        return "Kısa süreli ama yüksek efor gerektiren görevler. Örn: 15-30 dk Spor, HIIT.";
      case TaskType.oneTime:
        return "Sadece 'Yapıldı' veya 'Yapılmadı' durumu olan basit görevler. Örn: Yatak toplamak.";
      case TaskType.continuous:
        return "Uzun süreli odak gerektiren görevler. Örn: 1-3 saat Ders çalışmak, Kod yazmak.";
      case TaskType.repetitive:
        return "Günlük rutin olarak birden fazla kez yapılanlar. Örn: 3 kez Diş fırçalamak.";
      case TaskType.negative:
        return "Kaçınmak istediğiniz, kotası olan alışkanlıklar. Örn: Max 2 saat Sosyal medya.";
      case TaskType.periodic:
        return "Belirli aralıklarla yapılması gereken görevler. Örn: 2 günde bir Kitap okumak.";  
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Yeni Görev Oluştur'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // 1. Görev Adı Girişi
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(
                labelText: 'Görev Adı',
                hintText: 'Örn: C# Çalışmak',
                border: OutlineInputBorder(),
                filled: true,
                fillColor: Colors.black26,
              ),
            ),
            const SizedBox(height: 24),

            // 2. Dinamik Açıklama Kutusu (Seçime göre anında değişir)
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.deepPurpleAccent.withOpacity(0.1),
                border: Border.all(color: Colors.deepPurpleAccent.withOpacity(0.5)),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Görev Açıklaması:',
                    style: TextStyle(fontWeight: FontWeight.bold, color: Colors.deepPurpleAccent),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    _getTypeDescription(_selectedType), // Açıklama metnini buradan çekiyoruz
                    style: const TextStyle(fontSize: 14, height: 1.4),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            const Text(
              'Görev Türünü Seçin:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),

            // 3. iPhone Tarzı Kaydırmalı Seçici (CupertinoPicker)
            Container(
              height: 150, // Tekerleğin ekranda kaplayacağı alan
              decoration: BoxDecoration(
                color: Colors.black12,
                borderRadius: BorderRadius.circular(16),
              ),
              child: CupertinoPicker(
                itemExtent: 40, // Her bir satırın yüksekliği
                scrollController: FixedExtentScrollController(
                  initialItem: TaskType.values.indexOf(_selectedType), // Varsayılanı ortala
                ),
                onSelectedItemChanged: (int index) {
                  // Kullanıcı tekerleği her çevirdiğinde ekranı güncelle
                  setState(() {
                    _selectedType = TaskType.values[index];
                  });
                },
                // Enum listemizi tekerleğin içine Türkçe metinler olarak basıyoruz
                children: TaskType.values.map((TaskType type) {
                  return Center(
                    child: Text(
                      _getTypeName(type),
                      style: const TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  );
                }).toList(),
              ),
            ),
            
            const Spacer(),

            // 4. Kaydet Butonu
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                backgroundColor: Colors.deepPurpleAccent,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              onPressed: () {
                if (_titleController.text.isEmpty) return;

                final newTask = TaskModel(
                  id: DateTime.now().millisecondsSinceEpoch.toString(),
                  title: _titleController.text,
                  type: _selectedType,
                  colorTheme: "pixel_purple", 
                );

                widget.onTaskCreated(newTask);
                Navigator.pop(context);
              },
              child: const Text('Görevi Yarat', style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold)),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}