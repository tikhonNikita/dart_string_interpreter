import 'expression.dart';

class ExpressionWithVariables implements Expression {
  final String _input;
  Map<String, num> _variables;

  int _currentPosition = 0;
  String? _currentChar;

  static final _numberRegex = RegExp(r'[0-9.]');
  static final _variableStartRegex = RegExp(r'[a-zA-Z]');
  static final _variableRegex = RegExp(r'[a-zA-Z0-9_]');

  ExpressionWithVariables(this._input) : _variables = {} {
    _currentChar = _input.isNotEmpty ? _input[0] : null;
  }

  void _nextChar() {
    _currentPosition++;
    _currentChar = (_currentPosition < _input.length) ? _input[_currentPosition] : null;
  }

  void skipWhitespace() {
    while (_currentChar == ' ') {
      _nextChar();
    }
  }

  double? _tryParseVariable() {
    if (_currentChar == null || !_variableStartRegex.hasMatch(_currentChar!)) {
      return null;
    }

    final start = _currentPosition;
    while (_currentChar != null && _variableRegex.hasMatch(_currentChar!)) {
      _nextChar();
    }

    final varName = _input.substring(start, _currentPosition);
    if (!_variables.containsKey(varName)) {
      throw Exception('Unknown variable "$varName"');
    }
    return _variables[varName]!.toDouble();
  }

  double _parseNumber() {
    skipWhitespace();
    final start = _currentPosition;

    final variableValue = _tryParseVariable();
    if (variableValue != null) {
      return variableValue;
    }

    while (_currentChar != null && (_numberRegex.hasMatch(_currentChar!))) {
      _nextChar();
    }
    final numberStr = _input.substring(start, _currentPosition);
    return double.parse(numberStr);
  }

  double _parseFactor() {
    skipWhitespace();
    if (_currentChar == '-') {
      _nextChar();
      return -_parseFactor();
    }
    if (_currentChar == '(') {
      _nextChar();
      final result = _parseExpression();
      if (_currentChar != ')') {
        throw Exception('Error: expected closing parenthesis');
      }
      _nextChar();
      return result;
    }
    return _parseNumber();
  }

  double _parseTerm() {
    double result = _parseFactor();
    while (true) {
      skipWhitespace();
      if (_currentChar == '*') {
        _nextChar();
        result *= _parseFactor();
      } else if (_currentChar == '/') {
        _nextChar();
        final divisor = _parseFactor();
        if (divisor == 0) {
          throw Exception('Error: division by zero');
        }
        result /= divisor;
      } else {
        break;
      }
    }
    return result;
  }

  double _parseExpression() {
    double result = _parseTerm();
    while (true) {
      skipWhitespace();
      if (_currentChar == '+') {
        _nextChar();
        result += _parseTerm();
      } else if (_currentChar == '-') {
        _nextChar();
        result -= _parseTerm();
      } else {
        break;
      }
    }
    return result;
  }

  void _prepareForReevaluation(Map<String, num> variables) {
    _currentPosition = 0;
    _currentChar = _input.isNotEmpty ? _input[_currentPosition] : null;
    _variables = variables;
  }

  @override
  double evaluate([Map<String, num>? variables]) {
    final newVariables = variables ?? {};
    _prepareForReevaluation(newVariables);

    final result = _parseExpression();
    skipWhitespace();

    if (_currentChar != null) {
      throw Exception('Error: unexpected character "$_currentChar"');
    }

    return result;
  }
}
