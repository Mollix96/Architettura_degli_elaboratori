#ifndef DISPLAY_H
#define DISPLAY_H

#include <systemc.h>

// Dichiara il modulo Display.
SC_MODULE(Display)
{
    sc_in<bool> clk;          // Segnale di clock.
    sc_in<sc_uint<5>> result; // Risultato dell'operazione.

    // Prototipi.

    void displayProc(); // Stampa la concetenazione dei bit in input e il risultato.

    // Init del modulo (costruttore della classe).
    SC_CTOR(Display)
    {
        SC_THREAD(displayProc);

        // Sensitivity list.
        sensitive << clk.pos();
    }
};

#endif
