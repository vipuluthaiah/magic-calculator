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
  var height;
  var width;
  String _display = "0";
  String _expectedString = "123456";
  TextEditingController _c;

  TextStyle defaultButtonTextStyle = TextStyle(
    color: Colors.white,
    fontFamily: 'Avenir',
    fontStyle: FontStyle.normal,
    fontSize: 30.0,
    fontWeight: FontWeight.w400,
  );
  Color defaultOrange = Colors.yellow[700];

  @override
  initState() {
    _c = new TextEditingController();
    super.initState();
  }

  Function _addNumber(int num) {
    return () {
      setState(() {
        _display += num.toString();
      });
    };
  }

  Function _addOperator(String op) {
    return () {
      setState(() {
        _display += op;
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

  void promptNumberSelection() {
    showDialog(
        child: new Dialog(
          child: new Column(
            children: <Widget>[
              new TextField(
                decoration: new InputDecoration(hintText: "Expected Number"),
                controller: _c,
              ),
              new FlatButton(
                child: new Text("Save"),
                onPressed: () {
                  setState(() {
                    this._expectedString = _c.text;
                  });
                  Navigator.pop(context);
                },
              )
            ],
          ),
        ),
        context: context);
  }

  void onEnterClick() {
    setState(() {
      _display = _expectedString;
    });
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        title: Text("Calculator"),
        backgroundColor: Colors.grey[850],
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: IconButton(
              icon: Icon(Icons.history),
              onPressed: promptNumberSelection,
            ),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
                alignment: Alignment.bottomRight,
                width: width,
                height: (height / 100) * 30,
                padding: EdgeInsets.fromLTRB(8, 8, 8, 48),
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    '$_display',
                    style: TextStyle(
                      fontFamily: 'Avenir',
                      fontStyle: FontStyle.normal,
                      color: Colors.white,
                      fontSize: 60.0,
                    ),
                    overflow: TextOverflow.visible,
                  ),
                )),
            Expanded(
              child: Container(
                color: Colors.grey[850],
                child: Column(
                  children: <Widget>[
                    Expanded(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          buildFunctionKey('AC',
                              onPressed: _clearDisplay,
                              textColor: Colors.white),
                          buildFunctionKey('DEL',
                              onPressed: _backspace, textColor: Colors.white),
                          buildFunctionKey('%', textColor: Colors.white),
                          buildFunctionKey('÷')
                        ],
                      ),
                    ),
                    Expanded(
                        child:
                            buildNumberRow([7, 8, 9], [buildFunctionKey('×')])),
                    Expanded(
                        child:
                            buildNumberRow([4, 5, 6], [buildFunctionKey('-')])),
                    Expanded(
                        child:
                            buildNumberRow([1, 2, 3], [buildFunctionKey('+')])),
                    Expanded(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          buildFunctionKey('.', textColor: Colors.white),
                          buildKey(0),
                          buildFunctionKey('()', textColor: Colors.white),
                          Expanded(
                            child: createFlatButton('=', onEnterClick,
                                backgroundColor: defaultOrange),
                          )
                        ],
                      ),
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

  Row buildNumberRow(List<int> nums, [List extra]) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[...nums.map(buildKey), ...extra],
    );
  }

  Expanded buildKey(int num) {
    return Expanded(
      child: createFlatButton(num.toString(), _addNumber(num)),
    );
  }

  Expanded buildFunctionKey(String key, {Function onPressed, Color textColor}) {
    return Expanded(
      child: createFlatButton(key, onPressed ?? _addOperator(key),
          textColor: textColor ?? defaultOrange),
    );
  }

  FlatButton createFlatButton(String key, Function onPressed,
      {Color textColor, Color backgroundColor}) {
    return FlatButton(
      onPressed: onPressed,
      child: Text(
        key,
        style: defaultButtonTextStyle.apply(color: textColor),
      ),
      color: backgroundColor,
      highlightColor: Colors.black26,
    );
  }
}
