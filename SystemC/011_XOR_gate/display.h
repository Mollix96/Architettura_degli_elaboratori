#ifndef DISPLAY_H
#define DISPLAY_H

#include <systemc.h>

// Dichiara il modulo Display.
SC_MODULE(Display)
{
    sc_in<sc_uint<1>> result;

    // Prototipi.
    void displayProc();

    // Init del modulo (costruttore della classe).
    SC_CTOR(Display)
    {
        // Dichiara la funzione displayProc()
        // come un SC_METHOD.
        SC_METHOD(displayProc);

        // Sensitivity list.
        sensitive << result;
    }
};

#endif
