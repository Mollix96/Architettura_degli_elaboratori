#include "fsm.h"
#include "testbench.h"

#include <stdlib.h>
#include <systemc.h>

#define CLOCK_PERIOD 1

int sc_main(int, char *[])
{
    /**
     * Istanzia un segnale di clock.
     */
    sc_clock clock("clock", CLOCK_PERIOD, SC_NS);

    /**
     * Istanzia i segnali di I/O.
     */
    sc_signal<bool> sigFiveCents;
    sc_signal<bool> sigTenCents;
    sc_signal<bool> sigReset;
    sc_signal<bool> sigCurState0;
    sc_signal<bool> sigCurState1;
    sc_signal<bool> sigOpen;
    sc_signal<bool> sigNextState0;
    sc_signal<bool> sigNextState1;
    sc_signal<bool> sigCurState0f;
    sc_signal<bool> sigCurState1f;

    /**
     * Istanzia i moduli.
     */
    Testbench testbench("testbench");
    FSM fsm("finiteStateMachine");

    /**
     * Binding dei segnali alle porte dei moduli.
     */

    // Binding di Testbench.
    testbench.clk(clock);
    testbench.fiveCents(sigFiveCents);
    testbench.tenCents(sigTenCents);
    testbench.reset(sigReset);
    testbench.curState0(sigCurState0);
    testbench.curState1(sigCurState1);

    // Binding della finite state machine.
    fsm.clk(clock);
    fsm.fiveCents(sigFiveCents);
    fsm.tenCents(sigTenCents);
    fsm.reset(sigReset);
    fsm.curState0(sigCurState0);
    fsm.curState1(sigCurState1);
    fsm.open(sigOpen);
    fsm.nextState0(sigNextState0);
    fsm.nextState1(sigNextState1);
    fsm.curState0f(sigCurState0f);
    fsm.curState1f(sigCurState1f);

    /**
     * Dichiara ed istanzia il trace file per memorizzare
     * i risultati della simulazione.
     */
    sc_trace_file *traceFile;
    traceFile = sc_create_vcd_trace_file("tracefile");

    /**
     * Specifica i segnali da monitorare nel trace file.
     */
    sc_trace(traceFile, clock, "Clock");         // Clock.
    sc_trace(traceFile, sigReset, "Reset");      // Reset.
    sc_trace(traceFile, sigFiveCents, "5cents"); // 5 cents.
    sc_trace(traceFile, sigTenCents, "10cents"); // 10 cents.
    sc_trace(traceFile, sigCurState0, "X0");     // X0.
    sc_trace(traceFile, sigCurState1, "X1");     // X1.
    sc_trace(traceFile, sigNextState0, "Y0");    // Y0.
    sc_trace(traceFile, sigNextState1, "Y1");    // Y1.
    sc_trace(traceFile, sigCurState0f, "X0F");   // X0F.
    sc_trace(traceFile, sigCurState1f, "X1F");   // X1F.
    sc_trace(traceFile, sigOpen, "Open");        // Open.

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
