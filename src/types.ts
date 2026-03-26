export type TaskType = 'heavy' | 'one_time' | 'continuous' | 'repetitive' | 'negative';

export interface TaskTier {
  label: string;
  xp: number;
  intensity: number;
}

export interface TaskTemplate {
  id: string;
  type: TaskType;
  titleKey: string;
  colorTheme: string;
  tiers?: Record<string, TaskTier>;
  baseXp?: number;
  quota?: {
    limitType: 'duration' | 'count';
    maxAllowed: number;
    baseXp: number;
    bonusXpUnderLimit: number;
  };
}

export interface DailyLog {
  taskId: string;
  date: string;
  achievedTier?: string;
  quotaStatus?: 'under_limit' | 'at_limit' | 'over_limit';
  earnedXp: number;
  completed: boolean;
}

export interface UserProfile {
  username: string;
  friendCode: string;
  level: number;
  currentXp: number;
  xpToNextLevel: number;
  restTokens: number;
}

export interface SocialFeedItem {
  id: string;
  friendName: string;
  date: string;
  summary: string;
}
