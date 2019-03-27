#include "datagen.h"
#include "display.h"
#include "xor.h"

#include <stdlib.h>
#include <systemc.h>

#define CLOCK_PERIOD 1

// SystemC main.
int sc_main(int, char *[])
{
    // Istanzia un segnale di clock.
    sc_clock clock("clock", CLOCK_PERIOD, SC_NS);

    // Istanzia i segnali di I/O.
    sc_signal<sc_uint<1>> sig1; // Primo input della prima porta XOR.
    sc_signal<sc_uint<1>> sig2; // Secondo input della prima porta XOR.
    sc_signal<sc_uint<1>> sig3; // Primo input della seconda porta XOR.
    sc_signal<sc_uint<1>> sig4; // Secondo input della seconda porta XOR.
    sc_signal<sc_uint<1>> sig5; // Output della prima porta XOR e
                                // primo input della terza porta XOR.
    sc_signal<sc_uint<1>> sig6; // Output della seconda porta XOR e
                                // secondo input della terza porta XOR.
    sc_signal<sc_uint<1>> sig7; // Output della terza porta XOR.

    // Istanzia i moduli.
    // NOTA: occorrono tre porte XOR.
    DataGen datagen("datagen");
    XOR_GATE xorGate1("xorgate1");
    XOR_GATE xorGate2("xorgate2");
    XOR_GATE xorGate3("xorgate3");
    Display display("display");

    // === Binding dei segnali alle porte dei moduli. ===

    // Binding di Datagen.
    datagen.clk(clock);
    datagen.output1(sig1);
    datagen.output2(sig2);
    datagen.output3(sig3);
    datagen.output4(sig4);

    // Binding della prima porta XOR.
    xorGate1.input1(sig1);
    xorGate1.input2(sig2);
    xorGate1.output(sig5);

    // Binding della seconda porta XOR.
    xorGate2.input1(sig3);
    xorGate2.input2(sig4);
    xorGate2.output(sig6);

    // Binding della terza porta XOR.
    // NOTA: gli ingressi di questa porta sono
    // le uscite delle porte XOR precedenti.
    xorGate3.input1(sig5);
    xorGate3.input2(sig6);
    xorGate3.output(sig7);

    // Binding di Display.
    display.clk(clock);
    display.input1(sig1);
    display.input2(sig2);
    display.input3(sig3);
    display.input4(sig4);
    display.result(sig7); // Output dell'ultima porta XOR.

    // === Fine binding. ===

    // Dichiara ed istanzia il trace file per memorizzare
    // i risultati della simulazione.
    sc_trace_file *traceFile;
    traceFile = sc_create_vcd_trace_file("tracefile");

    // Specifica i segnali da monitorare nel trace file.
    sc_trace(traceFile, clock, "clock"); // clock.
    sc_trace(traceFile, sig1, "Input1"); // sig1.
    sc_trace(traceFile, sig2, "Input2"); // sig2.
    sc_trace(traceFile, sig3, "Input3"); // sig3.
    sc_trace(traceFile, sig4, "Input4"); // sig4.
    sc_trace(traceFile, sig7, "Result"); // sig7.

    // Avvia la simulazione (parte la schedulazione degli eventi nel kernel).
    sc_start();

    // Chiude il trace file.
    sc_close_vcd_trace_file(traceFile);

    return EXIT_SUCCESS;
}
