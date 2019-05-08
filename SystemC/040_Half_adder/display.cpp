#include "display.h"

#include <stdio.h>

void Display::displayProc()
{
    while (true)
    {
        cout << "[Display] Input: "
             << input1.read() << " "
             << input2.read()
             << "  |  Sum: " << sum
             << "  |  Carry: " << carry
             << "\t@ " << sc_time_stamp()
             << endl;

        wait();
    }
}
