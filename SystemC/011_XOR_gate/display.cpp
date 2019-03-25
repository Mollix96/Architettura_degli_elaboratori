#include "display.h"

#include <stdbool.h>
#include <stdio.h>

// Metodo Display_Proc() per stampare il risultato.
void Display::display_proc()
{
    cout << "Result = " << (bool)result.read() << " @ " << sc_time_stamp() << endl;
}
