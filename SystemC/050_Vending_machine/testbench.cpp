#include "testbench.h"

void Testbench::generate()
{
    wait();

    /**
     * Reset.
     */
    reset.write(true);

    wait();

    /**
     * Test 1.
     */
    reset.write(false);     // Reset.
    fiveCents.write(false); // 5 cents.
    tenCents.write(false);  // 10 cents.
    curState0.write(false); // X0.
    curState1.write(false); // X1.

    wait();

    /**
     * Test 2.
     */
    reset.write(false);     // Reset.
    fiveCents.write(true);  // 5 cents.
    tenCents.write(false);  // 10 cents.
    curState0.write(false); // X0.
    curState1.write(false); // X1.

    wait();

    /**
     * Test 3.
     */
    reset.write(false);     // Reset.
    fiveCents.write(false); // 5 cents.
    tenCents.write(true);   // 10 cents.
    curState0.write(false); // X0.
    curState1.write(false); // X1.

    wait();

    /**
     * Test 4.
     */
    reset.write(false);     // Reset.
    fiveCents.write(true);  // 5 cents.
    tenCents.write(false);  // 10 cents.
    curState0.write(true);  // X0.
    curState1.write(false); // X1.

    wait();

    /**
     * Test 5.
     */
    reset.write(false);     // Reset.
    fiveCents.write(false); // 5 cents.
    tenCents.write(true);   // 10 cents.
    curState0.write(true);  // X0.
    curState1.write(false); // X1.

    wait();

    /**
     * Test 6.
     */
    reset.write(false);     // Reset.
    fiveCents.write(false); // 5 cents.
    tenCents.write(false);  // 10 cents.
    curState0.write(true);  // X0.
    curState1.write(false); // X1.

    wait();

    /**
     * Test 7.
     * (I valori di fiveCents e tenCents sono sono significativi)
     */
    reset.write(false);     // Reset.
    curState0.write(false); // X0.
    curState1.write(true);  // X1.

    wait();

    sc_stop();
}
