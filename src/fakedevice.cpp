#include <chrono>
#include <thread>

#include "include/fakedevice.h"

namespace FakeDevice
{
    int open()
    {
        return 0;
    }

    int close()
    {
        return 0;
    }

    int read(unsigned char *, int length)
    {
        std::this_thread::sleep_for(std::chrono::seconds(2));
        return length;
    }

    int write(unsigned char *, int length)
    {
        return length;
    }

}