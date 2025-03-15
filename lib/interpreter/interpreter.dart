import 'expression.dart';

class Interpreter {
  final Expression _expression;
  Interpreter(this._expression);

  double interpret([Map<String, num>? variables]) {
    return _expression.evaluate(variables);
  }
}
