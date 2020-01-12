import 'package:flutter/material.dart';

class Detail extends StatefulWidget {
  String title;
  String url;
  String price;
  Detail({this.title, this.url, this.price});
  @override
  _DetailState createState() => _DetailState();
}

class _DetailState extends State<Detail> with TickerProviderStateMixin {
  Color color;
  AnimationController _animationController;
  Animation _animation;
  bool visible = false;
  @override
  void initState() {
    color = Colors.blue;
    _animationController =
        AnimationController(duration: Duration(milliseconds: 300), vsync: this);
    _animation = Tween(begin: 0.0, end: 1.0).animate(_animationController)
      ..addStatusListener((state) {
        if (state == AnimationStatus.completed) {
          print("completed");
          visible=true;
        } else if (state == AnimationStatus.dismissed) {
          print("dismissed");
        }
      })
      ..addListener(() {
        print("value:${_animation.value}");
      });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: Colors.white,
        child: Stack(
          children: <Widget>[
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              bottom: MediaQuery.of(context).size.height * .2,
              child: Hero(
                tag: widget.title.toLowerCase(),
                child: Container(
                  height: MediaQuery.of(context).size.height * .8,
                  child: new Image(
                    image: new AssetImage(widget.url),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Icon(
                    Icons.arrow_back_ios,
                    size: 30.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: MediaQuery.of(context).size.height * .2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(top: 10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                widget.title,
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                    decoration: TextDecoration.none,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18.0,
                                    height: 1.5),
                              ),
                              Text(
                                "\$${widget.price}",
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                    decoration: TextDecoration.none,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14.0,
                                    height: 1.5),
                              ),
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            _animationController.forward();
                            print(_animationController.value);
                            // _changeColor();
                          },
                          child: Stack(
                            children: <Widget>[
                              AnimatedContainer(
                                duration: Duration(milliseconds: 500),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8.0),
                                    color: Color(0XFFE7E8E4)),
                                height:
                                    MediaQuery.of(context).size.height * .05,
                                width: MediaQuery.of(context).size.width * .25,
                                child: Center(
                                  child: Text(
                                    "Approve",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 12.0,
                                      decoration: TextDecoration.none,
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                child: AnimatedBuilder(
                                  builder: (context, child) {
                                    return SizedBox(
                                      width: (_animationController.value *
                                              MediaQuery.of(context)
                                                  .size
                                                  .width) *
                                          .25,
                                      child: child,
                                    );
                                  },
                                  animation: _animation,
                                  child: Container(
                                    height: MediaQuery.of(context).size.height *
                                        .05,
                                    width: MediaQuery.of(context).size.width,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8.0),
                                      color: Colors.red,
                                    ),
                                    child: Center(
                                      child: AnimatedBuilder(
                                        builder: (context, _) {
                                          return Text(
                                            "Approve",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: Curves.elasticIn.transform(_animationController.value)  * 12.0,
                                              decoration: TextDecoration.none,
                                            ),
                                          );
                                        },
                                        animation: _animation,
                                        // child:
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
