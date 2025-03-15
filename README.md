# String Interpreter

A mathematical expression interpreter written in Dart that can evaluate string expressions with variables.

## Features

- Parse and evaluate mathematical expressions from strings
- Support for basic arithmetic operations: addition, subtraction, multiplication, division
- Handling of parentheses for grouping operations
- Support for variables in expressions
- Proper operation precedence (multiplication/division before addition/subtraction)
- Support for unary minus operations
- Rounding interpreter that returns integers for whole number results

## Examples

```dart
// Basic expression
final expression = ExpressionWithVariables('2+3');
final interpreter = Interpreter(expression);
final result = interpreter.interpret(); // Returns 5.0

// Expression with variables
final expression = ExpressionWithVariables('x*2+y');
final interpreter = Interpreter(expression);
final result = interpreter.interpret({'x': 5, 'y': 3}); // Returns 13.0

// Complex expression
final expression = ExpressionWithVariables('10*x+4/2-1');
final interpreter = Interpreter(expression);
final result = interpreter.interpret({'x': 10}); // Returns 101.0
```

## Running Tests

To run all tests:

```bash
dart test
```

## Project Structure

- `lib/interpreter/expression.dart` - Interface for expressions
- `lib/interpreter/expression_with_variables.dart` - Main expression parser and evaluator
- `lib/interpreter/interpreter.dart` - Simple interpreter wrapper
- `lib/interpreter/rounding_interpreter.dart` - Interpreter that returns integers for whole numbers
- `bin/string_interpreter.dart` - Example usage
