import 'package:test/test.dart';
import 'package:string_interpreter/interpreter/interpreter.dart';
import 'package:string_interpreter/interpreter/expression_with_variables.dart';

void main() {
  group('Interpreter', () {
    test('Basic interpretation', () {
      final expression = ExpressionWithVariables('2+3');
      final interpreter = Interpreter(expression);
      expect(interpreter.interpret(), 5.0);
    });

    test('Interpretation with variables', () {
      final expression = ExpressionWithVariables('x*2');
      final interpreter = Interpreter(expression);
      expect(interpreter.interpret({'x': 7}), 14.0);
    });

    test('Required expression tests from requirements', () {
      final expression1 = ExpressionWithVariables('10*5+4/2-1');
      final interpreter1 = Interpreter(expression1);
      expect(interpreter1.interpret(), 51.0);

      final expression2 = ExpressionWithVariables('(x*3-5)/5');
      final interpreter2 = Interpreter(expression2);
      expect(interpreter2.interpret({'x': 10}), 5.0);

      final expression3 = ExpressionWithVariables('3*x+15/(3+2)');
      final interpreter3 = Interpreter(expression3);
      expect(interpreter3.interpret({'x': 10}), 33.0);
    });

    test('Reuse interpreter with different variable values', () {
      final expression = ExpressionWithVariables('10*x+4/2-1');
      final interpreter = Interpreter(expression);

      expect(interpreter.interpret({'x': 10}), 101.0);
      expect(interpreter.interpret({'x': 100}), 1001.0);
    });
  });
}
