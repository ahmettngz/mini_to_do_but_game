import { createContext, useContext, useState, ReactNode } from 'react';
import { UserProfile, TaskTemplate, DailyLog, SocialFeedItem } from './types';
import { translations, Language } from './i18n';

interface AppState {
  user: UserProfile;
  tasks: TaskTemplate[];
  logs: DailyLog[];
  socialFeed: SocialFeedItem[];
  lang: Language;
  setLang: (l: Language) => void;
  completeTask: (taskId: string, data: Partial<DailyLog>) => void;
  t: (key: string, params?: Record<string, any>) => string;
}

const AppContext = createContext<AppState | undefined>(undefined);

export const AppProvider = ({ children }: { children: ReactNode }) => {
  const [lang, setLang] = useState<Language>('tr');
  const [user, setUser] = useState<UserProfile>({
    username: "Geliştirici",
    friendCode: "DEV-9A2X",
    level: 5,
    currentXp: 350,
    xpToNextLevel: 500,
    restTokens: 2
  });

  const [tasks] = useState<TaskTemplate[]>([
    {
      id: "t1",
      type: "heavy",
      titleKey: "task_workout",
      colorTheme: "#ef4444",
      tiers: {
        easy: { label: "15 Dk", xp: 20, intensity: 1 },
        medium: { label: "30 Dk", xp: 45, intensity: 2 },
        hard: { label: "1 Saat+", xp: 80, intensity: 3 }
      }
    },
    {
      id: "t2",
      type: "one_time",
      titleKey: "task_make_bed",
      colorTheme: "#22c55e",
      baseXp: 15
    },
    {
      id: "t3",
      type: "continuous",
      titleKey: "task_study",
      colorTheme: "#3b82f6",
      tiers: {
        easy: { label: "1 Saat", xp: 20, intensity: 1 },
        medium: { label: "3 Saat", xp: 50, intensity: 2 },
        hard: { label: "5 Saat+", xp: 100, intensity: 3 }
      }
    },
    {
      id: "t4",
      type: "repetitive",
      titleKey: "task_brush_teeth",
      colorTheme: "#06b6d4",
      tiers: {
        easy: { label: "1 Kez", xp: 5, intensity: 1 },
        medium: { label: "2 Kez", xp: 15, intensity: 2 },
        hard: { label: "3 Kez+", xp: 30, intensity: 3 }
      }
    },
    {
      id: "t5",
      type: "negative",
      titleKey: "task_social_media",
      colorTheme: "#a855f7",
      quota: {
        limitType: "duration",
        maxAllowed: 2,
        baseXp: 30,
        bonusXpUnderLimit: 20
      }
    }
  ]);

  const [logs, setLogs] = useState<DailyLog[]>([]);

  const t = (key: string, params?: Record<string, any>) => {
    let text = (translations[lang] as any)[key] || key;
    if (params) {
      Object.entries(params).forEach(([k, v]) => {
        text = text.replace(`{${k}}`, v);
      });
    }
    return text;
  };

  const completeTask = (taskId: string, data: Partial<DailyLog>) => {
    const earnedXp = data.earnedXp || 0;
    setLogs(prev => [...prev.filter(l => l.taskId !== taskId), {
      taskId,
      date: new Date().toISOString().split('T')[0],
      completed: true,
      earnedXp,
      ...data
    } as DailyLog]);

    setUser(prev => {
      let newXp = prev.currentXp + earnedXp;
      let newLevel = prev.level;
      let nextLevelXp = prev.xpToNextLevel;

      if (newXp >= nextLevelXp) {
        newXp -= nextLevelXp;
        newLevel += 1;
        nextLevelXp = Math.floor(nextLevelXp * 1.2);
      }

      return { ...prev, currentXp: newXp, level: newLevel, xpToNextLevel: nextLevelXp };
    });
  };

  const socialFeed: SocialFeedItem[] = [
    { id: "f1", friendName: "Ahmet", date: "2026-03-26", summary: t('quest_summary', { name: 'Ahmet', count: 4, xp: 240 }) }
  ];

  return (
    <AppContext.Provider value={{ user, tasks, logs, socialFeed, lang, setLang, completeTask, t }}>
      {children}
    </AppContext.Provider>
  );
};

export const useApp = () => {
  const context = useContext(AppContext);
  if (!context) throw new Error("useApp must be used within AppProvider");
  return context;
};
