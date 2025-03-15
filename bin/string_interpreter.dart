import 'package:string_interpreter/interpreter/interpreter.dart';
import 'package:string_interpreter/interpreter/expression_with_variables.dart';

void main() {
  final expression = ExpressionWithVariables('10*x+4/2-1');
  final interpreter = Interpreter(expression);

  final result = interpreter.interpret({'x': 10});
  print(result);

  final result2 = interpreter.interpret({'x': 100});
  print(result2);
}
