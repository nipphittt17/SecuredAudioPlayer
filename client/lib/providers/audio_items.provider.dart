import 'package:client/models/audio_item.model.dart';
import 'package:flutter/cupertino.dart';

class AudioItemsProvider with ChangeNotifier {
  final _audioList = <AudioItemModel>[
    // For Testing
    // AudioItemModel(name: "Audio1", encryptedAudioFile: ''),
    // AudioItemModel(name: "Audio2", encryptedAudioFile: ''),
    // AudioItemModel(name: "Audio3", encryptedAudioFile: ''),
  ];

  List<AudioItemModel> get audioList => _audioList;

  void addAudio(AudioItemModel audioItemModel) {
    _audioList.add(audioItemModel);
    notifyListeners();
  }
}
