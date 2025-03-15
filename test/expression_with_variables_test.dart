import 'package:test/test.dart';
import 'package:string_interpreter/interpreter/expression_with_variables.dart';

void main() {
  group('ExpressionWithVariables', () {
    test('Basic arithmetic operations', () {
      final expression = ExpressionWithVariables('2+3');
      expect(expression.evaluate(), 5.0);

      final expression2 = ExpressionWithVariables('5-2');
      expect(expression2.evaluate(), 3.0);

      final expression3 = ExpressionWithVariables('3*4');
      expect(expression3.evaluate(), 12.0);

      final expression4 = ExpressionWithVariables('8/2');
      expect(expression4.evaluate(), 4.0);
    });

    test('Operation precedence', () {
      final expression = ExpressionWithVariables('2+3*4');
      expect(expression.evaluate(), 14.0);

      final expression2 = ExpressionWithVariables('10-4/2');
      expect(expression2.evaluate(), 8.0);

      final expression3 = ExpressionWithVariables('2*3+4*5');
      expect(expression3.evaluate(), 26.0);
    });

    test('Parentheses', () {
      final expression = ExpressionWithVariables('(2+3)*4');
      expect(expression.evaluate(), 20.0);

      final expression2 = ExpressionWithVariables('2*(3+4)');
      expect(expression2.evaluate(), 14.0);

      final expression3 = ExpressionWithVariables('(10-4)/2');
      expect(expression3.evaluate(), 3.0);

      final expression4 = ExpressionWithVariables('((2+3)*4)/2');
      expect(expression4.evaluate(), 10.0);
    });

    test('Variables', () {
      final expression = ExpressionWithVariables('x+5');
      expect(expression.evaluate({'x': 10}), 15.0);

      final expression2 = ExpressionWithVariables('x*y');
      expect(expression2.evaluate({'x': 3, 'y': 4}), 12.0);

      final expression3 = ExpressionWithVariables('total/count');
      expect(expression3.evaluate({'total': 100, 'count': 5}), 20.0);
    });

    test('Complex expressions with variables', () {
      final expression = ExpressionWithVariables('10*x+4/2-1');
      expect(expression.evaluate({'x': 10}), 101.0);

      final expression2 = ExpressionWithVariables('(x*3-5)/5');
      expect(expression2.evaluate({'x': 10}), 5.0);

      final expression3 = ExpressionWithVariables('3*x+15/(3+2)');
      expect(expression3.evaluate({'x': 10}), 33.0);
    });

    test('Unary minus', () {
      final expression = ExpressionWithVariables('-3+5');
      expect(expression.evaluate(), 2.0);

      final expression2 = ExpressionWithVariables('6*-2');
      expect(expression2.evaluate(), -12.0);

      final expression3 = ExpressionWithVariables('-x*2');
      expect(expression3.evaluate({'x': 5}), -10.0);

      final expression4 = ExpressionWithVariables('-(3+2)');
      expect(expression4.evaluate(), -5.0);
    });

    test('Whitespace handling', () {
      final expression = ExpressionWithVariables(' 2 + 3 ');
      expect(expression.evaluate(), 5.0);

      final expression2 = ExpressionWithVariables(' x * 5 ');
      expect(expression2.evaluate({'x': 4}), 20.0);
    });

    test('Division by zero', () {
      final expression = ExpressionWithVariables('5/0');
      expect(() => expression.evaluate(), throwsException);

      final expression2 = ExpressionWithVariables('10/(x-x)');
      expect(() => expression2.evaluate({'x': 5}), throwsException);
    });

    test('Missing closing parenthesis', () {
      final expression = ExpressionWithVariables('(2+3');
      expect(() => expression.evaluate(), throwsException);
    });

    test('Invalid characters', () {
      final expression = ExpressionWithVariables('2+3@4');
      expect(() => expression.evaluate(), throwsException);
    });

    test('Unknown variable', () {
      final expression = ExpressionWithVariables('x+y');
      expect(() => expression.evaluate({'x': 5}), throwsException);
    });

    test('Reevaluate with different variables', () {
      final expression = ExpressionWithVariables('x*2+y');

      expect(expression.evaluate({'x': 5, 'y': 3}), 13.0);
      expect(expression.evaluate({'x': 10, 'y': 5}), 25.0);

      final expressionComplex = ExpressionWithVariables('a*b+(c/d)');
      expect(expressionComplex.evaluate({'a': 2, 'b': 3, 'c': 8, 'd': 4}), 8.0);
      expect(
        expressionComplex.evaluate({'a': 5, 'b': 2, 'c': 10, 'd': 5}),
        12.0,
      );
    });
  });
}
