import 'dart:math';

class computeDetailsWelded {
  String x_section;
  double t_plate, b_plate, h, b_Top, tw, t, tf_Top, b_Bottom, tf_Bottom, e, ep,
      w, w1, w2, w3, v1, v2, v3, d, A, Iy, Iz, Iu, Iv, Wely, Welz, iy, iz,
      sy_Top, sy_Bottom, sz, g, Wply, Wplz, It, Iw, wt, ey, ez, ym, In, Weln,
      Izeta, Welzeta, izeta, alfa, twC, hC, aC, IyC, IzC, ezC, WplyC;
  String H, T_plate, B_plate, B_Top, B_Bottom, Tw, Tf_Top, Tf_Bottom, T, E, EP,
      W, W1, W2, W3, V1, V2, V3, D, Area, IY, IZ, IU, IV, WELY, WELZ, iY, iZ,
      sY_Top, sY_Bottom, G, WPLZ, WPLY, IT, WT, IW, eY, eZ, YM, IN, WELN, iN,
      IZeta, WELZeta, iZeta, Alfa, nameC;

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

  computeDetailsWelded(String x_section, double h, double b_Top, double tw,
      double tf_Top, double b_Bottom, double tf_Bottom, double t_plate,
      double b_plate, String nameC, double twC, double hC, double aC,
      double IyC, double IzC, double WplyC, double ezC, double alfa) {
    this.t_plate = this.b_plate = this.h = this.b_Top = this.tw = this.t =
        this.tf_Top = this.b_Bottom = this.tf_Bottom = this.e = this.ep = this
        .w = this.w1 = this.w2 = this.w3 = this.v1 = this.v2 = this.v3 =
        this.d = this.A = this.Iy = this.Iz = this.Iu = this.Iv = this.Wely =
        this.Welz = this.iy = this.iz = this.sy_Top = this.sy_Bottom = this.sz =
        this.g = this.Wply = this.Wplz = this.It = this.Iw = this.wt = this.ey =
        this.ez = this.ym = this.In = this.Weln = this.Izeta = this.Welzeta =
        this.izeta = this.alfa = this.twC = this.hC = this.aC = this.IyC =
        this.IzC = this.ezC = this.WplyC = 0;


    this.x_section = x_section;
    this.h = h;
    this.tw = tw;
    this.b_Top = b_Top;
    this.tf_Top = tf_Top;
    this.b_Bottom = b_Bottom;
    this.tf_Bottom = tf_Bottom;
    d = h - tf_Bottom - tf_Top;
    this.t_plate = t_plate;
    this.b_plate = b_plate;
    this.nameC = nameC;
    this.hC = hC;
    this.aC = aC;
    this.twC = twC;
    this.IyC = IyC;
    this.IzC = IzC;
    this.ezC = ezC;
    this.WplyC = WplyC;
    this.alfa = alfa;
  }

  void computeDetails(String x_section, double h, double b_Top, double tw,
      double tf_Top, double b_Bottom, double tf_Bottom) {
    this.x_section = x_section;
    this.h = h;
    this.tw = tw;
    this.b_Top = b_Top;
    this.tf_Top = tf_Top;
    this.b_Bottom = b_Bottom;
    this.tf_Bottom = tf_Bottom;
    d = h - tf_Bottom - tf_Top - t_plate - twC;
    switch (x_section) {
      case "weldI_equalFlange":
      case "weldI_unequalFlange":
        {
          this.A = tf_Bottom * b_Bottom + tf_Top * b_Top + tw * d; //mm^2
          this.e = (b_Top * tf_Top * (tf_Top / 2) +
              b_Bottom * tf_Bottom * (d + tf_Top + tf_Bottom / 2) +
              tw * d * (tf_Top + d / 2)) / A;
          this.Iy = b_Top * pow(tf_Top, 3) / 12 +
              b_Top * tf_Top * pow(e - tf_Top / 2, 2)
              + b_Bottom * pow(tf_Bottom, 3) / 12 +
              b_Bottom * tf_Bottom * pow(d - e + tf_Top + tf_Bottom / 2, 2)
              + tw * pow(d, 3) / 12 + d * tw * pow(d / 2 - e + tf_Top, 2);
          this.Iz = pow(b_Top, 3) * tf_Top / 12
              + pow(b_Bottom, 3) * tf_Bottom / 12
              + pow(tw, 3) * d / 12;
          this.Wely = Iy / max(e, h - e); //mm^3
          this.Welz = Iz / max(b_Bottom, b_Top) * 2; //mm^3
          this.iy = pow(Iy / A, 0.5); //mm
          this.iz = pow(Iz / A, 0.5); //mm
          double a1 = b_Top * tf_Top,
              a3 = b_Bottom * tf_Bottom,
              a2 = tw * d;
          if (a1 < a2 + a3) {
            this.ep = (a3 + tw * d - a1) / 2 / tw;
          }
          this.sy_Top = b_Top * tf_Top * (ep - tf_Top / 2)
              + tw * pow(ep - tf_Top, 2) / 2;
          this.sy_Bottom =
              b_Bottom * tf_Bottom * (d - ep + tf_Top + tf_Bottom / 2)
                  + tw * pow(d - ep + tf_Top, 2) / 2;
          this.Wplz = (b_Top * tf_Top * b_Top / 8
              + b_Bottom * tf_Bottom * b_Bottom / 8
              + d * pow(tw, 2) / 8) * 2;
          this.Wply = sy_Bottom + sy_Top;
          this.g = 78.5 * A / 1000000; //KN/mm
        }
        break;
      case "weldI_withPlate":
        {
          double a1 = b_Top * tf_Top,
              a3 = b_Bottom * tf_Bottom,
              a2 = tw * d,
              a_plate = t_plate * b_plate;
          this.A = a1 + a2 + a3 + a_plate; //mm^2
          this.e = (a_plate * t_plate / 2 + a1 * (tf_Top / 2 + t_plate) +
              a2 * (d / 2 + tf_Top + t_plate) + a3 * (h - tf_Bottom / 2)) / A;
          this.Iy =
              b_plate * pow(t_plate, 3) / 12 + a_plate * (-t_plate / 2 + e)
                  + b_Top * pow(tf_Top, 3) / 12 +
                  b_Top * tf_Top * pow(e - tf_Top / 2 - t_plate, 2)
                  + b_Bottom * pow(tf_Bottom, 3) / 12 + b_Bottom * tf_Bottom *
                  pow(d - e + tf_Top + t_plate + tf_Bottom / 2, 2)
                  + tw * pow(d, 3) / 12 +
                  d * tw * pow(d / 2 - e + tf_Top + t_plate, 2);
          this.Iz = pow(b_Top, 3) * tf_Top / 12
              + pow(b_Bottom, 3) * tf_Bottom / 12
              + pow(tw, 3) * d / 12
              + pow(b_plate, 3) * t_plate / 12;
          this.Wely = Iy / max(e, h - e); //mm^3
          this.Welz = Iz / max(b_Bottom, max(b_plate, b_Top)) * 2; //mm^3
          this.iy = pow(Iy / A, 0.5); //mm
          this.iz = pow(Iz / A, 0.5); //mm
          if (a1 + a_plate < a2 + a3) {
            this.ep = (a3 + tw * d - a1 - a_plate) / 2 / tw;
            this.sy_Top = a_plate * (ep - t_plate / 2)
                + b_Top * tf_Top * (ep - tf_Top / 2 - t_plate)
                + tw * pow(ep - tf_Top - t_plate, 2) / 2;
            this.sy_Bottom = b_Bottom * tf_Bottom *
                (d - ep + tf_Top + t_plate + tf_Bottom / 2)
                + tw * pow(d - ep + tf_Top + t_plate, 2) / 2;
          } else if (a_plate < a1 + a2 + a3) {
            this.ep = (a3 + tw * d + a1 - a_plate) / 2 / b_Top;
            this.sy_Top = a_plate * (ep - t_plate / 2)
                + b_Top * (ep - t_plate) * ((ep - t_plate) / 2 + t_plate);
            this.sy_Bottom = b_Bottom * tf_Bottom *
                (d - ep + tf_Top + t_plate + tf_Bottom / 2)
                + a2 * pow(d / 2 - ep + tf_Top + t_plate, 1) / 2
                + tf_Top * pow(tf_Top + t_plate - ep, 2) / 2;
          }
          this.Wplz = (b_plate * t_plate * b_plate / 8
              + b_Top * tf_Top * b_Top / 8
              + b_Bottom * tf_Bottom * b_Bottom / 8
              + d * pow(tw, 2) / 8) * 2;
          this.Wply = sy_Bottom + sy_Top;
          this.g = 78.5 * A / 1000000; //KN/mm
        }
        break;
      case "weldI_withChannelle":
        {
          double a1 = b_Top * tf_Top,
              a3 = b_Bottom * tf_Bottom,
              a2 = tw * d;
          this.A = a1 + a2 + a3 + aC; //mm^2
          this.e = (aC * ezC + a1 * (tf_Top / 2 + twC) +
              a2 * (d / 2 + tf_Top + twC) + a3 * (h - tf_Bottom / 2)) / A;
          this.Iy = IzC + aC * (-ez + e)
              + b_Top * pow(tf_Top, 3) / 12 +
              b_Top * tf_Top * pow(e - tf_Top / 2 - twC, 2)
              + b_Bottom * pow(tf_Bottom, 3) / 12 + b_Bottom * tf_Bottom *
              pow(d - e + tf_Top + twC + tf_Bottom / 2, 2)
              + tw * pow(d, 3) / 12 + d * tw * pow(d / 2 - e + tf_Top + twC, 2);
          this.Iz = IyC
              + pow(b_Bottom, 3) * tf_Bottom / 12
              + pow(tw, 3) * d / 12
              + pow(b_plate, 3) * t_plate / 12;
          this.Wely = Iy / max(e, h - e); //mm^3
          this.Welz = Iz / max(b_Bottom, max(hC, b_Top)) * 2; //mm^3
          this.iy = pow(Iy / A, 0.5); //mm
          this.iz = pow(Iz / A, 0.5); //mm
          if (a1 + aC < a2 + a3) {
            this.ep = (a3 + tw * d - a1 - aC) / 2 / tw;
            this.sy_Top = aC * (ep - twC / 2)
                + b_Top * tf_Top * (ep - tf_Top / 2 - twC)
                + tw * pow(ep - tf_Top - twC, 2) / 2;
            this.sy_Bottom =
                b_Bottom * tf_Bottom * (d - ep + tf_Top + twC + tf_Bottom / 2)
                    + tw * pow(d - ep + tf_Top + twC, 2) / 2;
          } else if (aC < a1 + a2 + a3) {
            this.ep = (a3 + tw * d + a1 - aC) / 2 / b_Top;
            this.sy_Top = aC * (ep - twC / 2)
                + b_Top * (ep - twC) * ((ep - twC) / 2 + twC);
            this.sy_Bottom =
                b_Bottom * tf_Bottom * (d - ep + tf_Top + twC + tf_Bottom / 2)
                    + a2 * pow(d / 2 - ep + tf_Top + twC, 1) / 2
                    + tf_Top * pow(tf_Top + twC - ep, 2) / 2;
          }
          this.Wplz = (WplyC / 2
              + b_Top * tf_Top * b_Top / 8
              + b_Bottom * tf_Bottom * b_Bottom / 8
              + d * pow(tw, 2) / 8) * 2;
          this.Wply = sy_Bottom + sy_Top;
          this.g = 78.5 * A / 1000000; //KN/mm
        }
        break;
      case "weldBox_parallelFlange":
        {
          double A_top = b_Top * tf_Top,
              A_bottom = b_Bottom * tf_Bottom,
              A_web = h * tw;
          A = A_bottom + A_top + A_web * 2;
          e = (A_top * tf_Top / 2 + A_web * (tf_Top + h / 2) * 2 +
              A_bottom * (tf_Bottom / 2 + tf_Top + h)) / A;
          Iy = pow(tf_Top, 3) * b_Top / 12 + A_top * pow(e - tf_Top / 2, 2)
              + pow(tf_Bottom, 3) * b_Bottom / 12 +
              A_bottom * pow(h + tf_Top - e + tf_Bottom / 2, 2)
              + (pow(h, 3) * tw / 12 + A_web * pow(h / 2 + tf_Top - e, 2)) * 2;
          Iz = pow(b_Top, 3) * tf_Top / 12
              + pow(tf_Bottom, 3) * b_Bottom / 12
              + (pow(tw, 3) * h / 12 + A_web * pow(b_Top / 2 - tw / 2, 2)) * 2;
          this.Wely = Iy / max(e, h + tf_Top + tf_Bottom - e); //mm^3
          this.Welz = Iz / b_Bottom * 2; //mm^3
          this.iy = pow(Iy / A, 0.5); //mm
          this.iz = pow(Iz / A, 0.5); //mm
          this.ep = (A_bottom - A_top) / (4 * tw) + h / 2 + tf_Top;
          this.sy_Top = A_top * (ep - tf_Top / 2) + tw * pow(ep - tf_Top, 2);
          this.sy_Bottom = A_bottom * (h + tf_Top + tf_Bottom / 2 - ep) +
              tw * pow(tf_Top + h - ep, 2);
          this.Wply = sy_Top + sy_Bottom;
          this.Wplz = (A_web * (b_Top / 2 - tw / 2) + A_top * b_Top / 8 +
              A_bottom * b_Bottom / 8) * 2;
          d = h;
          this.h = tf_Bottom + tf_Top + d;
          this.g = 78.5 * A / 1000000; //KN/mm
        }
        break;
      case "weldBox_unParallelFlange":
        {
          double lengthWeb = h;
          h = lengthWeb * sin(alfa); //المسافة الموازية للمحور Z
          double A_top = b_Top * tf_Top,
              A_bottom = b_Bottom * tf_Bottom,
              A_web = lengthWeb * tw;
          A = A_bottom + A_top + A_web * 2;
          e = (A_top * tf_Top / 2 + A_web * (tf_Top + h / 2) * 2 +
              A_bottom * (tf_Bottom / 2 + tf_Top + h)) / A;

          Iy = pow(tf_Top, 3) * b_Top / 12 + A_top * pow(e - tf_Top / 2, 2)
              + pow(tf_Bottom, 3) * b_Bottom / 12 +
              A_bottom * pow(h + tf_Top - e + tf_Bottom / 2, 2)
              + (pow(h, 3) * tw / 12 + A_web * pow(h / 2 + tf_Top - e, 2)) * 2;

          Iz = pow(b_Top, 3) * tf_Top / 12
              + pow(tf_Bottom, 3) * b_Bottom / 12
              + (pow(tw, 3) * h / 12 + A_web *
                  pow((b_Top - tw) / 2 - lengthWeb / 2 * cos(alfa), 2)) * 2;

          this.Wely = Iy / max(e, h + tf_Top + tf_Bottom - e); //mm^3
          this.Welz = Iz / max(b_Bottom / 2, b_Top / 2); //mm^3
          this.iy = pow(Iy / A, 0.5); //mm
          this.iz = pow(Iz / A, 0.5); //mm
          this.ep = (A_bottom - A_top) / (4 * tw / sin(alfa)) + h / 2 + tf_Top;
          this.sy_Top =
              A_top * (ep - tf_Top / 2) + tw * pow(ep - tf_Top, 2) / sin(alfa);
          this.sy_Bottom = A_bottom * (h + tf_Top + tf_Bottom / 2 - ep) +
              tw * pow(tf_Top + h - ep, 2) / sin(alfa);
          this.Wply = sy_Top + sy_Bottom;
          this.Wplz = (A_web * ((b_Top - tw) / 2 - lengthWeb / 2 * cos(alfa)) +
              A_top * b_Top / 8 + A_bottom * b_Bottom / 8) * 2;
          d = h;
          this.h = tf_Bottom + tf_Top + d;
          this.g = 78.5 * A / 1000000; //KN/mm
        }
        break;
    }
    _set_stringdetails();
  }

  _set_stringdetails() {
    this.H = roundToString(h);
    this.B_Bottom = b_Bottom.toString();
    this.B_Top = b_Top.toString();
    this.B_plate = b_plate.toString();
    this.T_plate = t_plate.toString();
    this.Tw = tw.toString();
    this.Tf_Top = tf_Top.toString();
    this.Tf_Bottom = tf_Bottom.toString();
    this.T = t.toString();
    this.D = roundToString(d);
    this.Alfa = roundToString(0.0 + (alfa / pi * 180).round());
    this.Area = roundToString(A / 100); //cm^2
    this.IW = roundToString(Iw / 1000000); //cm^6
    this.IT = roundToString(It / 10000); //cm^4
    this.IY = roundToString(Iy / 10000); //cm^4
    this.IZ = roundToString(Iz / 10000); //cm^4
    this.IU = roundToString(Iu / 10000); //cm^4
    this.IV = roundToString(Iv / 10000); //cm^4
    this.WELY = roundToString(Wely / 1000); //cm^3
    this.WELZ = roundToString(Welz / 1000); //cm^3
    this.sY_Bottom = roundToString(sy_Bottom / 1000);
    this.sY_Top = roundToString(sy_Top / 1000);
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
    this.IZeta = roundToString(Izeta / 10000);
    this.WELZeta = roundToString(Welzeta / 1000);
    this.iZeta = roundToString(izeta / 10);
  }

  List<String> getname_detail() {
    String h = 'h = ';
    String d = 'd = ';
    String e = 'e = ';
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
    String A = 'A = ';
    String alfa = 'alfa = ';
    String Iy = 'Iy = ';
    String Wely = 'Wely = ';
    String Wply = 'Wply = ';
    String iy = 'iy = ';
    String Iz = 'Iz = ';
    String Welz = 'Welz = ';
    String Wplz = 'Wplz = ';
    String iz = 'iz = ';
    String g = 'g = ';
    List<String> name = new List();
    switch (x_section) {
      case "weldI_equalFlange":
        {
          name.add((h));
          name.add((wtfwbf));
          name.add((ttftbf));
          name.add((tw));
          name.add((d));
          name.add((A));
          name.add((Iy));
          name.add((Wely));
          name.add((iy));
          name.add((Iz));
          name.add((Welz));
          name.add((iz));
          name.add((Wply));
          name.add((Wplz));
          name.add((g));
        }
        break;
      case "weldI_unequalFlange":
        {
          name.add((h));
          name.add((wtf));
          name.add((ttf));
          name.add((wbf));
          name.add((tbf));
          name.add((tw));
          name.add((d));
          name.add((e));
          name.add((A));
          name.add((Iy));
          name.add((Wely));
          name.add((iy));
          name.add((Iz));
          name.add((Welz));
          name.add((iz));
          name.add((Wply));
          name.add((Wplz));
          name.add((g));
        }
        break;
      case "weldI_withPlate":
        {
          name.add((h));
          name.add((wplate));
          name.add((tplate));
          name.add((wtf));
          name.add((ttf));
          name.add((wbf));
          name.add((tbf));
          name.add((tw));
          name.add((d));
          name.add((e));
          name.add((A));
          name.add((Iy));
          name.add((Wely));
          name.add((iy));
          name.add((Iz));
          name.add((Welz));
          name.add((iz));
          name.add((Wply));
          name.add((Wplz));
          name.add((g));
        }
        break;
      case "weldI_withChannelle":
        {
          name.add((upn));
          name.add((h));
          name.add((wtf));
          name.add((ttf));
          name.add((wbf));
          name.add((tbf));
          name.add((tw));
          name.add((d));
          name.add((e));
          name.add((A));
          name.add((Iy));
          name.add((Wely));
          name.add((iy));
          name.add((Iz));
          name.add((Welz));
          name.add((iz));
          name.add((Wply));
          name.add((Wplz));
          name.add((g));
        }
        break;
      case "weldBox_parallelFlange":
        {
          name.add((h));
          name.add((wtfwbf));
          if (tf_Top == tf_Bottom) {
            name.add((ttftbf));
          } else {
            name.add((ttf));
            name.add((tbf));
          }
          name.add((tw));
          name.add((d));
          if (tf_Top != tf_Bottom) {
            name.add((e));
          }
          name.add((A));
          name.add((Iy));
          name.add((Wely));
          name.add((iy));
          name.add((Iz));
          name.add((Welz));
          name.add((iz));
          name.add((Wply));
          name.add((Wplz));
          name.add((g));
        }
        break;
      case "weldBox_unParallelFlange":
        {
          name.add((h));
          name.add((wtf));
          name.add((ttf));
          name.add((wbf));
          name.add((tbf));
          name.add((tw));
          name.add((d));
          if (tf_Top * b_Top != tf_Bottom * b_Bottom) {
            name.add((e));
          }
          name.add((alfa));
          name.add((A));
          name.add((Iy));
          name.add((Wely));
          name.add((iy));
          name.add((Iz));
          name.add((Welz));
          name.add((iz));
          name.add((Wply));
          name.add((Wplz));
          name.add((g));
        }
        break;
    }
    return name;
  }

  List<String> getvalue_detail() {
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
    List<String> value = new List();
    double d1 = 0;
    switch (x_section) {
      case "weldI_equalFlange":
        {
          computeDetails(
              x_section,
              h,
              b_Top,
              tw,
              tf_Top,
              b_Bottom,
              tf_Bottom);
          value.add(H + (pas) + (mm));
          value.add(B_Top + (pas) + (mm));
          value.add(Tf_Top + (pas) + (mm));
          value.add(Tw + (pas) + (mm));
          value.add(D + (pas) + (mm));
          value.add(Area + (pas) + (cm2));
          value.add(IY + (pas) + (cm4));
          value.add(WELY + (pas) + (cm3));
          value.add(iY + (pas) + (cm));
          value.add(IZ + (pas) + (cm4));
          value.add(WELZ + (pas) + (cm3));
          value.add(iZ + (pas) + (cm));
          value.add(WPLY + (pas) + (cm3));
          value.add(WPLZ + (pas) + (cm3));
          value.add(G + (pas) + (KNmm));
        }
        break;
      case "weldI_unequalFlange":
        {
          computeDetails(
              x_section,
              h,
              b_Top,
              tw,
              tf_Top,
              b_Bottom,
              tf_Bottom);
          value.add(H + (pas) + (mm));
          value.add(B_Top + (pas) + (mm));
          value.add(Tf_Top + (pas) + (mm));
          value.add(B_Bottom + (pas) + (mm));
          value.add(Tf_Bottom + (pas) + (mm));
          value.add(Tw + (pas) + (mm));
          value.add(D + (pas) + (mm));
          value.add(E + (pas) + (cm));
          value.add(Area + (pas) + (cm2));
          value.add(IY + (pas) + (cm4));
          value.add(WELY + (pas) + (cm3));
          value.add(iY + (pas) + (cm));
          value.add(IZ + (pas) + (cm4));
          value.add(WELZ + (pas) + (cm3));
          value.add(iZ + (pas) + (cm));
          value.add(WPLY + (pas) + (cm3));
          value.add(WPLZ + (pas) + (cm3));
          value.add(G + (pas) + (KNmm));
        }
        break;
      case "weldI_withPlate":
        {
          computeDetails(
              x_section,
              h,
              b_Top,
              tw,
              tf_Top,
              b_Bottom,
              tf_Bottom);
          value.add(H + (pas) + (mm));
          value.add(B_plate + (pas) + (mm));
          value.add(T_plate + (pas) + (mm));
          value.add(B_Top + (pas) + (mm));
          value.add(Tf_Top + (pas) + (mm));
          value.add(B_Bottom + (pas) + (mm));
          value.add(Tf_Bottom + (pas) + (mm));
          value.add(Tw + (pas) + (mm));
          value.add(D + (pas) + (mm));
          value.add(E + (pas) + (cm));
          value.add(Area + (pas) + (cm2));
          value.add(IY + (pas) + (cm4));
          value.add(WELY + (pas) + (cm3));
          value.add(iY + (pas) + (cm));
          value.add(IZ + (pas) + (cm4));
          value.add(WELZ + (pas) + (cm3));
          value.add(iZ + (pas) + (cm));
          value.add(WPLY + (pas) + (cm3));
          value.add(WPLZ + (pas) + (cm3));
          value.add(G + (pas) + (KNmm));
        }
        break;
      case "weldI_withChannelle":
        {
          computeDetails(
              x_section,
              h,
              b_Top,
              tw,
              tf_Top,
              b_Bottom,
              tf_Bottom);
          value.add(nameC);
          value.add(H + (pas) + (mm));
          value.add(B_Top + (pas) + (mm));
          value.add(Tf_Top + (pas) + (mm));
          value.add(B_Bottom + (pas) + (mm));
          value.add(Tf_Bottom + (pas) + (mm));
          value.add(Tw + (pas) + (mm));
          value.add(D + (pas) + (mm));
          value.add(E + (pas) + (cm));
          value.add(Area + (pas) + (cm2));
          value.add(IY + (pas) + (cm4));
          value.add(WELY + (pas) + (cm3));
          value.add(iY + (pas) + (cm));
          value.add(IZ + (pas) + (cm4));
          value.add(WELZ + (pas) + (cm3));
          value.add(iZ + (pas) + (cm));
          value.add(WPLY + (pas) + (cm3));
          value.add(WPLZ + (pas) + (cm3));
          value.add(G + (pas) + (KNmm));
        }
        break;
      case "weldBox_parallelFlange":
        {
          computeDetails(
              x_section,
              h,
              b_Top,
              tw,
              tf_Top,
              b_Bottom,
              tf_Bottom);
          value.add(H + (pas) + (mm));
          value.add(B_Top + (pas) + (mm));
          if (tf_Top == tf_Bottom) {
            value.add(Tf_Top + (pas) + (mm));
          } else {
            value.add(Tf_Top + (pas) + (mm));
            value.add(Tf_Bottom + (pas) + (mm));
          }
          value.add(Tw + (pas) + (mm));
          value.add(D + (pas) + (mm));
          if (tf_Top != tf_Bottom) {
            value.add(E + (pas) + (cm));
          }
          value.add(Area + (pas) + (cm2));
          value.add(IY + (pas) + (cm4));
          value.add(WELY + (pas) + (cm3));
          value.add(iY + (pas) + (cm));
          value.add(IZ + (pas) + (cm4));
          value.add(WELZ + (pas) + (cm3));
          value.add(iZ + (pas) + (cm));
          value.add(WPLY + (pas) + (cm3));
          value.add(WPLZ + (pas) + (cm3));
          value.add(G + (pas) + (KNmm));
        }
        break;
      case "weldBox_unParallelFlange":
        {
          computeDetails(
              x_section,
              h,
              b_Top,
              tw,
              tf_Top,
              b_Bottom,
              tf_Bottom);
          value.add(H + (pas) + (mm));
          value.add(B_Top + (pas) + (mm));
          value.add(Tf_Top + (pas) + (mm));
          value.add(B_Bottom + (pas) + (mm));
          value.add(Tf_Bottom + (pas) + (mm));
          value.add(Tw + (pas) + (mm));
          value.add(D + (pas) + (mm));
          if (tf_Top * b_Top != tf_Bottom * b_Bottom) {
            value.add(E + (pas) + (cm));
          }
          value.add(Alfa + (pas) + (degree));
          value.add(Area + (pas) + (cm2));
          value.add(IY + (pas) + (cm4));
          value.add(WELY + (pas) + (cm3));
          value.add(iY + (pas) + (cm));
          value.add(IZ + (pas) + (cm4));
          value.add(WELZ + (pas) + (cm3));
          value.add(iZ + (pas) + (cm));
          value.add(WPLY + (pas) + (cm3));
          value.add(WPLZ + (pas) + (cm3));
          value.add(G + (pas) + (KNmm));
        }
        break;
    }
    return value;
  }

}
