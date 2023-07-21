import 'package:flutter_test/flutter_test.dart';

import 'package:password_strength_checker/password_strength_checker.dart';

void main() {
  test('calculate password strength', () {
    String password = 'ThisIsAStrongPassword1234!';

    PasswordStrengthChecker(
      password: password,
      callback: (strength) {
        expect(strength > 0.9, true);
      },
    );
  });
}
