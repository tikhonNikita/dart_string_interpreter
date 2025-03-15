import 'package:string_interpreter/interpreter/expression_with_variables.dart';
import 'package:string_interpreter/interpreter/rounding_interpreter.dart';

void main() {
  final expression = ExpressionWithVariables('10*x+4/2-1');
  final interpreter = RoundingInterpreter(expression);

  final result = interpreter.interpret({'x': 10});
  print(result);

  final result2 = interpreter.interpret({'x': 100});
  print(result2);

  final expression1 = ExpressionWithVariables('10/3');
  final interpreter1 = RoundingInterpreter(expression1);
  final result3 = interpreter1.interpret();
  print(result3);
}
