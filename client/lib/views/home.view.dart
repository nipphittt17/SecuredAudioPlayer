import 'dart:convert';

import 'package:desktop_multi_window/desktop_multi_window.dart';
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
                          Divider(),
                          SizedBox(height: 20),
                        ],
                      ),
                      Center(
                          child: PushButton(
                        buttonSize: ButtonSize.large,
                        padding: const EdgeInsets.all(13),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(7)),
                        onPressed: () async {
                          final window =
                              await DesktopMultiWindow.createWindow(jsonEncode(
                            {
                              'view': 'upload',
                              'args1': 'upload',
                              'args2': 500,
                              'args3': true,
                            },
                          ));
                          debugPrint('$window');
                          window
                            ..setFrame(
                                const Offset(0, 0) & const Size(350, 350))
                            ..center()
                            ..setTitle('About client')
                            ..show();
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
