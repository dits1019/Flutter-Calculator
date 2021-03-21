import 'package:calculator/CalButton.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var question = '';
  var answer = '0.0';

  //버튼에 들어갈 텍스트
  final List<String> buttonText = [
    'C',
    '←',
    '%',
    '/',
    '7',
    '8',
    '9',
    'x',
    '4',
    '5',
    '6',
    '-',
    '1',
    '2',
    '3',
    '+',
    '0',
    '.',
    '00',
    '=',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
              flex: 1,
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.only(top: 35, left: 20),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      question,
                      style: TextStyle(fontSize: 25),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 10, right: 10),
                    alignment: Alignment.centerRight,
                    child: Text(
                      answer,
                      style: TextStyle(fontSize: 36),
                    ),
                  ),
                ],
              )),
          Expanded(
            flex: 4,
            child: Container(
              child: GridView.builder(
                itemCount: buttonText.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4),
                itemBuilder: (BuildContext context, int index) {
                  if (index == 0) {
                    return CalButton(
                      buttonAction: () {
                        setState(() {
                          question = '';
                          answer = '0.0';
                        });
                      },
                      buttonText: buttonText[index],
                      color: Colors.green,
                      textColor: Colors.black,
                    );
                  } else if (index == 1) {
                    return CalButton(
                      buttonAction: () {
                        setState(() {
                          question = question.substring(0, question.length - 1);
                        });
                      },
                      buttonText: buttonText[index],
                      color: Colors.red,
                      textColor: Colors.black,
                    );
                  } else if (index == buttonText.length - 1) {
                    return CalButton(
                      buttonAction: () {
                        setState(() {
                          equalsAction();
                        });
                      },
                      buttonText: buttonText[index],
                      color: Colors.blue[900],
                      textColor: Colors.white,
                    );
                  } else {
                    return CalButton(
                        buttonAction: () {
                          setState(() {
                            question += buttonText[index];
                          });
                        },
                        buttonText: buttonText[index],
                        color: buttonColorSelect(buttonText[index])
                            ? Colors.blue[900]
                            : Colors.lightBlue[100],
                        textColor: buttonColorSelect(buttonText[index])
                            ? Colors.white
                            : Colors.black);
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  bool buttonColorSelect(String str) {
    if (str == '%' ||
        str == '/' ||
        str == 'x' ||
        str == '-' ||
        str == '+' ||
        str == '=')
      return true;
    else
      return false;
  }

  void equalsAction() {
    String userQuestion = question;
    userQuestion = userQuestion.replaceAll('x', '*');

    Parser p = Parser();
    Expression exp = p.parse(userQuestion);
    ContextModel cm = ContextModel();
    double eval = exp.evaluate(EvaluationType.REAL, cm);

    answer = eval.toString();
  }
}
