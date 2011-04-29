#include "sha1_32.h"

#define ROL(n,a) (unsigned)(((a) << (n)) | ((unsigned)(a) >> (32 - (n))))

static inline
unsigned f0(unsigned b,
			unsigned c,
			unsigned d)
{
	return 0x5A827999U + ((b & c) + (~b & d));
}

static inline
unsigned f1(unsigned b,
			unsigned c,
			unsigned d)
{
	return 0x6ED9EBA1U + (b ^ c ^ d);
}

static inline
unsigned f2(unsigned b,
			unsigned c,
			unsigned d)
{
	return 0x8F1BBCDCU + ((b & c) | (c & d) | (d & b));
}

static inline
unsigned f3(unsigned b,
			unsigned c,
			unsigned d)
{
	return 0xCA62C1D6U + (b ^ c ^ d);
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

/*
 *	Local Variables:
 *		tab-width:	4
 *	End:
 */
