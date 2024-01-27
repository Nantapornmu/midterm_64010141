import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MY Calculator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: GoogleFonts.notoSansTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      home: CalculatorScreen(),
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String currentInput = "0";
  String operation = "";
  double firstNumber = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MY Calculator'),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(0),
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(0.0),
            child: Text(
              currentInput,
              style: TextStyle(fontSize: 40),
              textAlign: TextAlign.right, 
            ),
          ),
        Align(
       alignment: Alignment.center,
       child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween, // เปลี่ยนจาก MainAxisAlignment.center เป็น MainAxisAlignment.spaceBetween
      children: <Widget>[
      SizedBox(width: 4), 
      buildFunctionButton('C', clearDisplay, Color(0xFFB5B5B5)),
      SizedBox(width: 4), 
      buildFunctionButton('⌫', backspace, Color(0xFFB5B5B5)),
      SizedBox(width: 4), 
             ],
            ),
          ),
          SizedBox(height: 4),
          Align(
       alignment: Alignment.center,
       child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween, // เปลี่ยนจาก MainAxisAlignment.center เป็น MainAxisAlignment.spaceBetween
      children: <Widget>[
              buildNumberButton('7'),
              SizedBox(width: 4), 
              buildNumberButton('8'),
              SizedBox(width: 4), 
              buildNumberButton('9'),
              SizedBox(width: 4), 
              buildOperationButton('/', Color(0xFFB5B5B5)),
            ],
          ),
          ),
          SizedBox(height: 4),
          Align(
       alignment: Alignment.center,
       child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween, // เปลี่ยนจาก MainAxisAlignment.center เป็น MainAxisAlignment.spaceBetween
      children: <Widget>[
              buildNumberButton('4'),
              SizedBox(width: 4), 
              buildNumberButton('5'),
              SizedBox(width: 4), 
              buildNumberButton('6'),
              SizedBox(width: 4), 
              buildOperationButton('⨉', Color(0xFFB5B5B5)),
            ],
          ),
          ),
          SizedBox(height: 4),
          Align(
       alignment: Alignment.center,
       child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween, // เปลี่ยนจาก MainAxisAlignment.center เป็น MainAxisAlignment.spaceBetween
      children: <Widget>[
              buildNumberButton('1'),
              SizedBox(width: 4), 
              buildNumberButton('2'),
              SizedBox(width: 4), 
              buildNumberButton('3'),
              SizedBox(width: 4), 
              buildOperationButton('-', Color(0xFFB5B5B5)),
            ],
          ),
          ),
          SizedBox(height: 4),
          Align(
       alignment: Alignment.center,
       child: Row(
      mainAxisAlignment: MainAxisAlignment.center, // เปลี่ยนจาก MainAxisAlignment.center เป็น MainAxisAlignment.spaceBetween
      children: <Widget>[
              buildNumberButton('0'),
              SizedBox(width: 4), 
              buildOperationButton('+', Color(0xFFB5B5B5)),
            ],
          ),
          ),
          SizedBox(height: 4),
          SizedBox(width: 4), 
          Align(
       alignment: Alignment.center,
       child: Row(
      mainAxisAlignment: MainAxisAlignment.center, // เปลี่ยนจาก MainAxisAlignment.center เป็น MainAxisAlignment.spaceBetween
      children: <Widget>[
              buildFunctionButton('=', clearDisplay, Color(0xBE02800C)),
            ],
          ),
          ),
        ],
      ),
    );
  }

  Widget buildFunctionButton(String label, VoidCallback onPressed, Color color) {
    return Container(
      width: 230,
      height: 70,
      child: InkWell(
        onTap: onPressed,
        child: Center(
          child: Text(
            label,
            style: TextStyle(fontSize: 20, color: Color(0xFF000000)),
          ),
        ),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(0),
        color: color,
      ),
    );
  }

  Widget buildNumberButton(String number) {
    return Container(
      width: 120,
      height: 100,
      child: InkWell(
        onTap: () => appendToInput(number),
        child: Center(
          child: Text(
            number,
            style: TextStyle(fontSize: 20, color: Color(0xFF000000)),
          ),
        ),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(0),
        color: Color.fromARGB(255, 137, 255, 87),
      ),
    );
  }

  Widget buildOperationButton(String op, Color color) {
    return Container(
      width: 100,
      height: 100,
      child: InkWell(
        onTap: () => operationButtonClick(op),
        child: Center(
          child: Text(
            op,
            style: TextStyle(fontSize: 20, color: Color(0xFF000000)),
          ),
        ),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(0),
        color: color,
      ),
    );
  }

  void appendToInput(String value) {
    setState(() {
      if (currentInput == "0" && value != ".") {
        currentInput = value;
      } else {
        currentInput += value;
      }
    });
  }

  void clearDisplay() {
    setState(() {
      currentInput = "0";
      operation = "";
      firstNumber = 0;
    });
  }

  void operationButtonClick(String op) {
    setState(() {
      if (operation.isNotEmpty) {
        calculate();
      }

      firstNumber = double.parse(currentInput);
      operation = op;
      currentInput = "0";
    });
  }

  void calculate() {
    setState(() {
      double secondNumber = double.parse(currentInput);

      switch (operation) {
        case "+":
          currentInput = (firstNumber + secondNumber).toString();
          break;
        case "-":
          currentInput = (firstNumber - secondNumber).toString();
          break;
        case "*":
          currentInput = (firstNumber * secondNumber).toString();
          break;
        case "/":
          if (secondNumber != 0) {
            currentInput = (firstNumber / secondNumber).toString();
          } else {
            currentInput = "Error";
          }
          break;
        default:
          break;
      }

      operation = "";
      firstNumber = double.parse(currentInput);
    });
  }

  void backspace() {
    setState(() {
      if (currentInput.length > 1) {
        currentInput = currentInput.substring(0, currentInput.length - 1);
      } else {
        currentInput = "0";
      }
    });
  }
}
