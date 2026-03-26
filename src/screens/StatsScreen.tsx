import { useApp } from "../AppContext";
import { format, startOfMonth, endOfMonth, eachDayOfInterval, isSameDay } from "date-fns";

export const StatsScreen = () => {
  const { user, logs, t } = useApp();
  
  const xpPercentage = (user.currentXp / user.xpToNextLevel) * 100;

  // Heatmap logic
  const monthStart = startOfMonth(new Date());
  const monthEnd = endOfMonth(new Date());
  const days = eachDayOfInterval({ start: monthStart, end: monthEnd });

  const getDayColor = (date: Date) => {
    const dayLogs = logs.filter(l => l.date === format(date, 'yyyy-MM-dd'));
    const totalXp = dayLogs.reduce((acc, curr) => acc + curr.earnedXp, 0);
    
    if (totalXp === 0) return "bg-neutral-800";
    if (totalXp < 50) return "bg-green-900";
    if (totalXp < 150) return "bg-green-700";
    return "bg-green-400";
  };

  return (
    <div className="space-y-8">
      <section className="pixel-card p-6 border-blue-500">
        <div className="flex items-center gap-6 mb-6">
          <div className="w-20 h-20 bg-neutral-700 pixel-border flex items-center justify-center overflow-hidden">
             {/* Placeholder for Pixel Avatar */}
             <div className="w-12 h-12 bg-yellow-500 animate-bounce" />
          </div>
          <div className="flex-1">
            <h2 className="font-pixel text-xs mb-2">{user.username}</h2>
            <div className="flex justify-between text-[10px] font-pixel mb-1">
              <span>LVL {user.level}</span>
              <span>{user.currentXp} / {user.xpToNextLevel} XP</span>
            </div>
            <div className="h-4 bg-black/40 pixel-border overflow-hidden">
              <div 
                className="h-full bg-blue-500 transition-all duration-500" 
                style={{ width: `${xpPercentage}%` }} 
              />
            </div>
          </div>
        </div>

        <div className="grid grid-cols-2 gap-4">
          <div className="bg-black/20 p-3 rounded">
            <span className="text-[10px] font-pixel opacity-60 block mb-1">{t('rest_tokens')}</span>
            <div className="flex gap-1">
              {[...Array(3)].map((_, i) => (
                <div key={i} className={`w-4 h-4 pixel-border ${i < user.restTokens ? 'bg-yellow-500' : 'bg-neutral-800'}`} />
              ))}
            </div>
          </div>
          <div className="bg-black/20 p-3 rounded">
            <span className="text-[10px] font-pixel opacity-60 block mb-1">{t('friend_code')}</span>
            <span className="font-retro text-xl text-blue-400">{user.friendCode}</span>
          </div>
        </div>
      </section>

      <section className="pixel-card p-4">
        <h3 className="font-pixel text-[10px] mb-4 opacity-80">{format(new Date(), 'MMMM yyyy')}</h3>
        <div className="grid grid-cols-7 gap-2">
          {days.map(day => (
            <div 
              key={day.toString()} 
              className={`aspect-square pixel-border ${getDayColor(day)}`}
              title={format(day, 'yyyy-MM-dd')}
            />
          ))}
        </div>
      </section>
    </div>
  );
};
