import 'package:client/models/audio_item.model.dart';
import 'package:client/providers/audio_items.provider.dart';
import 'package:client/widgets/audio_item.widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:macos_ui/macos_ui.dart';
import 'package:provider/provider.dart';

class AudioListView extends StatelessWidget {
  const AudioListView({super.key});

  @override
  Widget build(BuildContext context) {
    final AudioItemsProvider audioItemsProvider =
        Provider.of<AudioItemsProvider>(context);

    return Builder(
      builder: (context) {
        return MacosScaffold(
          toolBar: ToolBar(
            title: const Text('Audio List'),
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
                  padding: const EdgeInsets.symmetric(
                    vertical: 15,
                    horizontal: 25,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: audioItemsProvider.audioList.length,
                        itemBuilder: (context, index) {
                          final AudioItemModel model =
                              audioItemsProvider.audioList[index];
                          return AudioItemWidget(
                            sequence: index + 1,
                            audio: model,
                          );
                        },
                      )
                    ],
                  ),
                );
              },
            )
          ],
        );
      },
    );
  }
}
