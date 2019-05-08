#ifndef TESTBENCH_H
#define TESTBENCH_H

#include <stdbool.h>
#include <systemc.h>

SC_MODULE(Testbench)
{
    // Inputs.
    sc_in<bool> clk; // Segnale di clock.

    // Outputs.
    sc_out<bool> fiveCents;
    sc_out<bool> tenCents;
    sc_out<bool> reset;
    sc_out<bool> curState0; // Bit di stato.
    sc_out<bool> curState1; // Bit di stato.

    /**
     * Prototipi.
     */
    void generate();

    /**
     * Init del modulo (costruttore).
     */
    SC_CTOR(Testbench)
    {
        SC_THREAD(generate);

        // Sensitivity list.
        // Questo modulo deve essere eseguito ad ogni fronte
        // positivo del clock.
        sensitive << clk.pos();
    }
};

#endif
