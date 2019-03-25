#ifndef AND_H
#define AND_H

#include <systemc.h>

SC_MODULE(OP_AND)
{
    sc_in<sc_uint<2>> input;   // Input (intero senza segno a due bit).
    sc_out<sc_uint<1>> output; // Output.

    // Prototipi.
    void andProc();

    // Init del modulo (costruttore della classe).
    SC_CTOR(OP_AND)
    {
        SC_METHOD(andProc);

        // Sensitivity list (segnali che triggerano il kernel).
        // Questo modulo deve essere eseguito ogni volta
        // che uno dei bit dell'input cambia.
        sensitive << input;
    }
};

#endif
