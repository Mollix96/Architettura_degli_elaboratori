#ifndef DISPLAY_H
#define DISPLAY_H

#include <systemc.h>

SC_MODULE(Display)
{
    sc_in<sc_uint<1>> result;

    // Prototipi.
    void displayProc();

    // Init del modulo (costruttore della classe).
    SC_CTOR(Display)
    {
        // Dichiara la funzione Display_Proc()
        // come un SC_METHOD.
        SC_METHOD(displayProc);

        // Sensitivity list.
        sensitive << result;
    }
};

#endif
