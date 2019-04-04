#ifndef ENCODER_H
#define ENCODER_H

#include "xor.h"
#include <systemc.h>

SC_MODULE(Encoder)
{
    XOR_GATE xorGate1, xorGate2, xorGate3; // Le tre porte XOR.
    sc_in<sc_uint<1>> extSig1;             // Primo input della prima porta XOR.
    sc_in<sc_uint<1>> extSig2;             // Secondo input della prima porta XOR.
    sc_in<sc_uint<1>> extSig3;             // Primo input della seconda porta XOR.
    sc_in<sc_uint<1>> extSig4;             // Secondo input della seconda porta XOR.
    sc_signal<sc_uint<1>> intSig1;         // Primo input della terza porta XOR.
    sc_signal<sc_uint<1>> intSig2;         // Secondo input della terza porta XOR.
    sc_signal<sc_uint<1>> intSig3;         // Output della terza porta XOR.
    sc_out<sc_uint<5>> outSig;             // Output del modulo dopo la concatenazione.

    // Prototipi.
    void concat()
    {
        outSig = (extSig1, extSig2, extSig3, extSig4, intSig3);
    }

    // Init del modulo (costruttore della classe).
    SC_CTOR(Encoder) : xorGate1("xorgate1"), xorGate2("xorgate2"), xorGate3("xorgate3")
    {
        // === Binding dei segnali. ===

        // Prima porta XOR.
        xorGate1.input1(extSig1);
        xorGate1.input2(extSig2);
        xorGate1.output(intSig1);

        // Seconda porta XOR.
        xorGate2.input1(extSig3);
        xorGate2.input2(extSig4);
        xorGate2.output(intSig2);

        // Terza porta XOR.
        xorGate3.input1(intSig1);
        xorGate3.input2(intSig2);
        xorGate3.output(intSig3);

        SC_METHOD(concat);

        // Sensitivity list.
        sensitive << extSig1 << extSig2 << extSig3 << extSig4 << intSig3;
    }
};

#endif