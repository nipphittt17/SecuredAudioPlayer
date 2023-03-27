class SendEncryptedAudioResponseModel {
  final String deviceId;
  final String filename;
  final String encryptedAudioFileBase64;

  SendEncryptedAudioResponseModel({
    required this.deviceId,
    required this.filename,
    required this.encryptedAudioFileBase64,
  });

  Map<String, dynamic> toJson() {
    return {
      "DeviceId": deviceId,
      "Filename": filename,
      "EncryptedAudioFileBase64": encryptedAudioFileBase64,
    };
  }
}
