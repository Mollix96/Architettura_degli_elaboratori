#include "and.h"
#include "datagen.h"
#include "display.h"

#include <stdlib.h>
#include <systemc.h>

#define CLOCK_PERIOD 1

// SystemC main.
int sc_main(int, char *[])
{
    // Istanzia un segnale di clock.
    sc_clock clock("clock", CLOCK_PERIOD, SC_NS);

    // Istanzia i segnali di I/O.
    sc_signal<sc_uint<2>> sig1; // I due bit di input.
    sc_signal<sc_uint<1>> sig2; // Il bit di output.

    // Istanzia i moduli DataGen, OP_AND e Display.
    DataGen datagen("datagen");
    OP_AND opand("opand");
    Display display("display");

    // === Binding dei segnali alle porte dei moduli. ===

    // Binding di Datagen.
    datagen.clk(clock);
    datagen.output(sig1);

    // Binding di OP_AND.
    opand.input(sig1);
    opand.output(sig2);

    // Binding di Display.
    display.result(sig2);

    // === Fine binding. ===

    // Dichiara ed istanzia il trace file per memorizzare
    // i risultati della simulazione.
    sc_trace_file *traceFile;
    traceFile = sc_create_vcd_trace_file("tracefile");

    // Specifica i segnali da monitorare nel trace file.
    sc_trace(traceFile, clock, "clock"); // clock.
    sc_trace(traceFile, sig1, "Input");  // sig1.
    sc_trace(traceFile, sig2, "Result"); // sig2.

    // Avvia la simulazione (parte la schedulazione degli eventi nel kernel).
    sc_start();

    // Chiude il trace file.
    sc_close_vcd_trace_file(traceFile);

    return EXIT_SUCCESS;
}
