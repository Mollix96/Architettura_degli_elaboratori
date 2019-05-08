#ifndef FSM_H
#define FSM_H

#include <systemc.h>

SC_MODULE(FSM)
{
    // Inputs.
    sc_in<bool> clk; // Segnale di clock.
    sc_in<bool> fiveCents;
    sc_in<bool> tenCents;
    sc_in<bool> reset;
    sc_in<bool> curState0; // Bit di stato.
    sc_in<bool> curState1; // Bit di stato.

    // Outputs.
    sc_out<bool> open;
    sc_out<bool> nextState0; // Bit di stato.
    sc_out<bool> nextState1; // Bit di stato.
    sc_out<bool> curState0f; // Bit di stato.
    sc_out<bool> curState1f; // Bit di stato.

    // Prototipi.
    void nextStateUpdate(); // Transizione di stato.
    void outputLogic();     // Decide il bit 'open'.
    void flops();

    // Init del modulo (costruttore).
    SC_CTOR(FSM)
    {
        SC_METHOD(nextStateUpdate);
        sensitive << fiveCents << tenCents << curState0 << curState1;

        SC_METHOD(outputLogic);
        sensitive << curState0 << curState1;

        SC_METHOD(flops);
        sensitive << clk.pos();
    }
};

#endif
