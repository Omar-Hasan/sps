import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

class design_foundations {
  String type_foundation = "isolated";
  double pForce = 100,
      Df = 100,
      H = 50,
      A_long = 150,
      B_width = 100,
      a_long = 50,
      b_width = 30,
      fc = 180,
      qa = 3,
      gamaC = 2.5,
      gamaS = 1.5,
      Fy = 3600;
  String Height = '50',
      A = '150',
      B = '100',
      AsA1L = '0',
      AsA1D = '0',
      AsA2L = '0',
      AsA2D = '0',
      AsB1L = '0',
      AsB1D = '0',
      AsB2L = '0',
      AsB2D = '0';
  int A1d = 12,
      A2d = 12,
      B1d = 12,
      B2d = 12,
      A1n = 12,
      A2n = 12,
      B1n = 12,
      B2n = 12,
      A1L = 250,
      A2L = 250,
      B1L = 250,
      B2L =250;
  List<String> solution = new List();
  List<Solve> solve = new List();
  List<double> Area = new List();
  List<String> percent = new List();
  String fie = 'Փ', mm2 = 'mm²';

  design_foundations(
      this.type_foundation,
      this.pForce,
      this.H,
      this.Df,
      this.A_long,
      this.B_width,
      this.a_long,
      this.b_width,
      this.fc,
      this.Fy,
      this.gamaC,
      this.gamaS,
      this.qa) {
    design();
  }

  _round5(var num) {
    int i = num.round() % 5;
    if (i == 0) return num.round();
    return num.round() + (5 - i);
  }

  void design() {
    double gamaS = this.gamaS;
    double gamaC = this.gamaC;
    double Df = this.Df;
    double qa = this.qa * 10;
    double pT = pForce / (1 - (gamaS + gamaC) / 2 * (Df / 100) / qa);
    double Area = pT / qa * 10000; //cm2
    double delta = pow(-b_width + a_long, 2) + 4 * Area;
    int B = max(
        _round5((b_width - a_long + sqrt(delta)) / 2), _round5(b_width * 2));

    //ط2
    //int B = max(_round5(sqrt(Area * b_width / a_long)),_round5(b_width*2));

    int A = _round5(Area / B);
    double p_net = pForce / (A * B / 10000); //ton/m2
    //ثقب مباشر
    int d = _round5(((pForce - p_net * a_long * b_width / 10000) /
            (0.3 * 0.2 * (fc * 10) * 2 * (a_long + b_width) / 100)) *
        100);
    //تحقيقات
    //ثقب غير مباشر
    while ((pForce - p_net * (a_long + d) * (b_width + d) / 10000) /
            (0.85 * d * 2 * (a_long + b_width + 2 * d) / 10000) >=
        0.55 * sqrt(fc) * 10) d += 5;
    //تحقيق الاجهادات الشادة الرئيسية
    double Afatha = 0, se = B + 0.0;

    if (d >= (B - b_width) / 2)
      Afatha = B * ((A - a_long) / 2 - d);
    else {
      se = b_width + d * 2;
      Afatha = B * ((A - a_long) / 2 - d) - pow((B - b_width) / 2 - d, 2) / 2;
    }
    while (p_net * Afatha / (0.85 * d * se) > 0.44 * sqrt(fc) * 10) d += 5;
    //التحقق من اجهادات الضغط على الانعطاف وحساب التسليح
    double vB = p_net * B * (A - a_long) / 2 / 10000; //ton
    double MB = vB * (A - a_long) / 4 / 100; //ton.m
    double vA = p_net * A * (B - b_width) / 2 / 10000;
    double MA = vA * (B - b_width) / 4 / 100;
    double C = max(MA, MB) / (0.85 * d / 100); //ton
    while (2 * C / (0.4 * d * B) / 10000 > 0.4 * fc * 10) {
      d += 5;
      C = max(MA, MB) / (0.85 * d / 100); //ton
    }
    double AsB = max(MB * 10000 / (0.85 * d * 0.55 * Fy), 0.0012 * B * d);
    double AsA = max(MA * 10000 / (0.85 * d * 0.55 * Fy), 0.0012 * A * d);
    //شرط التماسك taoA>14
    double segmaOB = vB * 1000 / (0.85 * d * 14);
    double segmaOA = vA * 1000 / (0.85 * d * 14);
    //اختيار التسليح
    _barSolution(AsB * 100, B * 10 - 100, 30,segmaOB);
    int percent = solve[0].perCent;
    for (int i = 0; i < solve.length; i++) {
       if (percent >= solve[i].perCent) {
          percent = percent;
          //عدد قضبان التسليح الواقعة تحت العمود
          int nCol = (b_width * 10 / solve[i].distance).round();
          if (nCol < 5)
            nCol = 2;
          else
            nCol = (nCol / 2).ceil();
          AsA1D = (solve[i].number - nCol).toString() +
              fie +
              solve[i].diameter.toString();
          AsA1L = (A - 10 + 2 * min(30, _round5(((d + 5) / 2).ceil())))
              .toString(); //cm
          AsA2D = nCol.toString() + fie + solve[i].diameter.toString();
          AsA2L = ((A - 10 + (d + 5) * 2 - 20) * 2).toString();
          A1n = solve[i].number- nCol; A1d = solve[i].diameter; A1L = A - 10 + 2 * min(30, _round5(((d + 5) / 2).ceil()));
          A2n = nCol; A2d = solve[i].diameter; A2L = (A - 10 + (d + 5) * 2 - 20) * 2;
        }
    }
    _barSolution(AsA * 100, A * 10 - 100, 30,segmaOA);
    percent = solve[0].perCent;
    for (int i = 0; i < solve.length; i++) {
         if (percent <= solve[i].perCent) {
          percent = percent;
          //عدد قضبان التسليح الواقعة تحت العمود
          int nCol = (a_long * 10 / solve[i].distance).round();
          if (nCol < 5)
            nCol = 2;
          else
            nCol = (nCol / 2).ceil();
          AsB1D = (solve[i].number - nCol).toString() +
              fie +
              solve[i].diameter.toString();
          AsB1L = (B - 10 + 2 * min(30, _round5(((d + 5) / 2).ceil())))
              .toString(); //cm
          AsB2D = nCol.toString() + fie + solve[i].diameter.toString();
          AsB2L = ((B - 10 + (d + 5) * 2 - 20) * 2).toString();
          B1n = solve[i].number- nCol; B1d = solve[i].diameter; B1L = B - 10 + 2 * min(30, _round5(((d + 5) / 2).ceil()));
          B2n = nCol; B2d = solve[i].diameter; B2L = (B - 10 + (d + 5) * 2 - 20) * 2;
         }
    }
    Height = (d + 5).toString();
    this.A = A.toString();
    this.B = B.toString();
  }

  _barSolution(double area, int uniteLength, int okPercent, double segmaO) {
    solve = new List();
    solution = new List();
    this.Area = new List();
    percent = new List();
    int numberMAx = (uniteLength / 100).round();
    int numberMin = (uniteLength / 200).ceil();
    List<int> diameter = _getDiameter(40, 12);
    for (int d in diameter) {
      //int d = diameter.get(i);
      int n = (area / (pi * pow(d, 2) / 4)).ceil();
      while(n*pi*d/10<segmaO)
        n+=1;
      if (n > numberMAx || n < numberMin) continue;
      int perCent = ((n * pi * pow(d, 2) / 4 - area) / area * 100).ceil();
      if (perCent <= okPercent) {
        solve.add(Solve(d, perCent, (uniteLength / n).round(), n));
        percent.add(perCent.toString() + "%");
        this.Area.add((n * pi * pow(d, 2) / 4));
        solution.add(n.toString() + fie + d.toString());
      }
    }
    if (solve.length == 0) {
      solve.add(Solve(12, 1, 200, (uniteLength / 200).ceil()));
    }
  }

  List<int> _getDiameter(int maxD, int minD) {
    List<int> diameter = [40, 32, 28, 25, 22, 20, 16, 14, 12, 10, 8, 6];
    List<int> d = new List();
    for (int i in diameter) {
      if (i <= maxD && i >= minD) {
        d.add(i);
      }
    }
    return d;
  }

  _spacingSolution(double area, int spacingMAx, int spacingMin, int uniteLength,
      int okPercent) {
    solution = new List();
    Area = new List();
    percent = new List();
    solve = new List();

    if (area == 0) {
      return;
    }
    List<int> diameter = _getDiameter(40, 12);
    for (int d in diameter) {
      int distanc = (uniteLength * pi * pow(d, 2) / (area * 4)).floor();
      /* while(uniteLength%distanc!=0 && distanc > spacingMin){
        distanc -=1;
      }*/
      if (distanc > spacingMAx || distanc < spacingMin) continue;
      int perCent =
          ((uniteLength * pi * pow(d, 2) / (4 * distanc) - area) / area * 100)
              .ceil();
      if (perCent <= okPercent) {
        solve.add(Solve(d, perCent, distanc, (uniteLength / distanc).round()));
        percent.add((perCent).toString() + "%");
        Area.add((uniteLength * pi * pow(d, 2) / (4 * distanc)));
        solution.add(fie + d.toString() + "@" + distanc.toString() + "mm");
      }
    }
  }
}

class Solve {
  int diameter = 12, perCent = 1, number, distance = 100;

  Solve(this.diameter, this.perCent, this.distance, this.number);
}
