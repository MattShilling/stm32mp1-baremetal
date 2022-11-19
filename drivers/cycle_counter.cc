#include "drivers/cycle_counter.hh"
#include "stm32mp1xx.h"

namespace mdrivlib
{
void CycleCounter::init() {}

uint32_t CycleCounter::read_cycle_count()
{
	return PL1_GetCurrentPhysicalValue(); // something like 12MHz, so not really cycle counter, but accurate enough.
}
} // namespace mdrivlib
