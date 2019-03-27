#include "display.h"

#include <stdbool.h>
#include <stdio.h>

// Stampa il risultato.
void Display::displayProc()
{
    // NOTA: 'result' e' di tipo 'sc_in', pertanto l'accesso va fatto con una read().
    cout << "[Display] Result = " << (bool)result.read().range(0, 0) << " @ " << sc_time_stamp() << endl;
}
