#include "datagen.h"

#include <stdbool.h>

// Genera i valori booleani.
void DataGen::datagenProc()
{
    bool input_x;
    bool input_y;

    wait();

    // 0 AND 0
    input_x = false;
    input_y = false;

    out1.write(input_x);
    out2.write(input_y);

    cout << "[DataGen] Writing: " << input_x << " " << input_y
         << " @ " << sc_time_stamp() << endl;

    wait();

    // 0 AND 1
    input_x = false;
    input_y = true;

    out1.write(input_x);
    out2.write(input_y);

    cout << "[DataGen] Writing: " << input_x << " " << input_y
         << " @ " << sc_time_stamp() << endl;

    wait();

    // 1 AND 0
    input_x = true;
    input_y = false;

    out1.write(input_x);
    out2.write(input_y);

    cout << "[DataGen] Writing: " << input_x << " " << input_y
         << " @ " << sc_time_stamp() << endl;

    wait();

    // 1 AND 1
    input_x = true;
    input_y = true;

    out1.write(input_x);
    out2.write(input_y);

    cout << "[DataGen] Writing: " << input_x << " " << input_y
         << " @ " << sc_time_stamp() << endl;

    wait();

    sc_stop();
}
