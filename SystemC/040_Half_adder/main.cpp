#include "and.h"
#include "datagen.h"
#include "display.h"
#include "xor.h"

#include <stdlib.h>
#include <systemc.h>

#define CLOCK_PERIOD 1

/**
 * SystemC main.
 */
int sc_main(int, char *[])
{
    /**
     * Istanzia un segnale di clock.
     */
    sc_clock clock("clock", CLOCK_PERIOD, SC_NS);

    /**
     * Istanzia i segnali di I/O.
     */
    sc_signal<sc_uint<1>> sig1;     // Primo input.
    sc_signal<sc_uint<1>> sig2;     // Secondo input.
    sc_signal<sc_uint<1>> sigSum;   // Output della porta XOR.
    sc_signal<sc_uint<1>> sigCarry; // Output della porta AND.

    /**
     * Istanzia i moduli.
     */
    DataGen datagen("datagen");
    XOR_GATE xorGate("xorgate");
    AND_GATE andGate("andgate");
    Display display("display");

    /**
     * Binding dei segnali alle porte dei moduli.
     */

    // Binding di Datagen.
    datagen.clk(clock);
    datagen.output1(sig1);
    datagen.output2(sig2);

    // Binding della porta XOR.
    xorGate.input1(sig1);
    xorGate.input2(sig2);
    xorGate.output(sigSum);

    // Binding della porta AND.
    andGate.input1(sig1);
    andGate.input2(sig2);
    andGate.output(sigCarry);

    // Binding di Display.
    display.clk(clock);
    display.input1(sig1);
    display.input2(sig2);
    display.sum(sigSum);
    display.carry(sigCarry);

    /**
     * Dichiara ed istanzia il trace file per memorizzare
     * i risultati della simulazione.
     */
    sc_trace_file *traceFile;
    traceFile = sc_create_vcd_trace_file("tracefile");

    /**
     * Specifica i segnali da monitorare nel trace file.
     */
    sc_trace(traceFile, clock, "clock");    // clock.
    sc_trace(traceFile, sig1, "Input1");    // sig1.
    sc_trace(traceFile, sig2, "Input2");    // sig2.
    sc_trace(traceFile, sigSum, "Sum");     // sum.
    sc_trace(traceFile, sigCarry, "Carry"); // carry.

    /**
     * Avvia la simulazione.
     */
    sc_start();

    /**
     * Chiude il trace file.
     */
    sc_close_vcd_trace_file(traceFile);

    return EXIT_SUCCESS;
}
