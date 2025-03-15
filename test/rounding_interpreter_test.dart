import 'package:string_interpreter/interpreter/rounding_interpreter.dart';
import 'package:test/test.dart';
import 'package:string_interpreter/interpreter/expression_with_variables.dart';

void main() {
  group('Rounding interpreter', () {
    test('should return integer if result is a whole number', () {
      final expression = ExpressionWithVariables('2 + 2');
      final interpreter = RoundingInterpreter(expression);
      expect(interpreter.interpret(), 4);
      expect(interpreter.interpret().runtimeType, int);
    });

    test('should return double if result is not a whole number', () {
      final expression = ExpressionWithVariables('2.3 + 2.5');
      final interpreter = RoundingInterpreter(expression);
      expect(interpreter.interpret(), 4.8);
      expect(interpreter.interpret().runtimeType, double);
    });
  });
}
