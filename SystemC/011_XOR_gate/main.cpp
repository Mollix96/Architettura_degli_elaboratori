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
    sc_signal<sc_uint<1>> sig1; // Primo bit di input.
    sc_signal<sc_uint<1>> sig2; // Secondo bit di input.
    sc_signal<sc_uint<1>> sig3; // Bit di output.

    // Istanzia i moduli DataGen, OP_XOR e Display.
    DataGen datagen("datagen");
    OP_XOR opxor("opxor");
    Display display("display");

    // === Binding dei segnali alle porte dei moduli. ===

    // Binding di Datagen.
    datagen.clk(clock);
    datagen.out1(sig1);
    datagen.out2(sig2);

    // Binding di OP_XOR.
    opxor.input1(sig1);
    opxor.input2(sig2);
    opxor.output(sig3);

    // Binding di Display.
    display.result(sig3);

    // === Fine binding. ===

    // Dichiara ed istanzia il trace file per memorizzare
    // i risultati della simulazione.
    sc_trace_file *traceFile;
    traceFile = sc_create_vcd_trace_file("tracefile");

    // Specifica i segnali da monitorare nel trace file.
    sc_trace(traceFile, clock, "clock"); // clock.
    sc_trace(traceFile, sig1, "Input1"); // sig1.
    sc_trace(traceFile, sig2, "Input2"); // sig2.
    sc_trace(traceFile, sig3, "Result"); // sig3.

    // Avvia la simulazione (parte la schedulazione degli eventi nel kernel).
    sc_start();

    // Chiude il trace file.
    sc_close_vcd_trace_file(traceFile);

    return EXIT_SUCCESS;
}
