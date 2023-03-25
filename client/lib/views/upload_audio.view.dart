import 'dart:io';

import 'package:client/models/audio_dto.model.dart';
import 'package:client/models/audio_item.model.dart';
import 'package:client/providers/audio_items.provider.dart';
import 'package:client/utils/utils.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:macos_ui/macos_ui.dart';
import 'package:provider/provider.dart';

class UploadAudioView extends StatefulWidget {
  const UploadAudioView({super.key});

  @override
  State<UploadAudioView> createState() => _UploadAudioViewState();
}

class _UploadAudioViewState extends State<UploadAudioView> {
  final AudioDtoModel _audioDto = AudioDtoModel();

  final _ctrFilePath = TextEditingController();
  bool _isUploading = false;
  bool _isValidDto = true;
  bool _triggerSuccessfulMsg = false;

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
              padding: const EdgeInsets.symmetric(
                horizontal: 50,
                vertical: 10,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    "Upload Audio File",
                    style: TextStyle(
                      fontSize: 23,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Column(
                    children: [
                      MacosTextField(
                        padding: const EdgeInsets.all(8),
                        prefix: const MacosIcon(CupertinoIcons.textformat),
                        placeholder: "Name your audio file",
                        maxLines: 1,
                        onChanged: (value) {
                          setState(() {
                            _isValidDto = true;
                            _triggerSuccessfulMsg = false;
                          });
                          _audioDto.name = value;
                        },
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Flexible(
                            child: MacosTextField(
                              controller: _ctrFilePath,
                              padding: const EdgeInsets.all(8),
                              prefix: const MacosIcon(CupertinoIcons.folder),
                              enabled: false,
                              placeholder: "Selected File Path",
                              maxLines: 1,
                              style: const TextStyle(
                                  overflow: TextOverflow.ellipsis),
                            ),
                          ),
                          PushButton(
                            padding: const EdgeInsets.all(8),
                            buttonSize: ButtonSize.small,
                            mouseCursor: SystemMouseCursors.click,
                            child: const Text("Pick File"),
                            onPressed: () async {
                              setState(() {
                                _isValidDto = true;
                                _triggerSuccessfulMsg = false;
                              });
                              FilePickerResult? result =
                                  await FilePicker.platform.pickFiles();

                              if (result != null) {
                                _audioDto.file =
                                    File(result.files.single.path!);
                                _ctrFilePath.text =
                                    Utils.getFileName(result.files.first.path!);
                              }
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  /// Upload Button
                  SizedBox(
                    width: double.infinity,
                    child: PushButton(
                      padding: const EdgeInsets.symmetric(vertical: 13),
                      buttonSize: ButtonSize.large,
                      onPressed: () async {
                        final bool isValid = _audioDto.isValid();
                        if (!isValid) {
                          setState(() {
                            _isValidDto = false;
                            _triggerSuccessfulMsg = false;
                          });
                          return;
                        }

                        setState(() {
                          _isUploading = true;
                          _triggerSuccessfulMsg = false;
                        });
                        //
                        await Future.delayed(const Duration(seconds: 2));

                        final audioItemsProvider =
                            Provider.of<AudioItemsProvider>(
                          context,
                          listen: false,
                        );

                        audioItemsProvider.addAudio(AudioItemModel(
                            name: "Test", encryptedAudioFile: "w"));

                        setState(() {
                          _isUploading = false;
                          _triggerSuccessfulMsg = true;
                        });
                      },
                      mouseCursor: SystemMouseCursors.click,
                      child: const Text("Start Upload"),
                    ),
                  ),

                  if (_isUploading || !_isValidDto || _triggerSuccessfulMsg)
                    const SizedBox(height: 20),
                  if (!_isValidDto)
                    const Text(
                      "Filename should not be Empty\nAnd file should be mp3, wav, or wma",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.red,
                      ),
                    ),
                  if (_isUploading) const CupertinoActivityIndicator(),
                  if (_triggerSuccessfulMsg)
                    const Text(
                      "Successfully Upload Audio to List",
                      style: TextStyle(color: Colors.green),
                    ),
                ],
              ),
            );
          },
        )
      ],
    );
  }
}
