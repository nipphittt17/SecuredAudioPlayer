import 'dart:developer';

import 'package:audio_video_progress_bar/audio_video_progress_bar.dart'
    as audio_ui;
import 'package:client/models/audio_item.model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:macos_ui/macos_ui.dart';

class AudioView extends StatefulWidget {
  final AudioItemModel audioItemModel;

  const AudioView({super.key, required this.audioItemModel});

  @override
  State<AudioView> createState() => _AudioViewState();
}

class _AudioViewState extends State<AudioView> {
  bool _isPlaying = false;
  bool _isEnteringFirstTime = true;
  bool _isLoading = false;

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
                      audio_ui.ProgressBar(
                        barHeight: 4,
                        barCapShape: audio_ui.BarCapShape.round,
                        baseBarColor: Colors.grey.withOpacity(0.2),
                        progress: const Duration(milliseconds: 0000),
                        progressBarColor: Theme.of(context).primaryColor,
                        buffered: const Duration(milliseconds: 0),
                        total: const Duration(minutes: 2, seconds: 30),
                        thumbColor: Theme.of(context).primaryColor,
                        thumbCanPaintOutsideBar: true,
                        thumbGlowRadius: 0,
                        thumbGlowColor: Colors.transparent,
                        onSeek: (duration) {
                          log('User selected a new time: $duration');
                        },
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          MacosIconButton(
                            backgroundColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            shape: BoxShape.circle,
                            padding: const EdgeInsets.all(2),
                            onPressed: () {},
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

                                setState(() {
                                  _isLoading = false;
                                });
                                // if successful
                                _isEnteringFirstTime = false;
                              }

                              setState(() {
                                _isPlaying = !_isPlaying;
                              });

                              if (_isPlaying) {
                                // pause
                              } else {
                                // play
                              }
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
                          MacosIconButton(
                            backgroundColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            shape: BoxShape.circle,
                            padding: const EdgeInsets.all(2),
                            onPressed: () {},
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
}
