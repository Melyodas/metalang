using System;

public class min4
{
  public static int min2(int a, int b)
  {
    return Math.Min(a, b);
  }
  
  public static int min3(int a, int b, int c)
  {
    return min2(min2(a, b), c);
  }
  
  public static int min4_(int a, int b, int c, int d)
  {
    int f = min2(a, b);
    int e = min2(min2(f, c), d);
    return e;
  }
  
  
  public static void Main(String[] args)
  {
    int h = 1;
    int i = 2;
    int j = 3;
    int k = 4;
    int l = min2(h, i);
    int m = min2(min2(l, j), k);
    int g = m;
    Console.Write("" + g + " ");
    int o = 1;
    int p = 2;
    int q = 4;
    int r = 3;
    int s = min2(o, p);
    int t = min2(min2(s, q), r);
    int n = t;
    Console.Write("" + n + " ");
    int v = 1;
    int w = 3;
    int x = 2;
    int y = 4;
    int z = min2(v, w);
    int ba = min2(min2(z, x), y);
    int u = ba;
    Console.Write("" + u + " ");
    int bc = 1;
    int bd = 3;
    int be = 4;
    int bf = 2;
    int bg = min2(bc, bd);
    int bh = min2(min2(bg, be), bf);
    int bb = bh;
    Console.Write("" + bb + " ");
    int bj = 1;
    int bk = 4;
    int bl = 2;
    int bm = 3;
    int bn = min2(bj, bk);
    int bo = min2(min2(bn, bl), bm);
    int bi = bo;
    Console.Write("" + bi + " ");
    int bq = 1;
    int br = 4;
    int bs = 3;
    int bt = 2;
    int bu = min2(bq, br);
    int bv = min2(min2(bu, bs), bt);
    int bp = bv;
    Console.Write("" + bp + "\n");
    int bx = 2;
    int by = 1;
    int bz = 3;
    int ca = 4;
    int cb = min2(bx, by);
    int cc = min2(min2(cb, bz), ca);
    int bw = cc;
    Console.Write("" + bw + " ");
    int ce = 2;
    int cf = 1;
    int cg = 4;
    int ch = 3;
    int ci = min2(ce, cf);
    int cj = min2(min2(ci, cg), ch);
    int cd = cj;
    Console.Write("" + cd + " ");
    int cl = 2;
    int cm = 3;
    int cn = 1;
    int co = 4;
    int cp = min2(cl, cm);
    int cq = min2(min2(cp, cn), co);
    int ck = cq;
    Console.Write("" + ck + " ");
    int cs = 2;
    int ct = 3;
    int cu = 4;
    int cv = 1;
    int cw = min2(cs, ct);
    int cx = min2(min2(cw, cu), cv);
    int cr = cx;
    Console.Write("" + cr + " ");
    int cz = 2;
    int da = 4;
    int db = 1;
    int dc = 3;
    int dd = min2(cz, da);
    int de = min2(min2(dd, db), dc);
    int cy = de;
    Console.Write("" + cy + " ");
    int dg = 2;
    int dh = 4;
    int di = 3;
    int dj = 1;
    int dk = min2(dg, dh);
    int dl = min2(min2(dk, di), dj);
    int df = dl;
    Console.Write("" + df + "\n");
    int dn = 3;
    int dp = 1;
    int dq = 2;
    int dr = 4;
    int ds = min2(dn, dp);
    int dt = min2(min2(ds, dq), dr);
    int dm = dt;
    Console.Write("" + dm + " ");
    int dv = 3;
    int dw = 1;
    int dx = 4;
    int dy = 2;
    int dz = min2(dv, dw);
    int ea = min2(min2(dz, dx), dy);
    int du = ea;
    Console.Write("" + du + " ");
    int ec = 3;
    int ed = 2;
    int ee = 1;
    int ef = 4;
    int eg = min2(ec, ed);
    int eh = min2(min2(eg, ee), ef);
    int eb = eh;
    Console.Write("" + eb + " ");
    int ej = 3;
    int ek = 2;
    int el = 4;
    int em = 1;
    int en = min2(ej, ek);
    int eo = min2(min2(en, el), em);
    int ei = eo;
    Console.Write("" + ei + " ");
    int eq = 3;
    int er = 4;
    int es = 1;
    int et = 2;
    int eu = min2(eq, er);
    int ev = min2(min2(eu, es), et);
    int ep = ev;
    Console.Write("" + ep + " ");
    int ex = 3;
    int ey = 4;
    int ez = 2;
    int fa = 1;
    int fb = min2(ex, ey);
    int fc = min2(min2(fb, ez), fa);
    int ew = fc;
    Console.Write("" + ew + "\n");
    int fe = 4;
    int ff = 1;
    int fg = 2;
    int fh = 3;
    int fi = min2(fe, ff);
    int fj = min2(min2(fi, fg), fh);
    int fd = fj;
    Console.Write("" + fd + " ");
    int fl = 4;
    int fm = 1;
    int fn = 3;
    int fo = 2;
    int fp = min2(fl, fm);
    int fq = min2(min2(fp, fn), fo);
    int fk = fq;
    Console.Write("" + fk + " ");
    int fs = 4;
    int ft = 2;
    int fu = 1;
    int fv = 3;
    int fw = min2(fs, ft);
    int fx = min2(min2(fw, fu), fv);
    int fr = fx;
    Console.Write("" + fr + " ");
    int fz = 4;
    int ga = 2;
    int gb = 3;
    int gc = 1;
    int gd = min2(fz, ga);
    int ge = min2(min2(gd, gb), gc);
    int fy = ge;
    Console.Write("" + fy + " ");
    int gg = 4;
    int gh = 3;
    int gi = 1;
    int gj = 2;
    int gk = min2(gg, gh);
    int gl = min2(min2(gk, gi), gj);
    int gf = gl;
    Console.Write("" + gf + " ");
    int gn = 4;
    int gp = 3;
    int gq = 2;
    int gr = 1;
    int gs = min2(gn, gp);
    int gt = min2(min2(gs, gq), gr);
    int gm = gt;
    Console.Write("" + gm + "\n");
  }
  
}

