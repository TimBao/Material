## Task queue

### UML

@startuml taskqueue.png

class Task {

    + virtual void Execute(void) = 0

    + uint32 m_taskId

}

class TaskQueue {

    + virtual PAL_Error AddTask(Task* task) = 0
    + virtual PAL_Error RemoveTask(Task* task, bool cancelIfRunning) = 0
    + virtual void RemoveAllTasks(void) = 0

}

class EventTaskQueue {

    + virtual PAL_Error AddTask(Task* task, uint32 priority)
}

class WorkerTaskQueue {

    + virtual PAL_Error AddTask(Task* task, uint32 priority)
}

class UiTaskQueue {

}

TaskQueue <|-- EventTaskQueue
TaskQueue <|-- WorkerTaskQueue
TaskQueue <|-- UiTaskQueue
Task -- TaskQueue

namespace nimpal {
    namespace taskqueue {
        class Task {

            + PAL_Error Execute(void)
            + PAL_Error Cancel(void)
            + uint32 GetPercentageComplete() const
            + void UpdatePercentageComplete(uint32 completed)
            + TaskId Id() const
            + TaskPriority Priority() const

            - TaskId m_taskId
            - TaskPriority m_priority
            - volatile uint32 m_completed
            - PAL_TaskQueueCallback m_userCallback
            - void* m_userData
            - static volatitle TaskId m_nextId

        }

        class TaskQueue {

           + PAL_Error Queue(Task* task)
           + PAL_Error Dequeue(TaskId taskId, bool cancelIfRunning)
           + PAL_Error Clear(void)
           + Task* GetTask(void)
           + bool IsEmpty(void) const
           + const char* GetName(void) const
           + TaskQueueId Id(void) const

           - std::deque<Task*>::iterator GetInsertionInterator(uint32 newTaskPriority)

           - PAL_Lock* m_lock
           - TaskQueueId m_queueId
           - std::deque<Task* > m_taskQueue
           - char name[]
           - static volatile TaskQueueId m_nextId
        }

        class Thread {

            + virutal void NewTaskNotify(void) = 0
            + virtual void CancelRunningTaskNotify(void) = 0
            + virtual PAL_Error StartThread(void) = 0
            + virtual nb_threadId ThreadId(void) const = 0
            + State GetState(void) const

            # void ExecuteTasks(void)
            # void SetState(State state)

            - PAL_Lock m_lock
            - TaskQueue* m_taskQueue
            - ThreadStateListener* m_stateListener
            - Task* m_runningTask
            - State m_state

        }

        enum Thread::State {

            Invalid : 0
            Created
            Pending
            Executing
        }

        class ThreadIphone {

            + void* ThreadMain(void)
            + void NewTaskSourceCb(void)

            - pthread_t m_thread
            - CFRunLoopRef m_runLoop
            - CFRunLoopSourceRef m_newTaskSource
            - PAL_Event* m_threadStartedEvent
            - std::string m_name
        }

        class UiThreadIphone {

            + void NewTaskSourceCb(void)

            - pthread_t m_uiThreadId
            - CFRunLoopSourceRef m_newTaskSource
        }

        class ThreadStateListener {

            + virtual void ThreadStateChanged(Thread* thread, Thread::State state) = 0
        }

        class TaskManager {

            + PAL_Error AddTask(TaskQueue::TaskQueueId queueId,
                                PAL_TaskQueueCallback callback,
                                void* userData, TaskId* taskId,
                                TaskPriority priority = DEFAULT_TASK_PRIORITY)

            + PAL_Error RemoveTask(TaskQueue::TaskQueueId queueId, TaskId taskId, bool cancelIfRunning)
            + PAL_Error RemoveAllTasks(TaskQueue::TaskQueueId queueId)
            + virtual PAL_Error CreateWorkerQueue(const char* name, TaskQueue::TaskQueueId* queueId)
            + virtual PAL_Error DestroyWorkerQueue(TaskQueue::TaskQueueId queueId)
            + virtual TaskQueue::TaskQueueId GetWorkerQueueByName(const char* name) const
            + virtual nb_threadId GetWorkerThreadIdByName(const char* name) const
            + virtual nb_threadId GetEventThreadId(void) const = 0
            + virtual bool Destroy(void) = 0

            # virtual void ThreadStateChanged(Thread* thread, Thread::State state)
            # void FindThreadAndQueuea(TaskQueue::TaskQueueId queueId, Thread** thread, TaskQueue** queue) const = 0
            # virtual PAL_Error Initialize(void) = 0

            - PAL_Lock* m_lock
            - bool m_needToDestroy
        }

        TaskQueue "1" *-- "many" Task
        Thread *-- ThreadStateListener
        Thread *-- TaskQueue
        Thread *-- Task
        Thread -- Thread::State
        Thread <|-- ThreadIphone
        Thread <|-- UiThreadIphone
        ThreadStateListener <|-- TaskManager
        TaskManager o-- Task
        TaskManager -- TaskQueue
        TaskManager -- Thread
        TaskManager <|-- TaskManagerMultiThreaded
        TaskManager <|-- TaskManagerSingleThreaded

    }

    class PalAbstractFactor {

        static Thread* CreateThread(PAL_Instance* pal, TaskQueue* taskQueue, ThreadStateListener* listener, const char* name)
        static Thread* CreateUiThread(PAL_Instance* pal, TaskQueue* taskQueue, ThreadStateListener* listener)
    }

    PalAbstractFactor o-- taskqueue.Thread
    PalAbstractFactor *-- taskqueue.TaskQueue
    PalAbstractFactor *-- taskqueue.ThreadStateListener
}

TaskQueue -- taskqueue.TaskManager

@enduml
