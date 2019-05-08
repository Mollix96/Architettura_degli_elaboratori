#ifndef DISPLAY_H
#define DISPLAY_H

#include <systemc.h>

/**
 * Dichiara il modulo Display.
 */
SC_MODULE(Display)
{
    sc_in<bool> clk;          // Segnale di clock.
    sc_in<sc_uint<1>> input1; // Primo valore in input.
    sc_in<sc_uint<1>> input2; // Secondo valore in input.
    sc_in<sc_uint<1>> sum;    // Output della porta XOR.
    sc_in<sc_uint<1>> carry;  // Output della porta AND.

    /**
     * Prototipi.
     */
    void displayProc(); // Stampa i valori delle porte di input.

    /**
     * Init del modulo (costruttore della classe).
     */
    SC_CTOR(Display)
    {
        SC_THREAD(displayProc);

        // Sensitivity list.
        sensitive << clk.pos();
    }
};

#endif
