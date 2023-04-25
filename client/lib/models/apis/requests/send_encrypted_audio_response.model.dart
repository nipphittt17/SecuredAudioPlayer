class SendEncryptedAudioResponseModel {
  final String encryptedAudioFileBase64;

  SendEncryptedAudioResponseModel({
    required this.encryptedAudioFileBase64,
  });

  Map<String, dynamic> toJson(String secretKey) {
    return {
      "SecretKey": secretKey,
      "EncryptedAudioFileBase64": encryptedAudioFileBase64,
    };
  }
}
