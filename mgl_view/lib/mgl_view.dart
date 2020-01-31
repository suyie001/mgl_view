library mgl_view;




import 'package:flutter/material.dart';
enum AlignType {topCenter,topLeft,topRight}
class MView extends StatelessWidget {
  MView(this.child,{
    this.textStyle,
    this.alignment
});
  final AlignType alignment;
  final String child;
  final TextStyle textStyle ;
  @override
  Widget build(BuildContext context) {
   return LayoutBuilder(
     builder: (BuildContext context,BoxConstraints constraints){
       return Container(
         width: double.infinity,
         height: double.infinity,
         child: RotatedBox(
           quarterTurns:1,
           child: CustomPaint(

             painter: MTextPainter(
               alignment: alignment,
               content: child,
               textStyle:textStyle?? TextStyle(
                   color: Colors.black,
                   fontSize: 20,
                   letterSpacing: 4,
                   fontFamily: 'Menk Hawang Tig',
                   wordSpacing: 4) ,
             ),
           ),
         ),
       );
     },
   );

  }
}

class MTextPainter extends CustomPainter {
  MTextPainter({
    @required this.content,
    @required this.textStyle,
    this.alignment = AlignType.topLeft
});
  final String content;
  final TextStyle textStyle;
  final AlignType alignment;


  @override
  void paint(Canvas canvas, Size size) {
    List<Offset> Offsets = [];
    print('size: $size');
    List text = content.split(' ');
   // String text = content;
    var paint = new Paint();
    paint.color = textStyle.color;
    double offsetX = 0;
    double offsetY = size.height;

    bool newLine = true;
    double paragraphWidth = 0;
    double paragraphHeight = 0;
    int paragraphLine = 1;
    double maxWidth = 0;


    maxWidth = findMaxWidth(content, textStyle);

    for (int i = 0; i < text.length; i++) {

      TextSpan span = new TextSpan(style: textStyle, text: text[i]);
      TextPainter tp = new TextPainter(
          text: span,
          textAlign: TextAlign.center,
          textDirection: TextDirection.ltr);
      tp.layout();


      if (offsetX + tp.width > size.width) { // 如果一列不够一个文字，就新起一列。
        newLine = true;
        offsetX = 0; // 如果是新起一列，y 从0 开始
        paragraphWidth += tp.height;
        paragraphLine ++;

        print('paragraphHeight :$paragraphHeight');
      }

      if (newLine) {
        offsetY -= maxWidth;
        newLine = false;
      }


      if (offsetY < -maxWidth) {
        break; // 如果超出左边边界，不绘制。
      }

      //tp.paint(canvas, new Offset(offsetX, offsetY));
      Offsets.add(Offset(offsetX, offsetY));
      offsetX += tp.width;
    }
    for(int i = 0; i < text.length; i++){
      TextSpan span = new TextSpan(style: textStyle, text: text[i]);
      TextPainter tp = new TextPainter(
          text: span,
          textAlign: TextAlign.center,
          textDirection: TextDirection.ltr);
      tp.layout();
      double x = (size.height-paragraphLine*maxWidth)/2;
      double y = (size.width - paragraphHeight)/2;
      print('x:$x');
      print('y:$y');
      print('paragraphHeight:$paragraphHeight');
      if(alignment ==AlignType.topCenter){
        tp.paint(canvas, Offset(Offsets[i].dx,Offsets[i].dy-x)); //topCenter
      }else if(alignment ==AlignType.topLeft){
        tp.paint(canvas, Offsets[i]); //topLeft
      }else if(alignment ==AlignType.topRight){
        tp.paint(canvas, Offset(Offsets[i].dx,Offsets[i].dy-2*x));//topRight
      }




    }

  }
  double findMaxWidth(String text, TextStyle style) {
    double maxWidth = 0;
    for (int i = 0; i < text.length; i++) {
      TextSpan span = new TextSpan(style: textStyle, text: text[i]);
      TextPainter tp = new TextPainter(
          text: span,
          textAlign: TextAlign.center,
          textDirection: TextDirection.ltr);
      tp.layout();
      maxWidth = max(maxWidth, tp.height);
      print('maxWidth：$maxWidth');
    }


    return maxWidth;
  }

  @override
  bool shouldRepaint(MTextPainter oldDelegate) {
    return oldDelegate.content != content || oldDelegate.textStyle != textStyle || oldDelegate.alignment != alignment;
  }
  double max(double a, double b) {
    if (a > b) {
      return a;
    } else {
      return b;
    }
  }
}

