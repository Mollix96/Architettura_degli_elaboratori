#include "display.h"

#include <stdbool.h>
#include <stdio.h>

void Display::displayProc()
{
    while (true)
    {
        cout << "[Display] Result: "
             << result.read() << " : "
             << (sc_bv<5>)result.read() << "\t@ "
             << sc_time_stamp() << endl;

        wait();
    }
}
