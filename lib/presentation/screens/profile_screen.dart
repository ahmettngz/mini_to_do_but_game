import 'package:flutter/material.dart';
import '../viewmodels/user_viewmodel.dart';
import '../viewmodels/task_viewmodel.dart';

class ProfileScreen extends StatelessWidget {
  final UserViewModel userViewModel;
  final TaskViewModel taskViewModel;

  const ProfileScreen({
    super.key, 
    required this.userViewModel, 
    required this.taskViewModel,
  });

  // Level'a göre RPG Unvanı veren yardımcı fonksiyon
  String _getRankName(int level) {
    if (level < 5) return "Acemi Maceracı";
    if (level < 10) return "Alışkanlık Şövalyesi";
    if (level < 20) return "Disiplin Ustası";
    return "Efsanevi İrade";
  }

  // Profil için aylık genel ısı haritası (Mock)
  Widget _buildMonthlyHeatmap() {
    return Wrap(
      spacing: 4,
      runSpacing: 4,
      children: List.generate(60, (index) { // 60 günlük (2 aylık) geçmiş
        int intensity = (index % 7 == 0) ? 0 : (index % 4);
        Color boxColor;
        
        if (intensity == 0) boxColor = Colors.white10;
        else if (intensity == 1) boxColor = Colors.tealAccent.withOpacity(0.3);
        else if (intensity == 2) boxColor = Colors.tealAccent.withOpacity(0.6);
        else boxColor = Colors.tealAccent; // En yoğun gün

        return Container(
          width: 16,
          height: 16,
          decoration: BoxDecoration(
            color: boxColor,
            borderRadius: BorderRadius.circular(3),
          ),
        );
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    // ListenableBuilder: Kullanıcı XP kazandıkça bu ekran kendini otomatik günceller
    return ListenableBuilder(
      listenable: userViewModel,
      builder: (context, child) {
        final user = userViewModel.user;
        final xpPercentage = user.currentXp / user.xpToNextLevel; // XP Barının doluluk oranı (0.0 ile 1.0 arası)

        return SingleChildScrollView( // Ekrana sığmazsa kaydırılabilsin
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              
              // 1. Avatar ve Level Halkası
              Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    width: 120,
                    height: 120,
                    child: CircularProgressIndicator(
                      value: xpPercentage,
                      strokeWidth: 8,
                      backgroundColor: Colors.white10,
                      color: Colors.tealAccent, // Neon yeşil XP halkası
                    ),
                  ),
                  const CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.deepPurpleAccent,
                    child: Icon(Icons.sports_esports, size: 50, color: Colors.white), // Retro oyun ikonu
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // 2. Seviye ve Unvan Yazıları
              Text(
                "Level ${user.level}",
                style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.white),
              ),
              Text(
                _getRankName(user.level),
                style: const TextStyle(fontSize: 18, color: Colors.tealAccent, letterSpacing: 2),
              ),
              const SizedBox(height: 32),

              // 3. Klasik XP Barı (İlerleme Çubuğu)
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Sonraki Seviyeye:", style: TextStyle(color: Colors.grey)),
                      Text("${user.currentXp} / ${user.xpToNextLevel} XP", style: const TextStyle(fontWeight: FontWeight.bold)),
                    ],
                  ),
                  const SizedBox(height: 8),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: LinearProgressIndicator(
                      value: xpPercentage,
                      minHeight: 12,
                      backgroundColor: Colors.white10,
                      color: Colors.tealAccent,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 40),

              // 4. İstatistik Kartları
              Row(
                children: [
                  Expanded(
                    child: _buildStatCard("Aktif Görev", taskViewModel.tasks.length.toString(), Icons.list_alt, Colors.orangeAccent),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _buildStatCard("Mevcut Seri", "12 Gün", Icons.local_fire_department, Colors.redAccent),
                  ),
                ],
              ),
              const SizedBox(height: 40),

              // 5. GitHub Tarzı Aylık Isı Haritası
              const Align(
                alignment: Alignment.centerLeft,
                child: Text("Aktivite Geçmişi (Son 60 Gün)", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.grey)),
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.black38,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.white12),
                ),
                child: _buildMonthlyHeatmap(),
              ),
            ],
          ),
        );
      },
    );
  }

  // Küçük İstatistik Kartlarını Çizen Yardımcı Fonksiyon
  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 32),
          const SizedBox(height: 8),
          Text(value, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white)),
          const SizedBox(height: 4),
          Text(title, style: const TextStyle(fontSize: 12, color: Colors.grey)),
        ],
      ),
    );
  }
}