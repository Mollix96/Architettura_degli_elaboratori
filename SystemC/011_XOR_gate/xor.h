#ifndef XOR_H
#define XOR_H

#include <systemc.h>

// Modulo OP_XOR (classe).
SC_MODULE(OP_XOR)
{
    sc_in<sc_uint<1>> input1; // Input 1.
    sc_in<sc_uint<1>> input2; // Input 2.

    sc_out<sc_uint<1>> output; // Output.

    // Prototipo della funzione che esprime la funzionalita'
    // del metodo.
    void xorProc(); // Processo.

    // Init del modulo (costruttore della classe).
    SC_CTOR(OP_XOR)
    {
        SC_METHOD(xorProc);

        // Sensitivity list (segnali che triggerano il kernel).
        // Il modulo OP_XOR deve essere eseguito ogni volta
        // che uno dei due ingressi cambia.
        sensitive << input1 << input2;
    }
};

#endif
