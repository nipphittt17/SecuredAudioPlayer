import 'package:client/models/audio_item.model.dart';
import 'package:flutter/material.dart';

class AudioItem extends StatelessWidget {
  const AudioItem({super.key, required this.audio});

  final AudioItemModel audio;

  @override
  Widget build(BuildContext context) {
    // return MacosListTile(
    //   title: Text(audio.name),
    //   leading: const Icon(Icons.abc),
    //   mouseCursor: SystemMouseCursors.click,
    // );

    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          TextButton(
            onPressed: () {},
            child: Text(audio.name),
          ),
        ],
      ),
    );
  }
}
