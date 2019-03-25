#include "and.h"

void OP_AND::andProc()
{
    sc_uint<2> data;

    // Legge la coppia di bit sul pin di input e la assegna alla variabile 'data'.
    data = input.read();

    // Effettua l'operazione di AND bit-a-bit tra i due bit dell'input.
    // Sceglie come primo bit quello piu' a sinsitra.
    output.write(data.range(1, 1) & data.range(0, 0));
}
