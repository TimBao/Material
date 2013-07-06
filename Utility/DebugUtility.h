#include <sys/time.h>
#include <stdio.h>

class DebugUtility
{
public:
    DebugUtility () { gettimeofday(&m_startTime, NULL);  }
    virtual ~DebugUtility () { gettimeofday(&m_stopTime, NULL); printf("Total time elapsed : %.00lf us\n" , TimeDuration(m_startTime, m_stopTime)); }

private:
    double TimeDuration(struct timeval start, struct timeval stop);
    // Disable "evil" constructor
    DebugUtility(const DebugUtility&);
    void operator=(const DebugUtility&);

    struct timeval m_startTime;
    struct timeval m_stopTime;
};


double DebugUtility::TimeDuration(struct timeval start, struct timeval stop)
{
    double mStart = (double)start.tv_sec*1000000 + (double)start.tv_usec;
    double mStop = (double)stop.tv_sec*1000000 + (double)stop.tv_usec;
    return mStop - mStart;
}

DebugUtility::DebugUtility(const DebugUtility& du)
{

}

void operator=(const DebugUtility& du)
{

}

