#include "stdmansos.h"

/**
 * Sends counter over serial port
 */
void slowlyPrintNumber(uint8_t c)
{
    PRINTF("%u\n", c);
    mdelay(1000);
}
