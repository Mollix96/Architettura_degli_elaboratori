#ifndef DISPLAY_H
#define DISPLAY_H

#include <systemc.h>

// Dichiara il modulo Display.
SC_MODULE(Display)
{
    sc_in<sc_uint<1>> result;

    // Prototipi.
    void display_proc();

    // Init del modulo (costruttore della classe).
    SC_CTOR(Display)
    {
        // Dichiara la funzione Display_Proc()
        // come un SC_METHOD.
        SC_METHOD(display_proc);

        // Sensitivity list.
        sensitive << result;
    }
};

#endif
