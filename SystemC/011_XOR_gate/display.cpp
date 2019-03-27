#include "display.h"

#include <stdbool.h>
#include <stdio.h>

// Stampa a schermo il risultato.
void Display::displayProc()
{
    cout << "[Display] Result = " << (bool)result.read() << " @ " << sc_time_stamp() << endl;
}
