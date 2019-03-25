#ifndef AND_H
#define AND_H

#include <systemc.h>

// Modulo OP_AND (classe).
SC_MODULE(OP_AND)
{
    sc_in<bool> input1; // Input 1.
    sc_in<bool> input2; // Input 2.

    sc_out<bool> output; // Output.

    // Prototipi.
    void andProc(); // Processo.

    // Init del modulo (costruttore della classe).
    SC_CTOR(OP_AND)
    {
        SC_METHOD(andProc);

        // Sensitivity list (segnali che triggerano il kernel).
        // Il modulo OP_AND deve essere eseguito ogni volta
        // che uno dei due ingressi cambia.
        sensitive << input1 << input2;
    }
};

#endif
