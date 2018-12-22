import 'package:flutter/material.dart';

class MT extends StatelessWidget {
  MT(
      {this.child,
      this.fontSize,
      this.color,
      this.fontWeight,
      this.spacing,
      this.maxLines});
// :_normalFontSize = ScreenUtil().setSp(18,false),
//  _fontSize = ScreenUtil().setSp(int.parse(fontSize.toString()),false);

  final String child;
  final FontWeight fontWeight;
  final double fontSize;
  final Color color;
  final double spacing;
  final int maxLines;
//  final double _fontSize;
//  final double _normalFontSize;
  @override
  Widget build(BuildContext context) {
    // if (child == ''){
    //   return Padding(
    //     padding: const EdgeInsets.all(1.0),
    //     child: Text(' '),
    //   );
    // }
    // else
    return Padding(
      padding: EdgeInsets.only(right: spacing == null ? 4.0 : spacing),
      child: Text(
        child,
        softWrap: true,
        maxLines: maxLines == null ? 1 : maxLines,
        textScaleFactor: 1.0,
        style: TextStyle(
          fontSize: fontSize == null ? 18.0 : fontSize,
          color: color == null ? Colors.black : color,
          fontWeight: fontWeight == null ? FontWeight.normal : fontWeight,
          fontFamily: 'Menk Hawang Tig',
        ),
      ),
    );
  }
}
