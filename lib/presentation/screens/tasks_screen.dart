import 'package:flutter/material.dart';
import '../viewmodels/task_viewmodel.dart';
import '../../domain/models/task_model.dart';
import 'task_detail_screen.dart';

class TasksScreen extends StatelessWidget {
  final TaskViewModel viewModel;

  const TasksScreen({super.key, required this.viewModel});

  // Görevin bugün aktif olup olmadığını kontrol eden matematik
  bool _isActiveToday(TaskModel task) {
    if (task.type != TaskType.periodic) return true; // Periyodik değilse her zaman aktiftir
    if (task.nextDueDate == null) return true; // Tarih girilmemişse aktiftir
    
    final now = DateTime.now();
    // Eğer bugünün tarihi, görevin yapılması gereken tarihi geçmişse veya o günse aktiftir
    return now.isAfter(task.nextDueDate!) || now.difference(task.nextDueDate!).inDays == 0;
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: viewModel,
      builder: (context, child) {
        final allTasks = viewModel.tasks;

        if (allTasks.isEmpty) {
          return const Center(child: Text("Henüz bir görev yok.\nSağ alttaki + butonuna bas!", textAlign: TextAlign.center));
        }

        // Görevleri iki ayrı listeye ayırıyoruz
        final activeTasks = allTasks.where((task) => _isActiveToday(task)).toList();
        final inactiveTasks = allTasks.where((task) => !_isActiveToday(task)).toList();

        return ListView(
          padding: const EdgeInsets.all(16),
          children: [
            // --- AKTİF GÖREVLER BÖLÜMÜ ---
            const Text("⚡ Bugünün Görevleri", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.tealAccent)),
            const SizedBox(height: 12),
            if (activeTasks.isEmpty)
              const Padding(padding: EdgeInsets.only(bottom: 24), child: Text("Bugün için tüm görevler tamam! 🎉", style: TextStyle(color: Colors.grey))),
            ...activeTasks.map((task) => _buildTaskCard(context, task, isActive: true)),

            const SizedBox(height: 24),

            // --- DİNLENEN (PASİF) GÖREVLER BÖLÜMÜ ---
            if (inactiveTasks.isNotEmpty) ...[
              const Divider(color: Colors.white24),
              const SizedBox(height: 12),
              const Text("💤 Dinlenen Görevler", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.grey)),
              const SizedBox(height: 12),
              ...inactiveTasks.map((task) => _buildTaskCard(context, task, isActive: false)),
            ]
          ],
        );
      },
    );
  }

  // Görev Kartını Çizen Yardımcı Fonksiyon
  Widget _buildTaskCard(BuildContext context, TaskModel task, {required bool isActive}) {
    String subtitleText = "Tip: ${task.type.name.toUpperCase()}";
    
    // Eğer görev pasifse, "X gün kaldı" matematiğini yap
    if (!isActive && task.nextDueDate != null) {
      final daysLeft = task.nextDueDate!.difference(DateTime.now()).inDays;
      subtitleText = "⏳ $daysLeft gün sonra aktif olacak";
    }

    return Card(
      // Pasif görevlerin rengini soluklaştırarak (opacity) UI'da fark yaratıyoruz
      color: isActive ? Colors.deepPurple[900]?.withOpacity(0.5) : Colors.black38,
      shape: RoundedRectangleBorder(
        side: BorderSide(color: isActive ? Colors.deepPurpleAccent : Colors.white12, width: 1),
        borderRadius: BorderRadius.circular(12),
      ),
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        title: Text(
          task.title,
          style: TextStyle(
            fontWeight: FontWeight.bold, 
            fontSize: 18,
            color: isActive ? Colors.white : Colors.grey, // Pasifse yazıyı da gri yap
          ),
        ),
        subtitle: Text(subtitleText, style: TextStyle(color: isActive ? Colors.grey : Colors.white38)),
        // Sadece aktif görevlerde sağ ok çıksın
        trailing: isActive ? const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.deepPurpleAccent) : const Icon(Icons.lock_clock, size: 16, color: Colors.white24),
        onTap: () {
          // Göreve tıklandığında Detay Ekranını aç
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => TaskDetailScreen(
                task: task,
                onDelete: (id) {
                  viewModel.deleteTask(id);
                },
              ),
            ),
          );
        },
      ),
    );
  }
}