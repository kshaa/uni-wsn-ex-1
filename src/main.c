#include "stdmansos.h"
#include "lib.h"

/**
 * Sends counter over serial port
 */
void appMain(void)
{
    uint8_t counter = 1;
    while (counter <= 100) {
        slowlyPrintNumber(counter++);
    }
}
