import 'dart:convert';
import 'dart:io';

import 'package:client/models/send_raw_audio_response.model.dart';

class AudioDtoModel {
  String name = "";
  File? file;

  static List<String> availableFileExtension = [
    "mp3",
    "wav",
    "wma",
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
    final bytes = await file!.readAsBytes();
    final base64String = base64.encode(bytes);

    return SendRawAudioResponseModel(
      filename: name,
      rawAudioFileBase64: base64String,
    );
  }
}
