import 'package:client/models/audio_item.model.dart';
import 'package:flutter/material.dart';
import 'package:macos_ui/macos_ui.dart';

class AudioItemWidget extends StatefulWidget {
  const AudioItemWidget({
    super.key,
    required this.sequence,
    required this.audio,
  });

  final int sequence;
  final AudioItemModel audio;

  @override
  State<AudioItemWidget> createState() => _AudioItemWidgetState();
}

class _AudioItemWidgetState extends State<AudioItemWidget> {
  bool _isHovering = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: MouseRegion(
        onEnter: (_) {
          setState(() {
            _isHovering = true;
          });
        },
        onExit: (_) {
          setState(() {
            _isHovering = false;
          });
        },
        child: Container(
          color:
              _isHovering ? Colors.blue.withOpacity(0.2) : Colors.transparent,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: MacosListTile(
              mouseCursor: SystemMouseCursors.click,
              onClick: () {},
              leadingWhitespace: 10,
              title: Text(
                widget.audio.name,
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),
              leading: const Icon(Icons.audio_file, size: 20),
            ),
          ),
        ),
      ),
    );
  }
}
