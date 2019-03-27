#include "display.h"

#include <stdbool.h>
#include <stdio.h>

// Stampa a schermo gli ingressi ed il risultato.
void Display::displayProc()
{
    cout << "[Display] I/O:   "
         << (bool)input1.read()
         << " " << (bool)input2.read()
         << " " << (bool)input3.read()
         << " " << (bool)input4.read()
         << " -> " << (bool)result.read()
         << " @ " << sc_time_stamp() << endl;
}
