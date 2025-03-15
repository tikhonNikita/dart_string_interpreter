import 'package:test/test.dart';
import '../bin/interpreter/interpreter.dart';

void main() {
  test('initialTest', () {
    final interpreter = Interpreter();
    final phrase = '1+1';
    final result = interpreter.interpret(phrase);
    expect(result, '1+1');
  });
}
