class SendRawAudioResponseModel {
  final String deviceId;
  final String filename;
  final String rawAudioFileBase64;

  SendRawAudioResponseModel({
    required this.deviceId,
    required this.filename,
    required this.rawAudioFileBase64,
  });

  Map<String, dynamic> toJson() {
    return {
      "DeviceId": deviceId,
      "Filename": filename,
      "RawAudioFileBase64": rawAudioFileBase64,
    };
  }
}
