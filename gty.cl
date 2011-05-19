/* -*-C-*- */

#define W4 0

#ifdef __OPENCL_VERSION__

typedef unsigned T;

#if W4
typedef uint4 W;
#else
typedef unsigned W;
#endif

#define ROL(n,a) rotate(a,n)

#else

typedef cl_uint T;

#if W4
typedef cl_uint4 W;
#else
typedef cl_uint W;
#endif

#define ROL(n,a) (T)(((a) << (n)) | ((T)(a) >> (32 - (n))))

#endif

T f0(T b,
			T c,
			T d)
{
	return 0x5A827999U + ((c & b) | (d & ~b));
}


T f1(T b,
			T c,
			T d)
{
	return 0x6ED9EBA1U + (b ^ c ^ d);
}


T f2(T b,
			T c,
			T d)
{
	return 0x8F1BBCDCU + ((b & c) | (c & d) | (d & b));
}


T f3(T b,
			T c,
			T d)
{
	return 0xCA62C1D6U + (b ^ c ^ d);
}

/*
40-7E 63
89-97 9
A6-DD 56
*/

T kadj(T a)
{
	a &= 0x7F;
	a += 0x40;
	if (a >= 0x7F) a += (0x89 - 0x7F);
	if (a >= 0x98) a += (0xA6 - 0x98);
	return a;
}

T kadjL(T a)
{
	a &= 0x3F;
	a += 0x40;
	if (a >= 0x7A) a += (0xA6 - 0x7A);
	return a;
}

T k24(T a) {
	return (kadj(a >> 14) << 24) | (kadj(a >> 7) << 16) | (kadj(a) << 8) | 0x80;
}

T key32(T a) {
	return (kadj(a >> 21) << 24) | (kadj(a >> 14) << 16) | (kadj(a >> 7) << 8) | kadj(a);
}

T k32L(T a) {
	return (kadj(a >> 21) << 24) | (kadj(a >> 14) << 16) | (kadj(a >> 7) << 8) | kadjL(a);
}

void
sha1_k80(T *hash,
		T k00, T k01, T k02, T k03, T k04, T k05, T k06, T k07, T k08, T k09,
		T k10, T k11, T k12, T k13, T k14, T k15, T k16, T k17, T k18, T k19,
		T k20, T k21, T k22, T k23, T k24, T k25, T k26, T k27, T k28, T k29,
		T k30, T k31, T k32, T k33, T k34, T k35, T k36, T k37, T k38, T k39,
		T k40, T k41, T k42, T k43, T k44, T k45, T k46, T k47, T k48, T k49,
		T k50, T k51, T k52, T k53, T k54, T k55, T k56, T k57, T k58, T k59,
		T k60, T k61, T k62, T k63, T k64, T k65, T k66, T k67, T k68, T k69,
		T k70, T k71, T k72, T k73, T k74, T k75, T k76, T k77, T k78, T k79)
{
	T a, b, c, d, e;
	T t;

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
	t = ROL(5, a) + f0(b, c, d) + e + k10; e = d; d = c; c = ROL(30, b); b = a; a = t;
	t = ROL(5, a) + f0(b, c, d) + e + k11; e = d; d = c; c = ROL(30, b); b = a; a = t;
	t = ROL(5, a) + f0(b, c, d) + e + k12; e = d; d = c; c = ROL(30, b); b = a; a = t;
	t = ROL(5, a) + f0(b, c, d) + e + k13; e = d; d = c; c = ROL(30, b); b = a; a = t;
	t = ROL(5, a) + f0(b, c, d) + e + k14; e = d; d = c; c = ROL(30, b); b = a; a = t;
	t = ROL(5, a) + f0(b, c, d) + e + k15; e = d; d = c; c = ROL(30, b); b = a; a = t;
	t = ROL(5, a) + f0(b, c, d) + e + k16; e = d; d = c; c = ROL(30, b); b = a; a = t;
	t = ROL(5, a) + f0(b, c, d) + e + k17; e = d; d = c; c = ROL(30, b); b = a; a = t;
	t = ROL(5, a) + f0(b, c, d) + e + k18; e = d; d = c; c = ROL(30, b); b = a; a = t;
	t = ROL(5, a) + f0(b, c, d) + e + k19; e = d; d = c; c = ROL(30, b); b = a; a = t;
	t = ROL(5, a) + f1(b, c, d) + e + k20; e = d; d = c; c = ROL(30, b); b = a; a = t;
	t = ROL(5, a) + f1(b, c, d) + e + k21; e = d; d = c; c = ROL(30, b); b = a; a = t;
	t = ROL(5, a) + f1(b, c, d) + e + k22; e = d; d = c; c = ROL(30, b); b = a; a = t;
	t = ROL(5, a) + f1(b, c, d) + e + k23; e = d; d = c; c = ROL(30, b); b = a; a = t;
	t = ROL(5, a) + f1(b, c, d) + e + k24; e = d; d = c; c = ROL(30, b); b = a; a = t;
	t = ROL(5, a) + f1(b, c, d) + e + k25; e = d; d = c; c = ROL(30, b); b = a; a = t;
	t = ROL(5, a) + f1(b, c, d) + e + k26; e = d; d = c; c = ROL(30, b); b = a; a = t;
	t = ROL(5, a) + f1(b, c, d) + e + k27; e = d; d = c; c = ROL(30, b); b = a; a = t;
	t = ROL(5, a) + f1(b, c, d) + e + k28; e = d; d = c; c = ROL(30, b); b = a; a = t;
	t = ROL(5, a) + f1(b, c, d) + e + k29; e = d; d = c; c = ROL(30, b); b = a; a = t;
	t = ROL(5, a) + f1(b, c, d) + e + k30; e = d; d = c; c = ROL(30, b); b = a; a = t;
	t = ROL(5, a) + f1(b, c, d) + e + k31; e = d; d = c; c = ROL(30, b); b = a; a = t;
	t = ROL(5, a) + f1(b, c, d) + e + k32; e = d; d = c; c = ROL(30, b); b = a; a = t;
	t = ROL(5, a) + f1(b, c, d) + e + k33; e = d; d = c; c = ROL(30, b); b = a; a = t;
	t = ROL(5, a) + f1(b, c, d) + e + k34; e = d; d = c; c = ROL(30, b); b = a; a = t;
	t = ROL(5, a) + f1(b, c, d) + e + k35; e = d; d = c; c = ROL(30, b); b = a; a = t;
	t = ROL(5, a) + f1(b, c, d) + e + k36; e = d; d = c; c = ROL(30, b); b = a; a = t;
	t = ROL(5, a) + f1(b, c, d) + e + k37; e = d; d = c; c = ROL(30, b); b = a; a = t;
	t = ROL(5, a) + f1(b, c, d) + e + k38; e = d; d = c; c = ROL(30, b); b = a; a = t;
	t = ROL(5, a) + f1(b, c, d) + e + k39; e = d; d = c; c = ROL(30, b); b = a; a = t;
	t = ROL(5, a) + f2(b, c, d) + e + k40; e = d; d = c; c = ROL(30, b); b = a; a = t;
	t = ROL(5, a) + f2(b, c, d) + e + k41; e = d; d = c; c = ROL(30, b); b = a; a = t;
	t = ROL(5, a) + f2(b, c, d) + e + k42; e = d; d = c; c = ROL(30, b); b = a; a = t;
	t = ROL(5, a) + f2(b, c, d) + e + k43; e = d; d = c; c = ROL(30, b); b = a; a = t;
	t = ROL(5, a) + f2(b, c, d) + e + k44; e = d; d = c; c = ROL(30, b); b = a; a = t;
	t = ROL(5, a) + f2(b, c, d) + e + k45; e = d; d = c; c = ROL(30, b); b = a; a = t;
	t = ROL(5, a) + f2(b, c, d) + e + k46; e = d; d = c; c = ROL(30, b); b = a; a = t;
	t = ROL(5, a) + f2(b, c, d) + e + k47; e = d; d = c; c = ROL(30, b); b = a; a = t;
	t = ROL(5, a) + f2(b, c, d) + e + k48; e = d; d = c; c = ROL(30, b); b = a; a = t;
	t = ROL(5, a) + f2(b, c, d) + e + k49; e = d; d = c; c = ROL(30, b); b = a; a = t;
	t = ROL(5, a) + f2(b, c, d) + e + k50; e = d; d = c; c = ROL(30, b); b = a; a = t;
	t = ROL(5, a) + f2(b, c, d) + e + k51; e = d; d = c; c = ROL(30, b); b = a; a = t;
	t = ROL(5, a) + f2(b, c, d) + e + k52; e = d; d = c; c = ROL(30, b); b = a; a = t;
	t = ROL(5, a) + f2(b, c, d) + e + k53; e = d; d = c; c = ROL(30, b); b = a; a = t;
	t = ROL(5, a) + f2(b, c, d) + e + k54; e = d; d = c; c = ROL(30, b); b = a; a = t;
	t = ROL(5, a) + f2(b, c, d) + e + k55; e = d; d = c; c = ROL(30, b); b = a; a = t;
	t = ROL(5, a) + f2(b, c, d) + e + k56; e = d; d = c; c = ROL(30, b); b = a; a = t;
	t = ROL(5, a) + f2(b, c, d) + e + k57; e = d; d = c; c = ROL(30, b); b = a; a = t;
	t = ROL(5, a) + f2(b, c, d) + e + k58; e = d; d = c; c = ROL(30, b); b = a; a = t;
	t = ROL(5, a) + f2(b, c, d) + e + k59; e = d; d = c; c = ROL(30, b); b = a; a = t;
	t = ROL(5, a) + f3(b, c, d) + e + k60; e = d; d = c; c = ROL(30, b); b = a; a = t;
	t = ROL(5, a) + f3(b, c, d) + e + k61; e = d; d = c; c = ROL(30, b); b = a; a = t;
	t = ROL(5, a) + f3(b, c, d) + e + k62; e = d; d = c; c = ROL(30, b); b = a; a = t;
	t = ROL(5, a) + f3(b, c, d) + e + k63; e = d; d = c; c = ROL(30, b); b = a; a = t;
	t = ROL(5, a) + f3(b, c, d) + e + k64; e = d; d = c; c = ROL(30, b); b = a; a = t;
	t = ROL(5, a) + f3(b, c, d) + e + k65; e = d; d = c; c = ROL(30, b); b = a; a = t;
	t = ROL(5, a) + f3(b, c, d) + e + k66; e = d; d = c; c = ROL(30, b); b = a; a = t;
	t = ROL(5, a) + f3(b, c, d) + e + k67; e = d; d = c; c = ROL(30, b); b = a; a = t;
	t = ROL(5, a) + f3(b, c, d) + e + k68; e = d; d = c; c = ROL(30, b); b = a; a = t;
	t = ROL(5, a) + f3(b, c, d) + e + k69; e = d; d = c; c = ROL(30, b); b = a; a = t;
	t = ROL(5, a) + f3(b, c, d) + e + k70; e = d; d = c; c = ROL(30, b); b = a; a = t;
	t = ROL(5, a) + f3(b, c, d) + e + k71; e = d; d = c; c = ROL(30, b); b = a; a = t;
	t = ROL(5, a) + f3(b, c, d) + e + k72; e = d; d = c; c = ROL(30, b); b = a; a = t;
	t = ROL(5, a) + f3(b, c, d) + e + k73; e = d; d = c; c = ROL(30, b); b = a; a = t;
	t = ROL(5, a) + f3(b, c, d) + e + k74; e = d; d = c; c = ROL(30, b); b = a; a = t;
	t = ROL(5, a) + f3(b, c, d) + e + k75; e = d; d = c; c = ROL(30, b); b = a; a = t;
	t = ROL(5, a) + f3(b, c, d) + e + k76; e = d; d = c; c = ROL(30, b); b = a; a = t;
	t = ROL(5, a) + f3(b, c, d) + e + k77; e = d; d = c; c = ROL(30, b); b = a; a = t;
	t = ROL(5, a) + f3(b, c, d) + e + k78; e = d; d = c; c = ROL(30, b); b = a; a = t;
	t = ROL(5, a) + f3(b, c, d) + e + k79; e = d; d = c; c = ROL(30, b); b = a; a = t;

	hash[0] = 0x67452301U + a;
	hash[1] = 0xEFCDAB89U + b;
	hash[2] = 0x98BADCFEU + c;
}

void
sha1_k80_1(T *hash,
		   T t01,
		   T k00, T k01, T k02, T k03, T k04, T k05, T k06, T k07, T k08, T k09,
		   T k10, T k11, T k12, T k13, T k14, T k15, T k16, T k17, T k18, T k19,
		   T k20, T k21, T k22, T k23, T k24, T k25, T k26, T k27, T k28, T k29,
		   T k30, T k31, T k32, T k33, T k34, T k35, T k36, T k37, T k38, T k39,
		   T k40, T k41, T k42, T k43, T k44, T k45, T k46, T k47, T k48, T k49,
		   T k50, T k51, T k52, T k53, T k54, T k55, T k56, T k57, T k58, T k59,
		   T k60, T k61, T k62, T k63, T k64, T k65, T k66, T k67, T k68, T k69,
		   T k70, T k71, T k72, T k73, T k74, T k75, T k76, T k77, T k78, T k79)
{
	k01 ^= t01;
	T t17 = ROL(1, t01); k17 ^= t17;


	T t20 = ROL(1, t17); k20 ^= t20;


	T t23 = ROL(1, t20); k23 ^= t23;

	T t25 = t20; k25 ^= t25;
	T t26 = ROL(2, t25); k26 ^= t26;


	T t29 = ROL(1, t26); k29 ^= t29;

	T t31 = t26 ^ t25; k31 ^= t31;
	T t32 = ROL(1, t29); k32 ^= t32;
	T t33 = t25 ^ t23; k33 ^= t33;

	T t35 = ROL(1, t32); k35 ^= t35;
	T t36 = t26; k36 ^= t36;
	T t37 = t36 ^ t32; k37 ^= t37;
	T t38 = ROL(4, t36); k38 ^= t38;
	T t39 = t36; k39 ^= t39;

	T t41 = ROL(1, t38 ^ t23); k41 ^= t41;

	T t43 = t38 ^ t32; k43 ^= t43;
	T t44 = ROL(6, t39); k44 ^= t44;
	T t45 = t35 ^ t32 ^ t23; k45 ^= t45;

	T t47 = ROL(1, t44 ^ t23); k47 ^= t47;
	T t48 = t43 ^ t37; k48 ^= t48;
	T t49 = t48 ^ t44 ^ t29 ^ t23; k49 ^= t49;
	T t50 = ROL(2, t44); k50 ^= t50;
	T t51 = t38; k51 ^= t51;
	T t52 = t37; k52 ^= t52;
	T t53 = t48 ^ ROL(5, t51); k53 ^= t53;

	T t55 = t50 ^ t44 ^ t35; k55 ^= t55;
	T t56 = ROL(6, t51); k56 ^= t56;
	T t57 = t52 ^ ROL(4, t45); k57 ^= t57;
	T t58 = t51; k58 ^= t58;
	T t59 = t53 ^ ROL(9, t52); k59 ^= t59;
	T t60 = t58 ^ t50; k60 ^= t60;
	T t61 = t41 ^ ROL(4, t49); k61 ^= t61;
	T t62 = ROL(8, t58); k62 ^= t62;
	T t63 = t60 ^ t52; k63 ^= t63;
	T t64 = t58; k64 ^= t64;
	T t65 = t63 ^ ROL(1, t62 ^ t32); k65 ^= t65;

	T t67 = t62 ^ t56; k67 ^= t67;
	T t68 = ROL(1, t65 ^ t63); k68 ^= t68;
	T t69 = ROL(8, t45); k69 ^= t69;

	T t71 = ROL(8, t47); k71 ^= t71;
	T t72 = t62 ^ t50; k72 ^= t72;
	T t73 = t29 ^ ROL(8, t49); k73 ^= t73;
	T t74 = ROL(12, t64); k74 ^= t74;
	T t75 = t72 ^ t60; k75 ^= t75;
	T t76 = t72 ^ t67 ^ t32; k76 ^= t76;
	T t77 = ROL(4, t65 ^ t45); k77 ^= t77;

	T t79 = ROL(4, t67 ^ t47 ^ t23); k79 ^= t79;

	sha1_k80(hash,
			 k00, k01, k02, k03, k04, k05, k06, k07, k08, k09,
			 k10, k11, k12, k13, k14, k15, k16, k17, k18, k19,
			 k20, k21, k22, k23, k24, k25, k26, k27, k28, k29,
			 k30, k31, k32, k33, k34, k35, k36, k37, k38, k39,
			 k40, k41, k42, k43, k44, k45, k46, k47, k48, k49,
			 k50, k51, k52, k53, k54, k55, k56, k57, k58, k59,
			 k60, k61, k62, k63, k64, k65, k66, k67, k68, k69,
			 k70, k71, k72, k73, k74, k75, k76, k77, k78, k79);
}

void
sha1_32(T *hash,
		T k00, T k01, T k02, T k03, T k04, T k05, T k06, T k07,
		T k08, T k09, T k10, T k11, T k12, T k13, T k14, T k15)
{
	T k16 = ROL(1, k00 ^ k02 ^ k08 ^ k13);
	T k17 = ROL(1, k01 ^ k03 ^ k09 ^ k14);
	T k18 = ROL(1, k02 ^ k04 ^ k10 ^ k15);
	T k19 = ROL(1, k03 ^ k05 ^ k11 ^ k16);
	T k20 = ROL(1, k04 ^ k06 ^ k12 ^ k17);
	T k21 = ROL(1, k05 ^ k07 ^ k13 ^ k18);
	T k22 = ROL(1, k06 ^ k08 ^ k14 ^ k19);
	T k23 = ROL(1, k07 ^ k09 ^ k15 ^ k20);
	T k24 = ROL(1, k08 ^ k10 ^ k16 ^ k21);
	T k25 = ROL(1, k09 ^ k11 ^ k17 ^ k22);
	T k26 = ROL(1, k10 ^ k12 ^ k18 ^ k23);
	T k27 = ROL(1, k11 ^ k13 ^ k19 ^ k24);
	T k28 = ROL(1, k12 ^ k14 ^ k20 ^ k25);
	T k29 = ROL(1, k13 ^ k15 ^ k21 ^ k26);
	T k30 = ROL(1, k14 ^ k16 ^ k22 ^ k27);
	T k31 = ROL(1, k15 ^ k17 ^ k23 ^ k28);
	T k32 = ROL(1, k16 ^ k18 ^ k24 ^ k29);
	T k33 = ROL(1, k17 ^ k19 ^ k25 ^ k30);
	T k34 = ROL(1, k18 ^ k20 ^ k26 ^ k31);
	T k35 = ROL(1, k19 ^ k21 ^ k27 ^ k32);
	T k36 = ROL(1, k20 ^ k22 ^ k28 ^ k33);
	T k37 = ROL(1, k21 ^ k23 ^ k29 ^ k34);
	T k38 = ROL(1, k22 ^ k24 ^ k30 ^ k35);
	T k39 = ROL(1, k23 ^ k25 ^ k31 ^ k36);
	T k40 = ROL(1, k24 ^ k26 ^ k32 ^ k37);
	T k41 = ROL(1, k25 ^ k27 ^ k33 ^ k38);
	T k42 = ROL(1, k26 ^ k28 ^ k34 ^ k39);
	T k43 = ROL(1, k27 ^ k29 ^ k35 ^ k40);
	T k44 = ROL(1, k28 ^ k30 ^ k36 ^ k41);
	T k45 = ROL(1, k29 ^ k31 ^ k37 ^ k42);
	T k46 = ROL(1, k30 ^ k32 ^ k38 ^ k43);
	T k47 = ROL(1, k31 ^ k33 ^ k39 ^ k44);
	T k48 = ROL(1, k32 ^ k34 ^ k40 ^ k45);
	T k49 = ROL(1, k33 ^ k35 ^ k41 ^ k46);
	T k50 = ROL(1, k34 ^ k36 ^ k42 ^ k47);
	T k51 = ROL(1, k35 ^ k37 ^ k43 ^ k48);
	T k52 = ROL(1, k36 ^ k38 ^ k44 ^ k49);
	T k53 = ROL(1, k37 ^ k39 ^ k45 ^ k50);
	T k54 = ROL(1, k38 ^ k40 ^ k46 ^ k51);
	T k55 = ROL(1, k39 ^ k41 ^ k47 ^ k52);
	T k56 = ROL(1, k40 ^ k42 ^ k48 ^ k53);
	T k57 = ROL(1, k41 ^ k43 ^ k49 ^ k54);
	T k58 = ROL(1, k42 ^ k44 ^ k50 ^ k55);
	T k59 = ROL(1, k43 ^ k45 ^ k51 ^ k56);
	T k60 = ROL(1, k44 ^ k46 ^ k52 ^ k57);
	T k61 = ROL(1, k45 ^ k47 ^ k53 ^ k58);
	T k62 = ROL(1, k46 ^ k48 ^ k54 ^ k59);
	T k63 = ROL(1, k47 ^ k49 ^ k55 ^ k60);
	T k64 = ROL(1, k48 ^ k50 ^ k56 ^ k61);
	T k65 = ROL(1, k49 ^ k51 ^ k57 ^ k62);
	T k66 = ROL(1, k50 ^ k52 ^ k58 ^ k63);
	T k67 = ROL(1, k51 ^ k53 ^ k59 ^ k64);
	T k68 = ROL(1, k52 ^ k54 ^ k60 ^ k65);
	T k69 = ROL(1, k53 ^ k55 ^ k61 ^ k66);
	T k70 = ROL(1, k54 ^ k56 ^ k62 ^ k67);
	T k71 = ROL(1, k55 ^ k57 ^ k63 ^ k68);
	T k72 = ROL(1, k56 ^ k58 ^ k64 ^ k69);
	T k73 = ROL(1, k57 ^ k59 ^ k65 ^ k70);
	T k74 = ROL(1, k58 ^ k60 ^ k66 ^ k71);
	T k75 = ROL(1, k59 ^ k61 ^ k67 ^ k72);
	T k76 = ROL(1, k60 ^ k62 ^ k68 ^ k73);
	T k77 = ROL(1, k61 ^ k63 ^ k69 ^ k74);
	T k78 = ROL(1, k62 ^ k64 ^ k70 ^ k75);
	T k79 = ROL(1, k63 ^ k65 ^ k71 ^ k76);
	sha1_k80(hash,
			 k00, k01, k02, k03, k04, k05, k06, k07, k08, k09,
			 k10, k11, k12, k13, k14, k15, k16, k17, k18, k19,
			 k20, k21, k22, k23, k24, k25, k26, k27, k28, k29,
			 k30, k31, k32, k33, k34, k35, k36, k37, k38, k39,
			 k40, k41, k42, k43, k44, k45, k46, k47, k48, k49,
			 k50, k51, k52, k53, k54, k55, k56, k57, k58, k59,
			 k60, k61, k62, k63, k64, k65, k66, k67, k68, k69,
			 k70, k71, k72, k73, k74, k75, k76, k77, k78, k79);
}

void
sha1_32_1(T *hash,
		T k00, T k01, T k02, T k03, T k04, T k05, T k06, T k07,
		T k08, T k09, T k10, T k11, T k12, T k13, T k14, T k15)
{
	T t01 = k01;
	k01 = 0;
	T k16 = ROL(1, k00 ^ k02 ^ k08 ^ k13);
	T k17 = ROL(1, k01 ^ k03 ^ k09 ^ k14);
	T k18 = ROL(1, k02 ^ k04 ^ k10 ^ k15);
	T k19 = ROL(1, k03 ^ k05 ^ k11 ^ k16);
	T k20 = ROL(1, k04 ^ k06 ^ k12 ^ k17);
	T k21 = ROL(1, k05 ^ k07 ^ k13 ^ k18);
	T k22 = ROL(1, k06 ^ k08 ^ k14 ^ k19);
	T k23 = ROL(1, k07 ^ k09 ^ k15 ^ k20);
	T k24 = ROL(1, k08 ^ k10 ^ k16 ^ k21);
	T k25 = ROL(1, k09 ^ k11 ^ k17 ^ k22);
	T k26 = ROL(1, k10 ^ k12 ^ k18 ^ k23);
	T k27 = ROL(1, k11 ^ k13 ^ k19 ^ k24);
	T k28 = ROL(1, k12 ^ k14 ^ k20 ^ k25);
	T k29 = ROL(1, k13 ^ k15 ^ k21 ^ k26);
	T k30 = ROL(1, k14 ^ k16 ^ k22 ^ k27);
	T k31 = ROL(1, k15 ^ k17 ^ k23 ^ k28);
	T k32 = ROL(1, k16 ^ k18 ^ k24 ^ k29);
	T k33 = ROL(1, k17 ^ k19 ^ k25 ^ k30);
	T k34 = ROL(1, k18 ^ k20 ^ k26 ^ k31);
	T k35 = ROL(1, k19 ^ k21 ^ k27 ^ k32);
	T k36 = ROL(1, k20 ^ k22 ^ k28 ^ k33);
	T k37 = ROL(1, k21 ^ k23 ^ k29 ^ k34);
	T k38 = ROL(1, k22 ^ k24 ^ k30 ^ k35);
	T k39 = ROL(1, k23 ^ k25 ^ k31 ^ k36);
	T k40 = ROL(1, k24 ^ k26 ^ k32 ^ k37);
	T k41 = ROL(1, k25 ^ k27 ^ k33 ^ k38);
	T k42 = ROL(1, k26 ^ k28 ^ k34 ^ k39);
	T k43 = ROL(1, k27 ^ k29 ^ k35 ^ k40);
	T k44 = ROL(1, k28 ^ k30 ^ k36 ^ k41);
	T k45 = ROL(1, k29 ^ k31 ^ k37 ^ k42);
	T k46 = ROL(1, k30 ^ k32 ^ k38 ^ k43);
	T k47 = ROL(1, k31 ^ k33 ^ k39 ^ k44);
	T k48 = ROL(1, k32 ^ k34 ^ k40 ^ k45);
	T k49 = ROL(1, k33 ^ k35 ^ k41 ^ k46);
	T k50 = ROL(1, k34 ^ k36 ^ k42 ^ k47);
	T k51 = ROL(1, k35 ^ k37 ^ k43 ^ k48);
	T k52 = ROL(1, k36 ^ k38 ^ k44 ^ k49);
	T k53 = ROL(1, k37 ^ k39 ^ k45 ^ k50);
	T k54 = ROL(1, k38 ^ k40 ^ k46 ^ k51);
	T k55 = ROL(1, k39 ^ k41 ^ k47 ^ k52);
	T k56 = ROL(1, k40 ^ k42 ^ k48 ^ k53);
	T k57 = ROL(1, k41 ^ k43 ^ k49 ^ k54);
	T k58 = ROL(1, k42 ^ k44 ^ k50 ^ k55);
	T k59 = ROL(1, k43 ^ k45 ^ k51 ^ k56);
	T k60 = ROL(1, k44 ^ k46 ^ k52 ^ k57);
	T k61 = ROL(1, k45 ^ k47 ^ k53 ^ k58);
	T k62 = ROL(1, k46 ^ k48 ^ k54 ^ k59);
	T k63 = ROL(1, k47 ^ k49 ^ k55 ^ k60);
	T k64 = ROL(1, k48 ^ k50 ^ k56 ^ k61);
	T k65 = ROL(1, k49 ^ k51 ^ k57 ^ k62);
	T k66 = ROL(1, k50 ^ k52 ^ k58 ^ k63);
	T k67 = ROL(1, k51 ^ k53 ^ k59 ^ k64);
	T k68 = ROL(1, k52 ^ k54 ^ k60 ^ k65);
	T k69 = ROL(1, k53 ^ k55 ^ k61 ^ k66);
	T k70 = ROL(1, k54 ^ k56 ^ k62 ^ k67);
	T k71 = ROL(1, k55 ^ k57 ^ k63 ^ k68);
	T k72 = ROL(1, k56 ^ k58 ^ k64 ^ k69);
	T k73 = ROL(1, k57 ^ k59 ^ k65 ^ k70);
	T k74 = ROL(1, k58 ^ k60 ^ k66 ^ k71);
	T k75 = ROL(1, k59 ^ k61 ^ k67 ^ k72);
	T k76 = ROL(1, k60 ^ k62 ^ k68 ^ k73);
	T k77 = ROL(1, k61 ^ k63 ^ k69 ^ k74);
	T k78 = ROL(1, k62 ^ k64 ^ k70 ^ k75);
	T k79 = ROL(1, k63 ^ k65 ^ k71 ^ k76);
#if 1
	sha1_k80_1(hash,
			   t01,
			   k00, k01, k02, k03, k04, k05, k06, k07, k08, k09,
			   k10, k11, k12, k13, k14, k15, k16, k17, k18, k19,
			   k20, k21, k22, k23, k24, k25, k26, k27, k28, k29,
			   k30, k31, k32, k33, k34, k35, k36, k37, k38, k39,
			   k40, k41, k42, k43, k44, k45, k46, k47, k48, k49,
			   k50, k51, k52, k53, k54, k55, k56, k57, k58, k59,
			   k60, k61, k62, k63, k64, k65, k66, k67, k68, k69,
			   k70, k71, k72, k73, k74, k75, k76, k77, k78, k79);
#else
	sha1_k80(hash,
			 k00, k01, k02, k03, k04, k05, k06, k07, k08, k09,
			 k10, k11, k12, k13, k14, k15, k16, k17, k18, k19,
			 k20, k21, k22, k23, k24, k25, k26, k27, k28, k29,
			 k30, k31, k32, k33, k34, k35, k36, k37, k38, k39,
			 k40, k41, k42, k43, k44, k45, k46, k47, k48, k49,
			 k50, k51, k52, k53, k54, k55, k56, k57, k58, k59,
			 k60, k61, k62, k63, k64, k65, k66, k67, k68, k69,
			 k70, k71, k72, k73, k74, k75, k76, k77, k78, k79);
#endif
}

#define SW(a0, a1, j, m) (t = (a0 ^ (a1 << j)) & m, a0 ^= t, a1 ^= (t >> j))

void tr32(const T *in, T *out)
{
	T a00 = in[0x00];
	T a01 = in[0x01];
	T a02 = in[0x02];
	T a03 = in[0x03];
	T a04 = in[0x04];
	T a05 = in[0x05];
	T a06 = in[0x06];
	T a07 = in[0x07];
	T a08 = in[0x08];
	T a09 = in[0x09];
	T a0A = in[0x0A];
	T a0B = in[0x0B];
	T a0C = in[0x0C];
	T a0D = in[0x0D];
	T a0E = in[0x0E];
	T a0F = in[0x0F];
	T a10 = in[0x10];
	T a11 = in[0x11];
	T a12 = in[0x12];
	T a13 = in[0x13];
	T a14 = in[0x14];
	T a15 = in[0x15];
	T a16 = in[0x16];
	T a17 = in[0x17];
	T a18 = in[0x18];
	T a19 = in[0x19];
	T a1A = in[0x1A];
	T a1B = in[0x1B];
	T a1C = in[0x1C];
	T a1D = in[0x1D];
	T a1E = in[0x1E];
	T a1F = in[0x1F];
	T t;
	T m = 0xFFFF0000;
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

T b64e(unsigned a) {
	if ('.' <= a && a <= '/')
		a -= '.' - 076;
	else if ('0' <= a && a <= '9')
		a -= '0' - 064;
	else if ('A' <= a && a <= 'Z')
		a -= 'A';
	else if ('a' <= a && a <= 'z')
		a -= 'a' - 032;
	else
		a = 076;
	return a;
}

T cmp8(T a, T b,
		 int s0, int s1, int s2, int s3,
		 int s4, int s5, int s6, int s7)
{
	T s04 = ((b64e(s0) << 26)
					| (b64e(s1) << 20)
					| (b64e(s2) << 14)
					| (b64e(s3) << 8)
					| (b64e(s4) << 2)
					| (b64e(s5) >> 4));
	T s47 = ((b64e(s5) << 28)
					| (b64e(s6) << 22)
					| (b64e(s7) << 16));
	return (a == s04
			&& (b & 0xFFFF0000) == s47
		);
}

T cmp8E(T a, T b, T c,
		int s0, int s1, int s2, int s3,
		int s4, int s5, int s6, int s7)
{
	T s01 = ((b64e(s0) << 2)
			 | (b64e(s1) >> 4));
	T s16 = ((b64e(s1) << 28)
			 | (b64e(s2) << 22)
			 | (b64e(s3) << 16)
			 | (b64e(s4) << 10)
			 | (b64e(s5) << 4)
			 | (b64e(s6) >> 2));
	T s67 = ((b64e(s6) << 30)
			 | (b64e(s7) << 24));
	return (1
			&& (a & 0x000000FF) == s01
			&& b == s16
			&& (c & 0xFF000000) == s67
		);
}

T cmp7(T a, T b,
		 int s0, int s1, int s2, int s3,
		 int s4, int s5, int s6)
{
	T s04 = ((b64e(s0) << 26)
					| (b64e(s1) << 20)
					| (b64e(s2) << 14)
					| (b64e(s3) << 8)
					| (b64e(s4) << 2)
					| (b64e(s5) >> 4));
	T s46 = ((b64e(s5) << 28)
			 | (b64e(s6) << 22));
	return (a == s04
			&& (b & 0xFFC00000) == s46
		);
}

T cmps(T a, T b, T c)
{
	return (0
			|| cmp8E(a, b, c, '1','1','2','2','1','1','2','2')
			|| cmp8(a, b, 'L','I','F','E','i','s','/','/')
			|| cmp8(a, b, 'd','d','z','a','5','i','g','k')
			|| cmp8(a, b, 'F','R','Z','X','X','X','X','X')
#if 1
			|| cmp8(a, b, '6','9','6','9','6','9','6','9')
#endif
			);
}

#ifdef __OPENCL_VERSION__
#if 1
__kernel
void gpuMain(__global W *Ary,
			 __constant T k[80])
{
	unsigned i;
	unsigned id = get_global_id(0);
	W a[32], b[32];
	W t[32];

	T h[5];
	W m = 0;
	for (i = 0; i < 32; i++) {
		sha1_k80_1(h,
				   key32((id << 5) + i),
				   k[00], 0, k[02], 0x80000000,
				   0x00000000, 0x00000000, 0x00000000, 0x00000000,
				   0x00000000, 0x00000000, 0x00000000, 0x00000000,
				   0x00000000, 0x00000000, 0x00000000, 0x00000060,
				   k[16], k[17], k[18], k[19],
				   k[20], k[21], k[22], k[23], k[24], k[25], k[26], k[27], k[28], k[29],
				   k[30], k[31], k[32], k[33], k[34], k[35], k[36], k[37], k[38], k[39],
				   k[40], k[41], k[42], k[43], k[44], k[45], k[46], k[47], k[48], k[49],
				   k[50], k[51], k[52], k[53], k[54], k[55], k[56], k[57], k[58], k[59],
				   k[60], k[61], k[62], k[63], k[64], k[65], k[66], k[67], k[68], k[69],
				   k[70], k[71], k[72], k[73], k[74], k[75], k[76], k[77], k[78], k[79]);
#if 1
		m >>= 1;
		if (cmps(h[0], h[1], h[2]))
			m |= 0x80000000;
#else
		a[i] = h[0];
		b[i] = h[1];
#endif
	}

	W x;
#if 1
	x = 0;
	for (i = 0; i < 32; i++) {
		if (0
			)
			x ^= 1U << i;
	}
#else
	tr32(a, t);
	x = t[31];
	for (i = 1; i < 30; i++)
		x |= t[31 - i];
	x = ~x;
#endif

	Ary[id] = m;
}
#elif 1
__kernel
void gpuMain(__global W *Ary,
			 __constant T k[80])
{
	unsigned i;
	unsigned id = get_global_id(0);
	W a[32], b[32];
	W t[32];

	T h[5];
	W m = 0;
	for (i = 0; i < 32; i++) {
		sha1_32_1(h,
				  k[00], key32((id << 5) + i), k[02], 0x80000000,
				  0x00000000, 0x00000000, 0x00000000, 0x00000000,
				  0x00000000, 0x00000000, 0x00000000, 0x00000000,
				  0x00000000, 0x00000000, 0x00000000, 0x00000060);
#if 1
		m >>= 1;
		if (cmps(h[0], h[1]))
			m |= 0x80000000;
#else
		a[i] = h[0];
		b[i] = h[1];
#endif
	}

	W x;
#if 1
	x = 0;
	for (i = 0; i < 32; i++) {
		if (0
			)
			x ^= 1U << i;
	}
#else
	tr32(a, t);
	x = t[31];
	for (i = 1; i < 30; i++)
		x |= t[31 - i];
	x = ~x;
#endif

	Ary[id] = m;
}
#elif 1
__kernel
void gpuMain(__global W *Ary,
			 T k0,
			 T k2)
{
	unsigned i;
	unsigned id = get_global_id(0);
	W a[32], b[32];
	W t[32];

	T h[5];
	W m = 0;
	for (i = 0; i < 32; i++) {
#if W4
		sha1_32(h,
				k0, k1, key32((id << 7) + i + 0), 0x80000000,
				0x00000000, 0x00000000, 0x00000000, 0x00000000,
				0x00000000, 0x00000000, 0x00000000, 0x00000000,
				0x00000000, 0x00000000, 0x00000000, 0x00000060);
		a[i].x = h[0];
		sha1_32(h,
				k0, k1, key32((id << 7) + i + 1), 0x80000000,
				0x00000000, 0x00000000, 0x00000000, 0x00000000,
				0x00000000, 0x00000000, 0x00000000, 0x00000000,
				0x00000000, 0x00000000, 0x00000000, 0x00000060);
		a[i].y = h[0];
		sha1_32(h,
				k0, k1, key32((id << 7) + i + 2), 0x80000000,
				0x00000000, 0x00000000, 0x00000000, 0x00000000,
				0x00000000, 0x00000000, 0x00000000, 0x00000000,
				0x00000000, 0x00000000, 0x00000000, 0x00000060);
		a[i].z = h[0];
		sha1_32(h,
				k0, k1, key32((id << 7) + i + 3), 0x80000000,
				0x00000000, 0x00000000, 0x00000000, 0x00000000,
				0x00000000, 0x00000000, 0x00000000, 0x00000000,
				0x00000000, 0x00000000, 0x00000000, 0x00000060);
		a[i].w = h[0];
#else
		sha1_32_1(h,
				k0, key32((id << 5) + i), k2, 0x80000000,
				0x00000000, 0x00000000, 0x00000000, 0x00000000,
				0x00000000, 0x00000000, 0x00000000, 0x00000000,
				0x00000000, 0x00000000, 0x00000000, 0x00000060);
#if 1
		m >>= 1;
		if (cmps(h[0], h[1]))
			m |= 0x80000000;
#else
		a[i] = h[0];
		b[i] = h[1];
#endif
#endif
	}

	W x;
#if 1
	x = 0;
	for (i = 0; i < 32; i++) {
		if (0
			)
			x ^= 1U << i;
	}
#else
	tr32(a, t);
	x = t[31];
	for (i = 1; i < 30; i++)
		x |= t[31 - i];
	x = ~x;
#endif

	Ary[id] = m;
}
#else
__kernel
void gpuMain(__global uint4 *Ary)
{
	unsigned i;
	unsigned id = get_global_id(0);
	uint4 a[32];

	T h[5];
	for (i = 0; i < 32; i++) {
#if 1
	sha1_32(h,
		0x55555555, 0x55555555, key32((id << 7) + i + 0), 0x80000000,
		0x00000000, 0x00000000, 0x00000000, 0x00000000,
		0x00000000, 0x00000000, 0x00000000, 0x00000000,
		0x00000000, 0x00000000, 0x00000000, 0x00000060);
	a[i].x = h[0];
	sha1_32(h,
		0x55555555, 0x55555555, key32((id << 7) + i + 1), 0x80000000,
		0x00000000, 0x00000000, 0x00000000, 0x00000000,
		0x00000000, 0x00000000, 0x00000000, 0x00000000,
		0x00000000, 0x00000000, 0x00000000, 0x00000060);
	a[i].y = h[0];
	sha1_32(h,
		0x55555555, 0x55555555, key32((id << 7) + i + 2), 0x80000000,
		0x00000000, 0x00000000, 0x00000000, 0x00000000,
		0x00000000, 0x00000000, 0x00000000, 0x00000000,
		0x00000000, 0x00000000, 0x00000000, 0x00000060);
	a[i].z = h[0];
	sha1_32(h,
		0x55555555, 0x55555555, key32((id << 7) + i + 3), 0x80000000,
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
#endif

/*
 *	Local Variables:
 *		tab-width:	4
 *	End:
 */
