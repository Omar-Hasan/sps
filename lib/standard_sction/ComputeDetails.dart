import 'dart:math';
import 'package:stahl_section/standard_sction/section_name.dart';

class ComputeDetails {
  String assetsImage;
  String x_section;
  double h = 0,
      b = 0,
      tw = 0,
      t = 0,
      tf = 0,
      r = 0,
      r0 = 0,
      ri = 0,
      r1 = 0,
      r2 = 0,
      r3 = 0,
      e = 0,
      w = 0,
      w1 = 0,
      w2 = 0,
      w3 = 0,
      v1 = 0,
      v2 = 0,
      v3 = 0,
      d = 0,
      A = 0,
      Iy = 0,
      Iz = 0,
      Iu = 0,
      Iv = 0,
      Wely = 0,
      Welz = 0,
      iy = 0,
      iz = 0,
      sy = 0,
      sz = 0,
      g = 0,
      Wply = 0,
      Wplz = 0,
      It = 0,
      Iw = 0,
      wt = 0,
      ey = 0,
      ez = 0,
      ym = 0,
      h1 = 0,
      In = 0,
      Weln = 0,
      inSmall = 0,
      Izeta = 0,
      Welzeta = 0,
      izeta = 0,
      tanalfa = 0;
  String H,
      B,
      Tw,
      Tf,
      T,
      R0,
      R00,
      Ri,
      R1,
      R2,
      R3,
      E,
      W,
      W1,
      W2,
      W3,
      V1,
      V2,
      V3,
      D,
      Area,
      IY,
      IZ,
      IU,
      IV,
      WELY,
      WELZ,
      iY,
      iZ,
      sY,
      G,
      WPLZ,
      WPLY,
      IT,
      WT,
      IW,
      eY,
      eZ,
      YM,
      H1,
      IN,
      WELN,
      iN,
      IZeta,
      WELZeta,
      iZeta,
      TANalfa;
  String ipn = "I";
  bool hd = false;

  String format2(double n) {
    return n.toStringAsFixed(n.truncateToDouble() == n ? 0 : 2);
  }

  String format3(double n) {
    return n.toStringAsFixed(n.truncateToDouble() == n ? 0 : 3);
  }

  String format1(double n) {
    return n.toStringAsFixed(n.truncateToDouble() == n ? 0 : 1);
  }

  String roundToString(double x) {
    String X;
    if (x < 1) {
      X = format3(x);
    } else if (x < 10) {
      X = format2(x);
    } else if (x < 100) {
      X = format1(x);
    } else if (x < 1000) {
      X = x.round().toString();
    } else if (x < 100000) {
      x = x / 10;
      X = (x.round() * 10).toString();
    } else if (x < 1000000) {
      x = x / 100;
      X = (x.round() * 100).toString();
    } else {
      x = x / 1000;
      X = (x.round() * 1000).toString();
    }
    if (x == 0) {
      X = "__";
    }
    return X;
  }

  ComputeDetails(String x_section, double h, double b, double tw, double tf,
      double r, double d, double r1, double r2) {
    this.x_section = x_section;
    this.h = h;
    this.b = b;
    this.tw = tw;
    this.tf = tf;
    this.r = r;
    this.r1 = r1;
    this.r2 = r2;
    if (d == 0) {
      this.d = h - 2 * tf - 2 * r;
    } else {
      this.d = d;
    }
    d = this.d;
    this.H = (h).toString();
    this.B = (b).toString();
    this.R0 = (r).toString();
    this.D = (d).toString();
    this.Tw = (tw).toString();
    this.Tf = (tf).toString();
    this.R1 = (r1).toString();
    this.R2 = (r2).toString();
  }

  double dA_delta(
      double yA, double ZA, double aDelta, double bDelta, double cDelta) {
    double destance = 0;
    destance = (yA * aDelta + ZA * bDelta + cDelta).abs() /
        pow(pow(aDelta, 2) + pow(bDelta, 2), 0.5);

    return destance;
  }

  void set_stringdetails() {
    this.H = (h).toString();
    this.B = (b).toString();
    this.Tw = (tw).toString();
    this.Tf = (tf).toString();
    this.T = (t).toString();
    this.R0 = (r).toString();
    this.R00 = roundToString(r0);
    this.Ri = roundToString(ri);
    this.R1 = (r1).toString();
    this.R2 = (r2).toString();
    this.R3 = (r3).toString();
    this.D = roundToString(d);
    this.H1 = roundToString(h1);
    this.TANalfa = roundToString(tanalfa);

    if (ipn == "ipn" || ipn == ("T") || ipn == ("UPN") || ipn == ("Z")) {
      this.Area = roundToString(A); //cm^2
      this.IY = roundToString(Iy); //cm^4
      this.IT = roundToString(It); //cm^4
      this.IZ = roundToString(Iz); //cm^4
      this.IU = roundToString(Iu); //cm^4
      this.IV = roundToString(Iv); //cm^4
      this.IW = roundToString(Iw); //cm^6
      this.WELY = roundToString(Wely); //cm^3
      this.WELZ = roundToString(Welz); //cm^3
      this.IY = roundToString(Iy);
      this.iY = roundToString(iy); //cm
      this.iZ = roundToString(iz); //cm
      this.G = roundToString(g);
      this.sY = roundToString(sy);
      this.eY = roundToString(ey);
      this.eZ = roundToString(ez);
      this.YM = roundToString(ym);
      this.IN = roundToString(In);
      this.WELN = roundToString(Weln);
      this.iN = roundToString(inSmall);
      this.IZeta = roundToString(Izeta);
      this.WELZeta = roundToString(Welzeta);
      this.iZeta = roundToString(izeta);
      this.TANalfa = roundToString(tanalfa);
    } else {
      this.Area = roundToString(A / 100); //cm^2
      this.IW = roundToString(Iw / 1000000); //cm^6
      this.IT = roundToString(It / 10000); //cm^4
      this.IY = roundToString(Iy / 10000); //cm^4
      this.IZ = roundToString(Iz / 10000); //cm^4
      this.IU = roundToString(Iu / 10000); //cm^4
      this.IV = roundToString(Iv / 10000); //cm^4
      this.WELY = roundToString(Wely / 1000); //cm^3
      this.WELZ = roundToString(Welz / 1000); //cm^3
      this.sY = roundToString(sy / 1000);
      this.WT = roundToString(wt / 1000);
      this.WPLZ = roundToString(Wplz / 1000);
      this.WPLY = roundToString(Wply / 1000);
      this.iY = roundToString(iy / 10); //cm
      this.iZ = roundToString(iz / 10); //cm
      this.G = roundToString(g);
      this.eY = roundToString(ey / 10);
      this.eZ = roundToString(ez / 10);
      this.YM = roundToString(ym / 10);
      this.E = roundToString(e / 10);
      this.W = roundToString(w / 10);
      this.W1 = roundToString(w1 / 10);
      this.W2 = roundToString(w2 / 10);
      this.W3 = roundToString(w3 / 10);
      this.V1 = roundToString(v1 / 10);
      this.V2 = roundToString(v2 / 10);
      this.V3 = roundToString(v3 / 10);
      this.IN = roundToString(In / 10000);
      this.WELN = roundToString(Weln / 1000);
      this.iN = roundToString(inSmall / 10);
      this.IZeta = roundToString(Izeta / 10000);
      this.WELZeta = roundToString(Welzeta / 1000);
      this.iZeta = roundToString(izeta / 10);
    }
  }

  _ComputeDetails(String x_section, double h, double b, double tw, double tf,
      double r, double d, double r1, double r2) {
    this.x_section = x_section;
    this.h = h;
    this.b = b;
    this.tw = tw;
    this.tf = tf;
    this.r = r;
    this.r1 = r1;
    this.r2 = r2;
    if (d == 0) {
      this.d = h - 2 * tf - 2 * r;
    } else {
      this.d = d;
    }
    d = this.d;
    this.H = (h).toString();
    this.B = (b).toString();
    this.Tw = (tw).toString();
    this.Tf = (tf).toString();
    this.R0 = (r).toString();
    this.R1 = (r1).toString();
    this.R2 = (r2).toString();
    this.D = roundToString(d);
    switch (x_section) {
      case "I_section":
        {
          this.A =
              (tf * b * 2 + tw * (h - 2 * tf) + pow(r, 2) * (4 - pi)); //mm^2
          this.Iy = (b * pow(tf, 3) / 12 + b * tf * pow((h / 2 - tf / 2), 2)) *
                  2 +
              tw * pow(h - tf * 2, 3) / 12 +
              (pow(r, 4) / 12 +
                      pow(r, 2) * pow((d + r) / 2, 2) -
                      (pow(r, 4) * 0.0549 +
                          pi * pow(r, 2) / 4 * pow((d / 2 + 0.4244 * r), 2))) *
                  4; //mm^4
          this.Iz = (pow(b, 3) * tf / 12) * 2 +
              pow(tw, 3) * (h - tf * 2) / 12 +
              (pow(r, 4) / 12 +
                      pow(r, 2) * pow((tw + r) / 2, 2) -
                      (pow(r, 4) * 0.0549 +
                          pi * pow(r, 2) / 4 * pow((tw / 2 + 0.5746 * r), 2))) *
                  4; //mm^4
          this.Wely = Iy / h * 2; //mm^3
          this.Welz = Iz / b * 2; //mm^3
          this.iy = pow(Iy / A, 0.5); //mm
          this.iz = pow(Iz / A, 0.5); //mm
          this.sy = b * tf * (h - tf) / 2 +
              tw * pow(h / 2 - tf, 2) / 2 +
              (r * r * (h / 2 - tf - 0.5 * r) -
                      r * r * pi / 4 * (0.4244 * r + h / 2 - tf - r)) *
                  2;
          this.Wplz = (b * tf * b / 2 +
                  (h - 2 * tf) * pow(tw, 2) / 8 +
                  (r * r * (tw / 2 + 0.5 * r) -
                          r * r * pi / 4 * (0.4244 * r + tw / 2)) *
                      2) *
              1;
          this.Wply = sy * 2;
          this.g = 78.5 * A / 1000000; //KN/mm
          this.Iw = Iz * pow(h - tf, 2) / 4;
          double alfa1 = -0.042 +
              0.2204 * tw / tf +
              0.1355 * r / tf -
              0.0865 * r * tw / pow(tf, 2) -
              0.0725 * pow(tw, 2) / pow(tf, 2);
          double D1 = (pow(tf + r, 2) + (r + 0.25 * tw) * tw) / (2 * r + tf);
          this.It = 2 * b * pow(tf, 3) / 3 +
              (h - 2 * tf) * pow(tw, 3) / 3 +
              2 * alfa1 * pow(D1, 4) -
              0.42 * pow(tf, 4);
        }
        break;
      case "T_section":
        {
          this.A = tw * (h - tf) + tf * b + pow(r, 2) * (2 - pi / 2);
          this.ey = (tw * (h - tf) * ((h - tf) / 2 + tf) +
                  tf * tf / 2 * b +
                  (r * r * (r / 2 + tf) - pi * r * r / 4 * (0.5756 * r + tf)) *
                      2) /
              A;
          this.Iy = b * pow(tf, 3) / 12 +
              b * tf * pow((ey - tf / 2), 2) +
              tw * pow(h - tf, 3) / 12 +
              tw * (h - tf) * pow(h - ey - (h - tf) / 2, 2) +
              (pow(r, 4) / 12 +
                      pow(r, 2) * pow(tf + r / 2 - ey, 2) -
                      (pow(r, 4) * 0.0549 +
                          pi * pow(r, 2) / 4 * pow(tf + 0.5756 * r - ey, 2))) *
                  2; //mm^4
          this.Iz = (pow(b, 3) * tf / 12) +
              pow(tw, 3) * (h - tf) / 12 +
              (pow(r, 4) / 12 +
                      pow(r, 2) * pow((tw + r) / 2, 2) -
                      (pow(r, 4) * 0.0549 +
                          pi * pow(r, 2) / 4 * pow((tw / 2 + 0.5756 * r), 2))) *
                  2; //mm^4
          this.Wely = Iy / (h - ey); //mm^3
          this.Welz = Iz / b * 2; //mm^3
          this.iy = pow(Iy / A, 0.5); //mm
          this.iz = pow(Iz / A, 0.5); //mm
          this.g = 78.5 * A / 1000000; //KN/mm
          this.Iw = pow(tf, 3) * pow(b, 3) / 144 +
              pow(h - tf / 2, 3) * pow(tw, 3) / 36;
          double alfa1 = -0.042 +
              0.2204 * tw / tf +
              0.1355 * r / tf -
              0.0865 * r * tw / pow(tf, 2) -
              0.0725 * pow(tw, 2) / pow(tf, 2);
          double D1 = (pow(tf + r, 2) + (r + 0.25 * tw) * tw) / (2 * r + tf);
          this.It = 1 * b * pow(tf, 3) / 3 +
              (h - tf) * pow(tw, 3) / 3 +
              alfa1 * pow(D1, 4) -
              0.21 * pow(tf, 4) -
              0.105 * pow(tw, 4);
        }
        break;
      case "U_section":
        {
          this.A = tw * (h - tf * 2) + tf * b * 2 + pow(r, 2) * (2 - pi / 2);
          this.ez = (tw * (h - tf * 2) * tw / 2 +
                  tf * b * b +
                  (r * r * (r / 2 + tw) - pi * r * r / 4 * (0.5756 * r + tw)) *
                      2) /
              A;
          this.Iy = (b * pow(tf, 3) / 12 + b * tf * pow((h - tf) / 2, 2)) * 2 +
              tw * pow(h - tf * 2, 3) / 12 +
              (pow(r, 4) / 12 +
                      pow(r, 2) * pow(h / 2 - tf - r / 2, 2) -
                      (pow(r, 4) * 0.0549 +
                          pi *
                              pow(r, 2) /
                              4 *
                              pow(h / 2 - tf - 0.5756 * r, 2))) *
                  2; //mm^4
          this.Iz = (pow(b, 3) * tf / 12 + b * tf * pow(b / 2 - ez, 2)) * 2 +
              pow(tw, 3) * (h - tf * 2) / 12 +
              tw * (h - tf * 2) * pow(ez - tw / 2, 2) +
              (pow(r, 4) / 12 +
                      pow(r, 2) * pow(ez - tw - r / 2, 2) -
                      (pow(r, 4) * 0.0549 +
                          pi * pow(r, 2) / 4 * pow(ez - tw - 0.5756 * r, 2))) *
                  2; //mm^4
          this.Wely = Iy / h * 2; //mm^3
          this.Welz = Iz / (b - ez); //mm^3
          this.iy = pow(Iy / A, 0.5); //mm
          this.iz = pow(Iz / A, 0.5); //mm
          this.sy = b * tf * (h - tf) / 2 +
              tw * pow(h / 2 - tf, 2) / 2 +
              (r * r * (h / 2 - tf - 0.5 * r) -
                      r * r * pi / 4 * (0.4244 * r + h / 2 - tf - r)) *
                  1;
          this.ym = pow(h - tf, 2) *
                  pow(b - tw, 2) *
                  (tf + 0 * r * r / (b - tw)) /
                  (4 * Iy) +
              ez -
              tw / 2 +
              (r * 0.255);
          this.g = 78.5 * A / 1000000; //KN/mm
          this.Iw = pow(h - tf, 2) *
              (Iz - A * pow(ez - tw, 2) * (pow(h - tf, 2) * A / (4 * Iy) - 1)) /
              4;
          double alfa3 = -0.0908 +
              0.2621 * tw / tf +
              0.1231 * r / tf -
              0.0752 * tw * r / pow(tf, 2) -
              0.0945 * pow(tw / tf, 2);
          double D3 = 2 *
              ((3 * r + tw + tf) - pow(2 * (2 * r + tw) * (2 * r + tf), 0.5));
          this.It = 2 * b * pow(tf, 3) / 3 +
              (h - 2 * tf) * pow(tw, 3) / 3 +
              2 * alfa3 * pow(D3, 4) -
              0.42 * pow(tf, 4);
        }
        break;
      case "L_section":
        {
          this.t = tw;
          if (h == b) {
            this.A = t * b * 2 -
                t * t +
                pow(r1, 2) * (1 - pi / 4) -
                (pow(r2, 2) * (2 - pi / 2));
            this.e = (b * t * t / 2 +
                    t * (b - t) * ((b - t) / 2 + t) +
                    (r1 * r1 * (r1 / 2 + t) -
                        pi * r1 * r1 / 4 * (0.5756 * r1 + t)) -
                    (r2 * r2 * (-r2 / 2 + t) -
                        pi * r2 * r2 / 4 * (-0.5756 * r2 + t)) -
                    (r2 * r2 * (-r2 / 2 + b) -
                        pi * r2 * r2 / 4 * (-0.5756 * r2 + b))) /
                A;
            this.ez = ey = e;
            this.w = dA_delta(e - b, e, 1, -1, 0);
            this.v1 = dA_delta(e, e, 1, 1, 0);
            this.v2 =
                dA_delta(e - t + r2 * 0.2833, e - b + r2 / 3.414, 1, 1, 0);
            this.Iy = Iz = b * pow(t, 3) / 12 +
                b * t * pow(ey - t / 2, 2) +
                t * pow(b - t, 3) / 12 +
                (b - t) * t * pow((b - t) / 2 + t - ey, 2) +
                pow(r1, 4) / 12 +
                pow(r1, 2) * pow(ey - t - r1 / 2, 2) -
                (0.0549 * pow(r1, 4) +
                    pi * pow(r1, 2) / 4 * pow(ey - t - 0.58 * r1, 2)) -
                (pow(r2, 4) / 12 +
                    pow(r2, 2) * pow(ey - t + r2 / 2, 2) -
                    (0.0549 * pow(r2, 4) +
                        pi * pow(r2, 2) / 4 * pow(ey - t + 0.58 * r2, 2))) -
                (pow(r2, 4) / 12 +
                    pow(r2, 2) * pow(b - ey - r2 / 2, 2) -
                    (0.0549 * pow(r2, 4) +
                        pi *
                            pow(r2, 2) /
                            4 *
                            pow(b - ey - 0.58 * r2, 2))); //mm^4

            double Iyz = pow(t, 2) * (b * b + h * h - t * t) / 4 +
                r1 * r1 * pow(t + r1 / 2, 2) -
                (pow(r1, 4) / 8 * 0 +
                    pi * r1 * r1 / 4 * pow(t + r1 * 0.58, 2)) -
                (r2 * r2 * (t - r2 / 2) * (b - r2 / 2) -
                    (pow(r2, 4) / 8 * 0 +
                        pi * r2 * r2 / 4 * (t - r2 * 0.58) * (b - r2 * 0.58))) -
                (r2 * r2 * (t - r2 / 2) * (h - r2 / 2) -
                    (pow(r2, 4) / 8 * 0 +
                        pi * r2 * r2 / 4 * (t - r2 * 0.58) * (h - r2 * 0.58))) -
                A * ey * ez;
            In = (Iy + Iz) / 2 + pow(pow((Iy - Iz) / 2, 2) + Iyz * Iyz, 0.5);
            Izeta = (Iy + Iz) / 2 - pow(pow((Iy - Iz) / 2, 2) + Iyz * Iyz, 0.5);
            tanalfa = tan(atan(-2 * Iyz / (Iy - Iz)) / 2);
            this.Wely = Welz = Iy / (h - e); //mm^3
            this.iy = iz = pow(Iy / A, 0.5); //mm
            this.inSmall = pow(In / A, 0.5); //mm
            this.izeta = pow(Izeta / A, 0.5); //mm
            this.g = 78.5 * A / 1000000; //KN/mm
          } else {
            this.A = t * b +
                h * t -
                t * t +
                pow(r1, 2) * (1 - pi / 4) -
                pow(r2, 2) * (2 - pi / 2);
            this.ey = (b * t * t / 2 +
                    t * (h - t) * ((h - t) / 2 + t) +
                    (r1 * r1 * (r1 / 2 + t) -
                        pi * r1 * r1 / 4 * (0.58 * r1 + t)) -
                    (r2 * r2 * (-r2 / 2 + t) -
                        pi * r2 * r2 / 4 * (-0.58 * r2 + t)) -
                    (r2 * r2 * (-r2 / 2 + h) -
                        pi * r2 * r2 / 4 * (-0.58 * r2 + h))) /
                A;
            this.ez = (b * t * b / 2 +
                    t * t * (h - t) / 2 +
                    (r1 * r1 * (r1 / 2 + t) -
                        pi * r1 * r1 / 4 * (0.58 * r1 + tw)) -
                    (r2 * r2 * (-r2 / 2 + t) -
                        pi * r2 * r2 / 4 * (-0.58 * r2 + tw)) -
                    (r2 * r2 * (-r2 / 2 + b) -
                        pi * r2 * r2 / 4 * (-0.58 * r2 + b))) /
                A;
            this.Iy = b * pow(t, 3) / 12 +
                b * t * pow(ey - t / 2, 2) +
                tw * pow(h - t, 3) / 12 +
                (h - t) * t * pow((h - t) / 2 + t - ey, 2) +
                pow(r1, 4) / 12 +
                pow(r1, 2) * pow(ey - t - r1 / 2, 2) -
                (0.0549 * pow(r1, 4) +
                    pi * pow(r1, 2) / 4 * pow(ey - t - 0.58 * r1, 2)) -
                (pow(r2, 4) / 12 +
                    pow(r2, 2) * pow(ey - t + r2 / 2, 2) -
                    (0.0549 * pow(r2, 4) +
                        pi * pow(r2, 2) / 4 * pow(ey - t + 0.58 * r2, 2))) -
                (pow(r2, 4) / 12 +
                    pow(r2, 2) * pow(h - ey - r2 / 2, 2) -
                    (0.0549 * pow(r2, 4) +
                        pi *
                            pow(r2, 2) /
                            4 *
                            pow(h - ey - 0.58 * r2, 2))); //mm^4
            this.Iz = t * pow(b, 3) / 12 +
                b * t * pow(ez - b / 2, 2) +
                (h - t) * pow(t, 3) / 12 +
                (h - t) * t * pow(t / 2 - ez, 2) +
                pow(r1, 4) / 12 +
                pow(r1, 2) * pow(ez - t - r1 / 2, 2) -
                (0.0549 * pow(r1, 4) +
                    pi * pow(r1, 2) / 4 * pow(ez - t - 0.5756 * r1, 2)) -
                (pow(r2, 4) / 12 +
                    pow(r2, 2) * pow(ez - t + r2 / 2, 2) -
                    (0.0549 * pow(r2, 4) +
                        pi * pow(r2, 2) / 4 * pow(ez - t + 0.5756 * r2, 2))) -
                (pow(r2, 4) / 12 +
                    pow(r2, 2) * pow(b - ez - r2 / 2, 2) -
                    (0.0549 * pow(r2, 4) +
                        pi *
                            pow(r2, 2) /
                            4 *
                            pow(b - ez - 0.5756 * r2, 2))); //mm^4
            double Iyz = pow(t, 2) * (b * b + h * h - t * t) / 4 +
                r1 * r1 * pow(t + r1 / 2, 2) -
                (pow(r1, 4) / 8 * 0 +
                    pi * r1 * r1 / 4 * pow(t + r1 * 0.58, 2)) -
                (r2 * r2 * (t - r2 / 2) * (b - r2 / 2) -
                    (pow(r2, 4) / 8 * 0 +
                        pi * r2 * r2 / 4 * (t - r2 * 0.58) * (b - r2 * 0.58))) -
                (r2 * r2 * (t - r2 / 2) * (h - r2 / 2) -
                    (pow(r2, 4) / 8 * 0 +
                        pi * r2 * r2 / 4 * (t - r2 * 0.58) * (h - r2 * 0.58))) -
                A * ey * ez;
            In = (Iy + Iz) / 2 + pow(pow((Iy - Iz) / 2, 2) + Iyz * Iyz, 0.5);
            Izeta = (Iy + Iz) / 2 - pow(pow((Iy - Iz) / 2, 2) + Iyz * Iyz, 0.5);
            tanalfa = tan(atan(-2 * Iyz / (Iy - Iz)) / 2);
            double alfa = atan(tanalfa); //* 180 /  PI;

            this.w2 = dA_delta(ez - b, ey, tanalfa, -1, 0);
            this.w1 = dA_delta(ez, ey - h, tanalfa, -1, 0);
            this.v1 = dA_delta(ez, ey, tan(1.5 * pi - alfa), 1, 0);
            this.v3 = dA_delta(ez - t + r2 * 0.2833, ey - h + r2 / 3.414,
                tan(1.5 * pi - alfa), 1, 0);
            this.v2 = dA_delta(ez - b + r2 / 3.414, ey - t + r2 * 0.2833,
                tan(1.5 * pi - alfa), 1, 0);
            this.Wely = Iy / (h - ey); //mm^3
            this.Welz = Iz / (b - ez); //mm^3
            this.iy = pow(Iy / A, 0.5); //mm
            this.iz = pow(Iz / A, 0.5); //mm
            this.inSmall = pow(In / A, 0.5); //mm
            this.izeta = pow(Izeta / A, 0.5); //mm
            this.g = 78.5 * A / 1000000; //KN/mm
          }
        }
        break;
      case "circle_section":
        {
          this.t = tf = tw;
          this.A = pi * (pow(b, 2) - pow(b - 2 * t, 2)) / 4;
          this.Iy = pi * (pow(b, 4) - pow(b - 2 * t, 4)) / 64;
          this.Iz = Iy;
          this.Wely = Iy / h * 2; //mm^3
          this.Welz = Wely; //mm^3
          wt = 2 * Wely;
          It = 2 * Iy;
          this.iy = pow(Iy / A, 0.5); //mm
          this.iz = pow(Iz / A, 0.5); //mm
          this.sy = (pow(b, 3) - pow(b - 2 * t, 3)) / 6;
          this.Wply = sy;
          this.g = 78.5 * A / 1000000; //KN/mm
        }
        break;
      case "HolwRec_section":
        {
          double p, Ap;
          double Rc = (r0 + ri) / 2;
          if (h == b) {
            A = pow(b, 2) -
                pow(b - 2 * t, 2) +
                pow(ri, 2) * (4 - pi) -
                pow(r0, 2) * (4 - pi);
            Iy = (pow(b, 4) - pow(b - 2 * t, 4)) / 12 -
                (pow(r0, 4) / 12 +
                        r0 * r0 * pow((b - r0) / 2, 2) -
                        (0.0549 * pow(r0, 4) +
                            pi * r0 * r0 / 4 * pow(b / 2 - 0.5756 * r0, 2))) *
                    4 +
                (pow(ri, 4) / 12 +
                        ri * ri * pow((b - 2 * t - ri) / 2, 2) -
                        (0.0549 * pow(ri, 4) +
                            pi *
                                ri *
                                ri /
                                4 *
                                pow((b - 2 * t) / 2 - 0.5756 * ri, 2))) *
                    4;
            Iz = Iy;
            this.Wely = Iy / b * 2; //mm^3
            this.Welz = Iz / b * 2; //mm^3
            this.iy = pow(Iy / A, 0.5); //mm
            this.iz = pow(Iz / A, 0.5); //mm
            this.sy = pow(b, 3) / 8 -
                (r0 * r0 * (b - r0) / 2 -
                        pi * r0 * r0 / 4 * (b / 2 - 0.5756 * r0)) *
                    2 -
                (pow(b - 2 * t, 3) / 8 -
                    (ri * ri * (b - ri - 2 * t) / 2 -
                            pi *
                                ri *
                                ri /
                                4 *
                                ((b - 2 * t) / 2 - 0.5756 * ri)) *
                        2);
            this.Wply = sy * 2;
            p = 2 * ((b - t) + (h - t)) - 2 * Rc * (4 - pi);
            Ap = (b - t) * (h - t) - Rc * Rc * (4 - pi);
          } else {
            A = b * h -
                (b - 2 * t) * (h - 2 * t) +
                pow(ri, 2) * (4 - pi) -
                pow(r0, 2) * (4 - pi);
            Iy = (pow(h, 3) * b - pow(h - 2 * t, 3) * (b - 2 * t)) / 12 -
                (pow(r0, 4) / 12 +
                        r0 * r0 * pow((h - r0) / 2, 2) -
                        (0.0549 * pow(r0, 4) +
                            pi * r0 * r0 / 4 * pow(h / 2 - 0.5756 * r0, 2))) *
                    4 +
                (pow(ri, 4) / 12 +
                        ri * ri * pow((h - 2 * t - ri) / 2, 2) -
                        (0.0549 * pow(ri, 4) +
                            pi *
                                ri *
                                ri /
                                4 *
                                pow((h - 2 * t) / 2 - 0.5756 * ri, 2))) *
                    4;
            Iz = (pow(b, 3) * h - pow(b - 2 * t, 3) * (h - 2 * t)) / 12 -
                (pow(r0, 4) / 12 +
                        r0 * r0 * pow((b - r0) / 2, 2) -
                        (0.0549 * pow(r0, 4) +
                            pi * r0 * r0 / 4 * pow(b / 2 - 0.5756 * r0, 2))) *
                    4 +
                (pow(ri, 4) / 12 +
                        ri * ri * pow((b - 2 * t - ri) / 2, 2) -
                        (0.0549 * pow(ri, 4) +
                            pi *
                                ri *
                                ri /
                                4 *
                                pow((b - 2 * t) / 2 - 0.5756 * ri, 2))) *
                    4;
            this.Wely = Iy / h * 2; //mm^3
            this.Welz = Iz / b * 2; //mm^3
            this.iy = pow(Iy / A, 0.5); //mm
            this.iz = pow(Iz / A, 0.5); //mm
            this.sy = pow(h, 2) * b / 8 -
                (r0 * r0 * (h - r0) / 2 -
                        pi * r0 * r0 / 4 * (h / 2 - 0.5756 * r0)) *
                    2 -
                (pow(h - 2 * t, 2) * (b - 2 * t) / 8 -
                    (ri * ri * (h - ri - 2 * t) / 2 -
                            pi *
                                ri *
                                ri /
                                4 *
                                ((h - 2 * t) / 2 - 0.5756 * ri)) *
                        2);
            this.sz = pow(b, 2) * h / 8 -
                (r0 * r0 * (b - r0) / 2 -
                        pi * r0 * r0 / 4 * (b / 2 - 0.5756 * r0)) *
                    2 -
                (pow(b - 2 * t, 2) * (h - 2 * t) / 8 -
                    (ri * ri * (b - ri - 2 * t) / 2 -
                            pi *
                                ri *
                                ri /
                                4 *
                                ((b - 2 * t) / 2 - 0.5756 * ri)) *
                        2);
            this.Wply = sy * 2;
            this.Wplz = sz * 2;
            /*p =  PI / 2 * (h + b - 2 * t) * (1 + 0.25 *  pow((h - b) / (h + b - 2 * t), 2));
                Ap =  PI * (b - t) * (h - t) / 4;elliptical hollow sections*/
            p = 2 * ((b - t) + (h - t)) - 2 * Rc * (4 - pi);
            Ap = (b - t) * (h - t) - Rc * Rc * (4 - pi);
          }
          this.It = 4 * Ap * Ap * t / p + pow(t, 3) * p / 3;
          this.g = 78.5 * A / 1000000; //KN/mm
        }
        break;
    }
    set_stringdetails();
  }

  List<String> getname_detail() {
    String h = 'h = ';
    String h1 = 'h1 = ';
    String d = 'd = ';
    String a = 'a = ';
    String e = 'e = ';
    String w = 'w = ';
    String w1 = 'w1 = ';
    String w2 = 'w2 = ';
    String v1 = 'v1 = ';
    String v2 = 'v2 = ';
    String v3 = 'v3 = ';
    String b = 'b = ';
    String r = 'r = ';
    String rMin = 'r_min = ';
    String r0 = 'r0 = ';
    String ri = 'ri = ';
    String r1 = 'r1 = ';
    String r2 = 'r2 = ';
    String r3 = 'r3 = ';
    String t = 't = ';
    String wtf = 'wtf = ';
    String wtfwbf = 'wtf = wbf';
    String ttftbf = 'ttf = tbf';
    String ttf = 'ttf = ';
    String wbf = 'wbf = ';
    String tbf = 'tbf = ';
    String tw = 'tw = ';
    String tplate = 'tPlate = ';
    String wplate = 'wPlate = ';
    String upn = 'UPN : ';
    String twtf = 'tw = tf';
    String twr1 = 'tw = r1';
    String tfr1 = 'tf = r1';
    String tf = 'tf = ';
    String A = 'A = ';
    String alfa = 'alfa = ';
    String Iy = 'Iy = ';
    String Wely = 'Wely = ';
    String Wply = 'Wply = ';
    String Wel = 'Wel = ';
    String Wpl = 'Wpl = ';
    String iy = 'iy = ';
    String I = 'Iy = Iz ';
    String Iyz = 'Iyz ';
    String Iy2 = 'Iy2 ';
    String Iz2 = 'Iz2 ';
    String I0 = 'I = ';
    String W = 'Wely = Welz ';
    String i = 'iy = iz  ';
    String i0 = 'i =  ';
    String Iz = 'Iz = ';
    String Welz = 'Welz = ';
    String Wplz = 'Wplz = ';
    String iz = 'iz = ';
    String Izeta = 'Iξ = ';
    String Welzeta = 'Welξ = ';
    String izeta = 'iξ = ';
    String tanalfa = 'tan α = ';
    String In = 'Iη = ';
    String Weln = 'Welη = ';
    String inet = 'iη = ';
    String sy = 'Sy = ';
    String ym = 'Ym = ';
    String IT = 'IT = ';
    String WT = 'WT = ';
    String Iw = 'Iw = ';
    String ez = 'ez = ';
    String ey = 'ey = ';
    String g = 'g = ';
    String D = 'D';
    String T0 = 'T =';
    String B = 'B = ';
    String H = 'H = ';
    String DT = 'D x T';

    List<String> name = List();
    switch (x_section) {
      case "I_section":
        {
          if (ipn == ("ipn")) {
            name.add(h);
            name.add(b);
            name.add(twr1);
            name.add(tf);
            name.add(r);
            name.add(d);
            name.add(A);
            name.add(Iy);
            name.add(Wely);
            name.add(iy);
            name.add(Iz);
            name.add(Welz);
            name.add(iz);
            name.add(sy);
            name.add(g);
          } else {
            name.add(h);
            name.add(b);
            name.add(tw);
            name.add(tf);
            name.add(r);
            name.add(d);
            name.add(A);
            name.add(Iy);
            if (hd == true) {
              name.add(Wely);
              name.add(Wply);
              name.add(Iz);
              name.add(Welz);
              name.add(Wplz);
              name.add(IT);
              name.add(g);
            } else {
              name.add(Wely);
              name.add(iy);
              name.add(Iz);
              name.add(Welz);
              name.add(iz);
              name.add(sy);
              name.add(g);
            }
          }
        }
        break;
      case "T_section":
        {
          if (ipn == ("1/2ipn")) {
            name.add(h);
            name.add(b);
            name.add(tw);
            name.add(tf);
            name.add(r);
            name.add(A);
            name.add(Iy);
            name.add(Wely);
            name.add(iy);
            name.add(Iz);
            name.add(Welz);
            name.add(iz);
            name.add(IT);
            name.add(ey);
            name.add(g);
          } else {
            name.add(h);
            name.add(b);
            name.add(twtf);
            name.add(r1);
            name.add(r2);
            name.add(r3);
            name.add(d);
            name.add(A);
            name.add(Iy);
            name.add(Wely);
            name.add(iy);
            name.add(Iz);
            name.add(Welz);
            name.add(iz);
            name.add(ey);
            name.add(g);
          }
        }
        break;
      case "U_section":
        {
          name.add(h);
          name.add(b);
          name.add(tw);
          if (ipn == ("UPN")) {
            name.add(tfr1);
            name.add(r2);
          } else {
            name.add(tf);
            name.add(r);
          }
          name.add(d);
          name.add(A);
          name.add(Iy);
          name.add(Wely);
          name.add(iy);
          name.add(Iz);
          name.add(Welz);
          name.add(iz);
          name.add(sy);
          name.add(ez);
          name.add(ym);
          name.add(g);
          name.add(IT);
          name.add(Iw);
        }
        break;
      case "Z_section":
        {
          name.add(h);
          name.add(h1);
          name.add(b);
          name.add(tw);
          name.add(tfr1);
          name.add(r2);
          name.add(g);
          name.add(A);
          name.add(Iy);
          name.add(Wely);
          name.add(iy);
          name.add(Iz);
          name.add(Welz);
          name.add(iz);
          name.add(In);
          name.add(Weln);
          name.add(inet);
          name.add(Izeta);
          name.add(Welzeta);
          name.add(izeta);
          name.add(tanalfa);
        }
        break;
      case "L_section":
        {
          if (ipn == ("unequal")) {
            name.add(a);
            name.add(b);
            name.add(t);
            name.add(r1);
            name.add(r2);
            name.add(ey);
            name.add(ez);
            name.add(w1);
            name.add(w2);
            name.add(v1);
            name.add(v2);
            name.add(v3);
            name.add(tanalfa);
            name.add(g);
            name.add(A);
            name.add(Iy);
            name.add(Wely);
            name.add(iy);
            name.add(Iz);
            name.add(Welz);
            name.add(iz);
            name.add(In);
            name.add(inet);
            name.add(Izeta);
            name.add(izeta);
          } else {
            name.add(a);
            name.add(t);
            name.add(r1);
            name.add(e);
            name.add(w);
            name.add(v1);
            name.add(v2);
            name.add(A);
            name.add(I);
            name.add(w);
            name.add(I);
            name.add(In);
            name.add(inet);
            name.add(Izeta);
            name.add(izeta);
            name.add(g);
          }
        }
        break;
      case "circle_section":
        {
          name.add(DT);
          name.add(A);
          name.add(i0);
          name.add(I0);
          name.add(Wel);
          name.add(Wpl);
          name.add(IT);
          name.add(WT);
          name.add(g);
        }
        break;
      case "HolwRec_section":
        {
          if (h == b) {
            name.add(b);
            name.add(t);
            name.add(r0);
            name.add(ri);
            name.add(A);
            name.add(I0);
            name.add(I0);
            name.add(Wel);
            name.add(Wpl);
            name.add(g);
          } else {
            name.add(H);
            name.add(b);
            name.add(t);
            name.add(r0);
            name.add(ri);
            name.add(A);
            name.add(Iy);
            name.add(iy);
            name.add(Wely);
            name.add(Wply);
            name.add(Iz);
            name.add(iz);
            name.add(Welz);
            name.add(Wplz);
            name.add(IT);
            name.add(g);
          }
        }
        break;
    }

    return name;
  }

  List<String> getvalue_detail(String selectedItem) {
    String KNmm = 'KN/m ';
    String mm = 'mm ';
    String m = 'Meter';
    String degree = 'Degree ';
    String cm2 = '〖cm〗^2';
    String cm3 = '〖cm〗^3';
    String cm4 = '〖cm〗^4';
    String cm6 = '〖cm〗^6';
    String cm = 'cm ';
    String pas = '  ';
    int number = 0;
    section_name sectionName = new section_name();
    List<String> value = new List();
    double d1 = 0;
    ipn = "1/2ipn";
    hd = false;
    switch (x_section) {
      case "I_section":
        {
          bool ch = false;
          for (int i = 0; i < sectionName.ipn_section.length; i++) {
            String s = sectionName.ipn_section[i];
            if (selectedItem == (s)) {
              number = i;
              ch = true;
              switch (number) {
                case 0:
                  {
                    h = 80;
                    b = 42;
                    tw = 3.9;
                    tf = 5.9;
                    r2 = 2.3;
                    d = 59;
                    A = 7.57;
                    Iy = 77.8;
                    Wely = 19.5;
                    iy = 3.2;
                    Iz = 6.29;
                    Welz = 3;
                    iz = 0.91;
                    sy = 11.4;
                  }
                  break;
                case 1:
                  {
                    h = 100;
                    b = 50;
                    tw = 4.5;
                    tf = 6.8;
                    r2 = 2.7;
                    d = 76;
                    A = 10.6;
                    Iy = 171;
                    Wely = 34.2;
                    iy = 4.01;
                    Iz = 12.2;
                    Welz = 4.88;
                    iz = 1.07;
                    sy = 19.9;
                  }
                  break;
                case 2:
                  {
                    h = 120;
                    b = 58;
                    tw = 5.1;
                    tf = 7.7;
                    r2 = 3.1;
                    d = 92;
                    A = 14.2;
                    Iy = 328;
                    Wely = 54.7;
                    iy = 4.81;
                    Iz = 21.5;
                    Welz = 7.41;
                    iz = 1.23;
                    sy = 31.8;
                  }
                  break;
                case 3:
                  {
                    h = 140;
                    b = 66;
                    tw = 5.7;
                    tf = 8.6;
                    r2 = 3.4;
                    d = 109;
                    A = 18.2;
                    Iy = 573;
                    Wely = 81.9;
                    iy = 5.61;
                    Iz = 35.2;
                    Welz = 10.7;
                    iz = 1.4;
                    sy = 47.7;
                  }
                  break;
                case 4:
                  {
                    h = 160;
                    b = 74;
                    tw = 6.3;
                    tf = 9.5;
                    r2 = 3.8;
                    d = 126;
                    A = 22.8;
                    Iy = 935;
                    Wely = 117;
                    iy = 6.4;
                    Iz = 54.7;
                    Welz = 14.8;
                    iz = 1.55;
                    sy = 68;
                  }
                  break;
                case 5:
                  {
                    h = 180;
                    b = 82;
                    tw = 6.9;
                    tf = 10.4;
                    r2 = 4.1;
                    d = 142;
                    A = 27.9;
                    Wely = 161;
                    iy = 7.2;
                    Iy = 1450;
                    Iz = 81.3;
                    Welz = 19.8;
                    iz = 1.71;
                    sy = 93.4;
                  }
                  break;
                case 6:
                  {
                    h = 200;
                    b = 90;
                    tw = 7.5;
                    tf = 11.3;
                    r2 = 4.5;
                    d = 159;
                    A = 33.4;
                    Iy = 2140;
                    Wely = 214;
                    iy = 8;
                    Iz = 117;
                    Welz = 26;
                    iz = 1.87;
                    sy = 125;
                  }
                  break;
                case 7:
                  {
                    h = 220;
                    b = 98;
                    tw = 8.1;
                    tf = 12.2;
                    r2 = 4.9;
                    d = 176;
                    A = 39.5;
                    Iy = 3060;
                    Wely = 278;
                    iy = 8.8;
                    Iz = 162;
                    Welz = 33.1;
                    iz = 2.02;
                    sy = 162;
                  }
                  break;
                case 8:
                  {
                    h = 240;
                    b = 106;
                    tw = 8.7;
                    tf = 13.1;
                    r2 = 5.2;
                    d = 193;
                    A = 46.1;
                    Iy = 4250;
                    Wely = 354;
                    iy = 9.59;
                    Iz = 221;
                    Welz = 41.7;
                    iz = 2.2;
                    sy = 206;
                  }
                  break;
                case 9:
                  {
                    h = 260;
                    b = 113;
                    tw = 9.4;
                    tf = 14.1;
                    r2 = 5.6;
                    d = 209;
                    A = 53.3;
                    Iy = 50740;
                    Wely = 442;
                    iy = 10.4;
                    Iz = 288;
                    Welz = 51;
                    iz = 2.32;
                    sy = 257;
                  }
                  break;
                case 10:
                  {
                    h = 280;
                    b = 119;
                    tw = 10.1;
                    tf = 15.2;
                    r2 = 6.1;
                    d = 225;
                    A = 61;
                    Iy = 7590;
                    Wely = 542;
                    iy = 11.1;
                    Iz = 364;
                    Welz = 61.2;
                    iz = 2.45;
                    sy = 316;
                  }
                  break;
                case 11:
                  {
                    h = 300;
                    b = 125;
                    tw = 10.8;
                    tf = 16.2;
                    r2 = 6.5;
                    d = 242;
                    A = 69;
                    Iy = 9800;
                    Wely = 653;
                    iy = 11.9;
                    Iz = 451;
                    Welz = 72.2;
                    iz = 2.56;
                    sy = 381;
                  }
                  break;
                case 12:
                  {
                    h = 320;
                    b = 131;
                    tw = 11.5;
                    tf = 17.3;
                    r2 = 6.9;
                    d = 258;
                    A = 77.7;
                    Iy = 12510;
                    Wely = 782;
                    iy = 12.7;
                    Iz = 555;
                    Welz = 84.7;
                    iz = 2.67;
                    sy = 457;
                  }
                  break;
                case 13:
                  {
                    h = 340;
                    b = 137;
                    tw = 12.2;
                    tf = 18.3;
                    r2 = 7.3;
                    d = 274;
                    A = 86.7;
                    Iy = 15700;
                    Wely = 923;
                    iy = 13.5;
                    Iz = 674;
                    Welz = 98.4;
                    iz = 2.8;
                    sy = 540;
                  }
                  break;
                case 14:
                  {
                    h = 360;
                    b = 143;
                    tw = 13;
                    tf = 19.5;
                    r2 = 7.8;
                    d = 290;
                    A = 97;
                    Iy = 19610;
                    Wely = 1090;
                    iy = 14.2;
                    Iz = 818;
                    Welz = 114;
                    iz = 2.9;
                    sy = 638;
                  }
                  break;
                case 15:
                  {
                    h = 380;
                    b = 149;
                    tw = 13.7;
                    tf = 20.5;
                    r2 = 8.2;
                    d = 307;
                    A = 107;
                    Iy = 24010;
                    Wely = 1260;
                    iy = 15;
                    Iz = 975;
                    Welz = 131;
                    iz = 3.02;
                    sy = 741;
                  }
                  break;
                case 16:
                  {
                    h = 400;
                    b = 155;
                    tw = 14.4;
                    tf = 21.6;
                    r2 = 8.6;
                    d = 323;
                    A = 118;
                    Iy = 29210;
                    Wely = 1460;
                    iy = 15.7;
                    Iz = 1160;
                    Welz = 149;
                    iz = 3.13;
                    sy = 857;
                  }
                  break;
                case 17:
                  {
                    h = 450;
                    b = 170;
                    tw = 16.2;
                    tf = 24.3;
                    r2 = 9.7;
                    d = 364;
                    A = 147;
                    Iy = 45850;
                    Wely = 240;
                    iy = 17.7;
                    Iz = 1730;
                    Welz = 203;
                    iz = 3.43;
                    sy = 1200;
                  }
                  break;
                case 18:
                  {
                    h = 500;
                    b = 185;
                    tw = 18;
                    tf = 27;
                    r2 = 10.8;
                    d = 404;
                    A = 179;
                    Iy = 68740;
                    Wely = 2750;
                    iy = 19.6;
                    Iz = 2480;
                    Welz = 268;
                    iz = 3.72;
                    sy = 1620;
                  }
                  break;
                case 19:
                  {
                    h = 550;
                    b = 200;
                    tw = 19;
                    tf = 30;
                    r2 = 11.9;
                    d = 446;
                    A = 212;
                    Iy = 99180;
                    Wely = 3610;
                    iy = 21.6;
                    Iz = 3490;
                    Welz = 349;
                    iz = 4.02;
                    sy = 2120;
                  }
                  break;
                case 20:
                  {
                    h = 600;
                    b = 215;
                    tw = 21.6;
                    tf = 32.4;
                    r2 = 13;
                    d = 486;
                    A = 254;
                    Iy = 139000;
                    Wely = 4630;
                    iy = 23.4;
                    Iz = 4670;
                    Welz = 434;
                    iz = 4.3;
                    sy = 2730;
                  }
                  break;
              }
              r = r1 = tw;
              i = sectionName.ipn_section.length;
              ipn = "ipn";
              this.g = 78.5 * A / 10000; //KN/mm
            }
          }
          if (!ch) {
            for (int i = 0; i < sectionName.ipe_section.length; i++) {
              if (selectedItem == (sectionName.ipe_section[i])) {
                number = i;
                ch = true;
                switch (number) {
                  case 0:
                    {
                      h = 80;
                      b = 46;
                      tw = 3.8;
                      tf = 5.2;
                      r = 5;
                      d = 54;
                    }
                    break;
                  case 1:
                    {
                      h = 100;
                      b = 55;
                      tw = 4.1;
                      tf = 5.7;
                      r = 7;
                      d = 74;
                    }
                    break;
                  case 2:
                    {
                      h = 120;
                      b = 64;
                      tw = 4.4;
                      tf = 6.3;
                      r = 7;
                      d = 93;
                    }
                    break;
                  case 3:
                    {
                      h = 140;
                      b = 73;
                      tw = 4.7;
                      tf = 6.9;
                      r = 7;
                      d = 112;
                    }
                    break;
                  case 4:
                    {
                      h = 160;
                      b = 82;
                      tw = 5;
                      tf = 7.4;
                      r = 9;
                      d = 127;
                    }
                    break;
                  case 5:
                    {
                      h = 180;
                      b = 91;
                      tw = 5.3;
                      tf = 8;
                      r = 9;
                      d = 146;
                    }
                    break;
                  case 6:
                    {
                      h = 200;
                      b = 100;
                      tw = 5.6;
                      tf = 8.5;
                      r = 12;
                      d = 159;
                    }
                    break;
                  case 7:
                    {
                      h = 220;
                      b = 110;
                      tw = 5.7;
                      tf = 9.2;
                      r = 12;
                      d = 177;
                    }
                    break;
                  case 8:
                    {
                      h = 240;
                      b = 120;
                      tw = 6.2;
                      tf = 9.8;
                      r = 15;
                      d = 190;
                    }
                    break;
                  case 9:
                    {
                      h = 270;
                      b = 135;
                      tw = 6.6;
                      tf = 10.2;
                      r = 15;
                      d = 219;
                    }
                    break;
                  case 10:
                    {
                      h = 300;
                      b = 150;
                      tw = 7.1;
                      tf = 10.7;
                      r = 15;
                      d = 248;
                    }
                    break;
                  case 11:
                    {
                      h = 330;
                      b = 160;
                      tw = 7.5;
                      tf = 11.5;
                      r = 18;
                      d = 271;
                    }
                    break;
                  case 12:
                    {
                      h = 360;
                      b = 170;
                      tw = 8;
                      tf = 127;
                      r = 18;
                      d = 298;
                    }
                    break;
                  case 13:
                    {
                      h = 400;
                      b = 180;
                      tw = 8.6;
                      tf = 13.5;
                      r = 21;
                      d = 331;
                    }
                    break;
                  case 14:
                    {
                      h = 450;
                      b = 190;
                      tw = 9.4;
                      tf = 14.6;
                      r = 21;
                      d = 378;
                    }
                    break;
                  case 15:
                    {
                      h = 500;
                      b = 200;
                      tw = 10.2;
                      tf = 16;
                      r = 21;
                      d = 426;
                    }
                    break;
                  case 16:
                    {
                      h = 550;
                      b = 210;
                      tw = 11.1;
                      tf = 17.2;
                      r = 24;
                      d = 467;
                    }
                    break;
                  case 17:
                    {
                      h = 600;
                      b = 220;
                      tw = 12;
                      tf = 19;
                      r = 24;
                      d = 514;
                    }
                    break;
                }
                d1 = d;
                i = sectionName.ipe_section.length;
                ipn = "ipe";
              }
            }
          }
          if (!ch) {
            for (int i = 0; i < sectionName.ipea_section.length; i++) {
              if (selectedItem == (sectionName.ipea_section[i])) {
                number = i;
                ch = true;
                switch (number) {
                  case 0:
                    {
                      h = 118;
                      b = 64;
                      tw = 3.8;
                      tf = 5.1;
                      r = 7;
                      d = 93;
                    }
                    break;
                  case 1:
                    {
                      h = 137;
                      b = 73;
                      tw = 3.8;
                      tf = 5.6;
                      r = 7;
                      d = 112;
                    }
                    break;
                  case 2:
                    {
                      h = 157;
                      b = 82;
                      tw = 4;
                      tf = 5.9;
                      r = 9;
                      d = 127;
                    }
                    break;
                  case 3:
                    {
                      h = 177;
                      b = 91;
                      tw = 4.3;
                      tf = 6.5;
                      r = 9;
                      d = 146;
                    }
                    break;
                  case 4:
                    {
                      h = 197;
                      b = 100;
                      tw = 4.5;
                      tf = 7;
                      r = 12;
                      d = 159;
                    }
                    break;
                  case 5:
                    {
                      h = 217;
                      b = 110;
                      tw = 5;
                      tf = 7.7;
                      r = 12;
                      d = 177;
                    }
                    break;
                  case 6:
                    {
                      h = 237;
                      b = 120;
                      tw = 5.2;
                      tf = 8.3;
                      r = 15;
                      d = 190;
                    }
                    break;
                  case 7:
                    {
                      h = 267;
                      b = 135;
                      tw = 5.5;
                      tf = 8.7;
                      r = 15;
                      d = 219;
                    }
                    break;
                  case 8:
                    {
                      h = 297;
                      b = 150;
                      tw = 6.1;
                      tf = 9.2;
                      r = 15;
                      d = 248;
                    }
                    break;
                  case 9:
                    {
                      h = 327;
                      b = 160;
                      tw = 6.5;
                      tf = 10;
                      r = 18;
                      d = 271;
                    }
                    break;
                  case 10:
                    {
                      h = 358;
                      b = 170;
                      tw = 6.6;
                      tf = 11.5;
                      r = 18;
                      d = 298;
                    }
                    break;
                  case 11:
                    {
                      h = 397;
                      b = 180;
                      tw = 7;
                      tf = 12;
                      r = 21;
                      d = 331;
                    }
                    break;
                  case 12:
                    {
                      h = 447;
                      b = 190;
                      tw = 7.6;
                      tf = 13.1;
                      r = 21;
                      d = 378;
                    }
                    break;
                  case 13:
                    {
                      h = 497;
                      b = 200;
                      tw = 8.4;
                      tf = 14.5;
                      r = 21;
                      d = 426;
                    }
                    break;
                  case 14:
                    {
                      h = 547;
                      b = 210;
                      tw = 9;
                      tf = 15.7;
                      r = 24;
                      d = 467;
                    }
                    break;
                  case 15:
                    {
                      h = 597;
                      b = 220;
                      tw = 9.8;
                      tf = 17.5;
                      r = 24;
                      d = 514;
                    }
                    break;
                }
                d1 = d;
                i = sectionName.ipea_section.length;
                ipn = "ipe";
              }
            }
          }
          if (!ch) {
            for (int i = 0; i < sectionName.ipeo_section.length; i++) {
              if (selectedItem == (sectionName.ipeo_section[i])) {
                number = i;
                ch = true;
                switch (number) {
                  case 0:
                    {
                      h = 182;
                      b = 92;
                      tw = 6;
                      tf = 9;
                      r = 9;
                    }
                    break;
                  case 1:
                    {
                      h = 202;
                      b = 102;
                      tw = 6.2;
                      tf = 9.5;
                      r = 12;
                    }
                    break;
                  case 2:
                    {
                      h = 222;
                      b = 112;
                      tw = 6.6;
                      tf = 10.2;
                      r = 12;
                    }
                    break;
                  case 3:
                    {
                      h = 242;
                      b = 122;
                      tw = 7;
                      tf = 10.8;
                      r = 15;
                    }
                    break;
                  case 4:
                    {
                      h = 274;
                      b = 136;
                      tw = 7.5;
                      tf = 12.2;
                      r = 15;
                    }
                    break;
                  case 5:
                    {
                      h = 304;
                      b = 152;
                      tw = 8;
                      tf = 12.7;
                      r = 15;
                    }
                    break;
                  case 6:
                    {
                      h = 334;
                      b = 162;
                      tw = 8.5;
                      tf = 13.5;
                      r = 18;
                    }
                    break;
                  case 7:
                    {
                      h = 364;
                      b = 172;
                      tw = 9.2;
                      tf = 14.7;
                      r = 18;
                    }
                    break;
                  case 8:
                    {
                      h = 404;
                      b = 182;
                      tw = 9.7;
                      tf = 15.5;
                      r = 21;
                    }
                    break;
                  case 9:
                    {
                      h = 456;
                      b = 192;
                      tw = 11;
                      tf = 17.6;
                      r = 21;
                    }
                    break;
                  case 10:
                    {
                      h = 506;
                      b = 202;
                      tw = 12;
                      tf = 19;
                      r = 21;
                    }
                    break;
                  case 11:
                    {
                      h = 556;
                      b = 212;
                      tw = 12.7;
                      tf = 20.2;
                      r = 24;
                    }
                    break;
                  case 12:
                    {
                      h = 610;
                      b = 224;
                      tw = 15;
                      tf = 24;
                      r = 24;
                    }
                    break;
                }
                i = sectionName.ipeo_section.length;
                ipn = "ipe";
              }
            }
          }
          if (!ch) {
            for (int i = 0; i < sectionName.ipev_section.length; i++) {
              if (selectedItem == (sectionName.ipev_section[i])) {
                number = i;
                ch = true;
                i = sectionName.ipev_section.length;
                switch (number) {
                  case 0:
                    {
                      h = 408;
                      b = 182;
                      tw = 10.6;
                      tf = 17.5;
                      r = 21;
                    }
                    break;
                  case 1:
                    {
                      h = 460;
                      b = 194;
                      tw = 12.4;
                      tf = 19.6;
                      r = 21;
                    }
                    break;
                  case 2:
                    {
                      h = 514;
                      b = 204;
                      tw = 14.2;
                      tf = 23;
                      r = 21;
                    }
                    break;
                  case 3:
                    {
                      h = 566;
                      b = 216;
                      tw = 17.1;
                      tf = 25.2;
                      r = 24;
                    }
                    break;
                  case 4:
                    {
                      h = 618;
                      b = 228;
                      tw = 18;
                      tf = 28;
                      r = 24;
                    }
                    break;
                }
                i = sectionName.ipev_section.length;
                ipn = "ipe";
              }
            }
          }
          if (!ch) {
            for (int i = 0; i < sectionName.heaa_section.length; i++) {
              if (selectedItem == (sectionName.heaa_section[i])) {
                ch = true;
                number = i;
                i = sectionName.heaa_section.length;
                ipn = "H";
                switch (number) {
                  case 0:
                    {
                      h = 91;
                      b = 100;
                      tw = 4.2;
                      tf = 5.5;
                      r = 12;
                    }
                    break;
                  case 1:
                    {
                      h = 109;
                      b = 120;
                      tw = 4.2;
                      tf = 5.5;
                      r = 12;
                    }
                    break;
                  case 2:
                    {
                      h = 128;
                      b = 140;
                      tw = 4.3;
                      tf = 6;
                      r = 12;
                    }
                    break;
                  case 3:
                    {
                      h = 148;
                      b = 160;
                      tw = 4.5;
                      tf = 7;
                      r = 15;
                    }
                    break;
                  case 4:
                    {
                      h = 167;
                      b = 180;
                      tw = 5;
                      tf = 7.5;
                      r = 15;
                    }
                    break;
                  case 5:
                    {
                      h = 186;
                      b = 200;
                      tw = 5.5;
                      tf = 8;
                      r = 18;
                    }
                    break;
                  case 6:
                    {
                      h = 205;
                      b = 220;
                      tw = 6;
                      tf = 8.5;
                      r = 18;
                    }
                    break;
                  case 7:
                    {
                      h = 224;
                      b = 240;
                      tw = 6.5;
                      tf = 9;
                      r = 21;
                    }
                    break;
                  case 8:
                    {
                      h = 244;
                      b = 360;
                      tw = 6.5;
                      tf = 9.5;
                      r = 24;
                    }
                    break;
                  case 9:
                    {
                      h = 264;
                      b = 280;
                      tw = 7;
                      tf = 10;
                      r = 24;
                    }
                    break;
                  case 10:
                    {
                      h = 283;
                      b = 300;
                      tw = 7.5;
                      tf = 10.5;
                      r = 27;
                    }
                    break;
                  case 11:
                    {
                      h = 301;
                      b = 300;
                      tw = 8;
                      tf = 11;
                      r = 27;
                    }
                    break;
                  case 12:
                    {
                      h = 320;
                      b = 300;
                      tw = 8.5;
                      tf = 11.5;
                      r = 27;
                    }
                    break;
                  case 13:
                    {
                      h = 339;
                      b = 300;
                      tw = 9;
                      tf = 12;
                      r = 27;
                    }
                    break;
                  case 14:
                    {
                      h = 378;
                      b = 300;
                      tw = 9.5;
                      tf = 13;
                      r = 27;
                    }
                    break;
                  case 15:
                    {
                      h = 425;
                      b = 300;
                      tw = 10;
                      tf = 13.5;
                      r = 27;
                    }
                    break;
                  case 16:
                    {
                      h = 472;
                      b = 300;
                      tw = 10.5;
                      tf = 14;
                      r = 27;
                    }
                    break;
                  case 17:
                    {
                      h = 522;
                      b = 300;
                      tw = 11.5;
                      tf = 15;
                      r = 27;
                    }
                    break;
                  case 18:
                    {
                      h = 571;
                      b = 300;
                      tw = 12;
                      tf = 15.5;
                      r = 27;
                    }
                    break;
                  case 19:
                    {
                      h = 620;
                      b = 300;
                      tw = 12.5;
                      tf = 16;
                      r = 27;
                    }
                    break;
                  case 20:
                    {
                      h = 670;
                      b = 300;
                      tw = 13;
                      tf = 17;
                      r = 27;
                    }
                    break;
                  case 21:
                    {
                      h = 770;
                      b = 300;
                      tw = 14;
                      tf = 18;
                      r = 30;
                    }
                    break;
                  case 22:
                    {
                      h = 870;
                      b = 300;
                      tw = 15;
                      tf = 20;
                      r = 30;
                    }
                    break;
                  case 23:
                    {
                      h = 970;
                      b = 300;
                      tw = 16;
                      tf = 21;
                      r = 30;
                    }
                    break;
                }
              }
            }
          }
          if (!ch) {
            for (int i = 0; i < sectionName.hd_section.length; i++) {
              if (selectedItem == (sectionName.hd_section[i])) {
                ch = true;
                number = i;
                hd = true;
                i = sectionName.hd_section.length;
                ipn = "H";
                switch (number) {
                  case 0:
                    {
                      h = 244;
                      b = 260;
                      tw = 6.5;
                      tf = 9.5;
                      r = 24;
                    }
                    break;
                  case 1:
                    {
                      h = 250;
                      b = 260;
                      tw = 7.5;
                      tf = 12.5;
                      r = 24;
                    }
                    break;
                  case 2:
                    {
                      h = 260;
                      b = 260;
                      tw = 10;
                      tf = 17.5;
                      r = 24;
                    }
                    break;
                  case 3:
                    {
                      h = 268;
                      b = 262;
                      tw = 12.5;
                      tf = 21.5;
                      r = 24;
                    }
                    break;
                  case 4:
                    {
                      h = 278;
                      b = 265;
                      tw = 15.5;
                      tf = 26.5;
                      r = 24;
                    }
                    break;
                  case 5:
                    {
                      h = 290;
                      b = 268;
                      tw = 18;
                      tf = 32.5;
                      r = 24;
                    }
                    break;
                  case 6:
                    {
                      h = 309;
                      b = 271;
                      tw = 24;
                      tf = 42;
                      r = 24;
                    }
                    break;
                  case 7:
                    {
                      h = 335;
                      b = 278;
                      tw = 31;
                      tf = 55;
                      r = 24;
                    }
                    break;
                  case 8:
                    {
                      h = 301;
                      b = 300;
                      tw = 8;
                      tf = 11;
                      r = 27;
                    }
                    break;
                  case 9:
                    {
                      h = 310;
                      b = 300;
                      tw = 9;
                      tf = 15.5;
                      r = 27;
                    }
                    break;
                  case 10:
                    {
                      h = 320;
                      b = 300;
                      tw = 11.5;
                      tf = 20.5;
                      r = 27;
                    }
                    break;
                  case 11:
                    {
                      h = 330;
                      b = 303;
                      tw = 14.5;
                      tf = 25.5;
                      r = 27;
                    }
                    break;
                  case 12:
                    {
                      h = 343;
                      b = 306;
                      tw = 18;
                      tf = 32;
                      r = 27;
                    }
                    break;
                  case 13:
                    {
                      h = 359;
                      b = 309;
                      tw = 21;
                      tf = 40;
                      r = 27;
                    }
                    break;
                  case 14:
                    {
                      h = 375;
                      b = 313;
                      tw = 27;
                      tf = 48;
                      r = 27;
                    }
                    break;
                  case 15:
                    {
                      h = 356;
                      b = 369;
                      tw = 11.2;
                      tf = 18;
                      r = 15;
                    }
                    break;
                  case 16:
                    {
                      h = 360;
                      b = 370;
                      tw = 12.3;
                      tf = 19.8;
                      r = 15;
                    }
                    break;
                  case 17:
                    {
                      h = 364;
                      b = 371;
                      tw = 13.3;
                      tf = 21.8;
                      r = 15;
                    }
                    break;
                  case 18:
                    {
                      h = 368;
                      b = 373;
                      tw = 15;
                      tf = 23.9;
                      r = 15;
                    }
                    break;
                  case 19:
                    {
                      h = 372;
                      b = 374;
                      tw = 16.4;
                      tf = 26.2;
                      r = 15;
                    }
                    break;
                  case 20:
                    {
                      h = 368;
                      b = 391;
                      tw = 15;
                      tf = 24;
                      r = 15;
                    }
                    break;
                  case 21:
                    {
                      h = 375;
                      b = 394;
                      tw = 17.3;
                      tf = 27.7;
                      r = 15;
                    }
                    break;
                  case 22:
                    {
                      h = 380;
                      b = 395;
                      tw = 18.9;
                      tf = 30.2;
                      r = 15;
                    }
                    break;
                  case 23:
                    {
                      h = 387;
                      b = 398;
                      tw = 21.1;
                      tf = 33.3;
                      r = 15;
                    }
                    break;
                  case 24:
                    {
                      h = 393;
                      b = 399;
                      tw = 222.6;
                      tf = 36.3;
                      r = 15;
                    }
                    break;
                  case 25:
                    {
                      h = 399;
                      b = 401;
                      tw = 24.9;
                      tf = 39.6;
                      r = 15;
                    }
                    break;
                  case 26:
                    {
                      h = 407;
                      b = 404;
                      tw = 27.2;
                      tf = 43.7;
                      r = 15;
                    }
                    break;
                  case 27:
                    {
                      h = 416;
                      b = 406;
                      tw = 29.8;
                      tf = 48;
                      r = 15;
                    }
                    break;
                  case 28:
                    {
                      h = 425;
                      b = 409;
                      tw = 32.8;
                      tf = 52.6;
                      r = 15;
                    }
                    break;
                  case 29:
                    {
                      h = 435;
                      b = 412;
                      tw = 35.8;
                      tf = 57.4;
                      r = 15;
                    }
                    break;
                  case 30:
                    {
                      h = 446;
                      b = 416;
                      tw = 39.1;
                      tf = 62.7;
                      r = 15;
                    }
                    break;
                  case 31:
                    {
                      h = 455;
                      b = 418;
                      tw = 42;
                      tf = 67.6;
                      r = 15;
                    }
                    break;
                  case 32:
                    {
                      h = 465;
                      b = 421;
                      tw = 45;
                      tf = 72.3;
                      r = 15;
                    }
                    break;
                  case 33:
                    {
                      h = 474;
                      b = 424;
                      tw = 47.6;
                      tf = 77.1;
                      r = 15;
                    }
                    break;
                  case 34:
                    {
                      h = 483;
                      b = 428;
                      tw = 51.2;
                      tf = 81.5;
                      r = 15;
                    }
                    break;
                  case 35:
                    {
                      h = 498;
                      b = 432;
                      tw = 55.6;
                      tf = 88.9;
                      r = 15;
                    }
                    break;
                  case 36:
                    {
                      h = 514;
                      b = 437;
                      tw = 60.5;
                      tf = 97;
                      r = 15;
                    }
                    break;
                  case 37:
                    {
                      h = 531;
                      b = 442;
                      tw = 65.9;
                      tf = 106;
                      r = 15;
                    }
                    break;
                  case 38:
                    {
                      h = 550;
                      b = 448;
                      tw = 71.9;
                      tf = 115;
                      r = 15;
                    }
                    break;
                  case 39:
                    {
                      h = 569;
                      b = 454;
                      tw = 78;
                      tf = 125;
                      r = 15;
                    }
                    break;
                  case 40:
                    {
                      h = 580;
                      b = 471;
                      tw = 95;
                      tf = 130;
                      r = 15;
                    }
                    break;
                  case 41:
                    {
                      h = 600;
                      b = 476;
                      tw = 100;
                      tf = 140;
                      r = 15;
                    }
                    break;
                }
              }
            }
          }
          if (!ch) {
            for (int i = 0; i < sectionName.hl_section.length; i++) {
              if (selectedItem == (sectionName.hl_section[i])) {
                ch = true;
                number = i;
                hd = true;
                i = sectionName.hl_section.length;
                ipn = "H";
                switch (number) {
                  case 0:
                    {
                      h = 927;
                      b = 418;
                      tw = 19.3;
                      tf = 32;
                      r = 19;
                    }
                    break;
                  case 1:
                    {
                      h = 931;
                      b = 419;
                      tw = 20.3;
                      tf = 34.3;
                      r = 19;
                    }
                    break;
                  case 2:
                    {
                      h = 936;
                      b = 420;
                      tw = 21.3;
                      tf = 36.6;
                      r = 19;
                    }
                    break;
                  case 3:
                    {
                      h = 943;
                      b = 422;
                      tw = 22.5;
                      tf = 39.9;
                      r = 19;
                    }
                    break;
                  case 4:
                    {
                      h = 948;
                      b = 423;
                      tw = 24;
                      tf = 42.7;
                      r = 19;
                    }
                    break;
                  case 5:
                    {
                      h = 957;
                      b = 422;
                      tw = 25.9;
                      tf = 47;
                      r = 19;
                    }
                    break;
                  case 6:
                    {
                      h = 965;
                      b = 425;
                      tw = 28.4;
                      tf = 51.1;
                      r = 19;
                    }
                    break;
                  case 7:
                    {
                      h = 975;
                      b = 425;
                      tw = 31;
                      tf = 55.9;
                      r = 19;
                    }
                    break;
                  case 8:
                    {
                      h = 987;
                      b = 431;
                      tw = 34.5;
                      tf = 62;
                      r = 19;
                    }
                    break;
                  case 9:
                    {
                      h = 999;
                      b = 434;
                      tw = 38.1;
                      tf = 68.1;
                      r = 19;
                    }
                    break;
                  case 10:
                    {
                      h = 1011;
                      b = 437;
                      tw = 40.9;
                      tf = 73.9;
                      r = 19;
                    }
                    break;
                  case 11:
                    {
                      h = 1043;
                      b = 446;
                      tw = 50;
                      tf = 89.9;
                      r = 19;
                    }
                    break;
                  case 12:
                    {
                      h = 1061;
                      b = 451;
                      tw = 55;
                      tf = 99.1;
                      r = 19;
                    }
                    break;
                  case 13:
                    {
                      h = 1081;
                      b = 457;
                      tw = 60.5;
                      tf = 109;
                      r = 19;
                    }
                    break;
                  case 14:
                    {
                      h = 1093;
                      b = 461;
                      tw = 64;
                      tf = 115.1;
                      r = 19;
                    }
                    break;
                  case 15:
                    {
                      h = 1093;
                      b = 473;
                      tw = 76.7;
                      tf = 115.1;
                      r = 19;
                    }
                    break;
                  case 16:
                    {
                      h = 982;
                      b = 400;
                      tw = 16.5;
                      tf = 27.1;
                      r = 30;
                    }
                    break;
                  case 17:
                    {
                      h = 990;
                      b = 400;
                      tw = 16.5;
                      tf = 31;
                      r = 30;
                    }
                    break;
                  case 18:
                    {
                      h = 1000;
                      b = 400;
                      tw = 19;
                      tf = 36.1;
                      r = 30;
                    }
                    break;
                  case 19:
                    {
                      h = 1008;
                      b = 402;
                      tw = 21.1;
                      tf = 40;
                      r = 30;
                    }
                    break;
                  case 20:
                    {
                      h = 1012;
                      b = 402;
                      tw = 23.6;
                      tf = 41.9;
                      r = 30;
                    }
                    break;
                  case 21:
                    {
                      h = 1020;
                      b = 404;
                      tw = 25.4;
                      tf = 46;
                      r = 30;
                    }
                    break;
                  case 22:
                    {
                      h = 1030;
                      b = 407;
                      tw = 28.4;
                      tf = 51.1;
                      r = 30;
                    }
                    break;
                  case 23:
                    {
                      h = 1032;
                      b = 408;
                      tw = 29.5;
                      tf = 52;
                      r = 30;
                    }
                    break;
                  case 24:
                    {
                      h = 1040;
                      b = 409;
                      tw = 31;
                      tf = 55.9;
                      r = 30;
                    }
                    break;
                  case 25:
                    {
                      h = 1048;
                      b = 412;
                      tw = 34;
                      tf = 60;
                      r = 30;
                    }
                    break;
                  case 26:
                    {
                      h = 1068;
                      b = 417;
                      tw = 39;
                      tf = 70;
                      r = 30;
                    }
                    break;
                  case 27:
                    {
                      h = 1092;
                      b = 424;
                      tw = 45.5;
                      tf = 82;
                      r = 30;
                    }
                    break;
                  case 28:
                    {
                      h = 1108;
                      b = 428;
                      tw = 50;
                      tf = 89.9;
                      r = 30;
                    }
                    break;
                  case 29:
                    {
                      h = 1090;
                      b = 400;
                      tw = 18;
                      tf = 31;
                      r = 30;
                    }
                    break;
                  case 30:
                    {
                      h = 1100;
                      b = 400;
                      tw = 20;
                      tf = 36;
                      r = 30;
                    }
                    break;
                  case 31:
                    {
                      h = 1108;
                      b = 402;
                      tw = 22;
                      tf = 40;
                      r = 30;
                    }
                    break;
                  case 32:
                    {
                      h = 1118;
                      b = 405;
                      tw = 26;
                      tf = 45;
                      r = 30;
                    }
                    break;
                  case 33:
                    {
                      h = 1128;
                      b = 407;
                      tw = 28;
                      tf = 50;
                      r = 30;
                    }
                    break;
                  case 43:
                    {
                      h = 1138;
                      b = 410;
                      tw = 31;
                      tf = 55;
                      r = 30;
                    }
                    break;
                }
              }
            }
          }
          if (!ch) {
            for (int i = 0; i < sectionName.hlz_section.length; i++) {
              if (selectedItem == (sectionName.hlz_section[i])) {
                ch = true;
                number = i;
                hd = true;
                ipn = "H";
                switch (number) {
                  case 0:
                    {
                      h = 1075;
                      b = 458;
                      tw = 20;
                      tf = 31;
                      r = 35;
                    }
                    break;
                  case 1:
                    {
                      h = 1079;
                      b = 458;
                      tw = 20;
                      tf = 33;
                      r = 35;
                    }
                    break;
                  case 2:
                    {
                      h = 1083;
                      b = 459;
                      tw = 21;
                      tf = 35;
                      r = 35;
                    }
                    break;
                  case 3:
                    {
                      h = 1087;
                      b = 460;
                      tw = 22;
                      tf = 37;
                      r = 35;
                    }
                    break;
                }
              }
            }
          }
          if (!ch) {
            for (int i = 0; i < sectionName.HEA_section.length; i++) {
              if (selectedItem == (sectionName.HEA_section[i])) {
                ch = true;
                number = i;
                i = sectionName.HEA_section.length;
                ipn = "H";
                switch (number) {
                  case 0:
                    {
                      h = 96;
                      b = 100;
                      tw = 5;
                      tf = 8;
                      r = 12;
                    }
                    break;
                  case 1:
                    {
                      h = 114;
                      b = 120;
                      tw = 5;
                      tf = 8;
                      r = 12;
                    }
                    break;
                  case 2:
                    {
                      h = 133;
                      b = 140;
                      tw = 5.5;
                      tf = 8.5;
                      r = 12;
                    }
                    break;
                  case 3:
                    {
                      h = 152;
                      b = 160;
                      tw = 6;
                      tf = 9;
                      r = 15;
                    }
                    break;
                  case 4:
                    {
                      h = 171;
                      b = 180;
                      tw = 6;
                      tf = 9.5;
                      r = 15;
                    }
                    break;
                  case 5:
                    {
                      h = 190;
                      b = 200;
                      tw = 6.5;
                      tf = 10;
                      r = 18;
                    }
                    break;
                  case 6:
                    {
                      h = 210;
                      b = 220;
                      tw = 7;
                      tf = 11;
                      r = 18;
                    }
                    break;
                  case 7:
                    {
                      h = 230;
                      b = 240;
                      tw = 7.5;
                      tf = 12;
                      r = 21;
                    }
                    break;
                  case 8:
                    {
                      h = 250;
                      b = 260;
                      tw = 7.5;
                      tf = 12.5;
                      r = 24;
                    }
                    break;
                  case 9:
                    {
                      h = 270;
                      b = 280;
                      tw = 8;
                      tf = 13;
                      r = 24;
                    }
                    break;
                  case 10:
                    {
                      h = 290;
                      b = 300;
                      tw = 8.5;
                      tf = 14;
                      r = 27;
                    }
                    break;
                  case 11:
                    {
                      h = 310;
                      b = 300;
                      tw = 9;
                      tf = 15.5;
                      r = 27;
                    }
                    break;
                  case 12:
                    {
                      h = 330;
                      b = 300;
                      tw = 9.5;
                      tf = 16.5;
                      r = 27;
                    }
                    break;
                  case 13:
                    {
                      h = 350;
                      b = 300;
                      tw = 10;
                      tf = 17.5;
                      r = 27;
                    }
                    break;
                  case 14:
                    {
                      h = 390;
                      b = 300;
                      tw = 11;
                      tf = 19;
                      r = 27;
                    }
                    break;
                  case 15:
                    {
                      h = 440;
                      b = 300;
                      tw = 11.5;
                      tf = 21;
                      r = 27;
                    }
                    break;
                  case 16:
                    {
                      h = 490;
                      b = 300;
                      tw = 12;
                      tf = 23;
                      r = 27;
                    }
                    break;
                  case 17:
                    {
                      h = 540;
                      b = 300;
                      tw = 12.5;
                      tf = 24;
                      r = 27;
                    }
                    break;
                  case 18:
                    {
                      h = 590;
                      b = 300;
                      tw = 13;
                      tf = 25;
                      r = 27;
                    }
                    break;
                  case 19:
                    {
                      h = 640;
                      b = 300;
                      tw = 13.5;
                      tf = 26;
                      r = 27;
                    }
                    break;
                  case 20:
                    {
                      h = 690;
                      b = 300;
                      tw = 14.5;
                      tf = 27;
                      r = 27;
                    }
                    break;
                  case 21:
                    {
                      h = 790;
                      b = 300;
                      tw = 15;
                      tf = 28;
                      r = 30;
                    }
                    break;
                  case 22:
                    {
                      h = 890;
                      b = 300;
                      tw = 16;
                      tf = 30;
                      r = 30;
                    }
                    break;
                  case 23:
                    {
                      h = 990;
                      b = 300;
                      tw = 16.5;
                      tf = 31;
                      r = 30;
                    }
                    break;
                }
              }
            }
          }
          if (!ch) {
            for (int i = 0; i < sectionName.HEB_section.length; i++) {
              if (selectedItem == (sectionName.HEB_section[i])) {
                number = i;
                ch = true;
                i = sectionName.HEB_section.length;
                ipn = "H";
                switch (number) {
                  case 0:
                    {
                      h = b = 100;
                      tw = 6;
                      tf = 10;
                      r = 12;
                    }
                    break;
                  case 1:
                    {
                      h = b = 120;
                      tw = 6.5;
                      tf = 11;
                      r = 12;
                    }
                    break;
                  case 2:
                    {
                      h = b = 140;
                      tw = 7;
                      tf = 12;
                      r = 12;
                    }
                    break;
                  case 3:
                    {
                      h = b = 160;
                      tw = 8;
                      tf = 13;
                      r = 15;
                    }
                    break;
                  case 4:
                    {
                      h = b = 180;
                      tw = 8.5;
                      tf = 14;
                      r = 15;
                    }
                    break;
                  case 5:
                    {
                      h = b = 200;
                      tw = 9;
                      tf = 15;
                      r = 18;
                    }
                    break;
                  case 6:
                    {
                      h = b = 220;
                      tw = 9.5;
                      tf = 16;
                      r = 18;
                    }
                    break;
                  case 7:
                    {
                      h = b = 240;
                      tw = 10;
                      tf = 17;
                      r = 21;
                    }
                    break;
                  case 8:
                    {
                      h = b = 260;
                      tw = 10;
                      tf = 17.5;
                      r = 24;
                    }
                    break;
                  case 9:
                    {
                      h = b = 280;
                      tw = 10.5;
                      tf = 18;
                      r = 24;
                    }
                    break;
                  case 10:
                    {
                      h = b = 300;
                      tw = 11;
                      tf = 19;
                      r = 27;
                    }
                    break;
                  case 11:
                    {
                      h = 320;
                      b = 300;
                      tw = 11.5;
                      tf = 20.5;
                      r = 27;
                    }
                    break;
                  case 12:
                    {
                      h = 340;
                      b = 300;
                      tw = 12;
                      tf = 21.5;
                      r = 27;
                    }
                    break;
                  case 13:
                    {
                      h = 360;
                      b = 300;
                      tw = 12.5;
                      tf = 22.5;
                      r = 27;
                    }
                    break;
                  case 14:
                    {
                      h = 400;
                      b = 300;
                      tw = 13.5;
                      tf = 24;
                      r = 27;
                    }
                    break;
                  case 15:
                    {
                      h = 450;
                      b = 300;
                      tw = 14;
                      tf = 26;
                      r = 27;
                    }
                    break;
                  case 16:
                    {
                      h = 500;
                      b = 300;
                      tw = 14.5;
                      tf = 28;
                      r = 27;
                    }
                    break;
                  case 17:
                    {
                      h = 550;
                      b = 300;
                      tw = 15;
                      tf = 29;
                      r = 27;
                    }
                    break;
                  case 18:
                    {
                      h = 600;
                      b = 300;
                      tw = 15.5;
                      tf = 30;
                      r = 27;
                    }
                    break;
                  case 19:
                    {
                      h = 650;
                      b = 300;
                      tw = 16;
                      tf = 31;
                      r = 27;
                    }
                    break;
                  case 20:
                    {
                      h = 700;
                      b = 300;
                      tw = 17;
                      tf = 32;
                      r = 27;
                    }
                    break;
                  case 21:
                    {
                      h = 800;
                      b = 300;
                      tw = 17.5;
                      tf = 33;
                      r = 27;
                    }
                    break;
                  case 22:
                    {
                      h = 900;
                      b = 300;
                      tw = 18.5;
                      tf = 35;
                      r = 27;
                    }
                    break;
                  case 23:
                    {
                      h = 1000;
                      b = 300;
                      tw = 19;
                      tf = 36;
                      r = 27;
                    }
                    break;
                }
              }
            }
          }
          if (!ch) {
            for (int i = 0; i < sectionName.HEM_section.length; i++) {
              if (selectedItem == (sectionName.HEM_section[i])) {
                number = i;
                ch = true;
                i = sectionName.HEM_section.length;
                ipn = "H";
                switch (number) {
                  case 0:
                    {
                      h = 120;
                      b = 106;
                      tw = 12;
                      tf = 20;
                      r = 12;
                    }
                    break;
                  case 1:
                    {
                      h = 140;
                      b = 126;
                      tw = 12.5;
                      tf = 21;
                      r = 12;
                    }
                    break;
                  case 2:
                    {
                      h = 160;
                      b = 146;
                      tw = 13;
                      tf = 22;
                      r = 12;
                    }
                    break;
                  case 3:
                    {
                      h = 180;
                      b = 166;
                      tw = 14;
                      tf = 23;
                      r = 15;
                    }
                    break;
                  case 4:
                    {
                      h = 200;
                      b = 186;
                      tw = 14.5;
                      tf = 24;
                      r = 15;
                    }
                    break;
                  case 5:
                    {
                      h = 220;
                      b = 206;
                      tw = 15;
                      tf = 25;
                      r = 18;
                    }
                    break;
                  case 6:
                    {
                      h = 240;
                      b = 226;
                      tw = 15.5;
                      tf = 26;
                      r = 18;
                    }
                    break;
                  case 7:
                    {
                      h = 270;
                      b = 248;
                      tw = 18;
                      tf = 32;
                      r = 21;
                    }
                    break;
                  case 8:
                    {
                      h = 290;
                      b = 268;
                      tw = 18;
                      tf = 32.5;
                      r = 24;
                    }
                    break;
                  case 9:
                    {
                      h = 310;
                      b = 288;
                      tw = 18.5;
                      tf = 33;
                      r = 24;
                    }
                    break;
                  case 10:
                    {
                      h = 340;
                      b = 310;
                      tw = 21;
                      tf = 39;
                      r = 27;
                    }
                    break;
                  case 11:
                    {
                      h = 259;
                      b = 309;
                      tw = 21;
                      tf = 40;
                      r = 27;
                    }
                    break;
                  case 12:
                    {
                      h = 377;
                      b = 309;
                      tw = 21;
                      tf = 40;
                      r = 27;
                    }
                    break;
                  case 13:
                    {
                      h = 395;
                      b = 308;
                      tw = 21;
                      tf = 40;
                      r = 27;
                    }
                    break;
                  case 14:
                    {
                      h = 432;
                      b = 307;
                      tw = 21;
                      tf = 40;
                      r = 27;
                    }
                    break;
                  case 15:
                    {
                      h = 478;
                      b = 307;
                      tw = 21;
                      tf = 40;
                      r = 27;
                    }
                    break;
                  case 16:
                    {
                      h = 524;
                      b = 306;
                      tw = 21;
                      tf = 40;
                      r = 27;
                    }
                    break;
                  case 17:
                    {
                      h = 572;
                      b = 306;
                      tw = 21;
                      tf = 40;
                      r = 27;
                    }
                    break;
                  case 18:
                    {
                      h = 620;
                      b = 305;
                      tw = 21;
                      tf = 40;
                      r = 27;
                    }
                    break;
                  case 19:
                    {
                      h = 668;
                      b = 305;
                      tw = 21;
                      tf = 40;
                      r = 27;
                    }
                    break;
                  case 20:
                    {
                      h = 716;
                      b = 304;
                      tw = 21;
                      tf = 40;
                      r = 27;
                    }
                    break;
                  case 21:
                    {
                      h = 814;
                      b = 303;
                      tw = 21;
                      tf = 40;
                      r = 30;
                    }
                    break;
                  case 22:
                    {
                      h = 910;
                      b = 302;
                      tw = 21;
                      tf = 40;
                      r = 30;
                    }
                    break;
                  case 23:
                    {
                      h = 1008;
                      b = 302;
                      tw = 21;
                      tf = 40;
                      r = 30;
                    }
                    break;
                }
              }
            }
          }
          if (ipn == ("ipn")) {
            set_stringdetails();
            value.add(H + pas + mm);
            value.add(B + pas + mm);
            value.add(Tw + pas + mm);
            value.add(Tf + pas + mm);
            value.add(R2 + pas + mm);
            value.add(D + pas + mm);
            value.add(Area + pas + cm2);
            value.add(IY + pas + cm4);
            value.add(WELY + pas + cm3);
            value.add(iY + pas + cm);
            value.add(IZ + pas + cm4);
            value.add(WELZ + pas + cm3);
            value.add(iZ + pas + cm);
            value.add(sY + pas + cm3);
            value.add(G + pas + KNmm);
          } else {
            _ComputeDetails(x_section, h, b, tw, tf, r, d1, r1, r2);
            value.add(H + pas + mm);
            value.add(B + pas + mm);
            value.add(Tw + pas + mm);
            value.add(Tf + pas + mm);
            value.add(R0 + pas + mm);
            value.add(D + pas + mm);
            value.add(Area + pas + cm2);
            value.add(IY + pas + cm4);
            value.add(WELY + pas + cm3);
            if (hd == true) {
              value.add(WPLY + pas + cm3);
              value.add(IZ + pas + cm4);
              value.add(WELZ + pas + cm3);
              value.add(WPLZ + pas + cm3);
              value.add(IT + pas + cm4);
              value.add(G + pas + KNmm);
            } else {
              value.add(iY + pas + cm);
              value.add(IZ + pas + cm4);
              value.add(WELZ + pas + cm3);
              value.add(iZ + pas + cm);
              value.add(sY + pas + cm3);
              value.add(G + pas + KNmm);
            }
          }
        }
        break;
      case "T_section":
        {
          bool ch = false;
          for (int i = 0; i < sectionName.t_section.length; i++) {
            String s = sectionName.t_section[i];
            if (selectedItem == (s)) {
              number = i;
              ch = true;
              switch (number) {
                case 0:
                  {
                    h = 30;
                    b = 30;
                    tf = tw = 4;
                    r1 = 4;
                    r2 = 2;
                    r3 = 1;
                    d = 21;
                    A = 2.26;
                    Iy = 2.72;
                    Wely = 0.8;
                    iy = 0.87;
                    Iz = 0.87;
                    Welz = 0.58;
                    iz = 0.62;
                    ey = 0.58;
                  }
                  break;
                case 1:
                  {
                    h = 35;
                    b = 35;
                    tf = tw = 4.5;
                    r1 = 4.5;
                    r2 = 2.5;
                    r3 = 1;
                    d = 25;
                    A = 2.97;
                    Iy = 3.1;
                    Wely = 3.23;
                    iy = 1.04;
                    Iz = 1.57;
                    Welz = 0.9;
                    iz = 0.37;
                    ey = 0.99;
                  }
                  break;
                case 2:
                  {
                    h = 40;
                    b = 40;
                    tf = tw = 5;
                    r1 = 5;
                    r2 = 2.5;
                    r3 = 1;
                    d = 29;
                    A = 3.77;
                    Iy = 5.28;
                    Wely = 1.84;
                    iy = 1.18;
                    Iz = 2.58;
                    Welz = 1.29;
                    iz = 0.38;
                    ey = 1.12;
                  }
                  break;
                case 3:
                  {
                    h = 50;
                    b = 50;
                    tf = tw = 6;
                    r1 = 6;
                    r2 = 3;
                    r3 = 1.5;
                    d = 37;
                    A = 5.66;
                    Iy = 12.1;
                    Wely = 3.36;
                    iy = 1.46;
                    Iz = 6.06;
                    Welz = 2.42;
                    iz = 1.03;
                    ey = 1.39;
                  }
                  break;
                case 4:
                  {
                    h = 60;
                    b = 60;
                    tf = tw = 7;
                    r1 = 7;
                    r2 = 3.5;
                    r3 = 2;
                    d = 45;
                    A = 7.94;
                    Iy = 23.8;
                    Wely = 5.48;
                    iy = 1.73;
                    Iz = 12.12;
                    Welz = 4.07;
                    iz = 1.24;
                    ey = 1.66;
                  }
                  break;
                case 5:
                  {
                    h = 70;
                    b = 70;
                    tf = tw = 8;
                    r1 = 8;
                    r2 = 4;
                    r3 = 2;
                    d = 53;
                    A = 10.6;
                    Iy = 44.5;
                    Wely = 8.79;
                    iy = 2.05;
                    Iz = 22.1;
                    Welz = 6.32;
                    iz = 1.44;
                    ey = 1.94;
                  }
                  break;
                case 6:
                  {
                    h = 80;
                    b = 80;
                    tf = tw = 9;
                    r1 = 9;
                    r2 = 4.5;
                    r3 = 2;
                    d = 61;
                    A = 13.6;
                    Iy = 73.7;
                    Wely = 12.8;
                    iy = 2.33;
                    Iz = 37;
                    Welz = 9.25;
                    iz = 1.65;
                    ey = 2.22;
                  }
                  break;
                case 7:
                  {
                    h = 100;
                    b = 100;
                    tf = tw = 11;
                    r1 = 11;
                    r2 = 5.5;
                    r3 = 3;
                    d = 77;
                    A = 20.9;
                    Iy = 179;
                    Wely = 24.6;
                    iy = 2.92;
                    Iz = 88.3;
                    Welz = 17.7;
                    iz = 2.05;
                    ey = 2.74;
                  }
                  break;
                case 8:
                  {
                    h = 120;
                    b = 120;
                    tf = tw = 13;
                    r1 = 13;
                    r2 = 6.5;
                    r3 = 3;
                    d = 93;
                    A = 29.6;
                    Iy = 366;
                    Wely = 42;
                    iy = 3.51;
                    Iz = 178;
                    Welz = 29.7;
                    iz = 2.45;
                    ey = 3.28;
                  }
                  break;
                case 9:
                  {
                    h = 140;
                    b = 140;
                    tf = tw = 15;
                    r1 = 15;
                    r2 = 7.5;
                    r3 = 4;
                    d = 109;
                    A = 39.9;
                    Iy = 660;
                    Wely = 64.7;
                    iy = 4.07;
                    Iz = 330;
                    Welz = 47.2;
                    iz = 2.88;
                    ey = 3.8;
                  }
                  break;
              }
              i = sectionName.t_section.length;
              ipn = "T";
              this.g = 78.5 * A / 10000; //KN/mm
            }
          }
          if (!ch) {
            for (int i = 0; i < sectionName.halfipe_section.length; i++) {
              if (selectedItem == (sectionName.halfipe_section[i])) {
                number = i;
                ch = true;
                i = sectionName.halfipe_section.length;
                switch (number) {
                  case 0:
                    {
                      h = 140;
                      b = 73;
                      tw = 4.7;
                      tf = 6.9;
                      r = 7;
                      d = 112;
                    }
                    break;
                  case 1:
                    {
                      h = 160;
                      b = 82;
                      tw = 5;
                      tf = 7.4;
                      r = 9;
                      d = 127;
                    }
                    break;
                  case 2:
                    {
                      h = 180;
                      b = 91;
                      tw = 5.3;
                      tf = 8;
                      r = 9;
                      d = 146;
                    }
                    break;
                  case 3:
                    {
                      h = 200;
                      b = 100;
                      tw = 5.6;
                      tf = 8.5;
                      r = 12;
                      d = 159;
                    }
                    break;
                  case 4:
                    {
                      h = 220;
                      b = 110;
                      tw = 5.7;
                      tf = 9.2;
                      r = 12;
                      d = 177;
                    }
                    break;
                  case 5:
                    {
                      h = 240;
                      b = 120;
                      tw = 6.2;
                      tf = 9.8;
                      r = 15;
                      d = 190;
                    }
                    break;
                  case 6:
                    {
                      h = 270;
                      b = 135;
                      tw = 6.6;
                      tf = 10.2;
                      r = 15;
                      d = 219;
                    }
                    break;
                  case 7:
                    {
                      h = 300;
                      b = 150;
                      tw = 7.1;
                      tf = 10.7;
                      r = 15;
                      d = 248;
                    }
                    break;
                  case 8:
                    {
                      h = 330;
                      b = 160;
                      tw = 7.5;
                      tf = 11.5;
                      r = 18;
                      d = 271;
                    }
                    break;
                  case 9:
                    {
                      h = 360;
                      b = 170;
                      tw = 8;
                      tf = 127;
                      r = 18;
                      d = 298;
                    }
                    break;
                  case 10:
                    {
                      h = 400;
                      b = 180;
                      tw = 8.6;
                      tf = 13.5;
                      r = 21;
                      d = 331;
                    }
                    break;
                  case 11:
                    {
                      h = 450;
                      b = 190;
                      tw = 9.4;
                      tf = 14.6;
                      r = 21;
                      d = 378;
                    }
                    break;
                  case 12:
                    {
                      h = 500;
                      b = 200;
                      tw = 10.2;
                      tf = 16;
                      r = 21;
                      d = 426;
                    }
                    break;
                  case 13:
                    {
                      h = 550;
                      b = 210;
                      tw = 11.1;
                      tf = 17.2;
                      r = 24;
                      d = 467;
                    }
                    break;
                  case 14:
                    {
                      h = 600;
                      b = 220;
                      tw = 12;
                      tf = 19;
                      r = 24;
                      d = 514;
                    }
                    break;
                }
                h = h / 2;
              }
            }
          }
          if (!ch) {
            for (int i = 0; i < sectionName.halfipeo_section.length; i++) {
              if (selectedItem == (sectionName.halfipeo_section[i])) {
                number = i;
                ch = true;
                i = sectionName.halfipeo_section.length;
                switch (number) {
                  case 0:
                    {
                      h = 274;
                      b = 136;
                      tw = 7.5;
                      tf = 12.2;
                      r = 15;
                    }
                    break;
                  case 1:
                    {
                      h = 304;
                      b = 152;
                      tw = 8;
                      tf = 12.7;
                      r = 15;
                    }
                    break;
                  case 2:
                    {
                      h = 334;
                      b = 162;
                      tw = 8.5;
                      tf = 13.5;
                      r = 18;
                    }
                    break;
                  case 3:
                    {
                      h = 364;
                      b = 172;
                      tw = 9.2;
                      tf = 14.7;
                      r = 18;
                    }
                    break;
                  case 4:
                    {
                      h = 404;
                      b = 182;
                      tw = 9.7;
                      tf = 15.5;
                      r = 21;
                    }
                    break;
                  case 5:
                    {
                      h = 456;
                      b = 192;
                      tw = 11;
                      tf = 17.6;
                      r = 21;
                    }
                    break;
                  case 6:
                    {
                      h = 506;
                      b = 202;
                      tw = 12;
                      tf = 19;
                      r = 21;
                    }
                    break;
                  case 7:
                    {
                      h = 556;
                      b = 212;
                      tw = 12.7;
                      tf = 20.2;
                      r = 24;
                    }
                    break;
                  case 8:
                    {
                      h = 610;
                      b = 224;
                      tw = 15;
                      tf = 24;
                      r = 24;
                    }
                    break;
                }
                h = h / 2;
              }
            }
          }
          if (!ch) {
            for (int i = 0; i < sectionName.halfipev_section.length; i++) {
              if (selectedItem == (sectionName.halfipev_section[i])) {
                number = i;
                ch = true;
                i = sectionName.halfipev_section.length;
                switch (number) {
                  case 0:
                    {
                      h = 408;
                      b = 182;
                      tw = 10.6;
                      tf = 17.5;
                      r = 21;
                    }
                    break;
                  case 1:
                    {
                      h = 460;
                      b = 194;
                      tw = 12.4;
                      tf = 19.6;
                      r = 21;
                    }
                    break;
                  case 2:
                    {
                      h = 514;
                      b = 204;
                      tw = 14.2;
                      tf = 23;
                      r = 21;
                    }
                    break;
                  case 3:
                    {
                      h = 566;
                      b = 216;
                      tw = 17.1;
                      tf = 25.2;
                      r = 24;
                    }
                    break;
                  case 4:
                    {
                      h = 618;
                      b = 228;
                      tw = 18;
                      tf = 28;
                      r = 24;
                    }
                    break;
                }
                h = h / 2;
              }
            }
          }
          if (!ch) {
            for (int i = 0; i < sectionName.halfHEA_section.length; i++) {
              if (selectedItem == (sectionName.halfHEA_section[i])) {
                ch = true;
                number = i;
                i = sectionName.halfHEA_section.length;
                switch (number) {
                  case 0:
                    {
                      h = 133;
                      b = 140;
                      tw = 5.5;
                      tf = 8.5;
                      r = 12;
                    }
                    break;
                  case 1:
                    {
                      h = 152;
                      b = 160;
                      tw = 6;
                      tf = 9;
                      r = 15;
                    }
                    break;
                  case 2:
                    {
                      h = 171;
                      b = 180;
                      tw = 6;
                      tf = 9.5;
                      r = 15;
                    }
                    break;
                  case 3:
                    {
                      h = 190;
                      b = 200;
                      tw = 6.5;
                      tf = 10;
                      r = 18;
                    }
                    break;
                  case 4:
                    {
                      h = 210;
                      b = 220;
                      tw = 7;
                      tf = 11;
                      r = 18;
                    }
                    break;
                  case 5:
                    {
                      h = 230;
                      b = 240;
                      tw = 7.5;
                      tf = 12;
                      r = 21;
                    }
                    break;
                  case 6:
                    {
                      h = 250;
                      b = 260;
                      tw = 7.5;
                      tf = 12.5;
                      r = 24;
                    }
                    break;
                  case 7:
                    {
                      h = 270;
                      b = 280;
                      tw = 8;
                      tf = 13;
                      r = 24;
                    }
                    break;
                  case 8:
                    {
                      h = 290;
                      b = 300;
                      tw = 8.5;
                      tf = 14;
                      r = 27;
                    }
                    break;
                  case 9:
                    {
                      h = 310;
                      b = 300;
                      tw = 9;
                      tf = 15.5;
                      r = 27;
                    }
                    break;
                  case 10:
                    {
                      h = 330;
                      b = 300;
                      tw = 9.5;
                      tf = 16.5;
                      r = 27;
                    }
                    break;
                  case 11:
                    {
                      h = 350;
                      b = 300;
                      tw = 10;
                      tf = 17.5;
                      r = 27;
                    }
                    break;
                  case 12:
                    {
                      h = 390;
                      b = 300;
                      tw = 11;
                      tf = 19;
                      r = 27;
                    }
                    break;
                  case 13:
                    {
                      h = 440;
                      b = 300;
                      tw = 11.5;
                      tf = 21;
                      r = 27;
                    }
                    break;
                  case 14:
                    {
                      h = 490;
                      b = 300;
                      tw = 12;
                      tf = 23;
                      r = 27;
                    }
                    break;
                  case 15:
                    {
                      h = 540;
                      b = 300;
                      tw = 12.5;
                      tf = 24;
                      r = 27;
                    }
                    break;
                  case 16:
                    {
                      h = 590;
                      b = 300;
                      tw = 13;
                      tf = 25;
                      r = 27;
                    }
                    break;
                  case 17:
                    {
                      h = 640;
                      b = 300;
                      tw = 13.5;
                      tf = 26;
                      r = 27;
                    }
                    break;
                  case 18:
                    {
                      h = 690;
                      b = 300;
                      tw = 14.5;
                      tf = 27;
                      r = 27;
                    }
                    break;
                  case 19:
                    {
                      h = 790;
                      b = 300;
                      tw = 15;
                      tf = 28;
                      r = 30;
                    }
                    break;
                }
                h = h / 2;
              }
            }
          }
          if (!ch) {
            for (int i = 0; i < sectionName.halfHEB_section.length; i++) {
              if (selectedItem == (sectionName.halfHEB_section[i])) {
                number = i;
                ch = true;
                i = sectionName.halfHEB_section.length;
                switch (number) {
                  case 0:
                    {
                      h = b = 140;
                      tw = 7;
                      tf = 12;
                      r = 12;
                    }
                    break;
                  case 1:
                    {
                      h = b = 160;
                      tw = 8;
                      tf = 13;
                      r = 15;
                    }
                    break;
                  case 2:
                    {
                      h = b = 180;
                      tw = 8.5;
                      tf = 14;
                      r = 15;
                    }
                    break;
                  case 3:
                    {
                      h = b = 200;
                      tw = 9;
                      tf = 15;
                      r = 18;
                    }
                    break;
                  case 4:
                    {
                      h = b = 220;
                      tw = 9.5;
                      tf = 16;
                      r = 18;
                    }
                    break;
                  case 5:
                    {
                      h = b = 240;
                      tw = 10;
                      tf = 17;
                      r = 21;
                    }
                    break;
                  case 6:
                    {
                      h = b = 260;
                      tw = 10;
                      tf = 17.5;
                      r = 24;
                    }
                    break;
                  case 7:
                    {
                      h = b = 280;
                      tw = 10.5;
                      tf = 18;
                      r = 24;
                    }
                    break;
                  case 8:
                    {
                      h = b = 300;
                      tw = 11;
                      tf = 19;
                      r = 27;
                    }
                    break;
                  case 9:
                    {
                      h = 320;
                      b = 300;
                      tw = 11.5;
                      tf = 20.5;
                      r = 27;
                    }
                    break;
                  case 10:
                    {
                      h = 340;
                      b = 300;
                      tw = 12;
                      tf = 21.5;
                      r = 27;
                    }
                    break;
                  case 11:
                    {
                      h = 360;
                      b = 300;
                      tw = 12.5;
                      tf = 22.5;
                      r = 27;
                    }
                    break;
                  case 12:
                    {
                      h = 400;
                      b = 300;
                      tw = 13.5;
                      tf = 24;
                      r = 27;
                    }
                    break;
                  case 13:
                    {
                      h = 450;
                      b = 300;
                      tw = 14;
                      tf = 26;
                      r = 27;
                    }
                    break;
                  case 14:
                    {
                      h = 500;
                      b = 300;
                      tw = 14.5;
                      tf = 28;
                      r = 27;
                    }
                    break;
                  case 15:
                    {
                      h = 550;
                      b = 300;
                      tw = 15;
                      tf = 29;
                      r = 27;
                    }
                    break;
                  case 16:
                    {
                      h = 600;
                      b = 300;
                      tw = 15.5;
                      tf = 30;
                      r = 27;
                    }
                    break;
                  case 17:
                    {
                      h = 650;
                      b = 300;
                      tw = 16;
                      tf = 31;
                      r = 27;
                    }
                    break;
                  case 18:
                    {
                      h = 700;
                      b = 300;
                      tw = 17;
                      tf = 32;
                      r = 27;
                    }
                    break;
                  case 19:
                    {
                      h = 800;
                      b = 300;
                      tw = 17.5;
                      tf = 33;
                      r = 27;
                    }
                    break;
                }
                h = h / 2;
              }
            }
          }
          if (!ch) {
            for (int i = 0; i < sectionName.halfHEM_section.length; i++) {
              if (selectedItem == (sectionName.halfHEM_section[i])) {
                number = i;
                ch = true;
                i = sectionName.halfHEM_section.length;
                switch (number) {
                  case 0:
                    {
                      h = 160;
                      b = 146;
                      tw = 13;
                      tf = 22;
                      r = 12;
                    }
                    break;
                  case 1:
                    {
                      h = 180;
                      b = 166;
                      tw = 14;
                      tf = 23;
                      r = 15;
                    }
                    break;
                  case 2:
                    {
                      h = 200;
                      b = 186;
                      tw = 14.5;
                      tf = 24;
                      r = 15;
                    }
                    break;
                  case 3:
                    {
                      h = 220;
                      b = 206;
                      tw = 15;
                      tf = 25;
                      r = 18;
                    }
                    break;
                  case 4:
                    {
                      h = 240;
                      b = 226;
                      tw = 15.5;
                      tf = 26;
                      r = 18;
                    }
                    break;
                  case 5:
                    {
                      h = 270;
                      b = 248;
                      tw = 18;
                      tf = 32;
                      r = 21;
                    }
                    break;
                  case 6:
                    {
                      h = 290;
                      b = 268;
                      tw = 18;
                      tf = 32.5;
                      r = 24;
                    }
                    break;
                  case 7:
                    {
                      h = 310;
                      b = 288;
                      tw = 18.5;
                      tf = 33;
                      r = 24;
                    }
                    break;
                  case 8:
                    {
                      h = 340;
                      b = 310;
                      tw = 21;
                      tf = 39;
                      r = 27;
                    }
                    break;
                  case 9:
                    {
                      h = 259;
                      b = 309;
                      tw = 21;
                      tf = 40;
                      r = 27;
                    }
                    break;
                  case 10:
                    {
                      h = 377;
                      b = 309;
                      tw = 21;
                      tf = 40;
                      r = 27;
                    }
                    break;
                  case 11:
                    {
                      h = 395;
                      b = 308;
                      tw = 21;
                      tf = 40;
                      r = 27;
                    }
                    break;
                  case 12:
                    {
                      h = 432;
                      b = 307;
                      tw = 21;
                      tf = 40;
                      r = 27;
                    }
                    break;
                  case 13:
                    {
                      h = 478;
                      b = 307;
                      tw = 21;
                      tf = 40;
                      r = 27;
                    }
                    break;
                  case 14:
                    {
                      h = 524;
                      b = 306;
                      tw = 21;
                      tf = 40;
                      r = 27;
                    }
                    break;
                  case 15:
                    {
                      h = 572;
                      b = 306;
                      tw = 21;
                      tf = 40;
                      r = 27;
                    }
                    break;
                  case 16:
                    {
                      h = 620;
                      b = 305;
                      tw = 21;
                      tf = 40;
                      r = 27;
                    }
                    break;
                  case 17:
                    {
                      h = 668;
                      b = 305;
                      tw = 21;
                      tf = 40;
                      r = 27;
                    }
                    break;
                  case 18:
                    {
                      h = 716;
                      b = 304;
                      tw = 21;
                      tf = 40;
                      r = 27;
                    }
                    break;
                  case 19:
                    {
                      h = 814;
                      b = 303;
                      tw = 21;
                      tf = 40;
                      r = 30;
                    }
                    break;
                }
                h = h / 2;
              }
            }
          }
          if (ipn == ("1/2ipn")) {
            _ComputeDetails(x_section, h, b, tw, tf, r, d1, r1, r2);
            value.add(H + pas + mm);
            value.add(B + pas + mm);
            value.add(Tw + pas + mm);
            value.add(Tf + pas + mm);
            value.add(R0 + pas + mm);
            value.add(Area + pas + cm2);
            value.add(IY + pas + cm4);
            value.add(WELY + pas + cm3);
            value.add(iY + pas + cm);
            value.add(IZ + pas + cm4);
            value.add(WELZ + pas + cm3);
            value.add(iZ + pas + cm);
            value.add(IT + pas + cm4);
            value.add(eY + pas + cm);
            value.add(G + pas + KNmm);
          } else {
            set_stringdetails();
            value.add(H + pas + mm);
            value.add(B + pas + mm);
            value.add(Tw + pas + mm);
            value.add(R1 + pas + mm);
            value.add(R2 + pas + mm);
            value.add(R3 + pas + mm);
            value.add(D + pas + mm);
            value.add(Area + pas + cm2);
            value.add(IY + pas + cm4);
            value.add(WELY + pas + cm3);
            value.add(iY + pas + cm);
            value.add(IZ + pas + cm4);
            value.add(WELZ + pas + cm3);
            value.add(iZ + pas + cm);
            value.add(eY + pas + cm);
            value.add(G + pas + KNmm);
          }
        }
        break;
      case "U_section":
        {
          bool ch = false;
          for (int i = 0; i < sectionName.UPn_section.length; i++) {
            String s = sectionName.UPn_section[i];
            if (selectedItem == (s)) {
              number = i;
              ch = true;
              switch (number) {
                case 0:
                  {
                    SetParameterUPN(50, 38, 5, 7, 3.5, 20, 7.12, 26.4, 10.6,
                        1.92, 9.12, 3.75, 1.13, 0, 1.37, 2.47, 1.1, 29.1);
                  }
                  break;
                case 1:
                  {
                    SetParameterUPN(65, 42, 5.5, 7.5, 4, 33, 9.03, 57.5, 17.7,
                        2.52, 14.1, 5.07, 1.25, 0, 1.42, 2.60, 1.57, 78.4);
                  }
                  break;
                case 2:
                  {
                    SetParameterUPN(80, 45, 6, 8, 4, 47, 11, 106, 26.5, 3.1,
                        19.4, 6.36, 1.33, 15.9, 1.45, 2.67, 2.16, 169);
                  }
                  break;
                case 3:
                  {
                    SetParameterUPN(100, 50, 6, 8.5, 4.5, 64, 13.5, 206, 41.2,
                        3.91, 29.3, 8.49, 1.47, 24.5, 1.55, 2.93, 2.81, 413);
                  }
                  break;
                case 4:
                  {
                    SetParameterUPN(120, 55, 7, 9, 4.5, 82, 17, 364, 60.7, 4.62,
                        43.2, 11.1, 1.59, 36.3, 1.6, 3.03, 4.15, 897);
                  }
                  break;
                case 5:
                  {
                    SetParameterUPN(140, 60, 7, 10, 5, 97, 20.4, 605, 86.4,
                        5.45, 62.7, 14.8, 1.75, 51.4, 1.75, 3.37, 5.72, 1792);
                  }
                  break;
                case 6:
                  {
                    SetParameterUPN(160, 65, 7.5, 10.5, 5.5, 116, 24, 925, 116,
                        6.21, 85.3, 18.3, 1.89, 68.8, 1.84, 3.56, 7.44, 3232);
                  }
                  break;
                case 7:
                  {
                    SetParameterUPN(180, 70, 8, 11, 5.5, 133, 28, 1350, 150,
                        6.95, 114, 22.4, 2.02, 89.6, 1.92, 3.75, 9.52, 5527);
                  }
                  break;
                case 8:
                  {
                    SetParameterUPN(200, 75, 8.5, 11.5, 6, 151, 32.2, 1910, 191,
                        7.7, 148, 27, 2.14, 114, 2.01, 3.94, 12, 8972);
                  }
                  break;
                case 9:
                  {
                    SetParameterUPN(220, 80, 90, 12.5, 6.5, 166, 37.4, 2690,
                        245, 8.48, 197, 33.6, 2.3, 146, 2.14, 4.2, 16.2, 14425);
                  }
                  break;
                case 10:
                  {
                    SetParameterUPN(240, 85, 9.5, 13, 6.5, 185, 42.3, 3600, 300,
                        9.22, 248, 39.6, 2.42, 179, 2.23, 4.39, 19.8, 21864);
                  }
                  break;
                case 11:
                  {
                    SetParameterUPN(260, 90, 10, 14, 7, 201, 48.3, 4820, 371,
                        9.99, 317, 47.7, 2.56, 221, 2.36, 4.66, 25.8, 32937);
                  }
                  break;
                case 12:
                  {
                    SetParameterUPN(280, 95, 10, 15, 7.5, 216, 53.3, 6280, 448,
                        10.9, 399, 57.2, 2.74, 266, 2.53, 5.02, 31.4, 47984);
                  }
                  break;
                case 13:
                  {
                    SetParameterUPN(300, 100, 10, 16, 8, 232, 58.8, 8030, 535,
                        11.7, 495, 67.8, 2.9, 316, 2.7, 5.41, 38, 68288);
                  }
                  break;
                case 14:
                  {
                    SetParameterUPN(
                        320,
                        100,
                        14,
                        17.5,
                        8.75,
                        247,
                        75.8,
                        10870,
                        679,
                        12.1,
                        597,
                        80.6,
                        2.81,
                        413,
                        2.6,
                        4.82,
                        68.1,
                        94232);
                  }
                  break;
                case 15:
                  {
                    SetParameterUPN(350, 100, 14, 16, 8, 283, 77.3, 12840, 734,
                        12.9, 570, 75, 2.72, 459, 2.4, 4.45, 62, 111550);
                  }
                  break;
                case 16:
                  {
                    SetParameterUPN(
                        380,
                        102,
                        13.5,
                        16,
                        8,
                        313,
                        80.4,
                        15760,
                        829,
                        14,
                        615,
                        78.7,
                        2.77,
                        507,
                        2.38,
                        4.58,
                        61.7,
                        143500);
                  }
                  break;
                case 17:
                  {
                    SetParameterUPN(400, 110, 14, 18, 9, 325, 91.5, 20350, 1020,
                        14.9, 846, 102, 3.04, 618, 2.65, 5.11, 83, 216980);
                  }
                  break;
              }
              i = sectionName.UPn_section.length;
              ipn = "UPN";
              this.g = 78.5 * A / 10000; //KN/mm
            }
          }
          if (!ch) {
            for (int i = 0; i < sectionName.UPe_section.length; i++) {
              if (selectedItem == (sectionName.UPe_section[i])) {
                number = i;
                ch = true;
                i = sectionName.UPe_section.length;
                switch (number) {
                  case 0:
                    {
                      SetParameterUPE(80, 50, 4, 7, 10);
                    }
                    break;
                  case 1:
                    {
                      SetParameterUPE(100, 55, 4.5, 7.5, 10);
                    }
                    break;
                  case 2:
                    {
                      SetParameterUPE(120, 60, 5, 8, 12);
                    }
                    break;
                  case 3:
                    {
                      SetParameterUPE(140, 65, 5, 9, 12);
                    }
                    break;
                  case 4:
                    {
                      SetParameterUPE(160, 70, 5.5, 9.5, 12);
                    }
                    break;
                  case 5:
                    {
                      SetParameterUPE(180, 75, 5.5, 10.5, 12);
                    }
                    break;
                  case 6:
                    {
                      SetParameterUPE(200, 80, 6, 11, 13);
                    }
                    break;
                  case 7:
                    {
                      SetParameterUPE(220, 85, 6.5, 12, 13);
                    }
                    break;
                  case 8:
                    {
                      SetParameterUPE(240, 90, 7, 12.5, 15);
                    }
                    break;
                  case 9:
                    {
                      SetParameterUPE(270, 95, 7.5, 13.5, 15);
                    }
                    break;
                  case 10:
                    {
                      SetParameterUPE(300, 100, 9.5, 15, 15);
                    }
                    break;
                  case 11:
                    {
                      SetParameterUPE(330, 105, 11, 16, 18);
                    }
                    break;
                  case 12:
                    {
                      SetParameterUPE(360, 110, 12, 17, 18);
                    }
                    break;
                  case 13:
                    {
                      SetParameterUPE(400, 115, 13.5, 18, 18);
                    }
                    break;
                }
                ipn = "UPE";
              }
            }
          }
          if (ipn == ("UPN")) {
            set_stringdetails();
            value.add(H + pas + mm);
            value.add(B + pas + mm);
            value.add(Tw + pas + mm);
            value.add(Tf + pas + mm);
            value.add(R2 + pas + mm);
            value.add(D + pas + mm);
            value.add(Area + pas + cm2);
            value.add(IY + pas + cm4);
            value.add(WELY + pas + cm3);
            value.add(iY + pas + cm);
            value.add(IZ + pas + cm4);
            value.add(WELZ + pas + cm3);
            value.add(iZ + pas + cm);
            value.add(sY + pas + cm3);
            value.add(eZ + pas + cm);
            value.add(YM + pas + cm);
            value.add(G + pas + KNmm);
            value.add(IT + pas + cm4);
            value.add(IW + pas + cm6);
          } else {
            _ComputeDetails(x_section, h, b, tw, tf, r, d1, r1, r2);
            value.add(H + pas + mm);
            value.add(B + pas + mm);
            value.add(Tw + pas + mm);
            value.add(Tf + pas + mm);
            value.add(R0 + pas + mm);
            value.add(D + pas + mm);
            value.add(Area + pas + cm2);
            value.add(IY + pas + cm4);
            value.add(WELY + pas + cm3);
            value.add(iY + pas + cm);
            value.add(IZ + pas + cm4);
            value.add(WELZ + pas + cm3);
            value.add(iZ + pas + cm);
            value.add(sY + pas + cm3);
            value.add(eZ + pas + cm);
            value.add(YM + pas + cm);
            value.add(G + pas + KNmm);
            value.add(IT + pas + cm4);
            value.add(IW + pas + cm6);
          }
        }
        break;
      case "Z_section":
        {
          bool ch = false;
          for (int i = 0; i < sectionName.z_section.length; i++) {
            String s = sectionName.z_section[i];
            if (selectedItem == (s)) {
              number = i;
              ch = true;
              switch (number) {
                case 0:
                  {
                    SetParameterZ(
                        30,
                        21,
                        38,
                        4,
                        4.5,
                        2.5,
                        4.32,
                        5.96,
                        3.97,
                        1.17,
                        13.7,
                        3.80,
                        1.78,
                        18.1,
                        4.69,
                        12.04,
                        1.54,
                        1.11,
                        0.60,
                        1.655);
                  }
                  break;
                case 1:
                  {
                    SetParameterZ(
                        40,
                        30,
                        40,
                        4.5,
                        5,
                        2.5,
                        5.43,
                        13.5,
                        6.75,
                        1.58,
                        17.6,
                        4.66,
                        180,
                        28.0,
                        2.72,
                        2.27,
                        3.05,
                        1.83,
                        0.75,
                        1.181);
                  }
                  break;
                case 2:
                  {
                    SetParameterZ(
                        50,
                        39,
                        43,
                        5,
                        5.5,
                        3,
                        6.77,
                        26.3,
                        10.5,
                        1.97,
                        23.8,
                        5.88,
                        1.88,
                        44.9,
                        9.76,
                        2.57,
                        5.23,
                        2.76,
                        0.88,
                        0.939);
                  }
                  break;
                case 3:
                  {
                    SetParameterZ(
                        60,
                        48,
                        45,
                        5,
                        6,
                        3,
                        7.91,
                        44.7,
                        14.9,
                        2.38,
                        30.1,
                        7.09,
                        1.95,
                        67.2,
                        13.5,
                        2.81,
                        7.6,
                        3.73,
                        .98,
                        .779);
                  }
                  break;
                case 4:
                  {
                    SetParameterZ(
                        80,
                        66,
                        50,
                        6,
                        7,
                        3.5,
                        11.1,
                        109,
                        27.3,
                        3.13,
                        47.4,
                        10.1,
                        2.07,
                        142,
                        24.4,
                        3.58,
                        14.7,
                        6.44,
                        1.15,
                        0.588);
                  }
                  break;
                case 5:
                  {
                    SetParameterZ(
                        100,
                        84,
                        55,
                        6.5,
                        8,
                        4,
                        14.5,
                        222,
                        44.4,
                        3.91,
                        72.5,
                        14.0,
                        2.24,
                        270,
                        39.8,
                        4.31,
                        24.6,
                        9.26,
                        1.30,
                        0.492);
                  }
                  break;
                case 6:
                  {
                    SetParameterZ(
                        120,
                        102,
                        60,
                        7,
                        9,
                        4.5,
                        18.2,
                        402,
                        67.0,
                        4.70,
                        106,
                        18.8,
                        2.42,
                        470,
                        60.6,
                        5.08,
                        37.7,
                        12.5,
                        1.44,
                        0.433);
                  }
                  break;
                case 7:
                  {
                    SetParameterZ(
                        140,
                        120,
                        65,
                        8,
                        10,
                        5,
                        22.9,
                        676,
                        96.6,
                        5.43,
                        148,
                        24.3,
                        2.54,
                        768,
                        88.0,
                        5.79,
                        56.4,
                        16.6,
                        1.57,
                        0.385);
                  }
                  break;
                case 8:
                  {
                    SetParameterZ(
                        160,
                        138,
                        70,
                        8.5,
                        11,
                        5.5,
                        27.5,
                        1060,
                        132,
                        6.20,
                        204,
                        31.0,
                        2.72,
                        1180,
                        121,
                        6.57,
                        79.5,
                        21.4,
                        1.70,
                        0.357);
                  }
                  break;
              }
              i = sectionName.z_section.length;
              ipn = "Z";
              this.g = 78.5 * A / 10000; //KN/mm
            }
          }
          set_stringdetails();
          value.add(H + pas + mm);
          value.add(H1 + pas + mm);
          value.add(B + pas + mm);
          value.add(Tw + pas + mm);
          value.add(Tf + pas + mm);
          value.add(R2 + pas + mm);
          value.add(G + pas + KNmm);
          value.add(Area + pas + cm2);
          value.add(IY + pas + cm4);
          value.add(WELY + pas + cm3);
          value.add(iY + pas + cm);
          value.add(IZ + pas + cm4);
          value.add(WELZ + pas + cm3);
          value.add(iZ + pas + cm);
          value.add(IN + pas + cm4);
          value.add(WELN + pas + cm3);
          value.add(iN + pas + cm);
          value.add(IZeta + pas + cm4);
          value.add(WELZeta + pas + cm3);
          value.add(iZeta + pas + cm);
          value.add(TANalfa + pas + KNmm);
        }
        break;
      case "L_section":
        {
          bool ch = false;
          for (int i = 0; i < sectionName.glL_section.length; i++) {
            String s = sectionName.glL_section[i];
            if (selectedItem == (s)) {
              number = i;
              ch = true;
              switch (number) {
                case 0:
                  {
                    SetParameterLequal(40, 4, 6);
                  }
                  break;
                case 1:
                  {
                    SetParameterLequal(40, 5, 6);
                  }
                  break;
                case 2:
                  {
                    SetParameterLequal(45, 4.5, 7);
                  }
                  break;
                case 3:
                  {
                    SetParameterLequal(50, 4, 7);
                  }
                  break;
                case 4:
                  {
                    SetParameterLequal(50, 5, 7);
                  }
                  break;
                case 5:
                  {
                    SetParameterLequal(50, 6, 7);
                  }
                  break;
                case 6:
                  {
                    SetParameterLequal(60, 5, 8);
                  }
                  break;
                case 7:
                  {
                    SetParameterLequal(60, 6, 8);
                  }
                  break;
                case 8:
                  {
                    SetParameterLequal(60, 8, 8);
                  }
                  break;
                case 9:
                  {
                    SetParameterLequal(65, 7, 9);
                  }
                  break;
                case 10:
                  {
                    SetParameterLequal(70, 6, 9);
                  }
                  break;
                case 11:
                  {
                    SetParameterLequal(70, 7, 9);
                  }
                  break;
                case 12:
                  {
                    SetParameterLequal(75, 6, 9);
                  }
                  break;
                case 13:
                  {
                    SetParameterLequal(75, 8, 9);
                  }
                  break;
                case 14:
                  {
                    SetParameterLequal(80, 8, 10);
                  }
                  break;
                case 15:
                  {
                    SetParameterLequal(80, 10, 10);
                  }
                  break;
                case 16:
                  {
                    SetParameterLequal(90, 7, 11);
                  }
                  break;
                case 17:
                  {
                    SetParameterLequal(90, 8, 11);
                  }
                  break;
                case 18:
                  {
                    SetParameterLequal(90, 9, 11);
                  }
                  break;
                case 19:
                  {
                    SetParameterLequal(90, 10, 11);
                  }
                  break;
                case 20:
                  {
                    SetParameterLequal(100, 8, 12);
                  }
                  break;
                case 21:
                  {
                    SetParameterLequal(100, 10, 12);
                  }
                  break;
                case 22:
                  {
                    SetParameterLequal(100, 12, 12);
                  }
                  break;
                case 23:
                  {
                    SetParameterLequal(120, 10, 13);
                  }
                  break;
                case 24:
                  {
                    SetParameterLequal(120, 12, 13);
                  }
                  break;
                case 25:
                  {
                    SetParameterLequal(130, 12, 14);
                  }
                  break;
                case 26:
                  {
                    SetParameterLequal(150, 10, 16);
                  }
                  break;
                case 27:
                  {
                    SetParameterLequal(150, 12, 16);
                  }
                  break;
                case 28:
                  {
                    SetParameterLequal(150, 15, 16);
                  }
                  break;
                case 29:
                  {
                    SetParameterLequal(160, 15, 17);
                  }
                  break;
                case 30:
                  {
                    SetParameterLequal(180, 16, 18);
                  }
                  break;
                case 31:
                  {
                    SetParameterLequal(180, 18, 18);
                  }
                  break;
                case 32:
                  {
                    SetParameterLequal(200, 16, 18);
                  }
                  break;
                case 33:
                  {
                    SetParameterLequal(200, 18, 18);
                  }
                  break;
                case 34:
                  {
                    SetParameterLequal(200, 20, 18);
                  }
                  break;
                case 35:
                  {
                    SetParameterLequal(200, 24, 18);
                  }
                  break;
                case 36:
                  {
                    SetParameterLequal(250, 17, 18);
                  }
                  break;
                case 37:
                  {
                    SetParameterLequal(250, 20, 18);
                  }
                  break;
                case 38:
                  {
                    SetParameterLequal(250, 28, 18);
                  }
                  break;
                case 39:
                  {
                    SetParameterLequal(250, 35, 18);
                  }
                  break;
                case 40:
                  {
                    SetParameterLequal(300, 25, 18);
                  }
                  break;
                case 41:
                  {
                    SetParameterLequal(300, 28, 18);
                  }
                  break;
                case 42:
                  {
                    SetParameterLequal(300, 31, 18);
                  }
                  break;
                case 43:
                  {
                    SetParameterLequal(300, 35, 18);
                  }
                  break;
              }
              i = sectionName.glL_section.length;
              ipn = "equal";
            }
          }
          if (!ch) {
            for (int i = 0; i < sectionName.unglL_section.length; i++) {
              String s = sectionName.unglL_section[i];
              if (selectedItem == (s)) {
                number = i;
                ch = true;
                switch (number) {
                  case 0:
                    {
                      SetParameterLUnequal(40, 20, 4, 4);
                    }
                    break;
                  case 1:
                    {
                      SetParameterLUnequal(40, 25, 4, 4);
                    }
                    break;
                  case 2:
                    {
                      SetParameterLUnequal(45, 30, 4, 4.5);
                    }
                    break;
                  case 3:
                    {
                      SetParameterLUnequal(50, 30, 5, 5);
                    }
                    break;
                  case 4:
                    {
                      SetParameterLUnequal(60, 30, 5, 5);
                    }
                    break;
                  case 5:
                    {
                      SetParameterLUnequal(60, 40, 5, 6);
                    }
                    break;
                  case 6:
                    {
                      SetParameterLUnequal(60, 40, 6, 6);
                    }
                    break;
                  case 7:
                    {
                      SetParameterLUnequal(65, 50, 5, 6);
                    }
                    break;
                  case 8:
                    {
                      SetParameterLUnequal(70, 50, 6, 7);
                    }
                    break;
                  case 9:
                    {
                      SetParameterLUnequal(75, 50, 6, 7);
                    }
                    break;
                  case 10:
                    {
                      SetParameterLUnequal(75, 70, 8, 7);
                    }
                    break;
                  case 11:
                    {
                      SetParameterLUnequal(80, 40, 6, 7);
                    }
                    break;
                  case 12:
                    {
                      SetParameterLUnequal(80, 40, 8, 7);
                    }
                    break;
                  case 13:
                    {
                      SetParameterLUnequal(80, 60, 7, 8);
                    }
                    break;
                  case 14:
                    {
                      SetParameterLUnequal(100, 50, 6, 8);
                    }
                    break;
                  case 15:
                    {
                      SetParameterLUnequal(100, 50, 8, 8);
                    }
                    break;
                  case 16:
                    {
                      SetParameterLUnequal(100, 65, 7, 10);
                    }
                    break;
                  case 17:
                    {
                      SetParameterLUnequal(100, 65, 8, 10);
                    }
                    break;
                  case 18:
                    {
                      SetParameterLUnequal(100, 65, 10, 10);
                    }
                    break;
                  case 19:
                    {
                      SetParameterLUnequal(100, 75, 8, 10);
                    }
                    break;
                  case 20:
                    {
                      SetParameterLUnequal(100, 75, 10, 10);
                    }
                    break;
                  case 21:
                    {
                      SetParameterLUnequal(100, 75, 12, 10);
                    }
                    break;
                  case 22:
                    {
                      SetParameterLUnequal(120, 80, 8, 11);
                    }
                    break;
                  case 23:
                    {
                      SetParameterLUnequal(120, 80, 10, 11);
                    }
                    break;
                  case 24:
                    {
                      SetParameterLUnequal(120, 80, 12, 11);
                    }
                    break;
                  case 25:
                    {
                      SetParameterLUnequal(125, 75, 8, 11);
                    }
                    break;
                  case 26:
                    {
                      SetParameterLUnequal(125, 75, 10, 11);
                    }
                    break;
                  case 27:
                    {
                      SetParameterLUnequal(125, 75, 12, 11);
                    }
                    break;
                  case 28:
                    {
                      SetParameterLUnequal(135, 65, 8, 11);
                    }
                    break;
                  case 29:
                    {
                      SetParameterLUnequal(135, 65, 10, 11);
                    }
                    break;
                  case 30:
                    {
                      SetParameterLUnequal(150, 75, 9, 12);
                    }
                    break;
                  case 31:
                    {
                      SetParameterLUnequal(150, 75, 10, 12);
                    }
                    break;
                  case 32:
                    {
                      SetParameterLUnequal(150, 75, 12, 12);
                    }
                    break;
                  case 33:
                    {
                      SetParameterLUnequal(150, 75, 15, 12);
                    }
                    break;
                  case 34:
                    {
                      SetParameterLUnequal(150, 90, 10, 12);
                    }
                    break;
                  case 35:
                    {
                      SetParameterLUnequal(150, 90, 12, 12);
                    }
                    break;
                  case 36:
                    {
                      SetParameterLUnequal(150, 90, 15, 12);
                    }
                    break;
                  case 37:
                    {
                      SetParameterLUnequal(150, 100, 10, 12);
                    }
                    break;
                  case 38:
                    {
                      SetParameterLUnequal(150, 100, 12, 12);
                    }
                    break;
                  case 39:
                    {
                      SetParameterLUnequal(200, 100, 10, 15);
                    }
                    break;
                  case 40:
                    {
                      SetParameterLUnequal(200, 100, 12, 15);
                    }
                    break;
                  case 41:
                    {
                      SetParameterLUnequal(200, 100, 15, 15);
                    }
                    break;
                  case 42:
                    {
                      SetParameterLUnequal(200, 150, 12, 15);
                    }
                    break;
                  case 43:
                    {
                      SetParameterLUnequal(200, 150, 15, 15);
                    }
                    break;
                }
                i = sectionName.unglL_section.length;
                ipn = "unequal";
              }
            }
          }
          if (h == b) {
            _ComputeDetails(x_section, h, b, tw, tf, 0, 0, r1, r2);
            value.add(B + pas + mm);
            value.add(Tw + pas + mm);
            value.add(R1 + pas + mm);
            value.add(E + pas + cm);
            value.add(W + pas + cm);
            value.add(V1 + pas + cm);
            value.add(V2 + pas + cm);
            value.add(Area + pas + cm2);
            value.add(IY + pas + cm4);
            value.add(WELY + pas + cm3);
            value.add(iY + pas + cm);
            value.add(IN + pas + cm4);
            value.add(iN + pas + cm);
            value.add(IZeta + pas + cm4);
            value.add(iZeta + pas + cm);
            value.add(G + pas + KNmm);
          } else {
            ipn = "unequal";
            _ComputeDetails(x_section, h, b, tw, tf, 0, 0, r1, r2);
            value.add(H + pas + mm);
            value.add(B + pas + mm);
            value.add(Tw + pas + mm);
            value.add(R1 + pas + mm);
            value.add(R2 + pas + mm);
            value.add(eY + pas + cm);
            value.add(eZ + pas + cm);
            value.add(W1 + pas + cm);
            value.add(W2 + pas + cm);
            value.add(V1 + pas + cm);
            value.add(V2 + pas + cm);
            value.add(V3 + pas + cm);
            value.add(TANalfa + pas);
            value.add(G + pas + KNmm);
            value.add(Area + pas + cm2);
            value.add(IY + pas + cm4);
            value.add(WELY + pas + cm3);
            value.add(iY + pas + cm);
            value.add(IZ + pas + cm4);
            value.add(WELZ + pas + cm3);
            value.add(iZ + pas + cm);
            value.add(IN + pas + cm4);
            value.add(iN + pas + cm);
            value.add(IZeta + pas + cm4);
            value.add(iZeta + pas + cm);
          }
        }
        break;
      case "circle_section":
        {
          bool ch = false;
          for (int i = 0; i < sectionName.Circle_section.length; i++) {
            String s = sectionName.Circle_section[i];
            if (selectedItem == (s)) {
              number = i;
              ch = true;
              switch (number) {
                case 0:
                  {
                    SetParameterCircl(33.7, 2.5);
                  }
                  break;
                case 1:
                  {
                    SetParameterCircl(33.7, 4);
                  }
                  break;
                case 2:
                  {
                    SetParameterCircl(42.4, 2.5);
                  }
                  break;
                case 3:
                  {
                    SetParameterCircl(42.4, 4);
                  }
                  break;
                case 4:
                  {
                    SetParameterCircl(48.3, 2.5);
                  }
                  break;
                case 5:
                  {
                    SetParameterCircl(48.3, 4);
                  }
                  break;
                case 6:
                  {
                    SetParameterCircl(48.3, 5);
                  }
                  break;
                case 7:
                  {
                    SetParameterCircl(60.3, 2.5);
                  }
                  break;
                case 8:
                  {
                    SetParameterCircl(60.3, 4);
                  }
                  break;
                case 9:
                  {
                    SetParameterCircl(60.3, 5);
                  }
                  break;
                case 10:
                  {
                    SetParameterCircl(76.1, 2.5);
                  }
                  break;
                case 11:
                  {
                    SetParameterCircl(76.1, 4);
                  }
                  break;
                case 12:
                  {
                    SetParameterCircl(76.1, 5);
                  }
                  break;
                case 13:
                  {
                    SetParameterCircl(88.9, 3);
                  }
                  break;
                case 14:
                  {
                    SetParameterCircl(88.9, 5);
                  }
                  break;
                case 15:
                  {
                    SetParameterCircl(88.9, 6.3);
                  }
                  break;
                case 16:
                  {
                    SetParameterCircl(101.6, 4);
                  }
                  break;
                case 17:
                  {
                    SetParameterCircl(101.6, 6.3);
                  }
                  break;
                case 18:
                  {
                    SetParameterCircl(101.6, 8);
                  }
                  break;
                case 19:
                  {
                    SetParameterCircl(101.6, 10);
                  }
                  break;
                case 20:
                  {
                    SetParameterCircl(114.3, 4);
                  }
                  break;
                case 21:
                  {
                    SetParameterCircl(114.3, 6.3);
                  }
                  break;
                case 22:
                  {
                    SetParameterCircl(114.3, 8);
                  }
                  break;
                case 23:
                  {
                    SetParameterCircl(114.3, 10);
                  }
                  break;
                case 24:
                  {
                    SetParameterCircl(139.7, 4);
                  }
                  break;
                case 25:
                  {
                    SetParameterCircl(139.7, 6.3);
                  }
                  break;
                case 26:
                  {
                    SetParameterCircl(139.7, 8);
                  }
                  break;
                case 27:
                  {
                    SetParameterCircl(139.7, 12.5);
                  }
                  break;
                case 28:
                  {
                    SetParameterCircl(168.3, 4);
                  }
                  break;
                case 29:
                  {
                    SetParameterCircl(168.3, 8);
                  }
                  break;
                case 30:
                  {
                    SetParameterCircl(168.3, 10);
                  }
                  break;
                case 31:
                  {
                    SetParameterCircl(168.3, 12.5);
                  }
                  break;
                case 32:
                  {
                    SetParameterCircl(177.8, 5);
                  }
                  break;
                case 33:
                  {
                    SetParameterCircl(177.8, 8);
                  }
                  break;
                case 34:
                  {
                    SetParameterCircl(177.8, 10);
                  }
                  break;
                case 35:
                  {
                    SetParameterCircl(177.8, 12.5);
                  }
                  break;
                case 36:
                  {
                    SetParameterCircl(177.8, 16);
                  }
                  break;
                case 37:
                  {
                    SetParameterCircl(193.7, 6.3);
                  }
                  break;
                case 38:
                  {
                    SetParameterCircl(219.1, 6.3);
                  }
                  break;
                case 39:
                  {
                    SetParameterCircl(219.1, 10);
                  }
                  break;
                case 40:
                  {
                    SetParameterCircl(219.1, 12.5);
                  }
                  break;
                case 41:
                  {
                    SetParameterCircl(219.1, 20);
                  }
                  break;
              }
              i = sectionName.Circle_section.length;
              ipn = "circle";
            }
          }
          _ComputeDetails(x_section, h, b, tw, tf, 0, 0, r1, r2);
          value.add(B + " x " + T + pas + mm);
          value.add(Area + pas + cm2);
          value.add(IY + pas + cm4);
          value.add(iY + pas + cm);
          value.add(WELY + pas + cm3);
          value.add(WPLY + pas + cm3);
          value.add(IT + pas + cm3);
          value.add(WT + pas + cm3);
          value.add(G + pas + KNmm);
        }
        break;
      case "HolwRec_section":
        {
          bool ch = false;
          for (int i = 0; i < sectionName.Wsquare_section.length; i++) {
            String s = sectionName.Wsquare_section[i];
            if (selectedItem == (s)) {
              number = i;
              ch = true;
              switch (number) {
                case 0:
                  {
                    SetParameterWSquar(40, 4);
                  }
                  break;
                case 1:
                  {
                    SetParameterWSquar(40, 5);
                  }
                  break;
                case 2:
                  {
                    SetParameterWSquar(50, 4);
                  }
                  break;
                case 3:
                  {
                    SetParameterWSquar(50, 5);
                  }
                  break;
                case 4:
                  {
                    SetParameterWSquar(50, 6.3);
                  }
                  break;
                case 5:
                  {
                    SetParameterWSquar(60, 4);
                  }
                  break;
                case 6:
                  {
                    SetParameterWSquar(60, 5);
                  }
                  break;
                case 7:
                  {
                    SetParameterWSquar(60, 6.3);
                  }
                  break;
                case 8:
                  {
                    SetParameterWSquar(60, 8);
                  }
                  break;
                case 9:
                  {
                    SetParameterWSquar(70, 4);
                  }
                  break;
                case 10:
                  {
                    SetParameterWSquar(70, 5);
                  }
                  break;
                case 11:
                  {
                    SetParameterWSquar(70, 6.3);
                  }
                  break;
                case 12:
                  {
                    SetParameterWSquar(70, 8);
                  }
                  break;
                case 13:
                  {
                    SetParameterWSquar(80, 4);
                  }
                  break;
                case 14:
                  {
                    SetParameterWSquar(80, 5);
                  }
                  break;
                case 15:
                  {
                    SetParameterWSquar(80, 6.3);
                  }
                  break;
                case 16:
                  {
                    SetParameterWSquar(80, 8);
                  }
                  break;
                case 17:
                  {
                    SetParameterWSquar(90, 4);
                  }
                  break;
                case 18:
                  {
                    SetParameterWSquar(90, 5);
                  }
                  break;
                case 19:
                  {
                    SetParameterWSquar(90, 6.3);
                  }
                  break;
                case 20:
                  {
                    SetParameterWSquar(90, 8);
                  }
                  break;
                case 21:
                  {
                    SetParameterWSquar(100, 4);
                  }
                  break;
                case 22:
                  {
                    SetParameterWSquar(100, 5);
                  }
                  break;
                case 23:
                  {
                    SetParameterWSquar(100, 6.3);
                  }
                  break;
                case 24:
                  {
                    SetParameterWSquar(100, 8);
                  }
                  break;
                case 25:
                  {
                    SetParameterWSquar(100, 10);
                  }
                  break;
                case 26:
                  {
                    SetParameterWSquar(120, 5);
                  }
                  break;
                case 27:
                  {
                    SetParameterWSquar(120, 6.3);
                  }
                  break;
                case 28:
                  {
                    SetParameterWSquar(120, 8);
                  }
                  break;
                case 29:
                  {
                    SetParameterWSquar(120, 10);
                  }
                  break;
                case 30:
                  {
                    SetParameterWSquar(120, 12.5);
                  }
                  break;
                case 31:
                  {
                    SetParameterWSquar(140, 5);
                  }
                  break;
                case 32:
                  {
                    SetParameterWSquar(140, 6.3);
                  }
                  break;
                case 33:
                  {
                    SetParameterWSquar(140, 8);
                  }
                  break;
                case 34:
                  {
                    SetParameterWSquar(140, 10);
                  }
                  break;
                case 35:
                  {
                    SetParameterWSquar(140, 12.5);
                  }
                  break;
                case 36:
                  {
                    SetParameterWSquar(150, 6.3);
                  }
                  break;
                case 37:
                  {
                    SetParameterWSquar(150, 8);
                  }
                  break;
                case 38:
                  {
                    SetParameterWSquar(150, 10);
                  }
                  break;
                case 39:
                  {
                    SetParameterWSquar(150, 12.5);
                  }
                  break;
                case 40:
                  {
                    SetParameterWSquar(150, 16);
                  }
                  break;
                case 41:
                  {
                    SetParameterWSquar(160, 6.3);
                  }
                  break;
                case 42:
                  {
                    SetParameterWSquar(160, 8);
                  }
                  break;
                case 43:
                  {
                    SetParameterWSquar(160, 10);
                  }
                  break;
                case 44:
                  {
                    SetParameterWSquar(160, 12.5);
                  }
                  break;
                case 45:
                  {
                    SetParameterWSquar(180, 16);
                  }
                  break;
                case 46:
                  {
                    SetParameterWSquar(180, 6.3);
                  }
                  break;
                case 47:
                  {
                    SetParameterWSquar(180, 8);
                  }
                  break;
                case 48:
                  {
                    SetParameterWSquar(180, 10);
                  }
                  break;
                case 49:
                  {
                    SetParameterWSquar(180, 12.5);
                  }
                  break;
                case 50:
                  {
                    SetParameterWSquar(180, 16);
                  }
                  break;
                case 51:
                  {
                    SetParameterWSquar(200, 6.3);
                  }
                  break;
                case 52:
                  {
                    SetParameterWSquar(200, 8);
                  }
                  break;
                case 53:
                  {
                    SetParameterWSquar(200, 10);
                  }
                  break;
                case 54:
                  {
                    SetParameterWSquar(200, 12.5);
                  }
                  break;
                case 55:
                  {
                    SetParameterWSquar(200, 16);
                  }
                  break;
                case 56:
                  {
                    SetParameterWSquar(220, 6.3);
                  }
                  break;
                case 57:
                  {
                    SetParameterWSquar(220, 8);
                  }
                  break;
                case 58:
                  {
                    SetParameterWSquar(220, 10);
                  }
                  break;
                case 59:
                  {
                    SetParameterWSquar(220, 12.5);
                  }
                  break;
                case 60:
                  {
                    SetParameterWSquar(220, 16);
                  }
                  break;
                case 61:
                  {
                    SetParameterWSquar(250, 6.3);
                  }
                  break;
                case 62:
                  {
                    SetParameterWSquar(250, 8);
                  }
                  break;
                case 63:
                  {
                    SetParameterWSquar(250, 10);
                  }
                  break;
                case 64:
                  {
                    SetParameterWSquar(250, 12.5);
                  }
                  break;
                case 65:
                  {
                    SetParameterWSquar(250, 16);
                  }
                  break;
                case 66:
                  {
                    SetParameterWSquar(260, 6.3);
                  }
                  break;
                case 67:
                  {
                    SetParameterWSquar(260, 8);
                  }
                  break;
                case 68:
                  {
                    SetParameterWSquar(260, 10);
                  }
                  break;
                case 69:
                  {
                    SetParameterWSquar(260, 12.5);
                  }
                  break;
                case 70:
                  {
                    SetParameterWSquar(260, 16);
                  }
                  break;
                case 71:
                  {
                    SetParameterWSquar(300, 6.3);
                  }
                  break;
                case 72:
                  {
                    SetParameterWSquar(300, 8);
                  }
                  break;
                case 73:
                  {
                    SetParameterWSquar(300, 10);
                  }
                  break;
                case 74:
                  {
                    SetParameterWSquar(300, 12.5);
                  }
                  break;
                case 75:
                  {
                    SetParameterWSquar(300, 16);
                  }
                  break;
                case 76:
                  {
                    SetParameterWSquar(350, 8);
                  }
                  break;
                case 77:
                  {
                    SetParameterWSquar(350, 10);
                  }
                  break;
                case 78:
                  {
                    SetParameterWSquar(350, 12.5);
                  }
                  break;
                case 79:
                  {
                    SetParameterWSquar(350, 16);
                  }
                  break;
                case 80:
                  {
                    SetParameterWSquar(400, 10);
                  }
                  break;
                case 81:
                  {
                    SetParameterWSquar(400, 12.5);
                  }
                  break;
                case 82:
                  {
                    SetParameterWSquar(400, 16);
                  }
                  break;
                case 83:
                  {
                    SetParameterWSquar(400, 20);
                  }
                  break;
              }
              i = sectionName.Wsquare_section.length;
              ipn = "square";
            }
          }
          if (!ch) {
            for (int i = 0; i < sectionName.Ksquare_section.length; i++) {
              String s = sectionName.Ksquare_section[i];
              if (selectedItem == (s)) {
                number = i;
                ch = true;
                switch (number) {
                  case 0:
                    {
                      SetParameterKSquar(30, 2.5);
                    }
                    break;
                  case 1:
                    {
                      SetParameterKSquar(40, 3);
                    }
                    break;
                  case 2:
                    {
                      SetParameterKSquar(40, 4);
                    }
                    break;
                  case 3:
                    {
                      SetParameterKSquar(50, 3);
                    }
                    break;
                  case 4:
                    {
                      SetParameterKSquar(50, 4);
                    }
                    break;
                  case 5:
                    {
                      SetParameterKSquar(50, 5);
                    }
                    break;
                  case 6:
                    {
                      SetParameterKSquar(60, 3);
                    }
                    break;
                  case 7:
                    {
                      SetParameterKSquar(60, 4);
                    }
                    break;
                  case 8:
                    {
                      SetParameterKSquar(60, 5);
                    }
                    break;
                  case 9:
                    {
                      SetParameterKSquar(60, 6.3);
                    }
                    break;
                  case 10:
                    {
                      SetParameterKSquar(70, 3);
                    }
                    break;
                  case 11:
                    {
                      SetParameterKSquar(70, 4);
                    }
                    break;
                  case 12:
                    {
                      SetParameterKSquar(70, 5);
                    }
                    break;
                  case 13:
                    {
                      SetParameterKSquar(70, 6.3);
                    }
                    break;
                  case 14:
                    {
                      SetParameterKSquar(80, 4);
                    }
                    break;
                  case 15:
                    {
                      SetParameterKSquar(80, 5);
                    }
                    break;
                  case 16:
                    {
                      SetParameterKSquar(80, 6.3);
                    }
                    break;
                  case 17:
                    {
                      SetParameterKSquar(80, 8);
                    }
                    break;
                  case 18:
                    {
                      SetParameterKSquar(90, 4);
                    }
                    break;
                  case 19:
                    {
                      SetParameterKSquar(90, 5);
                    }
                    break;
                  case 20:
                    {
                      SetParameterKSquar(90, 6.3);
                    }
                    break;
                  case 21:
                    {
                      SetParameterKSquar(90, 8);
                    }
                    break;
                  case 22:
                    {
                      SetParameterKSquar(100, 5);
                    }
                    break;
                  case 23:
                    {
                      SetParameterKSquar(100, 6.3);
                    }
                    break;
                  case 24:
                    {
                      SetParameterKSquar(100, 8);
                    }
                    break;
                  case 25:
                    {
                      SetParameterKSquar(100, 10);
                    }
                    break;
                  case 26:
                    {
                      SetParameterKSquar(100, 12.5);
                    }
                    break;
                  case 27:
                    {
                      SetParameterKSquar(120, 5);
                    }
                    break;
                  case 28:
                    {
                      SetParameterKSquar(120, 6.3);
                    }
                    break;
                  case 29:
                    {
                      SetParameterKSquar(120, 8);
                    }
                    break;
                  case 30:
                    {
                      SetParameterKSquar(120, 10);
                    }
                    break;
                  case 31:
                    {
                      SetParameterKSquar(120, 12.5);
                    }
                    break;
                  case 32:
                    {
                      SetParameterKSquar(140, 5);
                    }
                    break;
                  case 33:
                    {
                      SetParameterKSquar(140, 6.3);
                    }
                    break;
                  case 34:
                    {
                      SetParameterKSquar(140, 8);
                    }
                    break;
                  case 35:
                    {
                      SetParameterKSquar(140, 10);
                    }
                    break;
                  case 36:
                    {
                      SetParameterKSquar(140, 12.5);
                    }
                    break;
                  case 37:
                    {
                      SetParameterKSquar(150, 5);
                    }
                    break;
                  case 38:
                    {
                      SetParameterKSquar(150, 6.3);
                    }
                    break;
                  case 39:
                    {
                      SetParameterKSquar(150, 8);
                    }
                    break;
                  case 40:
                    {
                      SetParameterKSquar(150, 10);
                    }
                    break;
                  case 41:
                    {
                      SetParameterKSquar(150, 12.5);
                    }
                    break;
                  case 42:
                    {
                      SetParameterKSquar(150, 16);
                    }
                    break;
                  case 43:
                    {
                      SetParameterKSquar(160, 5);
                    }
                    break;
                  case 44:
                    {
                      SetParameterKSquar(160, 6.3);
                    }
                    break;
                  case 45:
                    {
                      SetParameterKSquar(160, 8);
                    }
                    break;
                  case 46:
                    {
                      SetParameterKSquar(160, 10);
                    }
                    break;
                  case 47:
                    {
                      SetParameterKSquar(160, 12.5);
                    }
                    break;
                  case 48:
                    {
                      SetParameterKSquar(160, 16);
                    }
                    break;
                  case 49:
                    {
                      SetParameterKSquar(180, 6.3);
                    }
                    break;
                  case 50:
                    {
                      SetParameterKSquar(180, 8);
                    }
                    break;
                  case 51:
                    {
                      SetParameterKSquar(180, 10);
                    }
                    break;
                  case 52:
                    {
                      SetParameterKSquar(180, 12.5);
                    }
                    break;
                  case 53:
                    {
                      SetParameterKSquar(180, 16);
                    }
                    break;
                  case 54:
                    {
                      SetParameterKSquar(200, 6.3);
                    }
                    break;
                  case 55:
                    {
                      SetParameterKSquar(200, 8);
                    }
                    break;
                  case 56:
                    {
                      SetParameterKSquar(200, 10);
                    }
                    break;
                  case 57:
                    {
                      SetParameterKSquar(200, 12.5);
                    }
                    break;
                  case 58:
                    {
                      SetParameterKSquar(200, 16);
                    }
                    break;
                  case 59:
                    {
                      SetParameterKSquar(220, 6.3);
                    }
                    break;
                  case 60:
                    {
                      SetParameterKSquar(220, 8);
                    }
                    break;
                  case 61:
                    {
                      SetParameterKSquar(220, 10);
                    }
                    break;
                  case 62:
                    {
                      SetParameterKSquar(220, 12.5);
                    }
                    break;
                  case 63:
                    {
                      SetParameterKSquar(220, 16);
                    }
                    break;
                  case 64:
                    {
                      SetParameterKSquar(250, 6.3);
                    }
                    break;
                  case 65:
                    {
                      SetParameterKSquar(250, 8);
                    }
                    break;
                  case 66:
                    {
                      SetParameterKSquar(250, 10);
                    }
                    break;
                  case 67:
                    {
                      SetParameterKSquar(250, 12.5);
                    }
                    break;
                  case 68:
                    {
                      SetParameterKSquar(250, 16);
                    }
                    break;
                  case 69:
                    {
                      SetParameterKSquar(260, 6.3);
                    }
                    break;
                  case 70:
                    {
                      SetParameterKSquar(260, 8);
                    }
                    break;
                  case 71:
                    {
                      SetParameterKSquar(260, 10);
                    }
                    break;
                  case 72:
                    {
                      SetParameterKSquar(260, 12.5);
                    }
                    break;
                  case 73:
                    {
                      SetParameterKSquar(260, 16);
                    }
                    break;
                  case 74:
                    {
                      SetParameterKSquar(300, 6.3);
                    }
                    break;
                  case 75:
                    {
                      SetParameterKSquar(300, 8);
                    }
                    break;
                  case 76:
                    {
                      SetParameterKSquar(300, 10);
                    }
                    break;
                  case 77:
                    {
                      SetParameterKSquar(300, 12.5);
                    }
                    break;
                  case 78:
                    {
                      SetParameterKSquar(300, 16);
                    }
                    break;
                  case 79:
                    {
                      SetParameterKSquar(350, 8);
                    }
                    break;
                  case 80:
                    {
                      SetParameterKSquar(350, 10);
                    }
                    break;
                  case 81:
                    {
                      SetParameterKSquar(350, 12.5);
                    }
                    break;
                  case 82:
                    {
                      SetParameterKSquar(350, 16);
                    }
                    break;
                  case 83:
                    {
                      SetParameterKSquar(400, 10);
                    }
                    break;
                  case 84:
                    {
                      SetParameterKSquar(400, 12.5);
                    }
                    break;
                  case 85:
                    {
                      SetParameterKSquar(400, 16);
                    }
                    break;
                }
                i = sectionName.Ksquare_section.length;
                ipn = "square";
              }
            }
          }
          if (!ch) {
            for (int i = 0; i < sectionName.Krec_section.length; i++) {
              String s = sectionName.Krec_section[i];
              if (selectedItem == (s)) {
                number = i;
                ch = true;
                switch (number) {
                  case 0:
                    {
                      SetParameterKRec(50, 30, 3);
                    }
                    break;
                  case 1:
                    {
                      SetParameterKRec(50, 30, 4);
                    }
                    break;
                  case 2:
                    {
                      SetParameterKRec(60, 40, 3);
                    }
                    break;
                  case 3:
                    {
                      SetParameterKRec(60, 40, 4);
                    }
                    break;
                  case 4:
                    {
                      SetParameterKRec(60, 40, 5);
                    }
                    break;
                  case 5:
                    {
                      SetParameterKRec(80, 40, 3);
                    }
                    break;
                  case 6:
                    {
                      SetParameterKRec(80, 40, 4);
                    }
                    break;
                  case 7:
                    {
                      SetParameterKRec(80, 40, 5);
                    }
                    break;
                  case 8:
                    {
                      SetParameterKRec(90, 50, 4);
                    }
                    break;
                  case 9:
                    {
                      SetParameterKRec(90, 50, 5);
                    }
                    break;
                  case 10:
                    {
                      SetParameterKRec(100, 50, 4);
                    }
                    break;
                  case 11:
                    {
                      SetParameterKRec(100, 50, 5);
                    }
                    break;
                  case 12:
                    {
                      SetParameterKRec(100, 50, 6.3);
                    }
                    break;
                  case 13:
                    {
                      SetParameterKRec(100, 60, 4);
                    }
                    break;
                  case 14:
                    {
                      SetParameterKRec(100, 60, 5);
                    }
                    break;
                  case 15:
                    {
                      SetParameterKRec(100, 60, 6.3);
                    }
                    break;
                  case 16:
                    {
                      SetParameterKRec(100, 80, 4);
                    }
                    break;
                  case 17:
                    {
                      SetParameterKRec(100, 80, 5);
                    }
                    break;
                  case 18:
                    {
                      SetParameterKRec(100, 80, 6.3);
                    }
                    break;
                  case 19:
                    {
                      SetParameterKRec(120, 60, 4);
                    }
                    break;
                  case 20:
                    {
                      SetParameterKRec(120, 60, 5);
                    }
                    break;
                  case 21:
                    {
                      SetParameterKRec(120, 60, 6.3);
                    }
                    break;
                  case 22:
                    {
                      SetParameterKRec(120, 60, 8);
                    }
                    break;
                  case 23:
                    {
                      SetParameterKRec(120, 80, 4);
                    }
                    break;
                  case 24:
                    {
                      SetParameterKRec(120, 80, 5);
                    }
                    break;
                  case 25:
                    {
                      SetParameterKRec(120, 80, 6.3);
                    }
                    break;
                  case 26:
                    {
                      SetParameterKRec(120, 80, 8);
                    }
                    break;
                  case 27:
                    {
                      SetParameterKRec(140, 80, 4);
                    }
                    break;
                  case 28:
                    {
                      SetParameterKRec(140, 80, 5);
                    }
                    break;
                  case 29:
                    {
                      SetParameterKRec(140, 80, 6.3);
                    }
                    break;
                  case 30:
                    {
                      SetParameterKRec(140, 80, 8);
                    }
                    break;
                  case 31:
                    {
                      SetParameterKRec(150, 100, 5);
                    }
                    break;
                  case 32:
                    {
                      SetParameterKRec(150, 100, 6.3);
                    }
                    break;
                  case 34:
                    {
                      SetParameterKRec(150, 100, 8);
                    }
                    break;
                  case 35:
                    {
                      SetParameterKRec(150, 100, 10);
                    }
                    break;
                  case 36:
                    {
                      SetParameterKRec(150, 100, 12.5);
                    }
                    break;
                  case 37:
                    {
                      SetParameterKRec(160, 80, 5);
                    }
                    break;
                  case 38:
                    {
                      SetParameterKRec(160, 80, 6.3);
                    }
                    break;
                  case 39:
                    {
                      SetParameterKRec(160, 80, 8);
                    }
                    break;
                  case 40:
                    {
                      SetParameterKRec(160, 80, 10);
                    }
                    break;
                  case 41:
                    {
                      SetParameterKRec(160, 80, 12.5);
                    }
                    break;
                  case 42:
                    {
                      SetParameterKRec(180, 100, 6.3);
                    }
                    break;
                  case 43:
                    {
                      SetParameterKRec(180, 100, 8);
                    }
                    break;
                  case 44:
                    {
                      SetParameterKRec(180, 100, 10);
                    }
                    break;
                  case 45:
                    {
                      SetParameterKRec(180, 100, 12.5);
                    }
                    break;
                  case 46:
                    {
                      SetParameterKRec(200, 100, 6.3);
                    }
                    break;
                  case 47:
                    {
                      SetParameterKRec(200, 100, 8);
                    }
                    break;
                  case 48:
                    {
                      SetParameterKRec(200, 100, 10);
                    }
                    break;
                  case 49:
                    {
                      SetParameterKRec(200, 100, 12.5);
                    }
                    break;
                  case 50:
                    {
                      SetParameterKRec(200, 120, 6.3);
                    }
                    break;
                  case 51:
                    {
                      SetParameterKRec(200, 120, 8);
                    }
                    break;
                  case 52:
                    {
                      SetParameterKRec(200, 120, 10);
                    }
                    break;
                  case 53:
                    {
                      SetParameterKRec(200, 120, 12.5);
                    }
                    break;
                  case 54:
                    {
                      SetParameterKRec(250, 150, 6.3);
                    }
                    break;
                  case 55:
                    {
                      SetParameterKRec(250, 150, 8);
                    }
                    break;
                  case 56:
                    {
                      SetParameterKRec(250, 150, 10);
                    }
                    break;
                  case 57:
                    {
                      SetParameterKRec(250, 150, 12.5);
                    }
                    break;
                  case 58:
                    {
                      SetParameterKRec(250, 150, 16);
                    }
                    break;
                  case 59:
                    {
                      SetParameterKRec(260, 180, 6.3);
                    }
                    break;
                  case 60:
                    {
                      SetParameterKRec(260, 180, 8);
                    }
                    break;
                  case 61:
                    {
                      SetParameterKRec(260, 180, 10);
                    }
                    break;
                  case 62:
                    {
                      SetParameterKRec(260, 180, 12);
                    }
                    break;
                  case 63:
                    {
                      SetParameterKRec(260, 180, 16);
                    }
                    break;
                  case 64:
                    {
                      SetParameterKRec(300, 100, 6.3);
                    }
                    break;
                  case 65:
                    {
                      SetParameterKRec(300, 100, 8);
                    }
                    break;
                  case 66:
                    {
                      SetParameterKRec(300, 100, 10);
                    }
                    break;
                  case 67:
                    {
                      SetParameterKRec(300, 100, 12);
                    }
                    break;
                  case 68:
                    {
                      SetParameterKRec(300, 100, 16);
                    }
                    break;
                  case 69:
                    {
                      SetParameterKRec(300, 150, 6.3);
                    }
                    break;
                  case 70:
                    {
                      SetParameterKRec(300, 150, 8);
                    }
                    break;
                  case 71:
                    {
                      SetParameterKRec(300, 150, 10);
                    }
                    break;
                  case 72:
                    {
                      SetParameterKRec(300, 150, 12);
                    }
                    break;
                  case 73:
                    {
                      SetParameterKRec(300, 150, 16);
                    }
                    break;
                  case 74:
                    {
                      SetParameterKRec(300, 200, 6.3);
                    }
                    break;
                  case 75:
                    {
                      SetParameterKRec(300, 200, 8);
                    }
                    break;
                  case 76:
                    {
                      SetParameterKRec(300, 200, 10);
                    }
                    break;
                  case 77:
                    {
                      SetParameterKRec(300, 200, 12);
                    }
                    break;
                  case 78:
                    {
                      SetParameterKRec(300, 200, 16);
                    }
                    break;
                  case 79:
                    {
                      SetParameterKRec(350, 250, 8);
                    }
                    break;
                  case 80:
                    {
                      SetParameterKRec(350, 250, 10);
                    }
                    break;
                  case 81:
                    {
                      SetParameterKRec(350, 250, 12);
                    }
                    break;
                  case 82:
                    {
                      SetParameterKRec(350, 250, 16);
                    }
                    break;
                  case 83:
                    {
                      SetParameterKRec(400, 200, 10);
                    }
                    break;
                  case 84:
                    {
                      SetParameterKRec(400, 200, 12);
                    }
                    break;
                  case 85:
                    {
                      SetParameterKRec(400, 200, 16);
                    }
                    break;
                  case 86:
                    {
                      SetParameterKRec(400, 300, 10);
                    }
                    break;
                  case 87:
                    {
                      SetParameterKRec(400, 300, 12);
                    }
                    break;
                  case 88:
                    {
                      SetParameterKRec(400, 300, 16);
                    }
                    break;
                }
                i = sectionName.Krec_section.length;
                ipn = "rec";
              }
            }
          }
          if (!ch) {
            for (int i = 0; i < sectionName.Wrec_section.length; i++) {
              String s = sectionName.Wrec_section[i];
              if (selectedItem == (s)) {
                number = i;
                ch = true;
                switch (number) {
                  case 0:
                    {
                      SetParameterWRec(50, 30, 3.2);
                    }
                    break;
                  case 1:
                    {
                      SetParameterWRec(50, 30, 4);
                    }
                    break;
                  case 2:
                    {
                      SetParameterWRec(50, 30, 5);
                    }
                    break;
                  case 3:
                    {
                      SetParameterWRec(60, 40, 3.2);
                    }
                    break;
                  case 4:
                    {
                      SetParameterWRec(60, 40, 4);
                    }
                    break;
                  case 5:
                    {
                      SetParameterWRec(60, 40, 5);
                    }
                    break;
                  case 6:
                    {
                      SetParameterWRec(60, 40, 6.3);
                    }
                    break;
                  case 7:
                    {
                      SetParameterWRec(80, 40, 4);
                    }
                    break;
                  case 8:
                    {
                      SetParameterWRec(80, 40, 5);
                    }
                    break;
                  case 9:
                    {
                      SetParameterWRec(80, 40, 6.3);
                    }
                    break;
                  case 10:
                    {
                      SetParameterWRec(80, 40, 8);
                    }
                    break;
                  case 11:
                    {
                      SetParameterWRec(90, 50, 4);
                    }
                    break;
                  case 12:
                    {
                      SetParameterWRec(90, 50, 5);
                    }
                    break;
                  case 13:
                    {
                      SetParameterWRec(90, 50, 6.3);
                    }
                    break;
                  case 14:
                    {
                      SetParameterWRec(90, 50, 8);
                    }
                    break;
                  case 15:
                    {
                      SetParameterWRec(100, 50, 4);
                    }
                    break;
                  case 16:
                    {
                      SetParameterWRec(100, 50, 5);
                    }
                    break;
                  case 17:
                    {
                      SetParameterWRec(100, 50, 6.3);
                    }
                    break;
                  case 18:
                    {
                      SetParameterWRec(100, 50, 8);
                    }
                    break;
                  case 19:
                    {
                      SetParameterWRec(120, 60, 4);
                    }
                    break;
                  case 20:
                    {
                      SetParameterWRec(120, 60, 5);
                    }
                    break;
                  case 21:
                    {
                      SetParameterWRec(120, 60, 6.3);
                    }
                    break;
                  case 22:
                    {
                      SetParameterWRec(120, 60, 8);
                    }
                    break;
                  case 23:
                    {
                      SetParameterWRec(120, 60, 10);
                    }
                    break;
                  case 24:
                    {
                      SetParameterWRec(120, 80, 4);
                    }
                    break;
                  case 25:
                    {
                      SetParameterWRec(120, 80, 5);
                    }
                    break;
                  case 26:
                    {
                      SetParameterWRec(120, 80, 6.3);
                    }
                    break;
                  case 27:
                    {
                      SetParameterWRec(120, 80, 8);
                    }
                    break;
                  case 28:
                    {
                      SetParameterWRec(120, 80, 10);
                    }
                    break;
                  case 29:
                    {
                      SetParameterWRec(140, 80, 4);
                    }
                    break;
                  case 30:
                    {
                      SetParameterWRec(140, 80, 5);
                    }
                    break;
                  case 31:
                    {
                      SetParameterWRec(140, 80, 6.3);
                    }
                    break;
                  case 32:
                    {
                      SetParameterWRec(140, 80, 8);
                    }
                    break;
                  case 33:
                    {
                      SetParameterWRec(140, 80, 10);
                    }
                    break;
                  case 34:
                    {
                      SetParameterWRec(150, 100, 6.3);
                    }
                    break;
                  case 35:
                    {
                      SetParameterWRec(150, 100, 8);
                    }
                    break;
                  case 36:
                    {
                      SetParameterWRec(150, 100, 12.5);
                    }
                    break;
                  case 37:
                    {
                      SetParameterWRec(160, 80, 5);
                    }
                    break;
                  case 38:
                    {
                      SetParameterWRec(160, 80, 6.3);
                    }
                    break;
                  case 39:
                    {
                      SetParameterWRec(160, 80, 8);
                    }
                    break;
                  case 40:
                    {
                      SetParameterWRec(160, 80, 12.5);
                    }
                    break;
                  case 41:
                    {
                      SetParameterWRec(180, 100, 5);
                    }
                    break;
                  case 42:
                    {
                      SetParameterWRec(180, 100, 6.3);
                    }
                    break;
                  case 43:
                    {
                      SetParameterWRec(180, 100, 8);
                    }
                    break;
                  case 44:
                    {
                      SetParameterWRec(180, 100, 10);
                    }
                    break;
                  case 45:
                    {
                      SetParameterWRec(180, 100, 12.5);
                    }
                    break;
                  case 46:
                    {
                      SetParameterWRec(200, 100, 6.3);
                    }
                    break;
                  case 47:
                    {
                      SetParameterWRec(200, 100, 8);
                    }
                    break;
                  case 48:
                    {
                      SetParameterWRec(200, 100, 10);
                    }
                    break;
                  case 49:
                    {
                      SetParameterWRec(200, 100, 12.5);
                    }
                    break;
                  case 50:
                    {
                      SetParameterWRec(200, 100, 16);
                    }
                    break;
                  case 51:
                    {
                      SetParameterWRec(200, 120, 6.3);
                    }
                    break;
                  case 52:
                    {
                      SetParameterWRec(200, 120, 8);
                    }
                    break;
                  case 53:
                    {
                      SetParameterWRec(200, 120, 10);
                    }
                    break;
                  case 54:
                    {
                      SetParameterWRec(200, 120, 12.5);
                    }
                    break;
                  case 55:
                    {
                      SetParameterWRec(250, 150, 6.3);
                    }
                    break;
                  case 56:
                    {
                      SetParameterWRec(250, 150, 8);
                    }
                    break;
                  case 57:
                    {
                      SetParameterWRec(250, 150, 10);
                    }
                    break;
                  case 58:
                    {
                      SetParameterWRec(250, 150, 12.5);
                    }
                    break;
                  case 59:
                    {
                      SetParameterWRec(250, 150, 16);
                    }
                    break;
                  case 60:
                    {
                      SetParameterWRec(260, 180, 6.3);
                    }
                    break;
                  case 61:
                    {
                      SetParameterWRec(260, 180, 8);
                    }
                    break;
                  case 62:
                    {
                      SetParameterWRec(260, 180, 10);
                    }
                    break;
                  case 63:
                    {
                      SetParameterWRec(260, 180, 12.5);
                    }
                    break;
                  case 64:
                    {
                      SetParameterWRec(260, 180, 16);
                    }
                    break;
                  case 65:
                    {
                      SetParameterWRec(300, 200, 6.3);
                    }
                    break;
                  case 66:
                    {
                      SetParameterWRec(300, 200, 8);
                    }
                    break;
                  case 67:
                    {
                      SetParameterWRec(300, 200, 10);
                    }
                    break;
                  case 68:
                    {
                      SetParameterWRec(300, 200, 12.5);
                    }
                    break;
                  case 69:
                    {
                      SetParameterWRec(300, 200, 16);
                    }
                    break;
                  case 70:
                    {
                      SetParameterWRec(350, 250, 6.3);
                    }
                    break;
                  case 71:
                    {
                      SetParameterWRec(350, 250, 8);
                    }
                    break;
                  case 72:
                    {
                      SetParameterWRec(350, 250, 10);
                    }
                    break;
                  case 73:
                    {
                      SetParameterWRec(350, 250, 12.5);
                    }
                    break;
                  case 74:
                    {
                      SetParameterWRec(350, 250, 16);
                    }
                    break;
                  case 75:
                    {
                      SetParameterWRec(400, 200, 8);
                    }
                    break;
                  case 76:
                    {
                      SetParameterWRec(400, 200, 10);
                    }
                    break;
                  case 77:
                    {
                      SetParameterWRec(400, 200, 12.5);
                    }
                    break;
                  case 78:
                    {
                      SetParameterWRec(400, 200, 16);
                    }
                    break;
                  case 79:
                    {
                      SetParameterWRec(450, 250, 8);
                    }
                    break;
                  case 80:
                    {
                      SetParameterWRec(450, 250, 10);
                    }
                    break;
                  case 81:
                    {
                      SetParameterWRec(450, 250, 12.5);
                    }
                    break;
                  case 82:
                    {
                      SetParameterWRec(450, 250, 16);
                    }
                    break;
                  case 83:
                    {
                      SetParameterWRec(500, 300, 10);
                    }
                    break;
                  case 84:
                    {
                      SetParameterWRec(500, 300, 12.5);
                    }
                    break;
                  case 85:
                    {
                      SetParameterWRec(500, 300, 16);
                    }
                    break;
                  case 86:
                    {
                      SetParameterWRec(500, 300, 20);
                    }
                    break;
                }
                i = sectionName.Wrec_section.length;
                ipn = "rec";
              }
            }
          }
          if (h == b) {
            if (!ch) {
              SetParameterWSquar(h, tw);
            }
            _ComputeDetails(x_section, h, b, t, t, 0, 0, r1, r2);
            value.add(B + pas + mm);
            value.add(T + pas + mm);
            value.add(R00 + pas + mm);
            value.add(Ri + pas + mm);
            value.add(Area + pas + cm2);
            value.add(IY + pas + cm4);
            value.add(iY + pas + cm);
            value.add(WELY + pas + cm3);
            value.add(WPLY + pas + cm3);
            value.add(G + pas + KNmm);
          } else {
            if (!ch) {
              SetParameterWRec(h, b, tw);
            }
            _ComputeDetails(x_section, h, b, t, t, 0, 0, r1, r2);
            value.add(H + pas + mm);
            value.add(B + pas + mm);
            value.add(T + pas + mm);
            value.add(R00 + pas + mm);
            value.add(Ri + pas + mm);
            value.add(Area + pas + cm2);
            value.add(IY + pas + cm4);
            value.add(iY + pas + cm);
            value.add(WELY + pas + cm3);
            value.add(WPLY + pas + cm3);
            value.add(IZ + pas + cm4);
            value.add(iZ + pas + cm);
            value.add(WELZ + pas + cm3);
            value.add(WPLZ + pas + cm3);
            value.add(IT + pas + cm4);
            value.add(G + pas + KNmm);
          }
        }
        break;
    }
    return value;
  }

  SetParameterUPN(
      double h,
      double b,
      double tw,
      double tf,
      double r2,
      double d,
      double a,
      double Iy,
      double wely,
      double Iy2,
      double Iz,
      double welz,
      double Iz2,
      double sy,
      double ez,
      double ym,
      double it,
      double iw) {
    this.h = h;
    this.b = b;
    this.tw = tw;
    this.tf = r1 = tf;
    this.r2 = r2;
    this.d = d;
    this.A = a;
    this.Iy = Iy;
    this.Wely = wely;
    this.iy = Iy2;
    this.Iz = Iz;
    this.Welz = welz;
    this.iz = Iz2;
    this.sy = sy;
    this.ez = ez;
    this.ym = ym;
    this.It = it;
    this.Iw = iw;
  }

  SetParameterUPE(double h, double b, double tw, double tf, double r) {
    this.h = h;
    this.b = b;
    this.tw = tw;
    this.tf = tf;
    this.r = r;
  }

  SetParameterZ(
      double h,
      double h1,
      double b,
      double tw,
      double tf,
      double r2,
      double a,
      double Iy,
      double wely,
      double Iy2,
      double Iz,
      double welz,
      double Iz2,
      double In,
      double weln,
      double In2,
      double Izeta,
      double welzeta,
      double Iz2eta,
      double tanalfa) {
    this.h = h;
    this.h1 = h1;
    this.b = b;
    this.tw = tw;
    this.tf = r1 = tf;
    this.r2 = r2;
    this.A = a;
    this.Iy = Iy;
    this.Wely = wely;
    this.iy = Iy2;
    this.Iz = Iz;
    this.Welz = welz;
    this.iz = Iz2;
    this.Izeta = Izeta;
    this.Welzeta = welzeta;
    this.izeta = Iz2eta;
    this.In = In;
    this.Weln = weln;
    this.inSmall = In2;
    this.tanalfa = tanalfa;
  }

  SetParameterLequal(
      double b,
      double t,
      double
          r1) /* double e, double w, double v1, double v2, double A, double I, double w, double I2, double In, double In2, double Izeta, double Iz2eta, double g*/ {
    this.h = this.b = b;
    this.t = tf = tw = t;
    this.r1 = r1;
    this.r2 = r1 / 2;
  }

  SetParameterLUnequal(
      double a,
      double b,
      double t,
      double
          r1) /* double e, double w, double v1, double v2, double A, double I, double w, double I2, double In, double In2, double Izeta, double Iz2eta, double g*/ {
    this.h = a;
    this.b = b;
    this.t = tf = tw = t;
    this.r1 = r1;
    this.r2 = r1 / 2;
  }

  SetParameterCircl(double D, double t) {
    this.h = D;
    this.b = D;
    this.t = tf = tw = t;
  }

  SetParameterWSquar(double B, double t) {
    this.h = B;
    this.b = B;
    this.t = tf = tw = t;
    this.r0 = 1.5 * t;
    this.ri = 1 * t;
  }

  SetParameterKSquar(double B, double t) {
    this.h = B;
    this.b = B;
    this.t = tf = tw = t;
    if (t <= 6) {
      this.r0 = 2 * t;
      this.ri = 1 * t;
    } else if (t <= 10) {
      this.r0 = 2.5 * t;
      this.ri = 1.5 * t;
    } else {
      this.r0 = 3 * t;
      this.ri = 2 * t;
    }
  }

  SetParameterWRec(double H, double B, double t) {
    this.h = H;
    this.b = B;
    this.r0 = 1.5 * t;
    this.ri = 1 * t;
    this.t = tf = tw = t;
  }

  SetParameterKRec(double H, double B, double t) {
    this.h = H;
    this.b = B;
    if (t <= 6) {
      this.r0 = 2 * t;
      this.ri = 1 * t;
    } else if (t <= 10) {
      this.r0 = 2.5 * t;
      this.ri = 1.5 * t;
    } else {
      this.r0 = 3 * t;
      this.ri = 2 * t;
    }
    this.t = tf = tw = t;
  }
}

