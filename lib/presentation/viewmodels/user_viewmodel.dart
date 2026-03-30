import 'package:flutter/material.dart';
import '../../domain/models/user_model.dart';

class UserViewModel extends ChangeNotifier {
  final UserModel _user = UserModel();

  UserModel get user => _user;

  // SİHİRLİ FONKSİYON: XP Ekleme ve Level Atlama
  void addXp(int amount) {
    _user.currentXp += amount;
    
    // Eğer mevcut XP, gereken XP'yi geçerse LEVEL ATLA!
    while (_user.currentXp >= _user.xpToNextLevel) {
      _user.currentXp -= _user.xpToNextLevel; // Kalan XP'yi bir sonraki levele aktar
      _user.level++; // Seviyeyi artır
      _user.xpToNextLevel = (_user.xpToNextLevel * 1.5).toInt(); // Her levelda oyun %50 zorlaşsın
    }
    
    notifyListeners(); // Profil ekranına "Yeniden çizil, level atladık!" diye bağırır
  }
}