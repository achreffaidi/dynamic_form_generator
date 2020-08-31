import 'package:Resume/scrollingScreenBaseState.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends BaseStateForScrollingScreen<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body : get3DLayer()
    );
  }



  getBox(Color color){
    return Container(
        margin: EdgeInsets.all(20),
        child: Card(color : color,child: Container(height: 100,width: MediaQuery.of(context).size.width*0.8,)));
  }

  Function(bool) firstPartHideCallBackFunction(bool visible){
    if(!visible){
     // _controller.pause() ;
    }else{
     // _controller.play();
    }
  }

  getHeader(){
    return
      Container(
        margin: EdgeInsets.only(left: 30 , right: 30 , top:70),
        height: 120,
        child: Center(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text("Achraf Feydi",style: TextStyle(fontSize: 35,color: Colors.blueGrey , fontWeight: FontWeight.w700),),
                  Text("Software Engineering Student",style: TextStyle(fontSize: 20,color: Colors.blueGrey,fontWeight: FontWeight.w300),),
                ],
              ),
              Container(

                child: Row(children: <Widget>[
                  Icon(Icons.share,color: Colors.blueGrey,size: 40,),
                  Icon(Icons.map,color: Colors.blueGrey,size: 40,)
                ],),
              )
            ],
          ),
        ),
      );
  }
  getText(){
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30,vertical: 30),
      child: Text( "Software Engineering Student with High GPA , Microsoft ImagineCup world Finalist and a strong problem solver", style: TextStyle(fontSize: 20,color: Colors.blueGrey),),

    );
  }

  getAnimatedText() {
    final size = MediaQuery.of(context).size;
    return Center(
      child: Container(
        width: size.width/2,
        child: SizedBox(

          child: Padding(
            padding: const EdgeInsets.all(40.0),
            child: TypewriterAnimatedTextKit(
              isRepeatingAnimation: true,
                speed: Duration(milliseconds: 200),
                onTap: () {
                  print("Tap Event");
                },
                text: [
                  "Welcome Into My Digital Resume 😎 \n100% Built using Flutter Framework! ..."
                ],
                textStyle: TextStyle(
                  color: Colors.white,
                    fontSize: 70.0,
                    fontFamily: "Agne"
                ),
                textAlign: TextAlign.start,
                alignment: AlignmentDirectional.topStart // or Alignment.topLeft
            ),
          ),
        ),
      ),
    );
  }


  double localX = 0;
  double localY = 0;
  bool defaultPosition = true;
  get3DLayer(){
    final size = MediaQuery.of(context).size;
    double height  = size.height-100 ;
    double width = size.width-100;
    double percentageX = (localX / width) * 100;
    double percentageY = (localY / height) * 100;

    return Center(
      child: Container(
        child: Transform(
          transform: Matrix4.identity()
            ..setEntry(3, 2, 0.0001)
            ..rotateX(defaultPosition ? 0 : (0.3 * (percentageY / 50) + -0.3))
            ..rotateY(defaultPosition ? 0 : (-0.3 * (percentageX / 50) + 0.3)),
          alignment: FractionalOffset.center,
          child: Container(
            width: width,
            height: height,
            decoration: BoxDecoration(
              color: Color(0xFFCCCCCC),
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                    offset: Offset(0, 60),
                    color: Color.fromARGB(120, 0, 0, 0),
                    blurRadius: 22,
                    spreadRadius: -20),
              ],
            ),
            child: MouseRegion(
              onEnter: (_) => setState(() => defaultPosition = false),
              onExit: (_) => setState(() {
                localY = (size.height) / 2;
                localX = (size.width * 0.45) / 2;
                defaultPosition = true;
              }),
              onHover: (details) {
                if (mounted) setState(() => defaultPosition = false);
                if (details.localPosition.dx > 0 && details.localPosition.dy > 0) {
                  if (details.localPosition.dx < (size.width * 0.45) * 1.5 && details.localPosition.dy > 0) {
                    localX = details.localPosition.dx;
                    localY = details.localPosition.dy;
                  }
                }
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Container(
                  color: Colors.white,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Container(
                        child:Image.asset("assets/background.jpg",fit: BoxFit.cover,) ,
                      ),
                      Transform(
                        transform: Matrix4.identity()
                          ..translate(
                              defaultPosition
                                  ? 0.0
                                  : (50 * (percentageX / 50) + -15),
                              defaultPosition
                                  ? 0.0
                                  : (50 * (percentageY / 50) + -15),
                              0.0),
                        alignment: FractionalOffset.center,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 22),
                          child: _getBody(),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _getBody() {
    return getLayoutForScrollingScreen(
        getHeader(),
        140,
        [getText(),getAnimatedText()],
        [getBox(Colors.yellow),getBox(Colors.pink),getBox(Colors.deepOrange,),getBox(Colors.black,),getBox(Colors.purple,),getBox(Colors.greenAccent,)],
        "",firstPartHideCallBackFunction);
  }

  }

