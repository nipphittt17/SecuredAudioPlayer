import 'dart:convert';

EncryptedAudioResponseModel encryptedAudioResponseFromJson(String str) =>
    EncryptedAudioResponseModel.fromJson(json.decode(str));

String encryptedAudioResponseToJson(EncryptedAudioResponseModel data) =>
    json.encode(data.toJson());

class EncryptedAudioResponseModel {
  EncryptedAudioResponseModel({
    required this.encryptedAudioFileBase64,
  });

  final String encryptedAudioFileBase64;

  factory EncryptedAudioResponseModel.fromJson(Map<String, dynamic> json) =>
      EncryptedAudioResponseModel(
        encryptedAudioFileBase64: json["EncryptedAudioFileBase64"],
      );

  Map<String, dynamic> toJson() => {
        "EncryptedAudioFileBase64": encryptedAudioFileBase64,
      };
}
