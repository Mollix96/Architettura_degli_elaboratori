#include "xor.h"

void OP_XOR::xorProc()
{
    sc_uint<1> data1;
    sc_uint<1> data2;

    // Legge i valori sul pin di input e li assegna alle variabili 'data'.
    data1 = input1.read();
    data2 = input2.read();

    // Scrive il risultato dell'operazione XOR bit-a-bit sul pin di output.
    output.write(data1.range(0, 0) ^ data2.range(0, 0));
}
