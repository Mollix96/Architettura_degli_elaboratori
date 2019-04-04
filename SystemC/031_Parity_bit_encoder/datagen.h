#ifndef DATAGEN_H
#define DATAGEN_H

#include <systemc.h>

SC_MODULE(DataGen)
{
    // Porta di input (segnale di clock).
    sc_in<bool> clk;

    // Porte di output.
    sc_out<sc_uint<1>> output1;
    sc_out<sc_uint<1>> output2;
    sc_out<sc_uint<1>> output3;
    sc_out<sc_uint<1>> output4;

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
