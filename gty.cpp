#include <CL/cl.h>
#include <assert.h>
#include <stdio.h>

#include <inttypes.h>
#include "sha1_32.h"

static
void dec64(char *h5, uint32_t h)
{
	char const m64[] = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789./";
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

static cl_uint numDevices;
static cl_device_id devs[64];
static cl_context ctx[64];
static cl_command_queue queue[64];
static cl_kernel kernel[64];

static const char *const kernel_src[] = {
	"__kernel void gpuMain(__global unsigned *Ary) {",
	"unsigned id = get_global_id(0);",
	"Ary[id] = id;",
	"}",
};

void gpu()
{
	int i;
	cl_int status;
	cl_uint numPlatforms;
	cl_platform_id ids[64];

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
		if (a == CL_DEVICE_TYPE_CPU) {
			devs[i] = 0;
			continue;
		}
		ctx[i] = clCreateContext(NULL, 1, &devs[i], 0, 0, &status);
		printf("create=%d\n", status);
		queue[i] = clCreateCommandQueue(ctx[i], devs[i], 0, &status);
		printf("queue=%d\n", status);

		/* source */
		cl_program program
			= clCreateProgramWithSource(ctx[i],
										sizeof(kernel_src) / sizeof(*kernel_src),
										(const char **)kernel_src,
										NULL,
										&status);
		printf("createProgram(%d)=%d\n",
			   sizeof(kernel_src) / sizeof(*kernel_src),
			   status);
		status = clBuildProgram(program,
								0, NULL,
								"-fbin-source -fbin-llvmir -fbin-amdil -fbin-exe",
								NULL,
								NULL);
		printf("build=%d\n", status);
		size_t szsz;
		size_t szs[256];
		status = clGetProgramInfo(program,
								  CL_PROGRAM_BINARY_SIZES,
								  sizeof(szs),
								  (void *)szs,
								  &szsz);
		unsigned char bbuf[65536];
		unsigned char *pbuf[] = {bbuf};
		printf("ssz=%d->%d p=%p st=%d\n", szsz, szs[0], pbuf[0], status);
		size_t bsz;
		status = clGetProgramInfo(program,
								  CL_PROGRAM_BINARIES,
								  sizeof(pbuf),
								  (void *)pbuf,
								  &bsz);
		printf("bsz=%d p=%p st=%d\n", bsz, pbuf[0], status);
#if 1
		FILE *fp = fopen("gty.elf", "wb");
		fwrite(bbuf, 1, szs[0], fp);
		fclose(fp);
#else
		for (int j = 0; j < szs[0]; j += 16) {
			for (int k = 0; k < 16; k++)
				printf("%02X ", bbuf[j + k]);
			for (int k = 0; k < 16; k++) {
				int c = bbuf[j + k];
				printf("%c", (0x20 <= c && c <= 0x7E
							  ? c : '.'));
			}
			printf(":%04X\n", j);
		}
		printf("(%d)\n", szs[0]);
#endif
		kernel[i] = clCreateKernel(program, "gpuMain", &status);
		printf("createkernel=%d\n", status);

		static int data[256];
		cl_mem ary = clCreateBuffer(ctx[i],
									CL_MEM_READ_WRITE | CL_MEM_COPY_HOST_PTR,
									sizeof(data), &data, NULL);
		clSetKernelArg(kernel[i], 0, sizeof(cl_mem), (void*)&ary);
		static size_t worksize[] = {256};
		clEnqueueNDRangeKernel(queue[i], kernel[i], 1, NULL, worksize, NULL, 0, NULL, NULL);
		clEnqueueReadBuffer(queue[i], ary, CL_TRUE, 0, sizeof(data), data, 0, NULL, NULL);
		for (int j = 0; j < 256; j++)
			printf("%5d: %08X\n", j, data[j]);

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
