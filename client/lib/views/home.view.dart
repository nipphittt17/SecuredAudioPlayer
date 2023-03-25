import 'package:client/views/upload_audio.view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:macos_ui/macos_ui.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        return MacosScaffold(
          toolBar: ToolBar(
            title: const Text('Home'),
            actions: [
              ToolBarIconButton(
                label: 'Toggle Sidebar',
                icon: const MacosIcon(CupertinoIcons.sidebar_left),
                showLabel: false,
                tooltipMessage: 'Toggle Sidebar',
                onPressed: () {
                  MacosWindowScope.of(context).toggleSidebar();
                },
              )
            ],
          ),
          children: [
            ContentArea(
              builder: (context, scrollController) {
                return Padding(
                  padding: const EdgeInsets.all(13.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: const [
                          Text(
                            "Secured Audio Player",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 23,
                            ),
                          ),
                          SizedBox(height: 20),
                          Text(
                            "-\"Provide the best secured audio to you\"-",
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 16,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                          SizedBox(height: 20),
                          Divider(color: Colors.grey),
                          SizedBox(height: 20),
                        ],
                      ),
                      Center(
                          child: PushButton(
                        buttonSize: ButtonSize.large,
                        padding: const EdgeInsets.all(13),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(7)),
                        mouseCursor: SystemMouseCursors.click,
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) {
                              return const UploadAudioView();
                            },
                          ));
                        },
                        child: const Text("Upload Audio"),
                      )),
                    ],
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }
}
