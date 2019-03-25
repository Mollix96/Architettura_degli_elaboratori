#ifndef DATAGEN_H
#define DATAGEN_H

#include <systemc.h>

SC_MODULE(DataGen)
{
    // Porta di input (segnale di clock).
    sc_in<bool> clk;

    // Porta di output:
    // due bit rappresentano il primo ed il
    // secondo input per una porta AND (00, 01, 10, 11).
    sc_out<sc_uint<2>> output;

    // Prototipi.
    void datagenProc();

    // Init del modulo (costruttore della classe).
    SC_CTOR(DataGen)
    {
        SC_THREAD(datagenProc);

        // Sensitivity list.
        // Questo modulo deve essere eseguito ad ogni fronte
        // positivo del clock.
        sensitive << clk.pos();
    }
};

#endif
