#include <CL/cl.h>
#include <assert.h>
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

void gpu()
{
	int i;
	cl_int status;
	cl_uint numPlatforms;
	cl_uint numDevices;
	cl_platform_id ids[64];
	cl_device_id devs[64];

	status = clGetPlatformIDs(0, NULL, &numPlatforms);
	printf("getplat=%d %d\n", status, numPlatforms);
	assert(status == CL_SUCCESS);
	status = clGetPlatformIDs(numPlatforms, ids, NULL);
	printf("getid=%d\n", status);
	assert(status == CL_SUCCESS);
	for (i = 0; i < numPlatforms; i++)
	{
		char buf[256];
		status = clGetPlatformInfo(ids[i], CL_PLATFORM_VENDOR, sizeof(buf), buf, NULL);
		printf("(%d)=%d\n", i, status);
		assert(status == CL_SUCCESS);
		printf("<%s>\n", buf);
	}
	numDevices = 64;
	status = clGetDeviceIDs(ids[0], CL_DEVICE_TYPE_ALL, 64, devs, &numDevices);
	printf("(%d)ndevs=%d\n", status, numDevices);
	assert(status == CL_SUCCESS);
	for (i = 0; i < numDevices; i++)
	{
		cl_device_type a;
		size_t s;
		status = clGetDeviceInfo(devs[i], CL_DEVICE_TYPE, sizeof(a), &a, &s);
		printf("(%d)%d->%d\n", status, sizeof(a), s);
		if (a != CL_DEVICE_TYPE_CPU) {
			cl_context ctx = clCreateContext(NULL, 1, &devs[i], 0, 0, &status);
			printf("create=%d\n", status);
		}
	}
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

	gpu();

	return 0;
}

/*
 *	Local Variables:
 *		tab-width:	4
 *	End:
 */
