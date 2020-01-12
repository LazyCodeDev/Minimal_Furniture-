import 'package:flutter/material.dart';
import 'package:unsplash_2/data.dart';
import 'package:unsplash_2/detail.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int currentPage = 0;
  PageController _pageController;
  @override
  void initState() {
    _pageController = PageController(
        initialPage: currentPage, keepPage: false, viewportFraction: .7);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        bottomNavigationBar: BottomNavigationBar(
          unselectedFontSize: 0,
          backgroundColor: Colors.white,
          selectedFontSize: 0,
          items: [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.favorite_border,
                color: Colors.black54,
                size: 30.0,
              ),
              title: Text(""),
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.vibration,
                color: Colors.redAccent,
                size: 30.0,
              ),
              title: Text(""),
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.person_outline,
                color: Colors.black54,
                size: 30.0,
              ),
              title: Text(""),
            ),
          ],
        ),
        body: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Align(
                alignment: Alignment.topRight,
                child: Container(
                  margin: EdgeInsets.only(right: 30.0, top: 15.0),
                  height: 50.0,
                  width: 50.0,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50.0),
                      image: DecorationImage(
                          image: AssetImage("assets/images/profil.png"),
                          fit: BoxFit.cover)),
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height * .75,
                width: MediaQuery.of(context).size.width,
                child: PageView.builder(
                  itemCount: pageList.length,
                  onPageChanged: (value) {
                    setState(() {
                      currentPage = value;
                    });
                  },
                  controller: _pageController,
                  itemBuilder: (context, index) => animatedItemBuilder(index),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget animatedItemBuilder(int index) {
    bool font = true;
    return AnimatedBuilder(
      animation: _pageController,
      builder: (context, child) {
        double value = 1;
        if (_pageController.position.haveDimensions) {
          value = _pageController.page - index;
          value = (1 - (value.abs() * .3)).clamp(0.00, 1.0);
          if (value >= .6) {
            font = false;
          }
        }
        return Center(
          child: SizedBox(
            height: Curves.easeInOut.transform(value) * 360.0,
            width: Curves.easeInOut.transform(value) * 300.0,
            child: Container(
              margin: EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.0),
                boxShadow: [
                  BoxShadow(
                      blurRadius: 20.0,
                      color: Colors.black12,
                      offset: Offset(10.0, 10.0))
                ],
              ),
              child: Stack(
                fit: StackFit.expand,
                children: <Widget>[
                  Positioned(
                    right: 0,
                    left: 0,
                    height: (Curves.easeInOut.transform(value) * 360) * .75,
                    child: Hero(
                      tag: pageList[index].title.toLowerCase(),
                      child: GestureDetector(
                        onTap: () => Navigator.push(context,MaterialPageRoute(builder: (_)=>Detail(price:pageList[index].price,url: pageList[index].url,title: pageList[index].title,))),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10.0),
                                topRight: Radius.circular(10.0),
                              ),
                              image: DecorationImage(
                                  image: AssetImage(pageList[index].url),
                                  fit: BoxFit.cover)),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: 0,
                    height: (Curves.easeInOut.transform(value) * 360) * .19,
                    child: Padding(
                      padding: EdgeInsets.only(left: 20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            pageList[index].title,
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18.0,
                              height: 1.5
                            ),
                          ),
                          Text(
                            "\$${pageList[index].price}",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 14.0,
                              height: 1.5
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
