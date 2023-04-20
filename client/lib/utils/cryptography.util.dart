import 'dart:convert';
import 'dart:io';

class CryptographyUtil {
  static Future<String> convertToBase64(File file) async {
    final bytes = await file.readAsBytes();
    return base64.encode(bytes);
  }
}
