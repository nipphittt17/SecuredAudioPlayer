import 'package:client/data/network_api_service.dart';
import 'package:client/models/audio_dto.model.dart';
import 'package:client/models/encrypted_audio_response.model.dart';
import 'package:client/models/send_raw_audio_response.model.dart';

class CryptoGraphyService {
  final encryptApi = "/encrypt-audio-file";
  final decryptApi = "/decrypt-audio-file";
  final _apiService = NetWorkApiService();

  Future<EncryptedAudioResponse> encryptAudioFile(
    AudioDtoModel audioDtoModel,
  ) async {
    final SendRawAudioResponseModel sendModel =
        await audioDtoModel.convertToResponseModel();

    late final EncryptedAudioResponse result;

    try {
      final jsonResponse = await _apiService.postResponse(
        encryptApi,
        sendModel.toJson(),
      );
      result = EncryptedAudioResponse.fromJson(jsonResponse);
    } catch (e) {
      rethrow;
    }
    return result;
  }
}
