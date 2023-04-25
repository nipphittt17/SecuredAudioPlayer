import 'dart:convert';

DecryptedAudioResponseModel decryptedAudioResponseModelFromJson(String str) =>
    DecryptedAudioResponseModel.fromJson(json.decode(str));

String decryptedAudioResponseModelToJson(DecryptedAudioResponseModel data) =>
    json.encode(data.toJson());

class DecryptedAudioResponseModel {
  DecryptedAudioResponseModel({
    required this.decryptedAudioFileBase64,
  });

  final String decryptedAudioFileBase64;

  factory DecryptedAudioResponseModel.fromJson(Map<String, dynamic> json) =>
      DecryptedAudioResponseModel(
        decryptedAudioFileBase64: json["DecryptedAudioFileBase64"],
      );

  Map<String, dynamic> toJson() => {
        "DecryptedAudioFileBase64": decryptedAudioFileBase64,
      };
}
