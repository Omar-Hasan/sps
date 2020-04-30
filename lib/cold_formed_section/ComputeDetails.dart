import 'dart:math';

import 'package:flutter/cupertino.dart';

class ComputeDetails {
  String S_steel, details, Material;
  double Ma,
      tetaEave,
      m = 0.0,
      g = 0.0,
      a,
      aFatha,
      A,
      AEfectiv,
      AEfectiv_I,
      AFatha,
      b,
      bFatha,
      BFatha,
      c,
      cFatha,
      CFatha,
      u = 0.0,
      raduis,
      t = 0.0,
      Ix,
      IxEfectiv,
      IxEfectiv_d,
      Iy,
      Wely,
      Welx,
      Ixy = 0.0,
      Teta = 0.0,
      Iy2 = 0.0,
      Ix2 = 0.0,
      rx,
      ry,
      rMin_x2 = 0.0,
      rMin_y2 = 0.0,
      j = 0.0,
      Cw = 0.0,
      alfa = 0.0;
  String MaString,
      tetaEaveString,
      mString,
      x0String,
      exString,
      G,
      x_section,
      aString,
      aFathaString,
      AEfectivString,
      AEfectiv_IString,
      AString,
      AFathaString,
      bString,
      bFathaString,
      BFathaString,
      cString,
      cFathaString,
      CString,
      Alfa,
      CFathaString,
      uString,
      raduisString,
      tString,
      IxString,
      IxEfectivString,
      IxEfectiv_dString,
      IyString,
      WELY,
      WELX,
      IxyString,
      TetaString,
      Iy2String,
      Ix2String,
      rxString,
      ryString,
      rMin_x2String,
      rMin_y2String,
      jString,
      CwString;
  double x0 = 0.0, ex = 0.0;
  int c1, c2, b1, b2, bA_eff, L_flang, L_web, Ls, LsEffect, Ycg;
  int c1_d, c2_d, b1_d, b2_d, LsEffect_d, Ycg_d;
  double Safetycoefficient = 1.67, f_d, Ix_d;
  String f_dString,
      SafetycoefficientString,
      c1String,
      c2String,
      bA_effString,
      b1String,
      b2String,
      L_flangString,
      L_webString,
      LsString,
      LsEffectString,
      YcgString,
      YcgU_compression,
      c1_dString,
      c2_dString,
      b1_dString,
      b2_dString,
      LsEffect_dString,
      Ycg_dString;
  bool cold = true;

  ComputeDetails(
      String Material,
      String details,
      String Steel_grade,
      String x_section,
      double height,
      double width,
      double height_lip,
      double thickness,
      double raduis,
      double alfa,
      double tetaEave) {
    this.x_section = x_section;
    this.AFatha = height;
    this.BFatha = width;
    this.t = thickness;
    if (t == 0) {
      cold = true; //الحساب ضمن واحدة الطول
    } else {
      cold = false;
    }
    this.raduis = raduis;
    this.CFatha = height_lip;
    this.alfa = alfa;
    S_steel = Steel_grade;
    this.details = details;
    this.Material = Material;
    this.tetaEave = tetaEave;
    YcgU_compression = _roundToString(AFatha / 2);
  }

  String _format2(double n) {
    return n.toStringAsFixed(n.truncateToDouble() == n ? 0 : 2);
  }

  String _format3(double n) {
    return n.toStringAsFixed(n.truncateToDouble() == n ? 0 : 3);
  }

  String _format5(double n) {
    n+= 0.0000001;
    return n.toStringAsFixed(n.truncateToDouble() == n ? 0 : 5);
  }

  String _format1(double n) {
    return n.toStringAsFixed(n.truncateToDouble() == n ? 0 : 1);
  }

  String _roundToString(double x) {
    String X;
    if (x < 1) {
      X = _format3(x);
    } else if (x < 10) {
      X = _format2(x);
    } else if (x < 100) {
      X = _format1(x);
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

  void _setString() {
    aString = _roundToString(a);
    aFathaString = _roundToString(aFatha);
    AString = _roundToString(A / 100);
    AEfectivString = _roundToString(AEfectiv / 100);
    AEfectiv_IString = _roundToString(AEfectiv_I / 100);
    AFathaString = _roundToString(AFatha);
    bString = _roundToString(b);
    bFathaString = _roundToString(bFatha);
    BFathaString = _roundToString(BFatha);
    cString = _roundToString(c);
    cFathaString = _roundToString(cFatha);
    CFathaString = _roundToString(CFatha);
    uString = _roundToString(u);
    raduisString = _roundToString(raduis);
    tString = _roundToString(t);
    IxString = _roundToString(Ix / 10000);
    IxEfectivString = _roundToString(IxEfectiv / 10000);
    IxEfectiv_dString = _roundToString(IxEfectiv_d / 10000);
    IyString = _roundToString(Iy / 10000);
    IxyString = _roundToString(Ixy / 10000);
    TetaString = _roundToString(Teta / pi * 180); //degree
    Iy2String = _roundToString(Iy2 / 10000);
    Ix2String = _roundToString(Ix2 / 10000);
    rxString = _roundToString(rx / 10);
    ryString = _roundToString(ry / 10);
    rMin_y2String = _roundToString(rMin_y2 / 10);
    rMin_x2String = _roundToString(rMin_x2 / 10);
    jString = _roundToString(j / 10000);
    CwString = _roundToString(Cw / 1000000);
    G = _roundToString(g);
    WELY = _roundToString(Wely / 1000);
    WELX = _roundToString(Welx / 1000);
    Alfa = _roundToString(alfa);
    exString = _roundToString(ex);
    mString = _roundToString(m);
    x0String = _roundToString(x0);
    MaString = _roundToString(Ma / 1000000);
    c1String = c1.toString();
    c2String = c2.toString();
    b1String = b1.toString();
    b2String = b2.toString();
    bA_effString = bA_eff.toString();
    L_flangString = L_flang.toString();
    L_webString = L_web.toString();
    LsString = Ls.toString();
    LsEffectString = LsEffect.toString();
    YcgString = Ycg.toString();
    c1_dString = c1_d.toString();
    c2_dString = c2_d.toString();
    b1_dString = b1_d.toString();
    b2_dString = b2_d.toString();
    LsEffect_dString = LsEffect_d.toString();
    Ycg_dString = Ycg_d.toString();
    SafetycoefficientString = _roundToString(Safetycoefficient);
    f_dString = _roundToString(f_d);
  }

  void _computeDetails() {
    switch (x_section) {
      case "z_with":
        {
          if (alfa == 90) {
            int constant = 1;
            a = AFatha - (2 * raduis + t);
            aFatha = AFatha - t;
            b = BFatha - (raduis + t / 2);
            bFatha = BFatha - (t / 2);
            c = CFatha;
            CFatha = c + t / 2 + raduis;
            cFatha = constant * (CFatha - t / 2);
            u = 1.57 * raduis; //طول القوس
            //
            if (t == 0) {
              this.t = 1.0;
            }
            // Area
            A = t * (a + 2 * b + 2 * u + constant * (2 * c + 2 * u));
            Ix = 2 *
                t *
                (1 / 24.0 * pow(a, 3) +
                    b * pow(a / 2 + raduis, 2) +
                    u * pow(a / 2 + 0.637 * raduis, 2) +
                    0.149 * pow(raduis, 3) +
                    constant *
                        (0.149 * pow(raduis, 3) +
                            u * pow(a / 2 + 0.637 * raduis, 2) +
                            0.0833 * pow(c, 3) +
                            c / 4 * pow(a - c, 2)));
            Iy = 2 *
                t *
                (1 / 12 * pow(b, 3) +
                    b * pow(b / 2 + raduis, 2) +
                    0.356 * pow(raduis, 3) +
                    constant *
                        (0.149 * pow(raduis, 3) +
                            u * pow(b + 1.637 * raduis, 2) +
                            c * pow(b + 2 * raduis, 2)));
            Ixy = 2 *
                t *
                (b * (a / 2 + raduis) * (b / 2 + raduis) +
                    0.5 * pow(raduis, 3) +
                    0.285 * a * pow(raduis, 2) +
                    constant *
                        (c * (2 * raduis + b) * (a / 2 - c / 2) -
                            0.137 * pow(raduis, 3) +
                            u *
                                (b + 1.637 * raduis) *
                                (0.5 * a + 0.637 * raduis)));
            Teta = atan((2 * Ixy / (Ix - Iy).abs())) / 2; //rad
            Ix2 = Ix * pow(cos(Teta), 2) +
                Iy * pow(sin(Teta), 2) -
                2 * Ixy * sin(Teta) * cos(Teta);
            Iy2 = Ix * pow(sin(Teta), 2) +
                Iy * pow(cos(Teta), 2) -
                2 * Ixy * sin(Teta) * cos(Teta);
            rx = sqrt(Ix / A);
            ry = sqrt(Iy / A);
            rMin_y2 = sqrt(Iy2 / A);
            rMin_x2 = sqrt(Ix2 / A);
            j = pow(t, 3) /
                3.0 *
                (a + 2 * b + 2 * u + constant * (2 * c + 2 * u));
            Cw = t *
                pow(bFatha, 2) /
                12 *
                (pow(aFatha, 2) *
                        (pow(bFatha, 2) +
                            2 * aFatha * bFatha +
                            4 * constant * bFatha * cFatha +
                            6 * aFatha * cFatha) +
                    4 *
                        constant *
                        pow(cFatha, 2) *
                        (3 * pow(aFatha, 2) +
                            3 * aFatha * bFatha +
                            4 * bFatha * cFatha +
                            2 * aFatha * cFatha +
                            pow(cFatha, 2))) /
                (aFatha + 2 * bFatha + 2 * cFatha);
            this.Welx = Ix / AFatha * 2; //mm^3
            this.Wely = Iy / (BFatha - t / 2); //mm^3
            //حساب مواصفات المقطع الفعال على الانعطاف
            alfa = alfa * pi / 180;
            _calck_EffectivProbertis(1, 0);
          } else {
            a = AFatha - (2 * raduis + t);
            aFatha = AFatha - t;
            b = BFatha - (raduis + t / 2);
            bFatha = BFatha - (t / 2);
            c = CFatha;
            CFatha = c + t / 2 + raduis;
            cFatha = (CFatha - t / 2);
            u = 1.57 * raduis; //طول القوس
            alfa = alfa - 90;
            double uAlfa = alfa * pi / 180 * raduis;
            double cosAlfa = cos(alfa * pi / 180);
            double sinAlfa = sin(alfa * pi / 180);
            double tanAlfa = tan(alfa * pi / 180);
            alfa = alfa * pi / 180;
            //
            if (t == 0) {
              this.t = 1.0;
            }
            // Area
            A = t * (a + 2 * b + 2 * u + (2 * c + 2 * uAlfa));
            Ix = 2 *
                t *
                (1.0 / 24 * pow(a, 3) +
                    b * pow(a / 2 + raduis, 2) +
                    u * pow(a / 2 + 0.637 * raduis, 2) +
                    0.149 * pow(raduis, 3) +
                    ((alfa + sinAlfa * cosAlfa) / 2 - pow(sinAlfa, 2) / alfa) *
                        pow(raduis, 3) +
                    uAlfa * pow(a / 2 + raduis * sinAlfa / alfa, 2) +
                    sinAlfa * sinAlfa / 12 * pow(c, 3) +
                    c *
                        pow(
                            AFatha / 2 -
                                sinAlfa * c / 2 -
                                raduis * (1 - cosAlfa) -
                                t / 2,
                            2));
            Iy = 2 *
                t *
                (1.0 / 12 * pow(b, 3) +
                    b * pow(b / 2 + raduis, 2) +
                    0.356 * pow(raduis, 3) +
                    ((alfa - sinAlfa * cosAlfa) / 2 -
                            pow(1 - cosAlfa, 2) / alfa) *
                        pow(raduis, 3) +
                    uAlfa * pow(b + raduis + raduis * (1 - cosAlfa) / alfa, 2) +
                    cosAlfa * cosAlfa / 12 * pow(c, 3) +
                    c *
                        pow(b + raduis + raduis * sinAlfa + cosAlfa * c / 2,
                            2));
            Ixy = 2 *
                t *
                (b * (a / 2 + raduis) * (b / 2 + raduis) +
                    0.5 * pow(raduis, 3) +
                    0.285 * a * pow(raduis, 2) +
                    (c *
                            (b + raduis + raduis * sinAlfa + sinAlfa * c / 2) *
                            (AFatha / 2 -
                                cosAlfa * c / 2 -
                                raduis * (1 - cosAlfa)) +
                        (sinAlfa * sinAlfa / 2 +
                            sinAlfa * (cosAlfa - 1) / alfa) +
                        uAlfa *
                            (b + raduis + raduis * (1 - cosAlfa) / alfa) *
                            (a / 2 + raduis - raduis * sinAlfa / alfa)));
            Teta = atan((2 * Ixy / (Ix - Iy).abs())) / 2; //rad
            Ix2 = Ix * pow(cos(Teta), 2) +
                Iy * pow(sin(Teta), 2) -
                2 * Ixy * sin(Teta) * cos(Teta);
            Iy2 = Ix * pow(sin(Teta), 2) +
                Iy * pow(cos(Teta), 2) -
                2 * Ixy * sin(Teta) * cos(Teta);
            rx = sqrt(Ix / A);
            ry = sqrt(Iy / A);
            rMin_y2 = sqrt(Iy2 / A);
            rMin_x2 = sqrt(Ix2 / A);
            this.Welx = Ix / AFatha * 2; //mm^3
            this.Wely = Iy / (BFatha - t / 2); //mm^3
            //error in this equation:
            j = pow(t, 3) / 3.0 * (a + 2 * b + 2 * u + 1 * (2 * c + 2 * u));
            Cw = t *
                pow(bFatha, 2) /
                12 *
                (pow(aFatha, 2) *
                        (pow(bFatha, 2) +
                            2 * aFatha * bFatha +
                            4 * bFatha * cFatha +
                            6 * aFatha * cFatha) +
                    4 *
                        1 *
                        pow(cFatha, 2) *
                        (3 * pow(aFatha, 2) +
                            3 * aFatha * bFatha +
                            4 * bFatha * cFatha +
                            2 * aFatha * cFatha +
                            pow(cFatha, 2))) /
                (aFatha + 2 * bFatha + 2 * cFatha);
            //حساب مواصفات المقطع الفعال على الانعطاف
            _calck_EffectivProbertis(sinAlfa, cosAlfa);
          }
        }
        break;
      case "z_without":
        {
          int constant = 0;
          a = AFatha - (2 * raduis + t);
          aFatha = AFatha - t;
          b = BFatha - (raduis + t / 2 + constant * (raduis + t / 2));
          bFatha = BFatha - (t / 2 + constant * t / 2);
          c = constant * (CFatha - (raduis + t / 2));
          cFatha = constant * (CFatha - t / 2);
          u = 1.57 * raduis; //طول القوس
          //
          if (t == 0) {
            this.t = 1.0;
          }
          // Area
          A = t * (a + 2 * b + 2 * u + constant * (2 * c + 2 * u));
          Ix = 2 *
              t *
              (1 / 24.0 * pow(a, 3) +
                  b * pow(a / 2 + raduis, 2) +
                  u * pow(a / 2 + 0.637 * raduis, 2) +
                  0.149 * pow(raduis, 3) +
                  constant *
                      (0.149 * pow(raduis, 3) +
                          u * pow(a / 2 + 0.637 * raduis, 2) +
                          0.0833 * pow(c, 3) +
                          c / 4 * pow(a - c, 2)));
          Iy = 2 *
              t *
              (1 / 12 * pow(b, 3) +
                  b * pow(b / 2 + raduis, 2) +
                  0.356 * pow(raduis, 3) +
                  constant *
                      (0.149 * pow(raduis, 3) +
                          u * pow(b + 1.637 * raduis, 2) +
                          c * pow(b + 2 * raduis, 2)));
          Ixy = 2 *
              t *
              (b * (a / 2 + raduis) * (b / 2 + raduis) +
                  0.5 * pow(raduis, 3) +
                  0.285 * a * pow(raduis, 2) +
                  constant *
                      (c * (2 * raduis + b) * (a / 2 - c / 2) -
                          0.137 * pow(raduis, 3) +
                          u *
                              (b + 1.637 * raduis) *
                              (0.5 * a + 0.637 * raduis)));
          Teta = atan((2 * Ixy / (Ix - Iy))) / 2; //rad
          Ix2 = Ix * pow(cos(Teta), 2) +
              Iy * pow(sin(Teta), 2) -
              2 * Ixy * sin(Teta) * cos(Teta);
          Iy2 = Ix * pow(sin(Teta), 2) +
              Iy * pow(cos(Teta), 2) -
              2 * Ixy * sin(Teta) * cos(Teta);
          rx = sqrt(Ix / A);
          ry = sqrt(Iy / A);
          rMin_y2 = sqrt(Iy2 / A);
          rMin_x2 = sqrt(Ix2 / A);
          j = pow(t, 3) /
              3.0 *
              (a + 2 * b + 2 * u + constant * (2 * c + 2 * u));
          Cw = t *
              pow(bFatha, 2) /
              12 *
              (pow(aFatha, 2) *
                      (pow(bFatha, 2) +
                          2 * aFatha * bFatha +
                          4 * constant * bFatha * cFatha +
                          6 * aFatha * cFatha) +
                  4 *
                      constant *
                      pow(cFatha, 2) *
                      (3 * pow(aFatha, 2) +
                          3 * aFatha * bFatha +
                          4 * bFatha * cFatha +
                          2 * aFatha * cFatha +
                          pow(cFatha, 2))) /
              (aFatha + 2 * bFatha + 2 * cFatha);
          this.Welx = Ix / AFatha * 2; //mm^3
          this.Wely = Iy / (BFatha - t / 2); //mm^3

          alfa = 0.0;
          _calck_EffectivProbertis(0, 1);
        }
        break;
      case "u_without":
        {
          int constant = 0;
          a = AFatha - (2 * raduis + t);
          aFatha = AFatha - t;
          b = BFatha - (raduis + t / 2 + constant * (raduis + t / 2));
          bFatha = BFatha - (t / 2 + constant * t / 2);
          c = constant * (CFatha - (raduis + t / 2));
          cFatha = constant * (CFatha - t / 2);
          u = 1.57 * raduis; //طول القوس
          //
          if (t == 0) {
            this.t = 1.0;
          }
          // Area
          A = t * (a + 2 * b + 2 * u + constant * (2 * c + 2 * u));
          Ix = 2 *
              t *
              (1 / 24.0 * pow(a, 3) +
                  b * pow(a / 2 + raduis, 2) +
                  u * pow(a / 2 + 0.637 * raduis, 2) +
                  0.149 * pow(raduis, 3) +
                  constant *
                      (0.149 * pow(raduis, 3) +
                          u * pow(a / 2 + 0.637 * raduis, 2) +
                          0.0833 * pow(c, 3) +
                          c / 4 * pow(a - c, 2)));
          ex = 2 *
              t *
              (b * (b / 2 + raduis) +
                  u * (0.363 * raduis) +
                  constant *
                      (u * (b + 1.637 * raduis) + c * (b + 2 * raduis))) /
              A;
          Iy = 2 *
                  t *
                  (b * pow(b / 2 + raduis, 2) +
                      0.0833 * pow(b, 3) +
                      0.356 * pow(raduis, 3) +
                      constant *
                          (0.149 * pow(raduis, 3) +
                              u * pow(b + 1.637 * raduis, 2) +
                              c * pow(b + 2 * raduis, 2))) -
              A * pow(ex, 2);
          m = bFatha *
              t /
              (12 * Ix) *
              (6 * cFatha * pow(aFatha, 2) +
                  3 * bFatha * pow(aFatha, 2) -
                  8 * pow(cFatha, 3));
          x0 = ex + m;
          rx = sqrt(Ix / A);
          ry = sqrt(Iy / A);
          j = pow(t, 3) /
              3.0 *
              (a + 2 * b + 2 * u + constant * (2 * c + 2 * u));
          Cw = t *
              pow(bFatha, 3) /
              12 *
              pow(aFatha, 2) *
              (3 * bFatha + 2 * aFatha) /
              (6 * bFatha + aFatha);
          this.Welx = Ix / AFatha * 2; //mm^3
          this.Wely = Iy / (BFatha - ex); //mm^3
          alfa = 0.0;
          _calck_EffectivProbertis(0, 1);
        }
        break;
      case "u_with":
        {
          int constant = 1;
          double sinTetaEave = sin(tetaEave * pi / 180);
          double cosTetaEave = cos(tetaEave * pi / 180);
          double tanTetaEave = tan(tetaEave * pi / 180);
          a = AFatha -
              (raduis + raduis * cosTetaEave + t / 2 * (1 + cosTetaEave));
          aFatha = AFatha - t / 2 * (1 + cosTetaEave);
          b = BFatha - (raduis + t / 2);
          bFatha = BFatha - (t / 2 + 0 * t / 2);
          c = CFatha;
          CFatha = c + t / 2 + raduis;
          cFatha = constant * (CFatha - t / 2);
          u = 1.57 * raduis; //طول القوس
          Offset p1,
              p0,
              p6,
              p7,
              BaseRotate = new Offset(0, (a + raduis + t / 2 * 0));
          p1 = new Offset(BaseRotate.dx + raduis * (1 - sinTetaEave),
              BaseRotate.dy + raduis * cosTetaEave);
          p0 = new Offset(p1.dx + (b) * cosTetaEave, p1.dy + (b) * sinTetaEave);
          p6 = new Offset(p0.dx + raduis * (cosTetaEave + sinTetaEave),
              p0.dy - raduis * cosTetaEave * (1 - tanTetaEave));
          p7 = new Offset(p6.dx + c * sinTetaEave, p6.dy - c * cosTetaEave);
          //
          if (t == 0) {
            this.t = 1.0;
          }
          // Area
          double tetaEaveRaduis = (90 - tetaEave) * pi / 180;
          double I1Raduis =
              ((tetaEaveRaduis + sin(tetaEaveRaduis) * cos(tetaEaveRaduis)) /
                          2 -
                      pow(sin(tetaEaveRaduis), 2) / tetaEaveRaduis) *
                  pow(raduis, 3);
          double I2Raduis =
              ((tetaEaveRaduis - sin(tetaEaveRaduis) * cos(tetaEaveRaduis)) /
                          2 -
                      pow(1 - cos(tetaEaveRaduis), 2) / tetaEaveRaduis) *
                  pow(raduis, 3);
          A = t *
              (a +
                  2 * b +
                  u +
                  tetaEaveRaduis * raduis +
                  constant * (2 * c + 2 * u));
          double ycg = t *
              (2 * u * (raduis * 0.363) +
                  c * (c / 2 + raduis) +
                  a * (a / 2 + raduis) //حتى الليف السفلي
                  +
                  b * (p1.dy + p0.dy) / 2 +
                  (tetaEaveRaduis * raduis) *
                      (raduis * (1 - cos(tetaEaveRaduis)) / tetaEaveRaduis +
                          BaseRotate.dy) +
                  u *
                      (p0.dy -
                          0.363 * raduis * (1 - sinTetaEave) * cosTetaEave) +
                  c * (p6.dy + p7.dy) / 2) /
              A;
          YcgU_compression = _roundToString(ycg);
          ex = t *
              (b * (b / 2 + raduis) +
                  b * (p0.dx + p1.dx) / 2.0 +
                  u * (0.363 * raduis) +
                  tetaEaveRaduis *
                      raduis *
                      raduis *
                      (1 - sin(tetaEaveRaduis) / tetaEaveRaduis) +
                  u * (b + 1.637 * raduis) +
                  c * (b + 2 * raduis) +
                  (raduis *
                          tetaEaveRaduis *
                          (p6.dx - 0.363 * raduis * cosTetaEave) +
                      c * (p6.dx + p7.dx) / 2)) /
              A;
          Ix = t *
              (1 / 12.0 * pow(a, 3) +
                  a * pow(ycg - raduis - a / 2, 2) +
                  b * pow(ycg, 2) +
                  b * pow((p0.dy + p1.dy) / 2 - ycg, 2) +
                  pow(b, 3) / 12.0 * pow(sinTetaEave, 2) +
                  2 * u * pow(ycg - 0.363 * raduis, 2) +
                  2 * 0.149 * pow(raduis, 3) +
                  tetaEaveRaduis *
                      raduis *
                      pow(
                          a +
                              raduis -
                              ycg +
                              (1 - cos((tetaEaveRaduis))) /
                                  tetaEaveRaduis *
                                  raduis,
                          2) +
                  I2Raduis +
                  u *
                      pow(
                          p0.dy -
                              ycg -
                              0.363 * raduis * (1 - sinTetaEave) * cosTetaEave,
                          2) +
                  0.149 * pow(raduis, 3) * cosTetaEave +
                  pow(c, 3) / 12.0 +
                  pow(c, 3) / 12.0 * pow(cosTetaEave, 2) +
                  c * pow(ycg - c / 2 - raduis, 2) +
                  c * pow((p6.dy + p7.dy) / 2 - ycg, 2));
          Iy = t *
                  (b * pow(b / 2 + raduis, 2) +
                      pow(b, 3) / 12.0 +
                      b * pow((p1.dx + p0.dx) / 2, 2) +
                      pow(b, 3) / 12.0 * pow(cosTetaEave, 2) +
                      0.356 * pow(raduis, 3) +
                      I1Raduis +
                      raduis *
                          tetaEaveRaduis *
                          pow(
                              raduis *
                                  (1 - sin(tetaEaveRaduis) / tetaEaveRaduis),
                              2) +
                      constant *
                          (0.149 * pow(raduis, 3) * (1 + cosTetaEave) +
                              u *
                                  (pow(p0.dx + 0.637 * raduis * cosTetaEave,
                                          2) +
                                      pow(b + 1.637 * raduis, 2)) +
                              pow(c, 3) / 12.0 * pow(sinTetaEave, 2) +
                              c *
                                  (pow((p6.dx + p7.dx) / 2, 2) +
                                      pow(b + 2 * raduis, 2)))) -
              A * pow(ex, 2);
          m = bFatha *
              t /
              (12 * Ix) *
              (6 * cFatha * pow(aFatha, 2) +
                  3 * bFatha * pow(aFatha, 2) -
                  8 * pow(cFatha, 3));
          x0 = ex + m;
          rx = sqrt(Ix / A);
          ry = sqrt(Iy / A);
          j = pow(t, 3) /
              3.0 *
              (a + 2 * b + 2 * u + constant * (2 * c + 2 * u));
          Cw = t *
              t /
              A *
              (ex *
                      A *
                      pow(aFatha, 2) /
                      t *
                      (pow(bFatha, 2) / 3 + m * m - m * bFatha) +
                  A /
                      3 /
                      t *
                      (m * m +
                          pow(aFatha, 3) +
                          pow(bFatha, 2) *
                              pow(cFatha, 2) *
                              (2 * cFatha + 3 * aFatha)) -
                  Ix * m * m / t * (2 * aFatha + 4 * cFatha) +
                  m *
                      pow(c, 2) /
                      3 *
                      (8 * bFatha * bFatha * cFatha +
                          2 *
                              m *
                              (2 * cFatha * (cFatha - aFatha) +
                                  bFatha * (2 * cFatha - 3 * aFatha))) +
                  pow(bFatha, 2) *
                      pow(aFatha, 2) /
                      6 *
                      ((3 * cFatha + bFatha) * (4 * cFatha + aFatha) -
                          6 * pow(cFatha, 2)) -
                  m * m * pow(a, 4) / 4);
          this.Welx = Ix / (p0.dy - ycg); //mm^3
          this.Wely = Iy / (max(p7.dx, BFatha) - ex); //mm^3
          alfa = alfa * pi / 180;
          _calck_EffectivProbertis(1, 0);
        }
        break;
      case "u_hat":
        {
          int constant = 1;
          a = AFatha - (2 * raduis + t);
          aFatha = AFatha - t;
          b = BFatha - (raduis + t / 2 + 0 * (raduis + t / 2));
          bFatha = BFatha - (t / 2 + constant * t / 2);
          c = CFatha;
          CFatha = c + t / 2 + raduis;
          cFatha = constant * (CFatha - t / 2);
          u = 1.57 * raduis; //طول القوس
          //
          if (t == 0) {
            this.t = 1.0;
          }
          // Aread
          A = t * (a + 2 * b + 2 * u + constant * (2 * c + 2 * u));
          /*Hat section*/
          Ix = 2 *
              t *
              (1 / 24.0 * pow(a, 3) +
                  b * pow(a / 2 + raduis, 2) +
                  u * pow(a / 2 + 0.637 * raduis, 2) +
                  0.149 * pow(raduis, 3) +
                  constant *
                      (0.149 * pow(raduis, 3) +
                          u * pow(a / 2 + 1.363 * raduis, 2) +
                          0.0833 * pow(c, 3) +
                          c / 4 * pow(a + c + 4 * raduis, 2)));
          ex = 2 *
              t *
              (b * (b / 2 + raduis) +
                  u * (0.363 * raduis) +
                  constant *
                      (u * (b + 1.637 * raduis) + c * (b + 2 * raduis))) /
              A;
          Iy = 2 *
                  t *
                  (b * pow(b / 2 + raduis, 2) +
                      0.0833 * pow(b, 3) +
                      0.356 * pow(raduis, 3) +
                      constant *
                          (0.149 * pow(raduis, 3) +
                              u * pow(b + 1.637 * raduis, 2) +
                              c * pow(b + 2 * raduis, 2))) -
              A * pow(ex, 2);
          m = bFatha *
              t /
              (12 * Ix) *
              (6 * cFatha * pow(aFatha, 2) +
                  3 * bFatha * pow(aFatha, 2) -
                  8 * pow(cFatha, 3));
          x0 = ex + m;
          rx = sqrt(Ix / A);
          ry = sqrt(Iy / A);
          j = pow(t, 3) /
              3.0 *
              (a + 2 * b + 2 * u + constant * (2 * c + 2 * u));
          /*hat lips*/
          Cw = pow(a, 2) /
                  4 *
                  (Iy + pow(ex, 2) * A * (1 - pow(aFatha, 2) * A / (4 * Ix))) +
              (2 * pow(bFatha, 2) * t * pow(cFatha, 3) / 3 -
                  aFatha * pow(bFatha, 2) * pow(cFatha, 2) * t +
                  pow(aFatha, 2) *
                      bFatha *
                      t *
                      pow(cFatha, 3) *
                      ex *
                      A /
                      (3 * Ix) -
                  4 * pow(bFatha, 2) * t * t * pow(cFatha, 6) / (9 * Ix));
          this.Welx = Ix / AFatha * 2; //mm^3
          this.Wely = Iy / (BFatha - ex); //mm^3
          alfa = alfa * pi / 180;
          _calck_EffectivProbertis(1, 0);
        }
        break;
    }
    this.g = 78.5 * A / 1000000; //KN/m
    _setString();
  }

  _calck_EffectivProbertis(double sinAlfa, double cosAlfa) {
    //تحديد الأطوال الفعالة
    double c1,
        c2,
        ls_efec,
        b1_Ix,
        b2_Ix,
        b_A,
        b1New,
        b2New,
        E = 205000,
        f = 355,
        Ycg = AFatha / 2;
    f = _f_yeild(S_steel);
    E = _young_module(Material);
    c1 = _FlangefectivLengthWithStiffiner(E, f, b, t, c, t, raduis, alfa)[0];
    c2 = _FlangefectivLengthWithStiffiner(E, f, b, t, c, t, raduis, alfa)[1];
    ls_efec = _StiffenerefectivLength(E, f, b, t, c, t, raduis, alfa);
    b1_Ix = _WebEfctivLength_Ix(E, f, a, t, Ycg)[0];
    b2_Ix = _WebEfctivLength_Ix(E, f, a, t, Ycg)[1] +
        AFatha -
        Ycg -
        (raduis + t / 2);
    b_A = _WebEfctivLength_A(E, f, a, t);
    Ycg_Z ycg = new Ycg_Z(c1, c2, c, raduis, b1_Ix, b2_Ix, b, alfa, E, f,t,tetaEave,AFatha,b);
    String s1, s2;
    do {
      b1New = b1_Ix;
      b2New = b2_Ix;
      ycg = new Ycg_Z(c1, c2, c, raduis, b1_Ix, b2_Ix, b, alfa, E, f,t,tetaEave,AFatha,b);
      Ycg = ycg.YcgLocal;
      b1_Ix = _WebEfctivLength_Ix(E, f, a, t, Ycg)[0];
      b2_Ix = _WebEfctivLength_Ix(E, f, a, t, Ycg)[1] +
          AFatha -
          Ycg -
          (raduis + t / 2);
      s1 = _format5(b1_Ix + b2_Ix);
      s2 = _format5(b1New + b2New);
    } while (!(s1 == (s2)));
    double cosTetaEave = cos(tetaEave * pi / 180);
    double sinTetaEave = sin(tetaEave * pi / 180);
    double tetaEaveRaduis = (90 - tetaEave) * pi / 180;
    if (alfa != 0) {
      /*IxEfectiv = t * (1.0 / 12 * (pow(b1New, 3) + pow(b2New, 3) + sinAlfa * sinAlfa * (pow(ls_efec, 3) + pow(c, 3)))+2*(+ 0.149 * pow(raduis, 3) +
                  ((alfa + sinAlfa * cosAlfa) / 2 - pow(sinAlfa, 2) / alfa) * pow(raduis, 3))
                  + multipArray(ycg.L_,squarArray(ycg.C_)) - sumArray(ycg.L_)*pow(ycg.Ycg,2));*/
      if (x_section == "u_hat") {
        ycg.cg_[0] += ycg.L_[0] + 2 * raduis;
        ycg.cg_[1] += 0.726 * raduis;
        ycg.cg_[9] += ycg.L_[9] + 2 * raduis;
        ycg.cg_[8] += 0.726 * raduis;
      }
      IxEfectiv = t *
          (1.0 /
                  12 *
                  ((pow(c1, 3) + pow(c2, 3)) * pow(sinTetaEave, 2) +
                      pow(b1New, 3) +
                      pow(b2New, 3) +
                      sinAlfa *
                          sinAlfa *
                          (pow(ls_efec, 3) * cosTetaEave * cosTetaEave +
                              pow(c, 3))) +
              pow(raduis, 3) *
                  (0.149 +
                      ((alfa + sinAlfa * cosAlfa) / 2 -
                              pow(sinAlfa, 2) / alfa) *
                          2 +
                      ((tetaEaveRaduis - sinTetaEave * cosTetaEave) / 2 -
                          pow(1 - sinTetaEave, 2) / tetaEaveRaduis)) +
              _multipArray(ycg.L_, _squarArray(ycg.cg_)));
    } else {
      /*IxEfectiv = t * (1.0 / 12 * (pow(b1New, 3) + pow(b2New, 3))+2*(+ 0.149 * pow(raduis, 3))
                  + multipArray(ycg.L_,squarArray(ycg.C_)) - sumArray(ycg.L_)*pow(ycg.Ycg,2));*/
      IxEfectiv = t *
          (1.0 / 12 * (pow(b1New, 3) + pow(b2New, 3)) +
              2 * (0.149 * pow(raduis, 3)) +
              _multipArray(ycg.L_, _squarArray(ycg.cg_)));
    }
    double uAlfa = raduis * alfa;
    AEfectiv = t *
        (b_A +
            2 * (c1 + c2) +
            u +
            raduis * tetaEaveRaduis +
            (2 * ls_efec + 2 * uAlfa));
    AEfectiv_I = t *
        (b1New +
            b2New +
            b +
            (c1 + c2) +
            raduis * tetaEaveRaduis +
            u +
            c +
            (ls_efec + 2 * uAlfa));
    this.Ycg = Ycg.round();
    this.c1 = c1.round();
    this.c2 = c2.round();
    this.b1 = b1New.round();
    this.b2 = b2New.round();
    this.bA_eff = b_A.round();
    this.L_flang = b.round();
    this.L_web = a.round();
    this.Ls = c.round();
    this.LsEffect = ls_efec.round();
    this.f_d = f / Safetycoefficient;
    Ma = IxEfectiv / Ycg * f_d;
    double Mad;
    Ycg = AFatha / 2;
    bool breif = false;
    do {
      c1 =
          _FlangefectivLengthWithStiffiner(E, f_d, b, t, c, t, raduis, alfa)[0];
      c2 =
          _FlangefectivLengthWithStiffiner(E, f_d, b, t, c, t, raduis, alfa)[1];
      ls_efec = _StiffenerefectivLength(E, f_d, b, t, c, t, raduis, alfa);
      b1_Ix = _WebEfctivLength_Ix(E, f_d, a, t, Ycg)[0];
      b2_Ix = _WebEfctivLength_Ix(E, f_d, a, t, Ycg)[1] +
          AFatha -
          Ycg -
          (raduis + t / 2);
      String s1d, s2d;
      do {
        b1New = b1_Ix;
        b2New = b2_Ix;
        ycg = new Ycg_Z(c1, c2, c, raduis, b1_Ix, b2_Ix, b, alfa, E, f_d,t,tetaEave,AFatha,b);
        Ycg = ycg.YcgLocal;
        b1_Ix = _WebEfctivLength_Ix(E, f_d, a, t, Ycg)[0];
        b2_Ix = _WebEfctivLength_Ix(E, f_d, a, t, Ycg)[1] +
            AFatha -
            Ycg -
            (raduis + t / 2);
        s1d = _format5(b1_Ix + b2_Ix);
        s2d = _format5(b1New + b2New);
      } while (!(s1d == s2d));
      if (alfa != 0) {
        if (x_section == ("u_hat")) {
          ycg.cg_[0] += ycg.L_[0] + 2 * raduis;
          ycg.cg_[1] += 0.726 * raduis;
          ycg.cg_[9] += ycg.L_[9] + 2 * raduis;
          ycg.cg_[8] += 0.726 * raduis;
        }
        IxEfectiv_d = t *
            (1.0 /
                    12 *
                    ((pow(c1, 3) + pow(c2, 3)) * pow(sinTetaEave, 2) +
                        pow(b1New, 3) +
                        pow(b2New, 3) +
                        sinAlfa *
                            sinAlfa *
                            (pow(ls_efec, 3) * cosTetaEave * cosTetaEave +
                                pow(c, 3))) +
                pow(raduis, 3) *
                    (0.149 +
                        ((alfa + sinAlfa * cosAlfa) / 2 -
                                pow(sinAlfa, 2) / alfa) *
                            2 +
                        ((tetaEaveRaduis - sinTetaEave * cosTetaEave) / 2 -
                            pow(1 - sinTetaEave, 2) / tetaEaveRaduis)) +
                _multipArray(ycg.L_, _squarArray(ycg.cg_)));
      } else {
        IxEfectiv_d = t *
            (1.0 / 12 * (pow(b1New, 3) + pow(b2New, 3)) +
                2 * (0.149 * pow(raduis, 3)) +
                _multipArray(ycg.L_, _squarArray(ycg.cg_)));
      }
      Mad = IxEfectiv_d / Ycg * f_d;
      if (Ma >= Mad) {
        breif = true;
      } else {
        f_d -= 0.1;
      }
    } while (!breif);
    this.Ycg_d = Ycg.round();
    this.c1_d = c1.round();
    this.c2_d = c2.round();
    this.b1_d = b1New.round();
    this.b2_d = b2New.round();
    this.LsEffect_d = ls_efec.round();
  }

  _f_yeild(String steel_grad) {
    double f = 355;
    switch (steel_grad) {
      case "S-235":
        {
          if (t <= 16) {
            f = 235;
          } else {
            f = 225;
          }
        }
        break;
      case "S-275":
        {
          if (t <= 16) {
            f = 275;
          } else {
            f = 265;
          }
        }
        break;
      case "S-355":
        {
          if (t <= 16) {
            f = 355;
          } else {
            f = 345;
          }
        }
        break;
      case "S-460":
        {
          if (t <= 16) {
            f = 460;
          } else {
            f = 440;
          }
        }
        break;
      case "AC-42100":
        f = 136;
        break;
      case "AC-42200":
        f = 157;
        break;
      case "AC-43000":
        f = 63;
        break;
      case "AC-43300":
        f = 130;
        break;
      case "AC-44200":
        f = 52;
        break;
      case "AC-51300":
        f = 66;
        break;
      case "spinner_Coppergrade":
        f = 100;
        break;
    }
    return f;
  }

  _young_module(String Material) {
    double E = 205000;
    switch (Material) {
      case "Steel":
        {
          E = 205000;
        }
        break;
      case "Aluminium":
        {
          E = 70000;
        }
        break;
      case "Copper":
        {
          E = 117000;
        }
        break;
    }
    return E;
  }

  static _multipArray(List<double> A1, List<double> A2) {
    double multip = 0;
    for (int i = 0; i < A1.length; i++) {
      multip += A1[i] * A2[i];
    }
    return multip;
  }

  static _squarArray(List<double> A1) {
    List<double> square = new List(A1.length);
    for (int i = 0; i < A1.length; i++) {
      square[i] = pow(A1[i], 2);
    }
    return square;
  }

  static _sumArray(List<double> A1) {
    double sum = 0;
    for (int i = 0; i < A1.length; i++) {
      sum += A1[i];
    }
    return sum;
  }

  _WebEfctivLength_Ix(
      double E, double f, double length, double thikcness, double Ycg) {
    double f1, f2, fi, k, lamda;
    List<double> B = new List(2);
    f1 = (Ycg - (raduis + thikcness / 2)) / Ycg * f;
    f2 = -(length + (raduis + thikcness / 2) - Ycg) / Ycg * f;
    fi = f2 / f1;
    k = 4 + 2 * pow(1 - fi, 3) + 2 * (1 - fi);
    lamda = 1.052 / sqrt(k) * length / thikcness * sqrt(f1 / E);
    double l_efective = _MinemiseAccordLamda(lamda) * length;
    double b1 = l_efective / (3 - fi);
    double b2;
    if (fi > -0.236) {
      b2 = l_efective - b1;
    } else {
      b2 = l_efective / 2;
      if (b1 + b2 > Ycg - t / 2 - raduis) {
        b2 = Ycg - b1 - t / 2 - raduis;
      }
    }
    B[0] = b1;
    B[1] = b2;
    return B;
  }

  _WebEfctivLength_A(double E, double f, double length, double thikcness) {
    double k, lamda, Lefective;
    k = 4;
    lamda = 1.052 / sqrt(k) * (length / thikcness) * sqrt(f / E);
    Lefective = _MinemiseAccordLamda(lamda) * length;
    return Lefective;
  }

  _FlangefectivLengthWithStiffiner(
      double E,
      double f,
      double length,
      double thikcness,
      double S_length,
      double S_thickness,
      double raduis,
      double alfa /*Rad*/) {
    List<double> C = new List(2);
    if (S_length == 0) {
      C[0] = _FlangefectivLengthWithoutStiffiner(E, f, length, thikcness);
      C[1] = 0;
      return C;
    }
    double n = 0.5, k = 0, Ia = 0, D = 0, Is, lamda, c1 = 0, c2 = 2;
    double S = 1.28 * sqrt(E / f);
    if (length / thikcness <= S / 3) {
      Ia = 0; //No edge Stiffener needed
      c1 = c2 = 1;
      C[0] = c1 * length / 2;
      C[1] = c2 * length / 2;
      return C;
    } else if (length / thikcness >= S) {
      n = 1 / 3;
      Ia = pow(thikcness, 4) * (115 * ((length / thikcness) / S) + 5);
    } else {
      n = 0.5;
      Ia = 399 * pow(thikcness, 4) * pow((length / thikcness) / S - 0.33, 3);
    }
    D = S_length + (raduis + t / 2) * tan(alfa / 2);
    double sinAlfa = sin(alfa);
    Is = pow(S_length, 3) * S_thickness * pow(sinAlfa, 2) / 12;
    if (D / length > 0.25 && D / b <= 0.8) {
      k = (4.82 - 5 * (D / length)) * pow(Is / Ia, n) + 0.43;
      if (k > 5.25 - 5 * (D / b)) {
        k = 5.25 - 5 * (D / b);
      }
    } else if (D / length <= 0.25) {
      k = 3.57 * pow(Is / Ia, n) + 0.43;
      if (k > 4) {
        k = 4;
      }
    }
    //Strength
    lamda = 1.052 / sqrt(k) * length / thikcness * sqrt(f / E);
    double L_efectiv = _MinemiseAccordLamda(lamda) * length;
    if (k == 0) {
      L_efectiv = length;
    }
    if (Is / Ia > 1) {
      c2 = c1 = 1;
    } else {
      c2 = Is / Ia;
      c1 = 2 - c2;
    }
    C[0] = c1 * L_efectiv / 2;
    C[1] = c2 * L_efectiv / 2;
    return C;
  }

  static _StiffenerefectivLength(
      double E,
      double f,
      double Flang_length,
      double thikcness,
      double S_length,
      double S_thickness,
      double raduis,
      double alfa /*Rad*/) {
    double Ia = 0, Is;
    double S = 1.28 * sqrt(E / f);
    double Effict_length = S_length;
    if (Effict_length == 0) {
      return Effict_length;
    }
    if (Flang_length / thikcness <= S / 3) {
    } else if (Flang_length / thikcness >= S) {
      Ia = pow(thikcness, 4) * (115 * ((Flang_length / thikcness) / S) + 5);
    } else {
      Ia = 399 *
          pow(thikcness, 4) *
          pow((Flang_length / thikcness) / S - 0.33, 3);
    }
    double sinAlfa = sin(alfa);
    Is = pow(S_length, 3) * S_thickness * pow(sinAlfa, 2) / 12;
    //Strength
    Effict_length =
        _FlangefectivLengthWithoutStiffiner(E, f, S_length, S_thickness);
    if (Is / Ia > 1) {
    } else {
      Effict_length = Effict_length * (Is / Ia);
    }
    return Effict_length;
  }

  static _FlangefectivLengthWithoutStiffiner(
      double E, double f, double length, double thikcness) {
    double k, lamda, Lefective;
    k = 0.43;
    lamda = 1.052 / sqrt(k) * length / thikcness * sqrt(f / E);
    Lefective = _MinemiseAccordLamda(lamda) * length;
    return Lefective;
  }

  static _MinemiseAccordLamda(double lamda) {
    double rou = 1;
    if (lamda <= 0.673) {
      rou = 1;
    } else if (lamda > 0.673) {
      rou = (1 - 0.22 / lamda) / lamda;
    }
    return rou;
  }

  List<String> getname_detail() {
    String h = 'h = ';
    String w = 'w = ';
    String r = 'r = ';
    String t = 't = ';
    String A = 'A = ';
    String Iy = 'Iy = ';
    String Wely = 'Wely = ';
    String Wely_eff = 'Wy-eff = ';
    String Iyz = 'Iyz ';
    String Iy2 = 'Iy2 ';
    String Iz2 = 'Iz2 ';
    String Iz = 'Iz = ';
    String Welz = 'Welz = ';
    String ez = 'ez = ';
    String g = 'g = ';
    String ry = 'rY = ';
    String rz = 'rZ = ';
    String teta = 'ϴ = ';
    String rminy2 = 'rMin_y2 = ';
    String rminz2 = 'rMin_z2 = ';
    String h_lip = 'h_lip = ';
    String m = 'm = ';
    String x0 = 'X0 = ';

    String deflection = 'Deflection';
    String L_flang = 'L_Flange = ';
    String C1 = 'C1 = ';
    String C2 = 'C2 = ';
    String L_web = 'L_web = ';
    String b1 = 'b1 = ';
    String b2 = 'b2 = ';
    String Ls = 'Ls = ';
    String Ls_effect = 'Ls_Eff = ';
    String ycg = 'Ycg = ';
    String alfa = 'alfa = ';
    String Ix_effective = 'Iy_effective= ';
    String A_effective = 'A_effective= ';
    String SaftyFactor = 'Փ = ';
    String fd = 'fd =';
    String Ma = 'Ma = ';

    List<String> name = new List();
    switch (details) {
      case "general":
        //default:
        switch (x_section) {
          case "z_without":
            {
              if (cold) {
                name.add((h));
                name.add((w));
                name.add((r));
                name.add((t));
                name.add((A));
                name.add((Iy));
                name.add((ry));
                name.add((Iz));
                name.add((rz));
                name.add((Iyz));
                name.add((teta));
                name.add((Iy2));
                name.add((rminy2));
                name.add((Iz2));
                name.add((rminz2));
                name.add((g));
              } else {
                name.add((h));
                name.add((w));
                name.add((t));
                name.add((r));
                name.add((A));
                name.add((Iy));
                name.add((Wely));
                name.add((ry));
                name.add((Iz));
                name.add((Welz));
                name.add((rz));
                name.add((Iyz));
                name.add((teta));
                name.add((Iy2));
                name.add((rminy2));
                name.add((Iz2));
                name.add((rminz2));
                name.add((g));
              }
            }
            break;
          case "z_with":
            {
              if (cold) {
                name.add((h));
                name.add((w));
                name.add((h_lip));
                name.add((r));
                name.add((t));
                name.add((A));
                name.add((Iy));
                name.add((ry));
                name.add((Iz));
                name.add((rz));
                name.add((Iyz));
                name.add((teta));
                name.add((Iy2));
                name.add((rminy2));
                name.add((Iz2));
                name.add((rminz2));
                name.add((g));
              } else {
                name.add((h));
                name.add((w));
                name.add((h_lip));
                name.add((t));
                name.add((r));
                name.add((A));
                name.add((Iy));
                name.add((Wely));
                name.add((ry));
                name.add((Iz));
                name.add((Welz));
                name.add((rz));
                name.add((Iyz));
                name.add((teta));
                name.add((Iy2));
                name.add((rminy2));
                name.add((Iz2));
                name.add((rminz2));
                name.add((g));
              }
            }
            break;
          case "u_with":
          case "u_hat":
            {
              if (cold) {
                name.add((h));
                name.add((w));
                name.add((h_lip));
                name.add((r));
                name.add((t));
                name.add((ez));
                name.add((m));
                name.add((x0));
                name.add((A));
                name.add((Iy));
                name.add((ry));
                name.add((Iz));
                name.add((rz));
                name.add((g));
              } else {
                name.add((h));
                name.add((w));
                name.add((h_lip));
                name.add((t));
                name.add((r));
                name.add((ez));
                name.add((m));
                name.add((x0));
                name.add((A));
                name.add((Iy));
                name.add((Wely));
                name.add((ry));
                name.add((Iz));
                name.add((Welz));
                name.add((rz));
                name.add((g));
              }
            }
            break;
          case "u_without":
            {
              if (cold) {
                name.add((h));
                name.add((w));
                name.add((r));
                name.add((t));
                name.add((ez));
                name.add((m));
                name.add((x0));
                name.add((A));
                name.add((Iy));
                name.add((ry));
                name.add((Iz));
                name.add((rz));
                name.add((g));
              } else {
                name.add((h));
                name.add((w));
                name.add((t));
                name.add((r));
                name.add((ez));
                name.add((m));
                name.add((x0));
                name.add((A));
                name.add((Iy));
                name.add((Wely));
                name.add((ry));
                name.add((Iz));
                name.add((Welz));
                name.add((rz));
                name.add((g));
              }
            }
        }
        break;
      case "flexural":
        switch (x_section) {
          case "z_without":
          case "u_without":
            {
              {
                name.add((ycg));
                name.add((L_flang));
                name.add((C1));
                name.add((L_web));
                name.add((b1));
                name.add((b2));
                name.add((Ix_effective));
                name.add((Wely_eff));
                name.add((A_effective));
                name.add((deflection));
                name.add((SaftyFactor));
                name.add((fd));
                name.add((Ma));
                name.add((ycg));
                name.add((L_flang));
                name.add((C1));
                name.add((L_web));
                name.add((b1));
                name.add((b2));
                name.add((Ix_effective));
              }
            }
            break;
          case "z_with":
          case "u_with":
          case "u_hat":
            {
              {
                name.add((ycg));
                name.add((L_flang));
                name.add((C1));
                name.add((C2));
                name.add((L_web));
                name.add((b1));
                name.add((b2));
                name.add((Ls));
                name.add((Ls_effect));
                name.add((Ix_effective));
                name.add((Wely_eff));
                name.add((A_effective));
                name.add((deflection));
                name.add((SaftyFactor));
                name.add((fd));
                name.add((Ma));
                name.add((ycg));
                name.add((L_flang));
                name.add((C1));
                name.add((C2));
                name.add((L_web));
                name.add((b1));
                name.add((b2));
                name.add((Ls));
                name.add((Ls_effect));
                name.add((Ix_effective));
              }
            }
            break;
        }
        break;
      case "compression":
        switch (x_section) {
          case "u_without":
          case "z_without":
            {
              {
                name.add((ycg));
                name.add((L_flang));
                name.add((C1));
                name.add((L_web));
                name.add((b1));
                name.add((b2));
                name.add((A_effective));
              }
            }
            break;
          case "u_with":
          case "u_hat":
          case "z_with":
            {
              {
                name.add((ycg));
                name.add((L_flang));
                name.add((C1));
                name.add((C2));
                name.add((L_web));
                name.add((b1));
                name.add((b2));
                name.add((Ls));
                name.add((Ls_effect));
                name.add((A_effective));
              }
            }
            break;
        }
        break;
    }
    return name;
  }

  List<String> getvalue_detail() {
    List<String> value = new List();
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
    String mutipleanyvaluewiththickness = 'Mutiple the value by thickness';
    String deflectionDetermination = 'determination at allowable moment';
    String Mpa = 'Mpa';
    String knm = 'KN.m';
    switch (details) {
      case "general":
        //default:
        switch (x_section) {
          case "z_without":
            {
              _computeDetails();
              if (cold) {
                value.add(AFathaString + (pas) + (mm));
                value.add(BFathaString + (pas) + (mm));
                value.add(raduisString + (pas) + (mm));
                value.add((mutipleanyvaluewiththickness));
                value.add(AString + (pas) + (cm));
                value.add(IxString + (pas) + (cm3));
                value.add(rxString + (pas) + (cm));
                value.add(IyString + (pas) + (cm3));
                value.add(ryString + (pas) + (cm));
                value.add(IxyString + (pas) + (cm3));
                value.add(TetaString + (pas) + (degree));
                value.add(Ix2String + (pas) + (cm3));
                value.add(rMin_x2String + (pas) + (cm));
                value.add(Iy2String + (pas) + (cm3));
                value.add(rMin_y2String + (pas) + (cm));
                value.add(G + (pas) + (KNmm));
              } else {
                value.add(AFathaString + (pas) + (mm));
                value.add(BFathaString + (pas) + (mm));
                value.add(tString + (pas) + (mm));
                value.add(raduisString + (pas) + (mm));
                value.add(AString + (pas) + (cm2));
                value.add(IxString + (pas) + (cm4));
                value.add(WELX + (pas) + (cm3));
                value.add(rxString + (pas) + (cm));
                value.add(IyString + (pas) + (cm4));
                value.add(WELY + (pas) + (cm3));
                value.add(ryString + (pas) + (cm));
                value.add(IxyString + (pas) + (cm4));
                value.add(TetaString + (pas) + (degree));
                value.add(Ix2String + (pas) + (cm4));
                value.add(rMin_x2String + (pas) + (cm));
                value.add(Iy2String + (pas) + (cm4));
                value.add(rMin_y2String + (pas) + (cm));
                value.add(G + (pas) + (KNmm));
              }
            }
            break;
          case "z_with":
            {
              _computeDetails();
              if (cold) {
                value.add(AFathaString + (pas) + (mm));
                value.add(BFathaString + (pas) + (mm));
                value.add(CFathaString + (pas) + (mm));
                value.add(raduisString + (pas) + (mm));
                value.add((mutipleanyvaluewiththickness));
                value.add(AString + (pas) + (cm));
                value.add(IxString + (pas) + (cm3));
                value.add(rxString + (pas) + (cm));
                value.add(IyString + (pas) + (cm3));
                value.add(ryString + (pas) + (cm));
                value.add(IxyString + (pas) + (cm3));
                value.add(TetaString + (pas) + (degree));
                value.add(Ix2String + (pas) + (cm3));
                value.add(rMin_x2String + (pas) + (cm));
                value.add(Iy2String + (pas) + (cm3));
                value.add(rMin_y2String + (pas) + (cm));
                value.add(G + (pas) + (KNmm));
              } else {
                value.add(AFathaString + (pas) + (mm));
                value.add(BFathaString + (pas) + (mm));
                value.add(CFathaString + (pas) + (mm));
                value.add(tString + (pas) + (mm));
                value.add(raduisString + (pas) + (mm));
                value.add(AString + (pas) + (cm2));
                value.add(IxString + (pas) + (cm4));
                value.add(WELX + (pas) + (cm3));
                value.add(rxString + (pas) + (cm));
                value.add(IyString + (pas) + (cm4));
                value.add(WELY + (pas) + (cm3));
                value.add(ryString + (pas) + (cm));
                value.add(IxyString + (pas) + (cm4));
                value.add(TetaString + (pas) + (degree));
                value.add(Ix2String + (pas) + (cm4));
                value.add(rMin_x2String + (pas) + (cm));
                value.add(Iy2String + (pas) + (cm4));
                value.add(rMin_y2String + (pas) + (cm));
                value.add(G + (pas) + (KNmm));
              }
            }
            break;
          case "u_with":
          case "u_hat":
            {
              _computeDetails();
              if (cold) {
                value.add(AFathaString + (pas) + (mm));
                value.add(BFathaString + (pas) + (mm));
                value.add(CFathaString + (pas) + (mm));
                value.add(raduisString + (pas) + (mm));
                value.add((mutipleanyvaluewiththickness));
                value.add(exString + (pas) + (mm));
                value.add(mString + (pas) + (mm));
                value.add(x0String + (pas) + (mm));
                value.add(AString + (pas) + (cm));
                value.add(IxString + (pas) + (cm3));
                value.add(rxString + (pas) + (cm));
                value.add(IyString + (pas) + (cm3));
                value.add(ryString + (pas) + (cm));
                value.add(G + (pas) + (KNmm));
              } else {
                value.add(AFathaString + (pas) + (mm));
                value.add(BFathaString + (pas) + (mm));
                value.add(CFathaString + (pas) + (mm));
                value.add(tString + (pas) + (mm));
                value.add(raduisString + (pas) + (mm));
                value.add(exString + (pas) + (mm));
                value.add(mString + (pas) + (mm));
                value.add(x0String + (pas) + (mm));
                value.add(AString + (pas) + (cm2));
                value.add(IxString + (pas) + (cm4));
                value.add(WELX + (pas) + (cm3));
                value.add(rxString + (pas) + (cm));
                value.add(IyString + (pas) + (cm4));
                value.add(WELY + (pas) + (cm3));
                value.add(ryString + (pas) + (cm));
                value.add(G + (pas) + (KNmm));
              }
            }
            break;
          case "u_without":
            {
              _computeDetails();
              if (cold) {
                value.add(AFathaString + (pas) + (mm));
                value.add(BFathaString + (pas) + (mm));
                value.add(raduisString + (pas) + (mm));
                value.add((mutipleanyvaluewiththickness));
                value.add(exString + (pas) + (mm));
                value.add(mString + (pas) + (mm));
                value.add(x0String + (pas) + (mm));
                value.add(AString + (pas) + (cm));
                value.add(IxString + (pas) + (cm3));
                value.add(rxString + (pas) + (cm));
                value.add(IyString + (pas) + (cm3));
                value.add(ryString + (pas) + (cm));
                value.add(G + (pas) + (KNmm));
              } else {
                value.add(AFathaString + (pas) + (mm));
                value.add(BFathaString + (pas) + (mm));
                value.add(tString + (pas) + (mm));
                value.add(raduisString + (pas) + (mm));
                value.add(exString + (pas) + (mm));
                value.add(mString + (pas) + (mm));
                value.add(x0String + (pas) + (mm));
                value.add(AString + (pas) + (cm2));
                value.add(IxString + (pas) + (cm4));
                value.add(WELX + (pas) + (cm3));
                value.add(rxString + (pas) + (cm));
                value.add(IyString + (pas) + (cm4));
                value.add(WELY + (pas) + (cm3));
                value.add(ryString + (pas) + (cm));
                value.add(G + (pas) + (KNmm));
              }
            }
            break;
        }
        break;
      case "flexural":
        switch (x_section) {
          case "z_without":
          case "u_without":
            {
              _computeDetails();
              value.add(YcgString + (pas) + (mm));
              value.add(L_flangString + (pas) + (mm));
              value.add(c1String + (pas) + (mm));
              value.add(L_webString + (pas) + (mm));
              value.add(b1String + (pas) + (mm));
              value.add(b2String + (pas) + (mm));
              value.add(IxEfectivString + (pas) + (cm4));
              value.add(_roundToString(double.parse(IxEfectivString) / (double.parse(YcgString)/10)) + (pas) + (cm3));
              value.add(AEfectiv_IString + (pas) + (cm2));
              value.add((deflectionDetermination));
              value.add(SafetycoefficientString);
              value.add(f_dString + (pas) + (Mpa));
              value.add(MaString + (pas) + (knm));
              value.add(Ycg_dString + (pas) + (mm));
              value.add(L_flangString + (pas) + (mm));
              value.add(c1_dString + (pas) + (mm));
              value.add(L_webString + (pas) + (mm));
              value.add(b1_dString + (pas) + (mm));
              value.add(b2_dString + (pas) + (mm));
              value.add(IxEfectiv_dString + (pas) + (cm4));
            }
            break;
          case "z_with":
            {
              _computeDetails();
              value.add(YcgString + (pas) + (mm));
              value.add(L_flangString + (pas) + (mm));
              value.add(c1String + (pas) + (mm));
              value.add(c2String + (pas) + (mm));
              value.add(L_webString + (pas) + (mm));
              value.add(b1String + (pas) + (mm));
              value.add(b2String + (pas) + (mm));
              value.add(LsString + (pas) + (mm));
              value.add(LsEffectString + (pas) + (mm));
              value.add(IxEfectivString + (pas) + (cm4));
              value.add(_roundToString(double.parse(IxEfectivString) / (double.parse(YcgString)/10)) + (pas) + (cm3));
              value.add(AEfectiv_IString + (pas) + (cm2));
              value.add((deflectionDetermination));
              value.add(SafetycoefficientString);
              value.add(f_dString + (pas) + (Mpa));
              value.add(MaString + (pas) + (knm));
              value.add(Ycg_dString + (pas) + (mm));
              value.add(L_flangString + (pas) + (mm));
              value.add(c1_dString + (pas) + (mm));
              value.add(c2_dString + (pas) + (mm));
              value.add(L_webString + (pas) + (mm));
              value.add(b1_dString + (pas) + (mm));
              value.add(b2_dString + (pas) + (mm));
              value.add(LsString + (pas) + (mm));
              value.add(LsEffect_dString + (pas) + (mm));
              value.add(IxEfectiv_dString + (pas) + (cm4));
            }
            break;
          case "u_with":
          case "u_hat":
            {
              _computeDetails();
              value.add(_roundToString(AFatha - Ycg) + (pas) + (mm));
              value.add(L_flangString + (pas) + (mm));
              value.add(c1String + (pas) + (mm));
              value.add(c2String + (pas) + (mm));
              value.add(L_webString + (pas) + (mm));
              value.add(b1String + (pas) + (mm));
              value.add(b2String + (pas) + (mm));
              value.add(LsString + (pas) + (mm));
              value.add(LsEffectString + (pas) + (mm));
              value.add(IxEfectivString + (pas) + (cm4));
              value.add(_roundToString(double.parse(IxEfectivString) / Ycg*10) + (pas) + (cm3));
              value.add(AEfectiv_IString + (pas) + (cm2));
              value.add((deflectionDetermination));
              value.add(SafetycoefficientString);
              value.add(f_dString + (pas) + (Mpa));
              value.add(MaString + (pas) + (knm));
              value.add(_roundToString(AFatha - Ycg_d) + (pas) + (mm));
              value.add(L_flangString + (pas) + (mm));
              value.add(c1_dString + (pas) + (mm));
              value.add(c2_dString + (pas) + (mm));
              value.add(L_webString + (pas) + (mm));
              value.add(b1_dString + (pas) + (mm));
              value.add(b2_dString + (pas) + (mm));
              value.add(LsString + (pas) + (mm));
              value.add(LsEffect_dString + (pas) + (mm));
              value.add(IxEfectiv_dString + (pas) + (cm4));
            }
            break;
        }
        break;
      case "compression":
        switch (x_section) {
          case "z_without":
          case "u_without":
            {
              _computeDetails();
              value.add(_roundToString(AFatha / 2) + (pas) + (mm));
              value.add(L_flangString + (pas) + (mm));
              value.add(c1String + (pas) + (mm));
              value.add(L_webString + (pas) + (mm));
              value.add(_roundToString(bA_eff / 2) + (pas) + (mm));
              value.add(_roundToString(bA_eff / 2) + (pas) + (mm));
              value.add(AEfectivString + (pas) + (cm2));
            }
            break;
          case "z_with":
            {
              _computeDetails();
              value.add(_roundToString(AFatha / 2) + (pas) + (mm));
              value.add(L_flangString + (pas) + (mm));
              value.add(c1String + (pas) + (mm));
              value.add(c2String + (pas) + (mm));
              value.add(L_webString + (pas) + (mm));
              value.add((bA_eff / 2).toString() + (pas) + (mm));
              value.add((bA_eff / 2).toString() + (pas) + (mm));
              value.add(LsString + (pas) + (mm));
              value.add(LsEffectString + (pas) + (mm));
              value.add(AEfectivString + (pas) + (cm2));
            }
            break;
          case "u_with":
          case "u_hat":
            {
              _computeDetails();
              value.add(YcgU_compression + (pas) + (mm));
              value.add(L_flangString + (pas) + (mm));
              value.add(c1String + (pas) + (mm));
              value.add(c2String + (pas) + (mm));
              value.add(L_webString + (pas) + (mm));
              value.add((bA_eff / 2).toString() + (pas) + (mm));
              value.add((bA_eff / 2).toString() + (pas) + (mm));
              value.add(LsString + (pas) + (mm));
              value.add(LsEffectString + (pas) + (mm));
              value.add(AEfectivString + (pas) + (cm2));
            }
            break;
        }
        break;
    }
    return value;
  }
}

class Ycg_Z {
  List<double> C_ = new List(10);
  List<double> cg_ = new List(10);
  List<double> L_ = new List(10);
  double YcgLocal = 0;

  Ycg_Z(
      double c1_flang,
      double c2_flang,
      double l_stiffener,
      double raduis,
      double b1_web,
      double b2_web,
      double l_flang,
      double alfa,
      double E,
      double f,double t,double tetaEave,double AFatha,double b) {
    double l_corner90 = 1.57 * raduis;
    double c_corner90 = 0.637 * raduis;
    double ls_eff =
        ComputeDetails._StiffenerefectivLength(E, f, l_flang, t, l_stiffener, t, raduis, alfa);
    double cosTetaEave = cos(tetaEave * pi / 180);
    double sinTetaEave = sin(tetaEave * pi / 180);
    double tanTetaEave = tan(tetaEave * pi / 180);
    Offset p1, p0, p6, p7, BaseRotate = new Offset(0, -raduis * cosTetaEave);
    p1 = new Offset(0, 0);
    p0 = new Offset(p1.dx + (b + raduis * sinTetaEave) * cosTetaEave,
        p1.dy + (b) * sinTetaEave);
    p6 = new Offset(p0.dx + raduis * (cosTetaEave + sinTetaEave),
        p0.dy - raduis * cosTetaEave * (1 - tanTetaEave));
    p7 = new Offset(p6.dx + ls_eff * sinTetaEave, p6.dy - ls_eff * cosTetaEave);
    double tetaEaveRaduis = (90 - tetaEave) * pi / 180;
    double l_cornerAlfa = alfa * raduis;
    double c_cornerAlfa;
    if (alfa == 0) {
      c_cornerAlfa = 0;
    } else {
      c_cornerAlfa = sin(alfa) / alfa * raduis;
    }
    double //c المسافة الى أعلى ليف
        c_b1 = b1_web / 2 + (raduis + t / 2) * cosTetaEave,
        c_b2 = AFatha - (b2_web / 2 + raduis + t / 2),
        c_c1 = t / 2 * cosTetaEave -
            (c1_flang * sinTetaEave / 2 +
                    p0.dy -
                    (c2_flang) * sinTetaEave / 2) /
                2,
        c_compStiffener = raduis * (1 - cos(alfa)) +
            ls_eff / 2 * sin(alfa) +
            t / 2 * cosTetaEave,
        c_compCorner90 = raduis * cosTetaEave -
            raduis * (1 - sinTetaEave) / tetaEaveRaduis +
            t / 2 * cosTetaEave,
        c_compCornerAlfa = raduis - c_cornerAlfa + t / 2 * cosTetaEave,
        c_tenCorner90 = AFatha - raduis + c_corner90 - t / 2,
        c_tenpCornerAlfa = AFatha - raduis + c_cornerAlfa - t / 2,
        c_tenStiffener = AFatha -
            (raduis * (1 - cos(alfa)) + l_stiffener / 2 * sin(alfa) + t / 2),
        c_tenFlange = AFatha - t / 2;
    if (cos(alfa) == 0) {
      c_compStiffener = t / 2 * cosTetaEave - (p6.dy + p7.dy) / 2;
      c_compCornerAlfa = t / 2 * cosTetaEave +
          p0.dy +
          0.363 * raduis * (1 - sinTetaEave) * cosTetaEave;
    }
    C_[0] = c_compStiffener;
    C_[1] = c_compCornerAlfa;
    C_[2] = c_c1;
    C_[3] = c_compCorner90;
    C_[4] = c_b1;
    C_[5] = c_b2;
    C_[6] = c_tenCorner90;
    C_[7] = c_tenFlange;
    C_[8] = c_tenpCornerAlfa;
    C_[9] = c_tenStiffener;
    L_[0] = ls_eff;
    L_[1] = l_cornerAlfa;
    L_[2] = c1_flang + c2_flang;
    L_[3] = l_corner90;
    L_[4] = b1_web;
    L_[5] = b2_web;
    L_[6] = l_corner90;
    L_[7] = l_flang;
    L_[8] = l_cornerAlfa;
    L_[9] = l_stiffener;
    YcgLocal = ComputeDetails._multipArray(L_, C_) / ComputeDetails._sumArray(L_);
    for (int i = 0; i < cg_.length; i++) {
      cg_[i] = (YcgLocal - C_[i]).abs();
    }
  }
}
