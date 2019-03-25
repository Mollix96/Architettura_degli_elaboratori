#ifndef DISPLAY_H
#define DISPLAY_H

#include <systemc.h>

// Dichiara il modulo Display.
SC_MODULE(Display)
{
    // Dichiara gli input/output.
    sc_in<bool> result;

    // Dichiara il prototipo della funzione.
    void displayProc();

    // Dichiara il constructor.
    SC_CTOR(Display)
    {
        // Dichiara la funzione displayProc()
        // come un SC_METHOD.
        SC_METHOD(displayProc);

        // Renderla sensibile all'input.
        sensitive << result;
    }
};

#endif
