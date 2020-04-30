import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

class DXFDocument {
  Canvas c;
  int height = 1000;
  int ACII = 65; //الكود الملحق
  int numberOfDashLength = 0;
  int totalPatternLength = 0;
  String LayarName = '0';
  String ENTITIS = '';
  int LayerState = 0; //1 => frozen , 4 => locked

  String Hex = '2f';

  DXFDocument(this.height);

  double rotateAngle = 0;

  _getHex(int n) {
    switch (n) {
      case 0:
      case 1:
      case 2:
      case 3:
      case 4:
      case 5:
      case 6:
      case 7:
      case 8:
      case 9:
        return '$n';
      case 10:
        return 'a';
        break;
      case 11:
        return 'b';
        break;
      case 12:
        return 'c';
        break;
      case 13:
        return 'd';
        break;
      case 14:
        return 'e';
        break;
      case 15:
        return 'f';
        break;
    }
  }

  _getDec(String Hex) {
    switch (Hex) {
      case '0':
      case '1':
      case '2':
      case '3':
      case '4':
      case '5':
      case '6':
      case '7':
      case '8':
      case '9':
        return int.parse(Hex);
      case 'a':
        return 10;
      case 'b':
        return 11;
        break;
      case 'c':
        return 12;
        break;
      case 'd':
        return 13;
        break;
      case 'e':
        return 14;
        break;
      case 'f':
        return 15;
        break;
    }
  }

  _sumHex(int n) {
    //التحويل الى النظام العشري
    for (int i = 0; i < Hex.length; i++) {
      n += _getDec(Hex.substring(Hex.length - 1 - i, Hex.length - i)) *
          pow(16, i);
    }
    //التحويل الى النظام الست عشري
    Hex = '';
    int number = n;
    while (number > 16 && number % 16 == 0) {
      Hex += '0';
      number = (number / 16).floor();
    }
    while (number % 16 > 0) {
      Hex += _getHex(number % 16);
      number = (number / 16).floor();
    }
    Hex += _getHex((n / 16).floor());
    Hex = Hex.split('').reversed.join();
  }

  toDXFString() {
    //STYLE 0 : arial_bold, 1 : arial, 2 : arial_bold
    String DXFString = "999\nomar.suhail.hasan@gmail.com\n0\nSECTION\n2\nHEADER\n9\n\$ACADVER\n1\nAC1027\n9\n\$HANDSEED\n5\n4e20\n0\nENDSEC\n0\nSECTION\n2\nCLASSES\n0\nENDSEC\n0\nSECTION\n2\nTABLES\n0\nTABLE\n2" +
        "\nVPORT\n5\n17\n100\nAcDbSymbolTable\n70\n1\n0\nVPORT\n5\n20\n100\nAcDbSymbolTableRecord\n100" +
        "\nAcDbViewportTableRecord\n2\n*ACTIVE\n40\n$height\n70\n0\n0\nENDTAB\n0\nTABLE\n2" +
        "\nLTYPE\n5\n18\n100\nAcDbSymbolTable\n70\n2\n0\nLTYPE\n5\n21\n100\nAcDbSymbolTableRecord\n100" +
        "\nAcDbLinetypeTableRecord\n2\nByBlock\n70\n0\n72\n$ACII\n73\n$numberOfDashLength\n40\n$totalPatternLength\n3\n\n0" +
        "\nLTYPE\n5\n22\n100\nAcDbSymbolTableRecord\n100" +
        "\nAcDbLinetypeTableRecord\n2\nByLayer\n70\n0\n72\n$ACII\n73\n$numberOfDashLength\n40\n$totalPatternLength\n3\n\n0\nENDTAB\n0\nTABLE\n2" +
        "\nLAYER\n5\n19\n100\nAcDbSymbolTable\n70\n1\n0\nLAYER\n5\n23\n100\nAcDbSymbolTableRecord\n100" +
        "\nAcDbLayerTableRecord\n2\n$LayarName\n70\n$LayerState\n390\n1\n0\nENDTAB\n0\nTABLE\n2" +
        "\nSTYLE\n5\n1a\n100\nAcDbSymbolTable\n70\n3\n0\nSTYLE\n5\n2d\n100\nAcDbSymbolTableRecord\n100" +
        "\nAcDbTextStyleTableRecord\n2\n0\n3\narial_bold\n70\n0\n0\nSTYLE\n5\n2e\n100\nAcDbSymbolTableRecord\n100" +
        "\nAcDbTextStyleTableRecord\n2\n1\n3\narial\n70\n0\n0\nSTYLE\n5\n2f\n100\nAcDbSymbolTableRecord\n100" +
        "\nAcDbTextStyleTableRecord\n2\n2\n3\narial_bold\n70\n0\n0\nENDTAB\n0\nTABLE\n2" +
        "\nVIEW\n5\n1b\n100\nAcDbSymbolTable\n70\n0\n0\nENDTAB\n0\nTABLE\n2" +
        "\nUCS\n5\n1c\n100\nAcDbSymbolTable\n70\n0\n0\nENDTAB\n0\nTABLE\n2" +
        "\nAPPID\n5\n1d\n100\nAcDbSymbolTable\n70\n1\n0\nAPPID\n5\n24\n100\nAcDbSymbolTableRecord\n100\nAcDbRegAppTableRecord\n2\nACAD\n70\n0\n0\nENDTAB\n0\nTABLE\n2" +
        "\nDIMSTYLE\n5\n1e\n100\nAcDbSymbolTable\n70\n0\n100\nAcDbDimStyleTable\n71\n1\n0\nENDTAB\n0\nTABLE\n2" +
        "\nBLOCK_RECORD\n5\n1f\n100\nAcDbSymbolTable\n70\n2\n0\nBLOCK_RECORD\n5\n25\n100\nAcDbSymbolTableRecord\n100" +
        "\nAcDbBlockTableRecord\n2\n*Model_Space\n70\n0\n280\n1\n281\n0\n0\nBLOCK_RECORD\n5\n26\n100\nAcDbSymbolTableRecord\n100\nAcDbBlockTableRecord\n2\n*Paper_Space\n70\n0\n280\n1\n281\n0\n0\nENDTAB\n0\nENDSEC" +
        "\n0\nSECTION\n2\nBLOCKS\n0\nBLOCK\n5\n27\n100\nAcDbEntity\n100\nAcDbBlockBegin\n2\n*Model_Space\n70\n0\n10\n0\n20\n0\n30\n0\n3\n*Model_Space\n1\n\n0\nENDBLK\n5\n28\n100\nAcDbEntity\n100\nAcDbBlockEnd\n0\nBLOCK\n5\n29\n100\nAcDbEntity\n100\nAcDbBlockBegin\n2\n*Paper_Space\n70\n0\n10\n0\n20\n0\n30\n0\n3\n*Paper_Space\n1\n\n0\nENDBLK\n5\n2a\n100\nAcDbEntity\n100\nAcDbBlockEnd\n0\nENDSEC\n0" +
        "\nSECTION\n2\nENTITIES$ENTITIS\n\n0\nENDSEC\n0" +
        "\nSECTION\n2\nOBJECTS\n0\nDICTIONARY\n5\n2b\n330\n0\n100\nAcDbDictionary\n281\n1\n3\nACAD_GROUP\n350\n2c\n0\nDICTIONARY\n5\n2c\n330\n2b\n100\nAcDbDictionary\n281\n1\n0\nENDSEC\n0\nEOF\n";
    return DXFString;
  }

  drawLine(Offset p1, Offset p2, Paint paint) {
    _sumHex(1);
    ENTITIS +=
        "\n0\nLINE\n5\n$Hex\n100\nAcDbEntity\n8\n$LayarName\n100\nAcDbLine\n10\n${p1.dx}\n20\n${p1.dy}\n30\n0.0\n11\n${p2.dx}\n21\n${p2.dy}\n31\n0.0\n62\n${paint.color}";
  }

  drawCircle(Offset c, double radius, Paint paint) {
    _sumHex(1);
    ENTITIS +=
    "\n0\nCIRCLE\n5\n$Hex\n100\nAcDbEntity\n8\n$LayarName\n100\nAcDbCircle\n10\n${c.dx}\n20\n${c.dy}\n30\n0.0\n40\n$radius\n62\n${paint.color}";
  }

  drawPoint(Offset p, double radius, Paint paint) {
    _sumHex(1);
    ENTITIS +=
    "\n0\nPOINT\n5\n$Hex\n100\nAcDbEntity\n100\nAcDbPoint\n10\n${p.dx}\n20\n${p.dy}\n30\n0.0\n62\n${paint.color}\n39\n${paint.strokeWidth}";
  }

  drawRect(Rect rect, Paint paint) {
    _sumHex(1);
    ENTITIS +=
        "\n0\nLWPOLYLINE\n5\n$Hex\n100\nAcDbEntity\n8\n$LayarName\n100\nAcDbPolyline\n90\n4\n70\n1\n10\n${rect.topLeft.dx}\n20\n${rect.topLeft.dy}\n30\n0.0\n10\n${rect.topRight.dx}\n20\n${rect.topRight.dy}\n30\n0.0\n10\n${rect.bottomRight.dx}\n20\n${rect.bottomRight.dy}\n30\n0.0\n10\n${rect.bottomLeft.dx}\n20\n${rect.bottomLeft.dy}\n30\n0.0\n62\n${paint.color}";
  }

  drawArc(Rect rect, startAngle, sweepAngle, useCenter, Paint paint) {
    _sumHex(1);
    ENTITIS +=
        "\n0\nELLIPSE\n5\n34\n100\nAcDbEntity\n100\nAcDbEllipse\n10\n${rect.center.dx}\n20\n${rect.center.dy}\n30\n0.0\n11\n${rect.topRight.dx - rect.center.dx}\n21\n0.0\n31\n0.0\n40\n1.0\n41\n$startAngle\n42\n${startAngle + sweepAngle}\n62\n${paint.color}";
  }

  drawText(TextSpan span, Offset p) {
    _sumHex(1);
    ENTITIS +=
        "\n0\nTEXT\n5\n$Hex\n100\nAcDbEntity\n8\n$LayarName\n100\nAcDbText\n1\n${span.text}\n7\n2\n10\n${p.dx}\n20\n${p.dy}\n30\n0.0\n11\n${p.dx}\n21\n${p.dy}\n31\n0.0\n40\n${span.style.height}\n50\n$rotateAngle\n51\n0.0\n62\n${span.style.color}\n100\nAcDbText";
  }

  drawDimension() {
    _sumHex(1);
    ENTITIS +=
        "0\nDIMENSION\n5\n$Hex\n100\nAcDbEntity\n8\n$LayarName\n100\nAcDbDimension\n280\n0\n  2\n*D2\n 10\n53.57422433973169\n 20\n326.0455059805098\n 30\n0.0\n 11\n51.4908910063983\n 21\n213.0227529902549\n 31\n0.0\n 70\n    33\n 71\n     5\n 42\n226.0455059805097\n 73\n     0\n 74\n     0\n 75\n     0\n  3\nISO-25\n100\nAcDbAlignedDimension\n 13\n100.0\n 23\n100.0\n 33\n0.0\n 14\n100.0\n 24\n326.0455059805098\n 34\n0.0\n1001\nACAD\n1000\nDSTYLE\n1002\n{\n1070\n    50\n1040\n1.570796326794896\n1002\n}";
  }

  rotate(double angle) {
    rotateAngle = angle;
  }
}
