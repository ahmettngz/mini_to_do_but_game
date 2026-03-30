class UserModel {
  int level;
  int currentXp;
  int xpToNextLevel;

  UserModel({
    this.level = 1, 
    this.currentXp = 0, 
    this.xpToNextLevel = 100 // İlk level için 100 XP gereksin
  });
}