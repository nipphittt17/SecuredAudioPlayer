import 'package:flutter/cupertino.dart';
import 'package:macos_ui/macos_ui.dart';

class UploadAudioView extends StatelessWidget {
  const UploadAudioView({super.key});

  @override
  Widget build(BuildContext context) {
    return MacosScaffold(
      toolBar: ToolBar(
        leading: const SizedBox.shrink(),
        actions: [
          ToolBarIconButton(
            label: "Pop",
            icon: const MacosIcon(CupertinoIcons.arrow_left),
            showLabel: false,
            tooltipMessage: "Go Back",
            onPressed: () {
              Navigator.of(context).pop();
            },
          )
        ],
      ),
      children: [
        ContentArea(
          builder: (context, scrollController) {
            return Center(
              child: Column(
                children: const [
                  Text("Upload data"),
                ],
              ),
            );
          },
        )
      ],
    );
  }
}
