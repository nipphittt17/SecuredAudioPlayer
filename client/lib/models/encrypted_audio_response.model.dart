import 'dart:convert';

EncryptedAudioResponseModel encryptedAudioResponseFromJson(String str) =>
    EncryptedAudioResponseModel.fromJson(json.decode(str));

String encryptedAudioResponseToJson(EncryptedAudioResponseModel data) =>
    json.encode(data.toJson());

class EncryptedAudioResponseModel {
  EncryptedAudioResponseModel({
    required this.encryptedAudioFileBase64,
    required this.secretKey,
  });

  final String encryptedAudioFileBase64;
  final String secretKey;

  factory EncryptedAudioResponseModel.fromJson(Map<String, dynamic> json) =>
      EncryptedAudioResponseModel(
          encryptedAudioFileBase64: json["EncryptedAudioFileBase64"],
          secretKey: json["SecretKey"]);

  Map<String, dynamic> toJson() => {
        "EncryptedAudioFileBase64": encryptedAudioFileBase64,
        "SecretKey": secretKey,
      };
}
