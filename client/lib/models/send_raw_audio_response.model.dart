class SendRawAudioResponseModel {
  final String filename;
  final String rawAudioFileBase64;

  SendRawAudioResponseModel({
    required this.filename,
    required this.rawAudioFileBase64,
  });

  Map<String, dynamic> toJson() {
    return {
      "Filename": filename,
      "RawAudioFileBase64": rawAudioFileBase64,
    };
  }
}
