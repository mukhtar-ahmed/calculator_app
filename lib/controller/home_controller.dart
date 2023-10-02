import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:math_expressions/math_expressions.dart';

class HomeController extends GetxController {
  bool operatorsPressed = false; // +-/*
  bool decimalPointEntered = false; //For checking point entre or not
  var oldInput;

  List<String> buttonText = [
    '7',
    '8',
    '9',
    '/',
    '4',
    '5',
    '6',
    '*',
    '1',
    '2',
    '3',
    '-',
    'C',
    '0',
    '.',
    '+',
  ];
  List<String> pressedButton = [];
  String result = '0';
  String pressedButtonText = ''; // User Input

  void onTapFun(String buttonText) {
    if (buttonText == 'C') {
      pressedButtonText = '';
      result = '';
      pressedButton.clear(); //
      decimalPointEntered = false;
    }
    if (buttonText == '=') {
      calculateResult();
    } else {
      if (buttonText == '+' ||
          buttonText == '-' ||
          buttonText == '*' ||
          buttonText == '/') {
        if (!operatorsPressed) {
          operatorsPressed = true;

          pressedButtonText += buttonText;
          pressedButton.add(buttonText);
          print(pressedButton);
          print(pressedButtonText);
        }
        decimalPointEntered = false;
      } else if (buttonText == '.') {
        // if a decimal point has already been entered in the current input
        if (!decimalPointEntered) {
          decimalPointEntered = true;
          pressedButtonText += buttonText;
          pressedButton.add(buttonText);
        }
      } else {
        if (buttonText == 'C') {
          pressedButtonText = '';
          result = '';
        } else {
          operatorsPressed = false;
          pressedButtonText += buttonText;
          pressedButton.add(buttonText);
        }
      }
    }
    update();
  }

  Future<void> calculateResult() async {
    Parser parser = Parser();
    Expression expression = parser.parse(pressedButtonText);
    ContextModel contextModel = ContextModel();
    double eval = expression.evaluate(EvaluationType.REAL, contextModel);
    print('jjjjjjjj');

    if (eval % 1 == 0) {
      result = eval.toInt().toString();
      print('asd');
      print(result);
      // widget.pressedButtonText = widget.result;
    } else {
      result = eval.toString();
      decimalPointEntered = true;
      update();
      print('asd1');
    }
    oldInput = pressedButtonText;
    pressedButtonText = result;
    update();

    if (pressedButtonText.isNotEmpty) {
      await FirebaseFirestore.instance.collection('result').add({
        'user_input': oldInput,
        'result': result,
        'timestamp': FieldValue.serverTimestamp(),
      });
    }
  }
}
