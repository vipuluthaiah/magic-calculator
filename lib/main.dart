import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  var height;
  var width;
  String _display = "123241";

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  Function _addNumber(int num) {
    return () {
      setState(() {
        _display += num.toString();
      });
    };
  }

  void _clearDisplay() {
    setState(() {
      _display = "";
    });
  }

  void _backspace() {
    setState(() {
      if (_display.length == 0) return;
      _display = _display.substring(0, _display.length - 1);
    });
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              alignment: Alignment.bottomRight,
              width: width,
              height: (height / 100) * 40,
              child: Text(
                '$_display',
                style: TextStyle(
                  fontFamily: 'Avenir',
                  fontStyle: FontStyle.normal,
                  color: Colors.black,
                  fontSize: 60.0,
                ),
              ),
            ),
            Expanded(
              child: Row(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(30.0),
                    color: Colors.grey[850],
                    child: Column(
                      children: <Widget>[
                        Expanded(
                          child: Row(
                            children: <Widget>[
                              buildFunctionKey('AC', _clearDisplay),
                              buildFunctionKey('DEL', _backspace),
                            ],
                          ),
                        ),
                        Expanded(child: buildNumberRow([7, 8, 9])),
                        Expanded(child: buildNumberRow([4, 5, 6])),
                        Expanded(child: buildNumberRow([1, 2, 3])),
                        Expanded(
                          child: Row(
                            children: <Widget>[
                              buildFunctionKey('.', () {}),
                              buildKey(0),
                              buildFunctionKey('=', () {}),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      buildFunctionKey('÷', () {}),
                      buildFunctionKey('x', () {}),
                      buildFunctionKey('-', () {}),
                      buildFunctionKey('+', () {}),
                      buildFunctionKey('=', () {}),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Row buildNumberRow(List<int> nums) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[...nums.map(buildKey)],
    );
  }

  Expanded buildKey(int num) {
    return buildFunctionKey(num.toString(), _addNumber(num));
  }

  Expanded buildFunctionKey(String key, Function onPressed,
      {TextStyle textStyle}) {
    if (textStyle == null) {
      textStyle = TextStyle(
        color: Colors.white,
        fontFamily: 'Avenir',
        fontStyle: FontStyle.normal,
        fontSize: 50.0,
        fontWeight: FontWeight.w300,
      );
    }

    return Expanded(
      child: FlatButton(
        onPressed: onPressed,
        child: Text(
          key,
          style: textStyle,
        ),
      ),
    );
  }
}
