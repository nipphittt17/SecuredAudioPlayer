import 'dart:io';

import 'package:client/models/audio_dto.dart';
import 'package:client/utils/utils.dart';
import 'package:desktop_multi_window/desktop_multi_window.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:macos_ui/macos_ui.dart';

class UploadAudioView extends StatefulWidget {
  const UploadAudioView({
    super.key,
    required this.windowController,
    required this.args,
  });

  final WindowController windowController;
  final Map? args;

  @override
  State<UploadAudioView> createState() => _UploadAudioViewState();
}

class _UploadAudioViewState extends State<UploadAudioView> {
  final AudioDto _audioDto = AudioDto();

  final _ctrFilePath = TextEditingController();
  bool _isUploading = false;
  bool _isValidDto = true;
  bool _triggerSuccessfulMsg = false;

  @override
  Widget build(BuildContext context) {
    return MacosApp(
      title: 'About',
      theme: MacosThemeData.light(),
      darkTheme: MacosThemeData.dark(),
      themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,
      home: MacosWindow(
        child: MacosScaffold(
          children: [
            ContentArea(
              builder: (context, scrollController) {
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 40,
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
                                  prefix:
                                      const MacosIcon(CupertinoIcons.folder),
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
                                    _ctrFilePath.text = Utils.getFileName(
                                        result.files.first.path!);
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
        ),
      ),
    );
  }
}
