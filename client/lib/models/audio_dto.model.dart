import 'dart:io';

import 'package:client/models/send_raw_audio_response.model.dart';
import 'package:client/utils/cryptography.util.dart';
import 'package:client/utils/generator.util.dart';
import 'package:device_info_plus/device_info_plus.dart';

class AudioDtoModel {
  String name = "";
  File? file;

  static List<String> availableFileExtension = [
    "mp3",
    "wav",
  ];

  bool isValid() {
    if (name.isEmpty || file == null) {
      return false;
    }
    final li = file!.path.split("/");
    final filename = li[li.length - 1].split(".");
    final extension = filename[filename.length - 1];
    return availableFileExtension.contains(extension);
  }

  Future<SendRawAudioResponseModel> convertToResponseModel() async {
    final macInfo = await DeviceInfoPlugin().macOsInfo;

    // * Rarely the Hardware UUID will be null
    final uniqueId = CryptographyUtil.sha256Hashing(
        macInfo.systemGUID ?? GeneratorUtil.randomString());
    final base64String = await CryptographyUtil.convertToBase64(file!);

    return SendRawAudioResponseModel(
      deviceId: uniqueId,
      filename: name,
      rawAudioFileBase64: base64String,
    );
  }
}
