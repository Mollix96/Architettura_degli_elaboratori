#include "datagen.h"

#include <stdbool.h>

void DataGen::datagenProc()
{
    sc_uint<4> input;

    wait();

    for (int tempInt = 0b0000; tempInt <= 0b1111; tempInt++)
    {
        // Carica la rappresentazione binaria del contatore.
        input = tempInt;

        // Scrive i bit in output.
        output1.write(input.range(3, 3));
        output2.write(input.range(2, 2));
        output3.write(input.range(1, 1));
        output4.write(input.range(0, 0));

        // Stampa a schermo i valori generati ed un timestamp.
        cout << "[DataGen] Input:  " << (sc_bv<4>)input
             << "\t\t@ " << sc_time_stamp() << endl;

        wait();
    }

    sc_stop();
}
