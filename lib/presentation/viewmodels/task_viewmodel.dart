import 'package:flutter/material.dart';
import '../../domain/models/task_model.dart';
import '../../data/repositories/mock_task_repository.dart';

// ChangeNotifier: İçindeki veri değiştiğinde arayüze "Kendini Yenile!" sinyali gönderen sihirli sınıftır.
class TaskViewModel extends ChangeNotifier {
  
  // Gizli (private) görev listemiz. Başlangıçta o yazdığımız 4 sahte görevi içine alıyor.
  final List<TaskModel> _tasks = MockTaskRepository().getDailyTasks();

  // Dışarıdan ekranların bu listeyi sadece "okuyabilmesi" için bir köprü
  List<TaskModel> get tasks => _tasks;

  // İŞTE BURASI: Yeni Görev Ekleme Fonksiyonumuz
  void addTask(TaskModel newTask) {
    _tasks.add(newTask); // Görevi listeye ekle
    notifyListeners(); // KRİTİK NOKTA: Ekranlara "Yeni veri geldi, yeniden çizilin!" diye bağırır.
  }
  // Görevi Silme Fonksiyonu
  void deleteTask(String taskId) {
    _tasks.removeWhere((task) => task.id == taskId);
    notifyListeners(); // Arayüze "Görev silindi, listeyi güncelle" diyoruz
  }
  
}