import 'package:flutter/material.dart';
import '../viewmodels/task_viewmodel.dart';
import 'tasks_screen.dart';
import 'add_task_screen.dart';

class MainLayout extends StatefulWidget {
  const MainLayout({super.key});

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  int _currentIndex = 1; 
  
  // UYGULAMANIN HAFIZASI (ViewModel) BURADA BAŞLIYOR
  final TaskViewModel _taskViewModel = TaskViewModel();

  // Ekranlarımızı dinamik (get) hale getirdik ki içine _taskViewModel'ı verebilelim
  List<Widget> get _screens => [
    const Center(child: Text('Sol Ekran: Hesap ve İstatistikler', style: TextStyle(fontSize: 20))),
    TasksScreen(viewModel: _taskViewModel), // Yeni Listeleme Ekranımız!
    const Center(child: Text('Sağ Ekran: Sosyal ve Lonca', style: TextStyle(fontSize: 20))),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nightly Reflection', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: const Color(0xFF121212),
        elevation: 0,
        centerTitle: true,
      ),
      body: _screens[_currentIndex],
      
      // FLOATING ACTION BUTTON (Sihirli "+" Butonu)
      // Sadece 1. sekmedeyken (Görevler) görünsün istiyoruz.
      floatingActionButton: _currentIndex == 1 
          ? FloatingActionButton(
              backgroundColor: Colors.deepPurpleAccent,
              onPressed: () {
                // Ekleme ekranına gidiyoruz
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddTaskScreen(
                      onTaskCreated: (newTask) {
                        // Yeni görev yaratıldığında bunu al ve Hafızaya (ViewModel'a) ekle!
                        _taskViewModel.addTask(newTask);
                      },
                    ),
                  ),
                );
              },
              child: const Icon(Icons.add, color: Colors.white, size: 28),
            )
          : null, // Diğer ekranlardayken butonu gizle

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index; 
          });
        },
        backgroundColor: const Color(0xFF1E1E1E),
        selectedItemColor: Colors.deepPurpleAccent,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profil'),
          BottomNavigationBarItem(icon: Icon(Icons.check_box), label: 'Görevler'),
          BottomNavigationBarItem(icon: Icon(Icons.people), label: 'Lonca'),
        ],
      ),
    );
  }
}