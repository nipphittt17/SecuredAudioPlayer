import 'dart:math';

class GeneratorUtil {
  static const int _maxCharacters = 30;

  static String randomString() {
    const characters =
        'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
    final random = Random();

    return String.fromCharCodes(
      List.generate(
        _maxCharacters,
        (_) => characters.codeUnitAt(
          random.nextInt(characters.length),
        ),
      ),
    );
  }
}
