/* -*-C-*- */

//#define ROL(n,a) (unsigned)(((a) << (n)) | ((unsigned)(a) >> (32 - (n))))
#define ROL(n,a) rotate(a,n)


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

unsigned k24(unsigned a) {
    return (kadj(a >> 14) << 24) | (kadj(a >> 7) << 16) | (kadj(a) << 8) | 0x80;
}

__kernel
void gpuMain(__global unsigned *Ary)
{
    unsigned id = get_global_id(0);

    unsigned k00 = 0x55555555;
    unsigned k01 = 0x55555555;
    unsigned k02 = 0x55555555;
    unsigned k03 = 0x55555555;
    unsigned k04 = 0x55555555;
    unsigned k05 = 0x55555555;
    unsigned k06 = 0x55555555;
    unsigned k07 = 0x55555555;
    unsigned k08 = 0x55555555;
    unsigned k09 = 0x55555555;
    unsigned k0A = 0x55555555;
    unsigned k0B = 0x55555555;
    unsigned k0C = 0x55555555;
    unsigned k0D = 0x55555580;
    unsigned k0E = 0x00000000;
    unsigned k0F = 0x000001B8;

    k0D = k24(id);

    unsigned a, b, c, d, e;
    unsigned t;

#if 1
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

	a += 0x67452301U;
	b += 0xEFCDAB89U;
	c += 0x98BADCFEU;
#else
	a = k0D;
#endif
    Ary[id] = a;
}
