import 'package:string_interpreter/interpreter/interpreter.dart';

void main() {
  final interpreter = Interpreter();

  final phrase = '1+1';
  final result = interpreter.interpret(phrase);
  print(result);
}
