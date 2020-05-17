import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  static const platform = const MethodChannel('setMyImagesAsWallpaper');

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    Orientation orientation = MediaQuery.of(context).orientation;
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("Wallpaper App"),
      ),
      body: Container(
        height: size.height,
        width: size.width,
        child: GridView.builder(
          itemCount: imageData.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: (orientation == Orientation.portrait) ? 2 : 3),
          itemBuilder: (BuildContext context, int index) {
            return Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              elevation: 5,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: GestureDetector(
                  onTap: () {
                    showCustomDialog(
                      myimage: imageData[index],
                      size: size,
                      context: context,
                    );
                  },
                  child: Image.network(
                    imageData[index],
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  List<String> imageData = [
    "https://cdn.pixabay.com/photo/2020/05/09/22/16/china-5151605__340.jpg",
    "https://cdn.pixabay.com/photo/2020/04/29/23/34/ocean-5110906__340.jpg",
    "https://cdn.pixabay.com/photo/2020/04/17/14/16/mountains-5055387__340.jpg",
    "https://cdn.pixabay.com/photo/2020/02/24/11/08/autumn-4875907__340.jpg",
  ];

  showCustomDialog({var myimage, Size size, BuildContext context}) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                height: size.height * 0.06,
                width: size.width * 0.8,
                decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(10)),
                child: FlatButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  textColor: Colors.white,
                  onPressed: () {
                    _setAsHomeScreenImg(myimage);
                  },
                  child: Text("Set As Home Screen Wallpaper"),
                ),
              ),
              SizedBox(height: size.height * 0.02),
              Container(
                height: size.height * 0.06,
                width: size.width * 0.8,
                decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(10)),
                child: FlatButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  textColor: Colors.white,
                  onPressed: () {
                    _setAsLockScreenImg(myimage);
                  },
                  child: Text("Set As Lock Screen Wallpaper"),
                ),
              ),
            ],
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          actions: <Widget>[
            FlatButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Close"),
            ),
          ],
        );
      },
    );
  }

  Future<void> _setAsLockScreenImg(var getImage) async {
    try {
      bool result =
          await platform.invokeMethod('setAsLockScreen', {"text": getImage});
      if (result == true) {
        Navigator.pop(context);
        _showSnackBar(
            message: "SuccessFully Image Set As Lock Screen Wallpaper",
            color: Colors.green);
      } else {
        Navigator.pop(context);
        _showSnackBar(
            message: "Failed To Image Set As Lock Screen Wallpaper",
            color: Colors.red);
      }
    } on PlatformException catch (e) {
      _showSnackBar(message: "$e", color: Colors.red);
    }
    return true;
  }

  Future<void> _setAsHomeScreenImg(var getImage) async {
    try {
      bool result =
          await platform.invokeMethod("setAsHomeScreen", {"text": getImage});
      if (result == true) {
        Navigator.pop(context);
        _showSnackBar(
            message: "Successfully Image Set As Home Screen Wallpaper",
            color: Colors.green);
      } else {
        Navigator.pop(context);
        _showSnackBar(
            message: "Failed To Set Image As Home Screen Wallpaper",
            color: Colors.red);
      }
    } on PlatformException catch (e) {
      _showSnackBar(message: "$e", color: Colors.red);
    }
    return true;
  }

  _showSnackBar({String message, Color color}) {
    final snackBar = SnackBar(
      duration: Duration(seconds: 3),
      content: Text(
        message,
        style: TextStyle(color: Colors.white),
      ),
      backgroundColor: color,
    );
    _scaffoldKey.currentState.showSnackBar(snackBar);
  }
}
