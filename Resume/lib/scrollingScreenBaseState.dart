import 'package:flutter/material.dart';

abstract class BaseStateForScrollingScreen<T extends StatefulWidget>
    extends State<T> {
  double _opacity = 0 ;
  double _offset = 0 ;
  GlobalKey firstPartKey = GlobalKey();
  GlobalKey secondPartKey = GlobalKey();

  BaseStateForScrollingScreen() {
    _scrollController.addListener(_scrollPositionListener) ;
  }

  ScrollController _scrollController = new ScrollController();

  Function _scrollPositionListener(){
    double p = _scrollController.offset ;
    double widgetHeight = firstPartKey.currentContext.size.height ;
    double screenHeight = MediaQuery.of(context).size.height ;
    if(p<widgetHeight){

      print(p.toString()+"-d"+widgetHeight.toString());
      if(p>screenHeight*0.1){
        _offset = screenHeight-secondPartKey.currentContext.size.height;
      }
      setState(() {
        _opacity = p/widgetHeight ;
      });
    }

  }

  Widget getLayoutForScrollingScreen(Widget header,double headerHeight, List<Widget> firstList , List<Widget> secondList , String imageUrl, Function(bool) listener) {
    if(_opacity<0.8){
      listener(true);
    }else{
      listener(false);
    }
    return Container(
      child: Stack(
        children: <Widget>[
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: AspectRatio(
              aspectRatio: 0.75,
              child: Opacity(
                  opacity: 1-_opacity,
                  child:Container()),
            ),
          ),
          Positioned(
            top: 0,
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(

           /*   child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: FractionalOffset.topCenter,
                    end: FractionalOffset.bottomCenter,
                    colors: [
                      Color(0xffffffff).withOpacity(1),
                      Color(0xffffffff).withOpacity(1),
                      Color(0xffffffff).withOpacity(1),
                      Color(0xffffffff).withOpacity(0),
                      Color(0xffffffff).withOpacity(0),

                    ],
                  ),
                ),
              ),*/
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: _getHeader(header),
          ),
          Positioned(
            top: headerHeight,
            left: 0,
            right: 0,
            bottom: 0,
            child: SingleChildScrollView(
              controller: _scrollController,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[_getFirstPart(firstList),_getSecondPart(secondList),SizedBox(height: _offset,)],
              ),
            ),
          ),
          Positioned(
            top: headerHeight,
            left: 0,
            right: 0,
            child: Container(
              height: 50,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: FractionalOffset.topCenter,
                    end: FractionalOffset.bottomCenter,
                    colors: [
                      Color(0xffffffff).withOpacity(0),
                      Color(0xffffffff).withOpacity(0),
                    ],
                  ),
                ),
              ),
            ),
          ),

        ],
      ),
    );
  }

  _getHeader(Widget header){
    return Container(child : header) ;
  }
  _getFirstPart(List<Widget> list){
    return Opacity(
        key: firstPartKey,
        opacity: 1-_opacity,
        child: Column(children: list,));
  }
  _getSecondPart(List<Widget> list){
    return Opacity(
        key: secondPartKey,
        opacity: _opacity,
        child: Column(children: list,));
  }
}