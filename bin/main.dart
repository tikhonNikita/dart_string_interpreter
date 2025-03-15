import '../bin/interpreter/interpreter.dart';

void main() {
  final interpreter = Interpreter();

  final phrase = '1+1';
  final result = interpreter.interpret(phrase);
  print(result);
  
}