#include <CL/cl.h>
#include <windows.h>
#include <process.h>
#include <assert.h>
#include <stdio.h>
#include <stdlib.h>
#include <malloc.h>
#include <sys/time.h>
#include <inttypes.h>

#include "gty.cl"

static HANDLE gmutex;
static uint64_t loop_cpu[64];
static uint64_t loop_gpu[64];
static int f_wipe;

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
	fprintf(fp, "\x81\x9F%s", hstr);
}

static cl_uint numDevices;
static cl_device_id devs[64];

struct pdarg
{
	cl_device_id dev;
};

void per_device(void* arg)
{
	cl_int status;
	cl_context ctx;
	cl_command_queue queue;
	pdarg* pd = (pdarg*)arg;
	ctx = clCreateContext(NULL, 1, &pd->dev, 0, 0, &status);
	printf("XX%p\n", pd);
	printf("create=%d\n", status);
	queue = clCreateCommandQueue(ctx, pd->dev, 0, &status);
	printf("queue=%d\n", status);

	/* source */
	char srcbuf[262144];
	FILE *sfp = fopen("gty.cl", "r");
	size_t srcsiz = fread(srcbuf, 1, sizeof(srcbuf), sfp);
	fclose(sfp);
	srcbuf[srcsiz] = 0;
	static char *srcp[] = {srcbuf};
	cl_program program
		= clCreateProgramWithSource(ctx,
									sizeof(srcp) / sizeof(*srcp),
									(const char **)srcp,
									NULL,
									&status);
	printf("createProgram(%d)=%d\n",
		   sizeof(srcp) / sizeof(*srcp),
		   status);
	status = clBuildProgram(program,
							0, NULL,
							"-O3 -fbin-source -fbin-llvmir -fbin-amdil -fbin-exe",
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
	unsigned char bbuf[1048576];
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
	cl_kernel kernel = clCreateKernel(program, "gpuMain", &status);
	printf("createkernel=%d\n", status);
#define N (128 * 128 * 128)
	W *data;
	cl_mem ary = clCreateBuffer(ctx,
								CL_MEM_ALLOC_HOST_PTR,
								N * sizeof(W), NULL, NULL);
	clSetKernelArg(kernel, 0, sizeof(cl_mem), (void*)&ary);
#if 1
	cl_mem kkey = clCreateBuffer(ctx,
								 CL_MEM_ALLOC_HOST_PTR,
								 80 * sizeof(W), NULL, NULL);
	clSetKernelArg(kernel, 1, sizeof(cl_mem), (void*)&kkey);
#else
	unsigned k0;
	unsigned k1;
	unsigned k2;
#endif

#if 1
	W *keys;
	keys = (W*)clEnqueueMapBuffer(queue, kkey, CL_TRUE, CL_MAP_READ|CL_MAP_WRITE, 0, 80 * sizeof(*keys), 0, NULL, NULL, NULL);
	assert(keys);
	for (int j = 0; j < 80; j++) keys[j] = 0;
	keys[ 3] = 0x80000000;
	keys[15] = 0x00000060;
	clEnqueueUnmapMemObject(queue, kkey, (void*)keys, 0, NULL, NULL);
#else
	unsigned keys[80];
	for (int j = 0; j < 80; j++) keys[j] = 0;
	keys[ 3] = 0x80000000;
	keys[15] = 0x00000060;
#endif
	struct timeval t1, t2;
	gettimeofday(&t1, NULL);
	static size_t worksize[] = {N};
	int iter;
	WaitForSingleObject(gmutex, INFINITE);
	srand(time(NULL));
	ReleaseMutex(gmutex);

	while (1) {
		keys = (W*)clEnqueueMapBuffer(queue, kkey, CL_TRUE, CL_MAP_READ|CL_MAP_WRITE, 0, 80 * sizeof(*keys), 0, NULL, NULL, NULL);
		assert(keys);
		keys[0] = key32(rand() ^ (rand() << 8) ^ (rand() << 16));
		keys[2] = k32L(rand() ^ (rand() << 8) ^ (rand() << 16));
		for (int j = 16; j < 80; j++)
			keys[j] = ROL(1, keys[j - 16] ^ keys[j - 14] ^ keys[j - 8] ^ keys[j - 3]);
		clEnqueueUnmapMemObject(queue, kkey, (void*)keys, 0, NULL, NULL);
#if 0
		clSetKernelArg(kernel, 1, sizeof(k0), (void*)&k0);
		clSetKernelArg(kernel, 2, sizeof(k2), (void*)&k2);
#endif
		clEnqueueNDRangeKernel(queue, kernel, 1, NULL, worksize, NULL, 0, NULL, NULL);
		data = (W*)clEnqueueMapBuffer(queue, ary, CL_TRUE, CL_MAP_READ|CL_MAP_WRITE, 0, N * sizeof(*data), 0, NULL, NULL, NULL);
		loop_gpu[0] += (W4 ? 4 : 1) * 32 * N;
		for (int j = 0; j < N; j++) {
			unsigned a = data[j];
			if (!a) continue;
			for (int k = 0; k < 32; k++) {
				if (!(a & (1U << k))) continue;
				unsigned k0 = keys[0];
				unsigned k1 = key32((j << 5 + 2 * W4) + k);
				unsigned k2 = keys[2];
				unsigned h[5];
				sha1_32(h,
						k0, k1, k2, 0x80000000,
						0x00000000, 0x00000000, 0x00000000, 0x00000000,
						0x00000000, 0x00000000, 0x00000000, 0x00000000,
						0x00000000, 0x00000000, 0x00000000, 0x00000060);
				WaitForSingleObject(gmutex, INFINITE);
				if (f_wipe) {
					fprintf(stderr, "                                                                               \r");
					f_wipe = 0;
				}
				print_key_hash(stderr, h);
				fprintf(stderr, " #%c%c%c%c%c%c%c%c%c%c%c%c\n",
						(k0 >> 24) & 0xFF,
						(k0 >> 16) & 0xFF,
						(k0 >>  8) & 0xFF,
						(k0 >>  0) & 0xFF,
						(k1 >> 24) & 0xFF,
						(k1 >> 16) & 0xFF,
						(k1 >>  8) & 0xFF,
						(k1 >>  0) & 0xFF,
						(k2 >> 24) & 0xFF,
						(k2 >> 16) & 0xFF,
						(k2 >>  8) & 0xFF,
						(k2 >>  0) & 0xFF);
				ReleaseMutex(gmutex);
			}
		}
		clEnqueueUnmapMemObject(queue, ary, (void*)data, 0, NULL, NULL);
	}
	gettimeofday(&t2, NULL);
	double d1 = 1000000.0 * t1.tv_sec + t1.tv_usec;
	double d2 = 1000000.0 * t2.tv_sec + t2.tv_usec;
	printf("%gM/s (%g s)\n",
		   iter * (W4 ? 4 : 1) * 32 * N / (d2 - d1),
		   (d2 - d1) / 1000000.0);
#if 0
	for (int j = 0; j < N; j++) {
		unsigned x = 0;
		for (int k = 0; k < 32; k++) {
			static uint32_t h[5];
#if 1
			sha1_32(h,
					k0, k1, key32((j << (5 + 2 * W4)) + k), 0x80000000,
					0x00000000, 0x00000000, 0x00000000, 0x00000000,
					0x00000000, 0x00000000, 0x00000000, 0x00000000,
					0x00000000, 0x00000000, 0x00000000, 0x00000060);
#else
			sha1_32(h,
					0x55555555, 0x55555555, 0x55555555, 0x55555555,
					0x55555555, 0x55555555, 0x55555555, 0x55555555,
					0x55555555, 0x55555555, 0x55555555, 0x55555555,
					0x55555555, k24(32 * j + k), 0x00000000, 0x000001B8);
#endif
			x ^= h[0];
		}
#if W4
		if (data[j].x != x)
			printf("%5d: %08X (should be %08X)\n", j, data[j].x, x);
#else
		if (data[j] != x)
			printf("%5d: %08X (should be %08X)\n", j, data[j], x);
#endif
	}
	printf("%gM/s (%g s)\n",
		   iter * (W4 ? 4 : 1) * 32 * N / (d2 - d1),
		   (d2 - d1) / 1000000.0);
#endif
}

void gpu(void *arg)
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
		pdarg *pd = new pdarg;
		pd->dev = devs[i];
		printf("XX%p\n", pd);
		per_device((void*)pd);
	}
}

int main()
{
#define UPDATE_INTERVAL 5	/* 速度表示の間隔 秒 */
  struct status {
    uint64_t startTime;	/* 開始時刻 ミリ秒 */
    uint64_t lastTime;	/* 最後に表示した時刻 ミリ秒 */
    uint64_t loop;		/* 総検索個数 */
    uint64_t loopgpu;
    uint64_t lastloop;	/* 最後に表示した時の loop */
    uint64_t lastgpu;
  } status;
  uint64_t curTime;
  uint32_t upd_int = 0;
/*
 平均速度 (trips/s) * UPDATE_INTERVAL が UINT32_MAX を超えると発狂する。
 UINT32_MAX = 4294967295, 平均速度 = 100Mtrips/s なら、
 4294967295 / (100 * 1000 * 1000) = 42.949 秒まで。（和良
 LOOP_FACTOR が平均速度より十分小さければ、ほぼ指定間隔になる。
 LOOP_FACTOR * UINT32_MAX + LOOP_FACOTR 個検索するとオーバーフローする。ｗ
 */

#if 0
  struct ITREE *root_expr = expr_parse("target.txt");
#endif

	gmutex = CreateMutex(NULL, FALSE, NULL);
	WaitForSingleObject(gmutex, INFINITE);

	_beginthread(gpu, 262144, NULL);

	struct timeval tv;
	memset( &status, 0, sizeof( struct status ) );
	gettimeofday(&tv, NULL);
	status.startTime = status.lastTime = 1000000ULL * tv.tv_sec + tv.tv_usec;

	ReleaseMutex(gmutex);
	while (1)
	{
		int n_gpus = 1;
		int n_cpus = 0;
		double USEC_SEC = 1000000.0;
		Sleep(5000);
	  /* 速度計測 */
		int i;
	  status.loop = status.loopgpu = 0;
	  for (i = 0; i < n_cpus; i++) status.loop += loop_cpu[i];
	  for (i = 0; i < n_gpus; i++) status.loopgpu += loop_gpu[i];

	  gettimeofday(&tv, NULL);
	  curTime = 1000000ULL * tv.tv_sec + tv.tv_usec;
	  if (status.loop + status.loopgpu >= status.lastloop + upd_int
		  && curTime != status.lastTime)
		{
		  uint64_t diffTime;
		  int a, b, c, g;
#if 0
		  WaitForSingleObject(mutex_key, INFINITE);
		  status.loop += xxxcnt;
		  xxxcnt = 0;
		  ReleaseMutex(mutex_key);
#endif
		  /* 通算(単位 ktrips/sec) */
		  diffTime = curTime - status.startTime;
		  a = (status.loop + status.loopgpu) / ((1000 / USEC_SEC) * diffTime);

		  /* 区間(単位 trips/sec) */
		  diffTime = curTime - status.lastTime;
		  b = USEC_SEC * (status.loop - status.lastloop) / diffTime;

		  diffTime = curTime - status.lastTime;
		  g = USEC_SEC * (status.loopgpu - status.lastgpu) / diffTime;

		  /* 予測 */
		  c = UPDATE_INTERVAL * (b + g);

		  /* 立ち上がりなど、誤差があり upd_int が小さすぎたときは
			 いきなり全補正せず 1 秒(==b)づつ収斂させる。 */
		  upd_int = (upd_int + b + g < c
					 ? upd_int + b + g
					 : c);

		  status.lastTime = curTime;
		  status.lastloop = status.loop;
		  status.lastgpu = status.loopgpu;
		  WaitForSingleObject(gmutex, INFINITE);
		  fprintf(stderr,
				  "%4d.%03dGtrips/s [%4d.%06dMtrips/s@CPU %4d.%06dMtrips/s@GPU]\r",
				  a / 1000000, (a / 1000) % 1000,
				  b / 1000000, b % 1000000,
				  g / 1000000, g % 1000000);
		  f_wipe++;
		  ReleaseMutex(gmutex);
		}
	}
}

/*
 *	Local Variables:
 *		tab-width:	4
 *	End:
 */
