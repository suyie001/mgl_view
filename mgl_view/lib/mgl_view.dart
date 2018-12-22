library mgl_view;

import 'mgl_text.dart';
import 'package:flutter/material.dart';

class MView extends StatefulWidget {
  MView(
    this.child, {
    this.height,
    this.width,
    this.fontSize,
    this.color,
    this.fontWeight,
    this.spacing,
  });
  final double height;
  final double width;
  final String child;
  final FontWeight fontWeight;
  final double fontSize;
  final Color color;
  final double spacing;
  @override
  _MViewState createState() => _MViewState();
}

class _MViewState extends State<MView> {
  List<String> _list;
  List<Widget> _mList = List();

  @override
  void initState() {
    super.initState();
    setState(() {
      _list = widget.child.split(' ');
    });

    initial();
  }

  @override
  void dispose() {
    super.dispose();
    _mList.clear();
  }

  @override
  Widget build(BuildContext context) {
//    initial();

    return Container(
      width: widget.width == null
          ? MediaQuery.of(context).size.width
          : widget.width,
      height: widget.height == null
          ? MediaQuery.of(context).size.height
          : widget.height,
      //color: Colors.blueAccent,
      child: LayoutBuilder(
        builder: (BuildContext context, size) {
          return MyTransform(
            mList: _mList,
            width: widget.width == null ? size.maxWidth : widget.width,
            height:
                widget.height == null ? size.minHeight + 2.0 : widget.height,
          );
        },
      ),
    );
  }

  initial() {
    print(_list);
    setState(() {
      for (var i = 0; i < _list.length; i++) {
        _mList.insert(
            i,
            MT(
              child: _list[i],
              fontSize: widget.fontSize,
              fontWeight: widget.fontWeight == null
                  ? FontWeight.normal
                  : widget.fontWeight,
              color: widget.color,
              spacing: widget.spacing,
            ));
      }
    });
  }
}

class MyTransform extends StatelessWidget {
  const MyTransform({
    Key key,
    @required this.width,
    @required this.height,
    @required List<Widget> mList,
  })  : _mList = mList,
        super(key: key);

  final width;
  final height;

  final List<Widget> _mList;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Positioned(
          top: -width,
          child: Container(
            color: Colors.red,
            height: width,
            width: height,
            constraints: BoxConstraints(),
            child: Transform.rotate(
                alignment: Alignment.bottomLeft,
                angle: 90 * 3.1415927 / 180,
                child: _mList == null
                    ? SizedBox(
                        width: 0.0,
                        height: 0.0,
                      )
                    : Wrap(
                        verticalDirection: VerticalDirection.up,
                        children: _mList,
                      )),
          ),
        ),
      ],
    );
  }
}
