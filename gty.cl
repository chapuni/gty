/* -*-C-*- */

#ifdef __OPENCL_VERSION__
#define ROL(n,a) rotate(a,n)
#else
#define ROL(n,a) (unsigned)(((a) << (n)) | ((unsigned)(a) >> (32 - (n))))
#endif

unsigned f0(unsigned b,
			unsigned c,
			unsigned d)
{
	return 0x5A827999U + ((b & c) + (~b & d));
}


unsigned f1(unsigned b,
			unsigned c,
			unsigned d)
{
	return 0x6ED9EBA1U + (b ^ c ^ d);
}


unsigned f2(unsigned b,
			unsigned c,
			unsigned d)
{
	return 0x8F1BBCDCU + ((b & c) | (c & d) | (d & b));
}


unsigned f3(unsigned b,
			unsigned c,
			unsigned d)
{
	return 0xCA62C1D6U + (b ^ c ^ d);
}

/*
40-7E 63
89-97 9
A6-DD 56
*/

unsigned kadj(unsigned a)
{
	a &= 0x7F;
	a += 0x40;
	if (a >= 0x7F) a += (0x89 - 0x7F);
	if (a >= 0x98) a += (0xA6 - 0x98);
	return a;
}

unsigned kadjL(unsigned a)
{
	a &= 0x7F;
	a += 0x40;
	if (a >= 0x7F) a += (0xA1 - 0x7F);
	return a;
}

unsigned k24(unsigned a) {
	return (kadj(a >> 14) << 24) | (kadj(a >> 7) << 16) | (kadj(a) << 8) | 0x80;
}

unsigned k32(unsigned a) {
	return (kadj(a >> 21) << 24) | (kadj(a >> 14) << 16) | (kadj(a >> 7) << 8) | kadj(a);
}

unsigned k32L(unsigned a) {
	return (kadj(a >> 21) << 24) | (kadj(a >> 14) << 16) | (kadj(a >> 7) << 8) | kadjL(a);
}

void sha1_32(unsigned *hash,
			 unsigned k00, unsigned k01, unsigned k02, unsigned k03,
			 unsigned k04, unsigned k05, unsigned k06, unsigned k07,
			 unsigned k08, unsigned k09, unsigned k0A, unsigned k0B,
			 unsigned k0C, unsigned k0D, unsigned k0E, unsigned k0F)
{
	unsigned a, b, c, d, e;
	unsigned t;

	a = 0x67452301U;
	b = 0xEFCDAB89U;
	c = 0x98BADCFEU;
	d = 0x10325476U;
	e = 0xC3D2E1F0U;

	t = ROL(5, a) + f0(b, c, d) + e + k00; e = d; d = c; c = ROL(30, b); b = a; a = t;
	t = ROL(5, a) + f0(b, c, d) + e + k01; e = d; d = c; c = ROL(30, b); b = a; a = t;
	t = ROL(5, a) + f0(b, c, d) + e + k02; e = d; d = c; c = ROL(30, b); b = a; a = t;
	t = ROL(5, a) + f0(b, c, d) + e + k03; e = d; d = c; c = ROL(30, b); b = a; a = t;
	t = ROL(5, a) + f0(b, c, d) + e + k04; e = d; d = c; c = ROL(30, b); b = a; a = t;
	t = ROL(5, a) + f0(b, c, d) + e + k05; e = d; d = c; c = ROL(30, b); b = a; a = t;
	t = ROL(5, a) + f0(b, c, d) + e + k06; e = d; d = c; c = ROL(30, b); b = a; a = t;
	t = ROL(5, a) + f0(b, c, d) + e + k07; e = d; d = c; c = ROL(30, b); b = a; a = t;
	t = ROL(5, a) + f0(b, c, d) + e + k08; e = d; d = c; c = ROL(30, b); b = a; a = t;
	t = ROL(5, a) + f0(b, c, d) + e + k09; e = d; d = c; c = ROL(30, b); b = a; a = t;
	t = ROL(5, a) + f0(b, c, d) + e + k0A; e = d; d = c; c = ROL(30, b); b = a; a = t;
	t = ROL(5, a) + f0(b, c, d) + e + k0B; e = d; d = c; c = ROL(30, b); b = a; a = t;
	t = ROL(5, a) + f0(b, c, d) + e + k0C; e = d; d = c; c = ROL(30, b); b = a; a = t;
	t = ROL(5, a) + f0(b, c, d) + e + k0D; e = d; d = c; c = ROL(30, b); b = a; a = t;
	t = ROL(5, a) + f0(b, c, d) + e + k0E; e = d; d = c; c = ROL(30, b); b = a; a = t;
	t = ROL(5, a) + f0(b, c, d) + e + k0F; e = d; d = c; c = ROL(30, b); b = a; a = t;

	k00 = ROL(1, k00 ^ k02 ^ k08 ^ k0D); t = ROL(5, a) + f0(b, c, d) + e + k00; e = d; d = c; c = ROL(30, b); b = a; a = t;
	k01 = ROL(1, k01 ^ k03 ^ k09 ^ k0E); t = ROL(5, a) + f0(b, c, d) + e + k01; e = d; d = c; c = ROL(30, b); b = a; a = t;
	k02 = ROL(1, k02 ^ k04 ^ k0A ^ k0F); t = ROL(5, a) + f0(b, c, d) + e + k02; e = d; d = c; c = ROL(30, b); b = a; a = t;
	k03 = ROL(1, k03 ^ k05 ^ k0B ^ k00); t = ROL(5, a) + f0(b, c, d) + e + k03; e = d; d = c; c = ROL(30, b); b = a; a = t;
	k04 = ROL(1, k04 ^ k06 ^ k0C ^ k01); t = ROL(5, a) + f1(b, c, d) + e + k04; e = d; d = c; c = ROL(30, b); b = a; a = t;
	k05 = ROL(1, k05 ^ k07 ^ k0D ^ k02); t = ROL(5, a) + f1(b, c, d) + e + k05; e = d; d = c; c = ROL(30, b); b = a; a = t;
	k06 = ROL(1, k06 ^ k08 ^ k0E ^ k03); t = ROL(5, a) + f1(b, c, d) + e + k06; e = d; d = c; c = ROL(30, b); b = a; a = t;
	k07 = ROL(1, k07 ^ k09 ^ k0F ^ k04); t = ROL(5, a) + f1(b, c, d) + e + k07; e = d; d = c; c = ROL(30, b); b = a; a = t;
	k08 = ROL(1, k08 ^ k0A ^ k00 ^ k05); t = ROL(5, a) + f1(b, c, d) + e + k08; e = d; d = c; c = ROL(30, b); b = a; a = t;
	k09 = ROL(1, k09 ^ k0B ^ k01 ^ k06); t = ROL(5, a) + f1(b, c, d) + e + k09; e = d; d = c; c = ROL(30, b); b = a; a = t;
	k0A = ROL(1, k0A ^ k0C ^ k02 ^ k07); t = ROL(5, a) + f1(b, c, d) + e + k0A; e = d; d = c; c = ROL(30, b); b = a; a = t;
	k0B = ROL(1, k0B ^ k0D ^ k03 ^ k08); t = ROL(5, a) + f1(b, c, d) + e + k0B; e = d; d = c; c = ROL(30, b); b = a; a = t;
	k0C = ROL(1, k0C ^ k0E ^ k04 ^ k09); t = ROL(5, a) + f1(b, c, d) + e + k0C; e = d; d = c; c = ROL(30, b); b = a; a = t;
	k0D = ROL(1, k0D ^ k0F ^ k05 ^ k0A); t = ROL(5, a) + f1(b, c, d) + e + k0D; e = d; d = c; c = ROL(30, b); b = a; a = t;
	k0E = ROL(1, k0E ^ k00 ^ k06 ^ k0B); t = ROL(5, a) + f1(b, c, d) + e + k0E; e = d; d = c; c = ROL(30, b); b = a; a = t;
	k0F = ROL(1, k0F ^ k01 ^ k07 ^ k0C); t = ROL(5, a) + f1(b, c, d) + e + k0F; e = d; d = c; c = ROL(30, b); b = a; a = t;
	k00 = ROL(1, k00 ^ k02 ^ k08 ^ k0D); t = ROL(5, a) + f1(b, c, d) + e + k00; e = d; d = c; c = ROL(30, b); b = a; a = t;
	k01 = ROL(1, k01 ^ k03 ^ k09 ^ k0E); t = ROL(5, a) + f1(b, c, d) + e + k01; e = d; d = c; c = ROL(30, b); b = a; a = t;
	k02 = ROL(1, k02 ^ k04 ^ k0A ^ k0F); t = ROL(5, a) + f1(b, c, d) + e + k02; e = d; d = c; c = ROL(30, b); b = a; a = t;
	k03 = ROL(1, k03 ^ k05 ^ k0B ^ k00); t = ROL(5, a) + f1(b, c, d) + e + k03; e = d; d = c; c = ROL(30, b); b = a; a = t;
	k04 = ROL(1, k04 ^ k06 ^ k0C ^ k01); t = ROL(5, a) + f1(b, c, d) + e + k04; e = d; d = c; c = ROL(30, b); b = a; a = t;
	k05 = ROL(1, k05 ^ k07 ^ k0D ^ k02); t = ROL(5, a) + f1(b, c, d) + e + k05; e = d; d = c; c = ROL(30, b); b = a; a = t;
	k06 = ROL(1, k06 ^ k08 ^ k0E ^ k03); t = ROL(5, a) + f1(b, c, d) + e + k06; e = d; d = c; c = ROL(30, b); b = a; a = t;
	k07 = ROL(1, k07 ^ k09 ^ k0F ^ k04); t = ROL(5, a) + f1(b, c, d) + e + k07; e = d; d = c; c = ROL(30, b); b = a; a = t;
	k08 = ROL(1, k08 ^ k0A ^ k00 ^ k05); t = ROL(5, a) + f2(b, c, d) + e + k08; e = d; d = c; c = ROL(30, b); b = a; a = t;
	k09 = ROL(1, k09 ^ k0B ^ k01 ^ k06); t = ROL(5, a) + f2(b, c, d) + e + k09; e = d; d = c; c = ROL(30, b); b = a; a = t;
	k0A = ROL(1, k0A ^ k0C ^ k02 ^ k07); t = ROL(5, a) + f2(b, c, d) + e + k0A; e = d; d = c; c = ROL(30, b); b = a; a = t;
	k0B = ROL(1, k0B ^ k0D ^ k03 ^ k08); t = ROL(5, a) + f2(b, c, d) + e + k0B; e = d; d = c; c = ROL(30, b); b = a; a = t;
	k0C = ROL(1, k0C ^ k0E ^ k04 ^ k09); t = ROL(5, a) + f2(b, c, d) + e + k0C; e = d; d = c; c = ROL(30, b); b = a; a = t;
	k0D = ROL(1, k0D ^ k0F ^ k05 ^ k0A); t = ROL(5, a) + f2(b, c, d) + e + k0D; e = d; d = c; c = ROL(30, b); b = a; a = t;
	k0E = ROL(1, k0E ^ k00 ^ k06 ^ k0B); t = ROL(5, a) + f2(b, c, d) + e + k0E; e = d; d = c; c = ROL(30, b); b = a; a = t;
	k0F = ROL(1, k0F ^ k01 ^ k07 ^ k0C); t = ROL(5, a) + f2(b, c, d) + e + k0F; e = d; d = c; c = ROL(30, b); b = a; a = t;
	k00 = ROL(1, k00 ^ k02 ^ k08 ^ k0D); t = ROL(5, a) + f2(b, c, d) + e + k00; e = d; d = c; c = ROL(30, b); b = a; a = t;
	k01 = ROL(1, k01 ^ k03 ^ k09 ^ k0E); t = ROL(5, a) + f2(b, c, d) + e + k01; e = d; d = c; c = ROL(30, b); b = a; a = t;
	k02 = ROL(1, k02 ^ k04 ^ k0A ^ k0F); t = ROL(5, a) + f2(b, c, d) + e + k02; e = d; d = c; c = ROL(30, b); b = a; a = t;
	k03 = ROL(1, k03 ^ k05 ^ k0B ^ k00); t = ROL(5, a) + f2(b, c, d) + e + k03; e = d; d = c; c = ROL(30, b); b = a; a = t;
	k04 = ROL(1, k04 ^ k06 ^ k0C ^ k01); t = ROL(5, a) + f2(b, c, d) + e + k04; e = d; d = c; c = ROL(30, b); b = a; a = t;
	k05 = ROL(1, k05 ^ k07 ^ k0D ^ k02); t = ROL(5, a) + f2(b, c, d) + e + k05; e = d; d = c; c = ROL(30, b); b = a; a = t;
	k06 = ROL(1, k06 ^ k08 ^ k0E ^ k03); t = ROL(5, a) + f2(b, c, d) + e + k06; e = d; d = c; c = ROL(30, b); b = a; a = t;
	k07 = ROL(1, k07 ^ k09 ^ k0F ^ k04); t = ROL(5, a) + f2(b, c, d) + e + k07; e = d; d = c; c = ROL(30, b); b = a; a = t;
	k08 = ROL(1, k08 ^ k0A ^ k00 ^ k05); t = ROL(5, a) + f2(b, c, d) + e + k08; e = d; d = c; c = ROL(30, b); b = a; a = t;
	k09 = ROL(1, k09 ^ k0B ^ k01 ^ k06); t = ROL(5, a) + f2(b, c, d) + e + k09; e = d; d = c; c = ROL(30, b); b = a; a = t;
	k0A = ROL(1, k0A ^ k0C ^ k02 ^ k07); t = ROL(5, a) + f2(b, c, d) + e + k0A; e = d; d = c; c = ROL(30, b); b = a; a = t;
	k0B = ROL(1, k0B ^ k0D ^ k03 ^ k08); t = ROL(5, a) + f2(b, c, d) + e + k0B; e = d; d = c; c = ROL(30, b); b = a; a = t;
	k0C = ROL(1, k0C ^ k0E ^ k04 ^ k09); t = ROL(5, a) + f3(b, c, d) + e + k0C; e = d; d = c; c = ROL(30, b); b = a; a = t;
	k0D = ROL(1, k0D ^ k0F ^ k05 ^ k0A); t = ROL(5, a) + f3(b, c, d) + e + k0D; e = d; d = c; c = ROL(30, b); b = a; a = t;
	k0E = ROL(1, k0E ^ k00 ^ k06 ^ k0B); t = ROL(5, a) + f3(b, c, d) + e + k0E; e = d; d = c; c = ROL(30, b); b = a; a = t;
	k0F = ROL(1, k0F ^ k01 ^ k07 ^ k0C); t = ROL(5, a) + f3(b, c, d) + e + k0F; e = d; d = c; c = ROL(30, b); b = a; a = t;
	k00 = ROL(1, k00 ^ k02 ^ k08 ^ k0D); t = ROL(5, a) + f3(b, c, d) + e + k00; e = d; d = c; c = ROL(30, b); b = a; a = t;
	k01 = ROL(1, k01 ^ k03 ^ k09 ^ k0E); t = ROL(5, a) + f3(b, c, d) + e + k01; e = d; d = c; c = ROL(30, b); b = a; a = t;
	k02 = ROL(1, k02 ^ k04 ^ k0A ^ k0F); t = ROL(5, a) + f3(b, c, d) + e + k02; e = d; d = c; c = ROL(30, b); b = a; a = t;
	k03 = ROL(1, k03 ^ k05 ^ k0B ^ k00); t = ROL(5, a) + f3(b, c, d) + e + k03; e = d; d = c; c = ROL(30, b); b = a; a = t;
	k04 = ROL(1, k04 ^ k06 ^ k0C ^ k01); t = ROL(5, a) + f3(b, c, d) + e + k04; e = d; d = c; c = ROL(30, b); b = a; a = t;
	k05 = ROL(1, k05 ^ k07 ^ k0D ^ k02); t = ROL(5, a) + f3(b, c, d) + e + k05; e = d; d = c; c = ROL(30, b); b = a; a = t;
	k06 = ROL(1, k06 ^ k08 ^ k0E ^ k03); t = ROL(5, a) + f3(b, c, d) + e + k06; e = d; d = c; c = ROL(30, b); b = a; a = t;
	k07 = ROL(1, k07 ^ k09 ^ k0F ^ k04); t = ROL(5, a) + f3(b, c, d) + e + k07; e = d; d = c; c = ROL(30, b); b = a; a = t;
	k08 = ROL(1, k08 ^ k0A ^ k00 ^ k05); t = ROL(5, a) + f3(b, c, d) + e + k08; e = d; d = c; c = ROL(30, b); b = a; a = t;
	k09 = ROL(1, k09 ^ k0B ^ k01 ^ k06); t = ROL(5, a) + f3(b, c, d) + e + k09; e = d; d = c; c = ROL(30, b); b = a; a = t;
	k0A = ROL(1, k0A ^ k0C ^ k02 ^ k07); t = ROL(5, a) + f3(b, c, d) + e + k0A; e = d; d = c; c = ROL(30, b); b = a; a = t;
	k0B = ROL(1, k0B ^ k0D ^ k03 ^ k08); t = ROL(5, a) + f3(b, c, d) + e + k0B; e = d; d = c; c = ROL(30, b); b = a; a = t;
	k0C = ROL(1, k0C ^ k0E ^ k04 ^ k09); t = ROL(5, a) + f3(b, c, d) + e + k0C; e = d; d = c; c = ROL(30, b); b = a; a = t;
	k0D = ROL(1, k0D ^ k0F ^ k05 ^ k0A); t = ROL(5, a) + f3(b, c, d) + e + k0D; e = d; d = c; c = ROL(30, b); b = a; a = t;
	k0E = ROL(1, k0E ^ k00 ^ k06 ^ k0B); t = ROL(5, a) + f3(b, c, d) + e + k0E; e = d; d = c; c = ROL(30, b); b = a; a = t;
	k0F = ROL(1, k0F ^ k01 ^ k07 ^ k0C); t = ROL(5, a) + f3(b, c, d) + e + k0F; e = d; d = c; c = ROL(30, b); b = a; a = t;

	hash[0] = 0x67452301U + a;
	hash[1] = 0xEFCDAB89U + b;
	hash[2] = 0x98BADCFEU + c;
}

#define SW(a0, a1, j, m) (t = (a0 ^ (a1 << j)) & m, a0 ^= t, a1 ^= (t >> j))

void tr32(const unsigned *in, unsigned *out)
{
	unsigned a00 = in[0x00];
	unsigned a01 = in[0x01];
	unsigned a02 = in[0x02];
	unsigned a03 = in[0x03];
	unsigned a04 = in[0x04];
	unsigned a05 = in[0x05];
	unsigned a06 = in[0x06];
	unsigned a07 = in[0x07];
	unsigned a08 = in[0x08];
	unsigned a09 = in[0x09];
	unsigned a0A = in[0x0A];
	unsigned a0B = in[0x0B];
	unsigned a0C = in[0x0C];
	unsigned a0D = in[0x0D];
	unsigned a0E = in[0x0E];
	unsigned a0F = in[0x0F];
	unsigned a10 = in[0x10];
	unsigned a11 = in[0x11];
	unsigned a12 = in[0x12];
	unsigned a13 = in[0x13];
	unsigned a14 = in[0x14];
	unsigned a15 = in[0x15];
	unsigned a16 = in[0x16];
	unsigned a17 = in[0x17];
	unsigned a18 = in[0x18];
	unsigned a19 = in[0x19];
	unsigned a1A = in[0x1A];
	unsigned a1B = in[0x1B];
	unsigned a1C = in[0x1C];
	unsigned a1D = in[0x1D];
	unsigned a1E = in[0x1E];
	unsigned a1F = in[0x1F];
	unsigned t;
	unsigned m = 0xFFFF0000;
	SW(a00, a10, 16, m);
	SW(a01, a11, 16, m);
	SW(a02, a12, 16, m);
	SW(a03, a13, 16, m);
	SW(a04, a14, 16, m);
	SW(a05, a15, 16, m);
	SW(a06, a16, 16, m);
	SW(a07, a17, 16, m);
	SW(a08, a18, 16, m);
	SW(a09, a19, 16, m);
	SW(a0A, a1A, 16, m);
	SW(a0B, a1B, 16, m);
	SW(a0C, a1C, 16, m);
	SW(a0D, a1D, 16, m);
	SW(a0E, a1E, 16, m);
	SW(a0F, a1F, 16, m);
	m ^= (m >> 8);
	SW(a00, a08, 8, m);
	SW(a01, a09, 8, m);
	SW(a02, a0A, 8, m);
	SW(a03, a0B, 8, m);
	SW(a04, a0C, 8, m);
	SW(a05, a0D, 8, m);
	SW(a06, a0E, 8, m);
	SW(a07, a0F, 8, m);
	SW(a10, a18, 8, m);
	SW(a11, a19, 8, m);
	SW(a12, a1A, 8, m);
	SW(a13, a1B, 8, m);
	SW(a14, a1C, 8, m);
	SW(a15, a1D, 8, m);
	SW(a16, a1E, 8, m);
	SW(a17, a1F, 8, m);
	m ^= (m >> 4);
	SW(a00, a04, 4, m);
	SW(a01, a05, 4, m);
	SW(a02, a06, 4, m);
	SW(a03, a07, 4, m);
	SW(a08, a0C, 4, m);
	SW(a09, a0D, 4, m);
	SW(a0A, a0E, 4, m);
	SW(a0B, a0F, 4, m);
	SW(a10, a14, 4, m);
	SW(a11, a15, 4, m);
	SW(a12, a16, 4, m);
	SW(a13, a17, 4, m);
	SW(a18, a1C, 4, m);
	SW(a19, a1D, 4, m);
	SW(a1A, a1E, 4, m);
	SW(a1B, a1F, 4, m);
	m ^= (m >> 2);
	SW(a00, a02, 2, m);
	SW(a01, a03, 2, m);
	SW(a04, a06, 2, m);
	SW(a05, a07, 2, m);
	SW(a08, a0A, 2, m);
	SW(a09, a0B, 2, m);
	SW(a0C, a0E, 2, m);
	SW(a0D, a0F, 2, m);
	SW(a10, a12, 2, m);
	SW(a11, a13, 2, m);
	SW(a14, a16, 2, m);
	SW(a15, a17, 2, m);
	SW(a18, a1A, 2, m);
	SW(a19, a1B, 2, m);
	SW(a1C, a1E, 2, m);
	SW(a1D, a1F, 2, m);
	m ^= (m >> 1);
	SW(a00, a01, 1, m);
	SW(a02, a03, 1, m);
	SW(a04, a05, 1, m);
	SW(a06, a07, 1, m);
	SW(a08, a09, 1, m);
	SW(a0A, a0B, 1, m);
	SW(a0C, a0D, 1, m);
	SW(a0E, a0F, 1, m);
	SW(a10, a11, 1, m);
	SW(a12, a13, 1, m);
	SW(a14, a15, 1, m);
	SW(a16, a17, 1, m);
	SW(a18, a19, 1, m);
	SW(a1A, a1B, 1, m);
	SW(a1C, a1D, 1, m);
	SW(a1E, a1F, 1, m);
	out[0x00] = a00;
	out[0x01] = a01;
	out[0x02] = a02;
	out[0x03] = a03;
	out[0x04] = a04;
	out[0x05] = a05;
	out[0x06] = a06;
	out[0x07] = a07;
	out[0x08] = a08;
	out[0x09] = a09;
	out[0x0A] = a0A;
	out[0x0B] = a0B;
	out[0x0C] = a0C;
	out[0x0D] = a0D;
	out[0x0E] = a0E;
	out[0x0F] = a0F;
	out[0x10] = a10;
	out[0x11] = a11;
	out[0x12] = a12;
	out[0x13] = a13;
	out[0x14] = a14;
	out[0x15] = a15;
	out[0x16] = a16;
	out[0x17] = a17;
	out[0x18] = a18;
	out[0x19] = a19;
	out[0x1A] = a1A;
	out[0x1B] = a1B;
	out[0x1C] = a1C;
	out[0x1D] = a1D;
	out[0x1E] = a1E;
	out[0x1F] = a1F;
}

#define W4 0

#ifdef __OPENCL_VERSION__

#if W4
#define W uint4
#else
#define W unsigned
#endif

#if 1
__kernel
void gpuMain(__global W *Ary,
			 unsigned k0,
			 unsigned k2)
{
	unsigned i;
	unsigned id = get_global_id(0);
	W a[32];
	W t[32];

	unsigned h[5];
	for (i = 0; i < 32; i++) {
#if W4
		sha1_32(h,
				k0, k1, k32((id << 7) + i + 0), 0x80000000,
				0x00000000, 0x00000000, 0x00000000, 0x00000000,
				0x00000000, 0x00000000, 0x00000000, 0x00000000,
				0x00000000, 0x00000000, 0x00000000, 0x00000060);
		a[i].x = h[0];
		sha1_32(h,
				k0, k1, k32((id << 7) + i + 1), 0x80000000,
				0x00000000, 0x00000000, 0x00000000, 0x00000000,
				0x00000000, 0x00000000, 0x00000000, 0x00000000,
				0x00000000, 0x00000000, 0x00000000, 0x00000060);
		a[i].y = h[0];
		sha1_32(h,
				k0, k1, k32((id << 7) + i + 2), 0x80000000,
				0x00000000, 0x00000000, 0x00000000, 0x00000000,
				0x00000000, 0x00000000, 0x00000000, 0x00000000,
				0x00000000, 0x00000000, 0x00000000, 0x00000060);
		a[i].z = h[0];
		sha1_32(h,
				k0, k1, k32((id << 7) + i + 3), 0x80000000,
				0x00000000, 0x00000000, 0x00000000, 0x00000000,
				0x00000000, 0x00000000, 0x00000000, 0x00000000,
				0x00000000, 0x00000000, 0x00000000, 0x00000060);
		a[i].w = h[0];
#else
		sha1_32(h,
				k0, k32((id << 5) + i), k2, 0x80000000,
				0x00000000, 0x00000000, 0x00000000, 0x00000000,
				0x00000000, 0x00000000, 0x00000000, 0x00000000,
				0x00000000, 0x00000000, 0x00000000, 0x00000060);
		a[i] = h[0];
#endif
	}

#if 1
	tr32(a, t);
	W x = t[31];
	for (i = 1; i < 30; i++)
		x |= t[31 - i];
	x = ~x;
#else
	W x = a[0];
	for (i = 1; i < 32; i++)
		x ^= a[i];
#endif

	Ary[id] = x;
}
#else
__kernel
void gpuMain(__global uint4 *Ary)
{
	unsigned i;
	unsigned id = get_global_id(0);
	uint4 a[32];

	unsigned h[5];
	for (i = 0; i < 32; i++) {
#if 1
	sha1_32(h,
		0x55555555, 0x55555555, k32((id << 7) + i + 0), 0x80000000,
		0x00000000, 0x00000000, 0x00000000, 0x00000000,
		0x00000000, 0x00000000, 0x00000000, 0x00000000,
		0x00000000, 0x00000000, 0x00000000, 0x00000060);
	a[i].x = h[0];
	sha1_32(h,
		0x55555555, 0x55555555, k32((id << 7) + i + 1), 0x80000000,
		0x00000000, 0x00000000, 0x00000000, 0x00000000,
		0x00000000, 0x00000000, 0x00000000, 0x00000000,
		0x00000000, 0x00000000, 0x00000000, 0x00000060);
	a[i].y = h[0];
	sha1_32(h,
		0x55555555, 0x55555555, k32((id << 7) + i + 2), 0x80000000,
		0x00000000, 0x00000000, 0x00000000, 0x00000000,
		0x00000000, 0x00000000, 0x00000000, 0x00000000,
		0x00000000, 0x00000000, 0x00000000, 0x00000060);
	a[i].z = h[0];
	sha1_32(h,
		0x55555555, 0x55555555, k32((id << 7) + i + 3), 0x80000000,
		0x00000000, 0x00000000, 0x00000000, 0x00000000,
		0x00000000, 0x00000000, 0x00000000, 0x00000000,
		0x00000000, 0x00000000, 0x00000000, 0x00000060);
	a[i].w = h[0];
#else
	sha1_32(h,
		0x55555555, 0x55555555, 0x55555555, 0x55555555,
		0x55555555, 0x55555555, 0x55555555, 0x55555555,
		0x55555555, 0x55555555, 0x55555555, 0x55555555,
		0x55555555, k24((id << 5) + i), 0x00000000, 0x000001B8);
	a[i].x = h[0];
#endif
	}

	uint4 x = a[0];
	for (i = 1; i < 32; i++)
		x ^= a[i];

	Ary[id] = x;
}
#endif
#else
#if W4
#define W cl_uint4
#else
#define W cl_uint
#endif

#endif
