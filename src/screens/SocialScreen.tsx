import { useApp } from "../AppContext";
import { Users, MessageSquare } from "lucide-react";

export const SocialScreen = () => {
  const { socialFeed, t } = useApp();

  return (
    <div className="space-y-6">
      <header className="flex justify-between items-center">
        <h1 className="font-pixel text-sm text-white">{t('nav_social')}</h1>
        <button className="pixel-btn bg-blue-600 text-[10px] font-pixel">
          + Arkadaş Ekle
        </button>
      </header>

      <div className="space-y-4">
        {socialFeed.map(item => (
          <div key={item.id} className="pixel-card p-4 border-neutral-600">
            <div className="flex items-center gap-3 mb-3">
              <div className="w-8 h-8 bg-neutral-700 pixel-border flex items-center justify-center">
                <Users size={16} className="text-blue-400" />
              </div>
              <span className="font-pixel text-[10px] text-blue-400">{item.friendName}</span>
              <span className="text-[10px] opacity-40 ml-auto">{item.date}</span>
            </div>
            <p className="font-retro text-lg leading-tight opacity-80">
              {item.summary}
            </p>
            <div className="mt-3 flex gap-4 opacity-40">
              <button className="flex items-center gap-1 text-xs">
                <MessageSquare size={14} /> 0
              </button>
            </div>
          </div>
        ))}
      </div>

      <div className="p-8 text-center opacity-20">
        <p className="font-pixel text-[8px]">Lonca verileri şifrelendi...</p>
      </div>
    </div>
  );
};
