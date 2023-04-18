class SendRawAudioResponseModel {
  final String rawAudioFileBase64;

  SendRawAudioResponseModel({required this.rawAudioFileBase64});

  Map<String, dynamic> toJson() {
    return {
      "RawAudioFileBase64": rawAudioFileBase64,
    };
  }
}
