import 'package:client/models/apis/requests/send_encrypted_audio_response.model.dart';

class AudioItemModel {
  AudioItemModel({required this.name, required this.encryptedAudioFile});

  final String name;
  final String encryptedAudioFile;

  Future<SendEncryptedAudioResponseModel> convertToResponseModel(
      String secretKey) async {
    return SendEncryptedAudioResponseModel(
      encryptedAudioFileBase64: encryptedAudioFile,
    );
  }
}
