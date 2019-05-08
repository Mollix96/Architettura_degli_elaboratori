#include "fsm.h"

/**
 * Implementazioni dei processi.
 */
void FSM::nextStateUpdate()
{
    bool fc, tc;   // 5, 10 cents.
    bool cs0, cs1; // Bit di stato.

    /**
     * Lettura degli ingressi.
     */
    fc = fiveCents.read();
    tc = tenCents.read();
    cs0 = curState0.read();
    cs1 = curState1.read();

    /**
     * Scrittura delle uscite.
     * Decide in quale stato deve passare la macchina.
     */
    nextState0.write(((!cs1) & (!cs0) & (!tc) & (fc)) | ((!cs1) & (cs0) & (!tc) & (!fc)));
    nextState1.write(((!cs1) & (tc) & (!fc)) | ((!cs1) & (!tc) & (fc) & (cs0)));
}

void FSM::outputLogic()
{
    bool cs0, cs1; // Bit di stato.

    /**
     * Lettura degli ingressi.
     */
    cs0 = curState0.read();
    cs1 = curState1.read();

    /**
     * Scrittura delle uscite.
     * Decide se erogare il prodotto.
     */
    open.write((cs1) & (!cs0));
}

void FSM::flops()
{
    if (reset.read() == true)
    {
        curState0f.write(false);
        curState1f.write(false);
    }
    else
    {
        curState0f.write(nextState0);
        curState1f.write(nextState1);
    }
}
