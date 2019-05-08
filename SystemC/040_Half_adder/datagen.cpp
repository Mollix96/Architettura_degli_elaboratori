#include "datagen.h"

void DataGen::datagenProc()
{
    sc_uint<2> input;

    wait();

    for (int tempInt = 0b00; tempInt <= 0b11; tempInt++)
    {
        // Carica la rappresentazione binaria del contatore.
        input = tempInt;

        // Scrive i bit in output.
        output1.write(input.range(1, 1));
        output2.write(input.range(0, 0));

        // Stampa a schermo i valori generati ed un timestamp.
        /*
        cout << "[DataGen] Input: "
             << (bool)input.range(1, 1) << " "
             << (bool)input.range(0, 0)
             << "                            @ "
             << sc_time_stamp() << endl;
        */

        wait();
    }

    sc_stop();
}
