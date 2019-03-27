#ifndef DISPLAY_H
#define DISPLAY_H

#include <systemc.h>

// Dichiara il modulo Display.
SC_MODULE(Display)
{
    sc_in<bool> clk;          // Segnale di clock.
    sc_in<sc_uint<1>> input1; // Primo bit in input.
    sc_in<sc_uint<1>> input2; // Secondo bit in input.
    sc_in<sc_uint<1>> input3; // Terzo bit in input.
    sc_in<sc_uint<1>> input4; // Quarto bit in input.
    sc_in<sc_uint<1>> result; // Risultato dell'operazione.

    // Prototipi.

    void displayProc(); // Stampa la concetenazione dei bit in input e il risultato.

    // Init del modulo (costruttore della classe).
    SC_CTOR(Display)
    {
        SC_METHOD(displayProc);

        // Sensitivity list.
        // NOTA: il modulo display viene risvegliato ad ogni fronte positivo del clock,
        // pertanto e' normale che la stampa avvenga con un ciclo di ritardo.
        sensitive << clk.pos();
    }
};

#endif
