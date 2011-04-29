#include <stdio.h>

#include <inttypes.h>
#include "sha1_32.h"

int main()
{
	static uint32_t h[5];

	sha1_32(h,
			   0x55555555, 0x55555555, 0x55555555, 0x80000000,
			   0x00000000, 0x00000000, 0x00000000, 0x00000000,
			   0x00000000, 0x00000000, 0x00000000, 0x00000000,
			   0x00000000, 0x00000000, 0x00000000, 0x00000060);

	printf("7CA678DA 749193EC 305EE9A0 5E5BD477 8AD4F786: should be\n"
		   "%08X %08X %08X %08X %08X\n",
		   h[0], h[1], h[2], h[3], h[4]);

	return 0;
}

/*
 *	Local Variables:
 *		tab-width:	4
 *	End:
 */
