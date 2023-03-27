import 'dart:convert';
import 'dart:developer';
import 'dart:typed_data';

import 'package:audio_video_progress_bar/audio_video_progress_bar.dart'
    as audio_ui;
import 'package:client/models/audio_item.model.dart';
import 'package:client/services/cryptography.service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:macos_ui/macos_ui.dart';

class AudioView extends StatefulWidget {
  final AudioItemModel audioItemModel;

  const AudioView({super.key, required this.audioItemModel});

  @override
  State<AudioView> createState() => _AudioViewState();
}

class _AudioViewState extends State<AudioView> {
  final _justplayer = AudioPlayer();
  final _cryptoService = CryptoGraphyService();

  bool _isPlaying = false;
  bool _isEnteringFirstTime = true;
  bool _isLoading = false;
  Duration? _totalDuration;

  @override
  Widget build(BuildContext context) {
    return MacosScaffold(
      toolBar: const ToolBar(
        title: Text(''),
        actions: [],
      ),
      children: [
        ContentArea(
          builder: (context, scrollController) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(
                    maxWidth: 500,
                    minWidth: 100,
                  ),
                  child: Column(
                    children: [
                      Text(
                        widget.audioItemModel.name,
                        style: const TextStyle(
                          fontSize: 23,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 20),
                      StreamBuilder(
                        stream: _justplayer.positionStream,
                        builder: (context, snapshot) {
                          Duration? currentDuration = snapshot.data;
                          return audio_ui.ProgressBar(
                            barHeight: 4,
                            barCapShape: audio_ui.BarCapShape.round,
                            baseBarColor: Colors.grey.withOpacity(0.2),
                            progress: currentDuration ??
                                const Duration(milliseconds: 0000),
                            progressBarColor: Theme.of(context).primaryColor,
                            buffered: const Duration(milliseconds: 0),
                            total: _totalDuration ?? const Duration(seconds: 1),
                            timeLabelTextStyle: TextStyle(
                              color: Theme.of(context).primaryColor,
                            ),
                            thumbColor: Theme.of(context).primaryColor,
                            thumbCanPaintOutsideBar: true,
                            thumbGlowRadius: 0,
                            thumbGlowColor: Colors.transparent,
                            onSeek: (duration) async {
                              await _justplayer.seek(duration);
                            },
                          );
                        },
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Go Back to Start
                          MacosIconButton(
                            backgroundColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            shape: BoxShape.circle,
                            padding: const EdgeInsets.all(2),
                            onPressed: () async {
                              await _justplayer
                                  .seek(const Duration(seconds: 0));
                            },
                            icon: const Icon(
                              CupertinoIcons.chevron_left_2,
                              size: 100,
                            ),
                          ),
                          const SizedBox(width: 10),
                          MacosIconButton(
                            shape: BoxShape.circle,
                            padding: const EdgeInsets.all(1),
                            onPressed: () async {
                              if (_isEnteringFirstTime) {
                                setState(() {
                                  _isLoading = true;
                                });

                                // decrypt the video to play
                                log("First Time!");

                                await Future.delayed(
                                    const Duration(seconds: 1));

                                final res = await _cryptoService
                                    .decryptAudio(widget.audioItemModel);
                                final Uint8List bytes =
                                    base64.decode(res.decryptedAudioFileBase64);

                                // Set Player
                                await _justplayer.setAudioSource(
                                    MyCustomSource(bytes.toList()));

                                // Set Duration
                                _totalDuration = _justplayer.duration;

                                log(_totalDuration?.inSeconds.toString() ??
                                    "No duration");

                                // await _player.setSource();

                                setState(() {
                                  _isLoading = false;
                                });
                                // if successful
                                _isEnteringFirstTime = false;
                              }

                              if (_totalDuration == _justplayer.position) {
                                setState(() {
                                  _isPlaying = false;
                                  _justplayer.pause();
                                });
                                return;
                              }

                              if (_isPlaying) {
                                // pause
                                _justplayer.pause();
                              } else {
                                // play
                                _justplayer.play();
                              }
                              setState(() {
                                _isPlaying = !_isPlaying;
                              });
                            },
                            icon: _isLoading
                                ? const CupertinoActivityIndicator()
                                : _isPlaying
                                    ? const Icon(
                                        CupertinoIcons.pause_circle_fill,
                                        size: 100,
                                      )
                                    : const MacosIcon(
                                        CupertinoIcons.play_circle_fill,
                                        size: 100,
                                      ),
                          ),
                          const SizedBox(width: 10),

                          // Go Right Button
                          MacosIconButton(
                            backgroundColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            shape: BoxShape.circle,
                            padding: const EdgeInsets.all(2),
                            onPressed: () async {
                              await _justplayer.seek(_totalDuration);

                              setState(() {
                                _isPlaying = false;
                                _justplayer.pause();
                              });
                            },
                            icon: const Icon(
                              CupertinoIcons.chevron_right_2,
                              size: 100,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  @override
  void dispose() {
    super.dispose();
    // _player.dispose();
  }
}

// Feed your own stream of bytes into the player
class MyCustomSource extends StreamAudioSource {
  final List<int> bytes;
  MyCustomSource(this.bytes);

  @override
  Future<StreamAudioResponse> request([int? start, int? end]) async {
    start ??= 0;
    end ??= bytes.length;
    return StreamAudioResponse(
      sourceLength: bytes.length,
      contentLength: end - start,
      offset: start,
      stream: Stream.value(bytes.sublist(start, end)),
      contentType: 'audio/mpeg',
    );
  }
}
