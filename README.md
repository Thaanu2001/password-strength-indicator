# password_strength_indicator

<a href="https://pub.dev/packages/password_strength_indicator">
<img src="https://img.shields.io/pub/v/password_strength_indicator?label=password_strength_indicator" alt="password_strength_indicator version">
</a>
<a href="https://github.com/Thaanu2001/password-strength-indicator/stargazers">
<img src="https://img.shields.io/github/stars/Thaanu2001/password-strength-indicator?style=social" alt="flutter_draggable_gridview Git Stars">
</a>
<a href="https://developer.android.com" style="pointer-events: stroke;" target="_blank">
<img src="https://img.shields.io/badge/platform-android-blue">
</a>
<a href="https://developer.apple.com/ios/" style="pointer-events: stroke;" target="_blank">
<img src="https://img.shields.io/badge/platform-iOS-blue">
</a>
<a href="" style="pointer-events: stroke;" target="_blank">
<img src="https://img.shields.io/badge/platform-Linux-blue">
</a>
<a href="" style="pointer-events: stroke;" target="_blank">
<img src="https://img.shields.io/badge/platform-Mac-blue">
</a>
<a href="" style="pointer-events: stroke;" target="_blank">
<img src="https://img.shields.io/badge/platform-web-blue">
</a>
<a href="" style="pointer-events: stroke;" target="_blank">
<img src="https://img.shields.io/badge/platform-Windows-blue">
</a>
<a href="https://opensource.org/licenses/MIT"><img src="https://img.shields.io/badge/license-MIT-purple.svg" alt="MIT License"></a>
</br></br>
A Flutter package to visually assess the strength of a password using a customizable strength bar.

## Features

- Visual representation of password strength using a strength bar.
- Customize the width, thickness, radius, and colors of the strength bar.
- Control the animation duration and curve for a smooth user experience.
- Define a callback function to receive the strength value of the password.
- Implement a custom strength builder to calculate the strength of the password based on your own criteria.
- Choose from different styles for the appearance of the strength bar.

## Screenshots

![ezgif-4-372e53535f](https://github.com/Thaanu2001/password-strength-indicator/assets/55238280/97d90212-972b-4a76-af1a-9fd425cdc984)

## Installation

To use this package, add `password_strength_indicator` as a dependency in your `pubspec.yaml` file.

## Usage

Import the package:

```dart
import 'package:password_strength_indicator/password_strength_indicator.dart';
```

To use the `PasswordStrengthIndicator` widget, simply provide the desired parameters:

```dart
PasswordStrengthIndicator(
  width: 200, // Change the width of the strength bar
  thickness: 12, // Change the thickness of the strength bar
  backgroundColor: Colors.grey, // Change the background color of the strength bar
  radius: 8, // Change the radius of the strength bar
  colors: StrengthColors(
    // Customize the colors of the strength bar
    weak: Colors.orange,
    medium: Colors.yellow,
    strong: Colors.green,
  ),
  duration: Duration(milliseconds: 300), // Set the animation duration
  curve: Curves.easeOut, // Set the animation curve
  callback: (double strength) {
    // Receive the strength value of the password
    print('Password Strength: $strength');
  },
  strengthBuilder: (String password) {
    // Implement a custom strength builder to calculate the strength based on your criteria
    // Return a value between 0.0 (too weak) and 1.0 (very strong)
    // Example:
    return password.length / 10;
  },
  style: StrengthBarStyle.line, // Choose a style for the strength bar
),
```

## Contribution

Contributions to this package are welcome! If you find a bug or have any suggestions, feel free to open an issue or submit a pull request on the [GitHub repository](https://github.com/Thaanu2001/password-strength-indicator).

## License

This package is released under the MIT License. See [LICENSE](LICENSE) for details.

**Developed with ❤️ by Thaanu Perera**

If you find this package helpful, consider giving it a ⭐ on pub.dev. Happy coding!
