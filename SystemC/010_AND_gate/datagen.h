#ifndef DATAGEN_H
#define DATAGEN_H

#include <systemc.h>

//Crea il modulo DataGen
SC_MODULE(DataGen)
{
    // Crea gli input/output
    sc_in<bool> clk; // Segnale di clock.

    sc_out<bool> out1; // Primo valore da generare.
    sc_out<bool> out2; // Secondo valore da generare.

    // Prototipi.
    void datagenProc();

    // Init del modulo (costruttore della classe).
    SC_CTOR(DataGen)
    {
        // Definisce la funzione DataGen_Proc()
        // come un “SC_THREAD”.
        SC_THREAD(datagenProc);

        // Rende il THREAD sensibile al fronte di salita del clock.
        sensitive << clk.pos();
    }
};

#endif
