#include "and.h"

void OP_AND::andProc()
{
    bool data1;
    bool data2;

    // Legge i valori sul pin di input e li assegna alle variabili 'data'.
    data1 = input1.read();
    data2 = input2.read();

    // Scrive il risultato dell'operazione AND bit-a-bit sul pin di output.
    output.write(data1 & data2);
}
