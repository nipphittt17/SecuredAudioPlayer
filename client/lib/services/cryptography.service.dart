import 'package:client/data/network_api_service.dart';
import 'package:client/models/apis/requests/send_raw_audio_response.model.dart';
import 'package:client/models/apis/responses/decrypted_audio_response.model.dart';
import 'package:client/models/apis/responses/encrypted_audio_response.model.dart';
import 'package:client/models/entities/audio_dto.model.dart';
import 'package:client/models/entities/audio_item.model.dart';

class CryptoGraphyService {
  final encryptApi = "/encrypt-audio-file";
  final decryptApi = "/decrypt-audio-file";
  final _apiService = NetWorkApiService();

  Future<EncryptedAudioResponseModel> encryptAudioFile(
    AudioDtoModel audioDtoModel,
  ) async {
    final SendRawAudioResponseModel sendModel =
        await audioDtoModel.convertToResponseModel();

    late final EncryptedAudioResponseModel result;

    try {
      final jsonResponse = await _apiService.postResponse(
        encryptApi,
        sendModel.toJson(),
      );
      result = EncryptedAudioResponseModel.fromJson(jsonResponse);
    } catch (e) {
      rethrow;
    }
    return result;
  }

  Future<DecryptedAudioResponseModel> decryptAudio(
    AudioItemModel audioItemModel,
    String secretKey,
  ) async {
    final sendModel = await audioItemModel.convertToResponseModel(secretKey);

    late final DecryptedAudioResponseModel result;

    try {
      final jsonResponse = await _apiService.postResponse(
        decryptApi,
        sendModel.toJson(secretKey),
      );
      result = DecryptedAudioResponseModel.fromJson(jsonResponse);
    } catch (e) {
      rethrow;
    }

    return result;
  }
}
