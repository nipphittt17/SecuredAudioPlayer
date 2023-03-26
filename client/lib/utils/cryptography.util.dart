import 'dart:convert';
import 'dart:io';

import 'package:crypto/crypto.dart';

class CryptographyUtil {
  static Future<String> convertToBase64(File file) async {
    final bytes = await file.readAsBytes();
    return base64.encode(bytes);
  }

  static String sha256Hashing(String target) {
    List<int> bytes = utf8.encode(target);
    Digest hash = sha256.convert(bytes);
    return hash.toString();
  }
}
