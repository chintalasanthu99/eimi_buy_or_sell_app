import 'package:flutter/material.dart';

extension WidgetExt on Widget {
  Widget paddingAll(double padding) =>
      Padding(padding: EdgeInsets.all(padding), child: this);
  Widget padding({double left=0.0, double top=0.0, double right=0.0, double bottom=0.0}) =>
      Padding(
          padding: EdgeInsets.fromLTRB(left, top, right, bottom), child: this);

  Widget onTap(Function() onTap) => GestureDetector(
        onTap: onTap,
        child: this,
      );
  Widget wrapContainer({double width = 0.0, double height = 0.0, margin=0.0}) => Container(
      width: width,
      height: height,
      margin: EdgeInsets.all(margin),
      child: this);
  Widget container() => Container(
      child: this);
  Widget center() => Center(child: this);
  Widget expanded() => Expanded(child: this);
  Widget singleChildScrollView() => SingleChildScrollView(child: this);

  Widget align(Alignment alignment) => Align(alignment: alignment, child: this);

  Widget positioned(double left,
      double top,
      double right,
      double bottom,
      double width,
      double height,) =>
      Positioned(left:left,top: top,right: right,bottom: bottom,width: width,height: height,child: this);

  Widget navigate(context,nextPage) => GestureDetector(
    onTap: ()=>{
      Navigator.push(context, new MaterialPageRoute(builder: (context) => nextPage))
    },
    child: this,
  );

  static Widget popAndNavigate(context,nextPage) => GestureDetector(
    onTap: ()=>{
      Navigator.pop(context),
      Navigator.push(context, new MaterialPageRoute(builder: (context) => nextPage))
    },
  );
}


extension TextExt on Text {
  Text stlye34(color){
    return this;}
}
