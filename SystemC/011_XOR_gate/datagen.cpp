#include "datagen.h"

#include <stdbool.h>

// Generatore di valori.
void DataGen::datagenProc()
{
    sc_uint<2> input;

    wait();

    // Genera la tabella:
    // 0 0
    // 0 1
    // 1 0
    // 1 1
    for (int tempInt = 0b00; tempInt <= 0b11; tempInt++)
    {
        // Carica la rappresentazione binaria del contatore.
        input = tempInt;

        // Scrive i valori in output.
        out1.write(input.range(1, 1));
        out2.write(input.range(0, 0));

        // Stampa a schermo i valori generati ed un timestamp.
        cout << "[DataGen] Writing Input: " << (bool)input.range(1, 1)
             << " " << (bool)input.range(0, 0) << " @ " << sc_time_stamp() << endl;

        wait();
    }

    sc_stop();
}
