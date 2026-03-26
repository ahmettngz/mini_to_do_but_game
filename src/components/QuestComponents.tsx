import { useApp } from "../AppContext";
import { TaskTemplate, DailyLog } from "../types";
import { motion, AnimatePresence } from "motion/react";
import { Check, X, Trophy, Zap, Clock, Repeat, ShieldAlert } from "lucide-react";
import { useState } from "react";
import { clsx, type ClassValue } from "clsx";
import { twMerge } from "tailwind-merge";

function cn(...inputs: ClassValue[]) {
  return twMerge(clsx(inputs));
}

export const QuestCard = ({ task, log, onClick }: { task: TaskTemplate, log?: DailyLog, onClick: () => void, key?: string }) => {
  const { t } = useApp();
  
  const getIcon = () => {
    switch (task.type) {
      case 'heavy': return <Zap size={20} />;
      case 'one_time': return <Trophy size={20} />;
      case 'continuous': return <Clock size={20} />;
      case 'repetitive': return <Repeat size={20} />;
      case 'negative': return <ShieldAlert size={20} />;
    }
  };

  return (
    <motion.div 
      whileTap={{ scale: 0.98 }}
      onClick={onClick}
      className={cn(
        "pixel-card p-4 mb-4 cursor-pointer transition-colors",
        log?.completed ? "opacity-60 bg-neutral-800" : "hover:bg-neutral-700"
      )}
      style={{ borderColor: task.colorTheme }}
    >
      <div className="flex items-center justify-between">
        <div className="flex items-center gap-4">
          <div className="p-2 bg-black/20 rounded-sm" style={{ color: task.colorTheme }}>
            {getIcon()}
          </div>
          <div>
            <h3 className="font-pixel text-[10px] leading-tight mb-1">{t(task.titleKey)}</h3>
            <span className="text-xs opacity-60 uppercase tracking-wider">{t(task.type)}</span>
          </div>
        </div>
        
        {log?.completed ? (
          <div className="flex flex-col items-end">
            <Check className="text-green-500" size={24} />
            <span className="text-[10px] font-pixel text-yellow-500">+{log.earnedXp} XP</span>
          </div>
        ) : (
          <div className="w-6 h-6 border-2 border-dashed border-white/20" />
        )}
      </div>
    </motion.div>
  );
};

export const QuestModal = ({ task, isOpen, onClose }: { task: TaskTemplate | null, isOpen: boolean, onClose: () => void }) => {
  const { t, completeTask } = useApp();
  const [selectedTier, setSelectedTier] = useState<string | null>(null);

  if (!task) return null;

  const handleComplete = (tierKey?: string, quotaStatus?: any) => {
    let earnedXp = 0;
    if (task.type === 'one_time') {
      earnedXp = task.baseXp || 0;
    } else if (tierKey && task.tiers) {
      earnedXp = task.tiers[tierKey].xp;
    } else if (quotaStatus && task.quota) {
      if (quotaStatus === 'under_limit') earnedXp = task.quota.baseXp + task.quota.bonusXpUnderLimit;
      else if (quotaStatus === 'at_limit') earnedXp = task.quota.baseXp;
      else earnedXp = 0;
    }

    completeTask(task.id, { 
      achievedTier: tierKey, 
      quotaStatus, 
      earnedXp 
    });
    onClose();
    setSelectedTier(null);
  };

  return (
    <AnimatePresence>
      {isOpen && (
        <>
          <motion.div 
            initial={{ opacity: 0 }}
            animate={{ opacity: 1 }}
            exit={{ opacity: 0 }}
            onClick={onClose}
            className="fixed inset-0 bg-black/80 z-40 backdrop-blur-sm"
          />
          <motion.div 
            initial={{ y: "100%" }}
            animate={{ y: 0 }}
            exit={{ y: "100%" }}
            className="fixed bottom-0 left-0 right-0 bg-[#222] z-50 p-6 pixel-border border-t-4 border-white/10 rounded-t-2xl"
          >
            <div className="max-w-md mx-auto">
              <div className="flex justify-between items-center mb-6">
                <h2 className="font-pixel text-xs text-yellow-500">{t(task.titleKey)}</h2>
                <button onClick={onClose}><X size={24} /></button>
              </div>

              <div className="space-y-4">
                {task.type === 'one_time' && (
                  <button 
                    onClick={() => handleComplete()}
                    className="pixel-btn w-full bg-green-600 hover:bg-green-500 font-pixel text-[10px]"
                  >
                    {t('done')} (+{task.baseXp} XP)
                  </button>
                )}

                {(task.type === 'heavy' || task.type === 'continuous' || task.type === 'repetitive') && task.tiers && (
                  <div className="grid gap-3">
                    {Object.entries(task.tiers).map(([key, tier]) => (
                      <button 
                        key={key}
                        onClick={() => handleComplete(key)}
                        className="pixel-btn w-full flex justify-between items-center bg-neutral-700 hover:bg-neutral-600"
                      >
                        <span className="font-retro text-xl">{tier.label}</span>
                        <span className="font-pixel text-[8px] text-yellow-400">+{tier.xp} XP</span>
                      </button>
                    ))}
                  </div>
                )}

                {task.type === 'negative' && (
                  <div className="grid gap-3">
                    <button 
                      onClick={() => handleComplete(undefined, 'under_limit')}
                      className="pixel-btn w-full bg-green-700 hover:bg-green-600 flex justify-between items-center"
                    >
                      <span className="font-retro text-xl">{t('under_limit')}</span>
                      <span className="font-pixel text-[8px] text-yellow-400">+{task.quota!.baseXp + task.quota!.bonusXpUnderLimit} XP</span>
                    </button>
                    <button 
                      onClick={() => handleComplete(undefined, 'at_limit')}
                      className="pixel-btn w-full bg-yellow-700 hover:bg-yellow-600 flex justify-between items-center"
                    >
                      <span className="font-retro text-xl">{t('at_limit')}</span>
                      <span className="font-pixel text-[8px] text-yellow-400">+{task.quota!.baseXp} XP</span>
                    </button>
                    <button 
                      onClick={() => handleComplete(undefined, 'over_limit')}
                      className="pixel-btn w-full bg-red-700 hover:bg-red-600 flex justify-between items-center"
                    >
                      <span className="font-retro text-xl">{t('over_limit')}</span>
                      <span className="font-pixel text-[8px] text-white">0 XP</span>
                    </button>
                  </div>
                )}
              </div>
            </div>
          </motion.div>
        </>
      )}
    </AnimatePresence>
  );
};
