import { useApp } from "../AppContext";
import { QuestCard, QuestModal } from "../components/QuestComponents";
import { useState } from "react";
import { TaskTemplate } from "../types";

export const QuestsScreen = () => {
  const { tasks, logs, t } = useApp();
  const [selectedTask, setSelectedTask] = useState<TaskTemplate | null>(null);

  return (
    <div className="pb-24">
      <header className="mb-8">
        <h1 className="font-pixel text-sm text-white mb-2">{t('nightly_reflection')}</h1>
        <div className="h-1 w-12 bg-yellow-500" />
      </header>

      <div className="space-y-2">
        {tasks.map(task => (
          <QuestCard 
            key={task.id} 
            task={task} 
            log={logs.find(l => l.taskId === task.id)}
            onClick={() => {
              if (!logs.find(l => l.taskId === task.id)) {
                setSelectedTask(task);
              }
            }}
          />
        ))}
      </div>

      <QuestModal 
        task={selectedTask} 
        isOpen={!!selectedTask} 
        onClose={() => setSelectedTask(null)} 
      />
    </div>
  );
};
