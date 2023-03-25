import 'package:client/models/audio_dto.dart';
import 'package:desktop_multi_window/desktop_multi_window.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:macos_ui/macos_ui.dart';

class UploadAudioView extends StatelessWidget {
  UploadAudioView({
    super.key,
    required this.windowController,
    required this.args,
  });

  final WindowController windowController;
  final Map? args;

  final AudioDto _audioDto = AudioDto();

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
                              _audioDto.name = value;
                            },
                          ),
                          const SizedBox(height: 10),
                          MacosTextField(
                            padding: const EdgeInsets.all(8),
                            prefix: const MacosIcon(CupertinoIcons.folder),
                            suffix: PushButton(
                              padding: const EdgeInsets.all(8),
                              buttonSize: ButtonSize.small,
                              mouseCursor: SystemMouseCursors.click,
                              child: const Text("Pick File"),
                              onPressed: () {},
                            ),
                            placeholder: "Selected File Path",
                            maxLines: 1,
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        width: double.infinity,
                        child: PushButton(
                          padding: const EdgeInsets.symmetric(vertical: 13),
                          buttonSize: ButtonSize.large,
                          onPressed: () {},
                          mouseCursor: SystemMouseCursors.click,
                          child: const Text("Start Upload"),
                        ),
                      )
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
