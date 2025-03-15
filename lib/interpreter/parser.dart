class Parser {
  final String _input;
  final Map<String, num> _variables;

  int _pos = 0;
  String? _currentChar;

  final _numberRegex = RegExp(r'[0-9.]');
  final _variableStartRegex = RegExp(r'[a-zA-Z]');
  final _variableRegex = RegExp(r'[a-zA-Z0-9_]');

  Parser(this._input, this._variables) {
    _currentChar = _input.isNotEmpty ? _input[0] : null;
  }

  void _nextChar() {
    _pos++;
    _currentChar = (_pos < _input.length) ? _input[_pos] : null;
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

    final start = _pos;
    while (_currentChar != null && _variableRegex.hasMatch(_currentChar!)) {
      _nextChar();
    }

    final varName = _input.substring(start, _pos);
    if (!_variables.containsKey(varName)) {
      throw Exception('Unknown variable "$varName"');
    }
    return _variables[varName]!.toDouble();
  }

  double _parseNumber() {
    skipWhitespace();
    final start = _pos;

    final variableValue = _tryParseVariable();
    if (variableValue != null) {
      return variableValue;
    }

    while (_currentChar != null && (_numberRegex.hasMatch(_currentChar!))) {
      _nextChar();
    }
    final numberStr = _input.substring(start, _pos);
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

  double parse() {
    final result = _parseExpression();
    skipWhitespace();
    if (_currentChar != null) {
      throw Exception('Error: unexpected character "$_currentChar"');
    }
    return result;
  }
}
