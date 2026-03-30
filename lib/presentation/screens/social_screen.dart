import 'package:flutter/material.dart';
import '../widgets/pixel_boss_video.dart';

class SocialScreen extends StatelessWidget {
  const SocialScreen({super.key});

  final List<Map<String, dynamic>> _mockFeed = const [
    {'name': 'Çağla', 'action': '"Boss Deviren" unvanını kazandı!', 'time': '5 dk önce', 'icon': Icons.shield, 'color': Colors.amber},
    {'name': 'Aslan', 'action': '1905 XP barajını aştı ve seviye atladı!', 'time': '12 dk önce', 'icon': Icons.local_fire_department, 'color': Colors.redAccent},
    {'name': 'Kaan', 'action': '3 günlük "Sürekli Odak" serisini tamamladı.', 'time': '1 saat önce', 'icon': Icons.psychology, 'color': Colors.tealAccent},
    {'name': 'Zeynep', 'action': 'Negatif görevinde fire verdi (Sosyal Medya).', 'time': '3 saat önce', 'icon': Icons.warning_amber_rounded, 'color': Colors.orangeAccent},
  ];

  // 💥 YENİ: GÜNLÜK BOSS SAVAŞI KARTI
  // 💥 GÜNCELLENEN: GÜNLÜK BOSS SAVAŞI KARTI (Video Arka Planlı)
  Widget _buildBossBattle() {
    double bossHpPercentage = 0.40; 
    
    return Container(
      height: 240, // Kartın yüksekliğini biraz artırdık
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color.fromARGB(255, 252, 107, 107), width: 2),
        boxShadow: [
          BoxShadow(color: const Color.fromARGB(255, 253, 135, 135).withOpacity(0.3), blurRadius: 15, spreadRadius: 1)
        ],
      ),
      // ClipRRect: İçindeki her şeyi köşeleri yuvarlatılmış kartın içine hapseder
      child: ClipRRect(
        borderRadius: BorderRadius.circular(14),
        child: Stack(
          fit: StackFit.expand,
          children: [
            // 1. KATMAN: Arka Plan Videosu
            const PixelBossVideoPlayer(),

            // 2. KATMAN: Yazıların okunması için Karanlık/Kırmızı Gradyan Filtre
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.black.withOpacity(0.85), const Color.fromARGB(255, 87, 36, 36)!.withOpacity(0.4)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),

            // 3. KATMAN: UI (Arayüz) ve Metinler
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("GÜNLÜK BOSS SAVAŞI", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white, letterSpacing: 1.2)),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(color: const Color.fromARGB(255, 68, 65, 65).withOpacity(0.8), borderRadius: BorderRadius.circular(12)),
                        child: const Row(
                          children: [
                            Icon(Icons.circle, color: Colors.white, size: 10),
                            SizedBox(width: 4),
                            Text("CANLI", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12)),
                          ],
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),
                  
                  const Text("Erteleme Lordu: Procrastinator", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.orangeAccent)),
                  const SizedBox(height: 4),
                  const Text("Loncanın bugün kazandığı tüm XP'ler bossa hasar veriyor!", style: TextStyle(color: Colors.white70, fontSize: 13, fontStyle: FontStyle.italic)),
                  
                  const Spacer(), // Boşluğu otomatik doldurur, alttakileri dibe iter

                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: LinearProgressIndicator(
                      value: bossHpPercentage,
                      minHeight: 14,
                      backgroundColor: Colors.white24,
                      color: Colors.redAccent,
                    ),
                  ),
                  const SizedBox(height: 8),
                  
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Kalan Can: 2000 / 5000", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                      Text("MVP: Çağla (950 Dmg) 👑", style: TextStyle(color: Colors.amber, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  // Liderlik Tablosu
  Widget _buildLeaderboard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: Colors.black38, borderRadius: BorderRadius.circular(16), border: Border.all(color: Colors.white12)),
      child: Column(
        children: [
          const Text("🏆 Haftanın Liderleri", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.amber)),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              _buildPodium("Aslan", "Lvl 8", 60, Colors.grey[400]!), 
              _buildPodium("Çağla", "Lvl 9", 80, Colors.amber),      
              _buildPodium("Kaan", "Lvl 7", 40, Colors.brown[300]!), 
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPodium(String name, String level, double height, Color color) {
    return Column(
      children: [
        Text(level, style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 12)),
        const SizedBox(height: 4),
        Container(
          width: 60, height: height,
          decoration: BoxDecoration(color: color.withOpacity(0.2), borderRadius: const BorderRadius.vertical(top: Radius.circular(8)), border: Border.all(color: color.withOpacity(0.8), width: 2)),
          alignment: Alignment.center,
          child: Text(name, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. BOSS SAVAŞI KARTI (En Tepeye Geldi!)
            _buildBossBattle(),
            const SizedBox(height: 20),

            // 2. Liderlik Tablosu
            _buildLeaderboard(),
            const SizedBox(height: 20),
            
            // 3. Canlı Akış Başlığı
            const Row(
              children: [
                Icon(Icons.rss_feed, color: Colors.tealAccent),
                SizedBox(width: 8),
                Text("Lonca Akışı", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)),
              ],
            ),
            const SizedBox(height: 12),

            // 4. Bildirim Listesi
            Expanded(
              child: ListView.builder(
                itemCount: _mockFeed.length,
                itemBuilder: (context, index) {
                  final item = _mockFeed[index];
                  return Card(
                    color: Colors.white10,
                    margin: const EdgeInsets.only(bottom: 12),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    child: ListTile(
                      leading: CircleAvatar(backgroundColor: item['color'].withOpacity(0.2), child: Icon(item['icon'], color: item['color'])),
                      title: RichText(
                        text: TextSpan(
                          style: const TextStyle(color: Colors.white, fontSize: 15),
                          children: [
                            TextSpan(text: "${item['name']} ", style: const TextStyle(fontWeight: FontWeight.bold)),
                            TextSpan(text: item['action'], style: const TextStyle(color: Colors.white70)),
                          ],
                        ),
                      ),
                      subtitle: Text(item['time'], style: const TextStyle(color: Colors.grey, fontSize: 12)),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}