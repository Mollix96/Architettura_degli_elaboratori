#ifndef AND_H
#define AND_H

#include <systemc.h>

SC_MODULE(AND_GATE)
{
    sc_in<sc_uint<1>> input1;  // Primo bit di input.
    sc_in<sc_uint<1>> input2;  // Secondo bit di input.
    sc_out<sc_uint<1>> output; // Output.

    // Prototipi.
    void andProc();

    // Init del modulo (costruttore della classe).
    SC_CTOR(AND_GATE)
    {
        SC_METHOD(andProc);

        // Sensitivity list (segnali che triggerano il kernel).
        // Questo modulo deve essere eseguito ogni volta
        // che uno dei due ingressi cambia.
        sensitive << input1 << input2;
    }
};

#endif
