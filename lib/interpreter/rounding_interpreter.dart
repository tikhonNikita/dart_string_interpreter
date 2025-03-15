import 'expression.dart';

class RoundingInterpreter {
  final Expression _expression;
  RoundingInterpreter(this._expression);

  num interpret([Map<String, num>? variables]) {
    final result = _expression.evaluate(variables);
    if (result == result.roundToDouble()) {
      return result.toInt();
    }
    return result;
  }
}
