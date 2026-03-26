import { useState } from 'react';
import { AppProvider, useApp } from './AppContext';
import { StatsScreen } from './screens/StatsScreen';
import { QuestsScreen } from './screens/QuestsScreen';
import { SocialScreen } from './screens/SocialScreen';
import { User, Sword, Shield, Globe } from 'lucide-react';
import { motion, AnimatePresence } from 'motion/react';
import { ReactNode } from 'react';

function MainLayout() {
  const [activeTab, setActiveTab] = useState<'stats' | 'quests' | 'social'>('quests');
  const { t, lang, setLang } = useApp();

  const renderScreen = () => {
    switch (activeTab) {
      case 'stats': return <StatsScreen />;
      case 'quests': return <QuestsScreen />;
      case 'social': return <SocialScreen />;
    }
  };

  return (
    <div className="min-h-screen bg-[#1a1a1a] text-[#f0f0f0] flex flex-col max-w-md mx-auto relative overflow-hidden">
      {/* Language Toggle */}
      <button 
        onClick={() => setLang(lang === 'tr' ? 'en' : 'tr')}
        className="absolute top-4 right-4 z-10 p-2 bg-black/40 pixel-border text-[10px] font-pixel flex items-center gap-2"
      >
        <Globe size={14} />
        {lang.toUpperCase()}
      </button>

      <main className="flex-1 p-6 overflow-y-auto">
        <AnimatePresence mode="wait">
          <motion.div
            key={activeTab}
            initial={{ opacity: 0, x: 20 }}
            animate={{ opacity: 1, x: 0 }}
            exit={{ opacity: 0, x: -20 }}
            transition={{ duration: 0.2 }}
          >
            {renderScreen()}
          </motion.div>
        </AnimatePresence>
      </main>

      {/* Navigation Bar */}
      <nav className="fixed bottom-0 left-0 right-0 max-w-md mx-auto bg-[#222] border-t-4 border-black p-2 flex justify-around z-30">
        <NavButton 
          active={activeTab === 'stats'} 
          onClick={() => setActiveTab('stats')}
          icon={<User size={24} />}
          label={t('nav_stats')}
        />
        <NavButton 
          active={activeTab === 'quests'} 
          onClick={() => setActiveTab('quests')}
          icon={<Sword size={24} />}
          label={t('nav_quests')}
        />
        <NavButton 
          active={activeTab === 'social'} 
          onClick={() => setActiveTab('social')}
          icon={<Shield size={24} />}
          label={t('nav_social')}
        />
      </nav>
    </div>
  );
}

function NavButton({ active, onClick, icon, label }: { active: boolean, onClick: () => void, icon: ReactNode, label: string }) {
  return (
    <button 
      onClick={onClick}
      className={`flex flex-col items-center gap-1 p-2 transition-all ${active ? 'text-yellow-500 scale-110' : 'text-white/40'}`}
    >
      <div className={`${active ? 'pixel-border bg-yellow-500/10 p-1' : ''}`}>
        {icon}
      </div>
      <span className="font-pixel text-[8px] uppercase tracking-tighter">{label}</span>
    </button>
  );
}

export default function App() {
  return (
    <AppProvider>
      <MainLayout />
    </AppProvider>
  );
}
