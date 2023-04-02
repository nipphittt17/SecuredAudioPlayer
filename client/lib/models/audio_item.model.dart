import 'package:client/models/send_encrypted_audio_response.model.dart';
import 'package:client/utils/cryptography.util.dart';
import 'package:client/utils/generator.util.dart';
import 'package:device_info_plus/device_info_plus.dart';

class AudioItemModel {
  AudioItemModel({required this.name, required this.encryptedAudioFile});

  final String name;
  final String encryptedAudioFile;

  Future<SendEncryptedAudioResponseModel> convertToResponseModel() async {
    final macInfo = await DeviceInfoPlugin().macOsInfo;
    final uniqueId = CryptographyUtil.sha256Hashing(
        macInfo.systemGUID ?? GeneratorUtil.randomString());

    return SendEncryptedAudioResponseModel(
      deviceId: uniqueId,
      filename: name,
      encryptedAudioFileBase64: encryptedAudioFile,
    );
  }
}
