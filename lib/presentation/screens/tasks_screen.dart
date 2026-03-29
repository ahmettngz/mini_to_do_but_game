import 'package:flutter/material.dart';
import '../viewmodels/task_viewmodel.dart';
import 'task_detail_screen.dart '; // Detay ekranını içeri aktarıyoruz
class TasksScreen extends StatelessWidget {
  final TaskViewModel viewModel; // Beynimiz buraya dışarıdan gelecek

  const TasksScreen({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    // ListenableBuilder: ViewModel'i dinler, yeni görev eklendiğinde SADECE bu listeyi günceller.
    return ListenableBuilder(
      listenable: viewModel,
      builder: (context, child) {
        final tasks = viewModel.tasks; // Görevleri çekiyoruz

        if (tasks.isEmpty) {
          return const Center(
            child: Text("Henüz bir görev yok.\nSağ alttaki + butonuna bas!", textAlign: TextAlign.center),
          );
        }

        // ListView.builder: Ekranda sadece görünen kısımları çizer, binlerce görev olsa bile telefonu kasmaz.
        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: tasks.length,
          itemBuilder: (context, index) {
            final task = tasks[index];
            
            // Retro Tarzı Görev Kartımız
            return Card(
              color: Colors.deepPurple[900]?.withOpacity(0.5),
              shape: RoundedRectangleBorder(
                side: const BorderSide(color: Colors.deepPurpleAccent, width: 1),
                borderRadius: BorderRadius.circular(12),
              ),
              margin: const EdgeInsets.only(bottom: 12),
              child: ListTile(
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                title: Text(
                  task.title,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                subtitle: Text(
                  "Tip: ${task.type.name.toUpperCase()}",
                  style: const TextStyle(color: Colors.grey),
                ),
                trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.deepPurpleAccent),
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
          },
        );
      },
    );
  }
}