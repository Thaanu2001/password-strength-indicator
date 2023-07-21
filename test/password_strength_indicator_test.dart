import 'package:flutter_test/flutter_test.dart';

import 'package:password_strength_indicator/password_strength_indicator.dart';

void main() {
  test('calculate password strength', () {
    String password = 'ThisIsAStrongPassword1234!';

    PasswordStrengthIndicator(
      password: password,
      callback: (strength) {
        expect(strength > 0.9, true);
      },
    );
  });
}
