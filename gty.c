#include <stdio.h>

#include <inttypes.h>
#include "sha1_32.h"

static
void dec64(char *h5, uint32_t h)
{
	char const m64[64] = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789./";
	h >>= 2; h5[4] = m64[h & 63];
	h >>= 6; h5[3] = m64[h & 63];
	h >>= 6; h5[2] = m64[h & 63];
	h >>= 6; h5[1] = m64[h & 63];
	h >>= 6; h5[0] = m64[h & 63];
}

static
void print_key_hash(FILE *fp, const uint32_t *h)
{
	char hstr[32];
	dec64(&hstr[ 0], h[0]);
	dec64(&hstr[ 5], (h[0] << 30) | (h[1] >> 2));
	dec64(&hstr[10], (h[1] << 28) | (h[2] >> 4));
	hstr[12] = 0;
	fprintf(fp, "<%s>\n", hstr);
}

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
	print_key_hash(stdout, h);

	return 0;
}

/*
 *	Local Variables:
 *		tab-width:	4
 *	End:
 */
