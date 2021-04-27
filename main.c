#include "stdmansos.h"

/**
 * Sends counter over serial port
 */
void appMain(void)
{
    uint8_t counter = 1;

    while (counter <= 100) {
        redLedToggle();
        PRINTF("%u\n", counter++);
        mdelay(1000);
    }
}
