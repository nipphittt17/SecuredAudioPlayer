import 'dart:io';

import 'package:client/models/apis/requests/send_raw_audio_response.model.dart';
import 'package:client/utils/cryptography.util.dart';

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
    final base64String = await CryptographyUtil.convertToBase64(file!);

    return SendRawAudioResponseModel(
      rawAudioFileBase64: base64String,
    );
  }
}
