import 'dart:convert';

EncryptedAudioResponse encryptedAudioResponseFromJson(String str) =>
    EncryptedAudioResponse.fromJson(json.decode(str));

String encryptedAudioResponseToJson(EncryptedAudioResponse data) =>
    json.encode(data.toJson());

class EncryptedAudioResponse {
  EncryptedAudioResponse({
    required this.encryptedAudioFileBase64,
  });

  final String encryptedAudioFileBase64;

  factory EncryptedAudioResponse.fromJson(Map<String, dynamic> json) =>
      EncryptedAudioResponse(
        encryptedAudioFileBase64: json["EncryptedAudioFileBase64"],
      );

  Map<String, dynamic> toJson() => {
        "EncryptedAudioFileBase64": encryptedAudioFileBase64,
      };
}
