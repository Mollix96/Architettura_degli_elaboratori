#include "datagen.h"
#include "display.h"
#include "encoder.h"
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
    sc_signal<sc_uint<1>> sig1; // Primo input
    sc_signal<sc_uint<1>> sig2; // Secondo input
    sc_signal<sc_uint<1>> sig3; // Terzo input
    sc_signal<sc_uint<1>> sig4; // Quarto input
    sc_signal<sc_uint<5>> sig5; // Output.

    // Istanzia i moduli.
    DataGen datagen("datagen");
    Display display("display");
    Encoder encoder("encoder");

    // === Binding dei segnali alle porte dei moduli. ===

    // Binding di Datagen.
    datagen.clk(clock);
    datagen.output1(sig1);
    datagen.output2(sig2);
    datagen.output3(sig3);
    datagen.output4(sig4);

    // Binding di Encoder.
    encoder.extSig1(sig1);
    encoder.extSig2(sig2);
    encoder.extSig3(sig3);
    encoder.extSig4(sig4);
    encoder.outSig(sig5);

    // Binding di Display.
    display.clk(clock);
    display.result(sig5);

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
    sc_trace(traceFile, sig5, "Result"); // sig5.

    // Avvia la simulazione.
    sc_start();

    // Chiude il trace file.
    sc_close_vcd_trace_file(traceFile);

    return EXIT_SUCCESS;
}
