import 'dart:io';

class AudioDto {
  String name = "";
  File? file;

  static List<String> availableFileExtension = [
    "mp3",
    "wav",
    "wma",
  ];

  bool isValid() {
    if (name.isEmpty || file == null) {
      return false;
    }
    final li = file!.path.split("/");
    final filename = li[li.length - 1].split(".");
    final extension = filename[filename.length - 1];
    return availableFileExtension.contains(extension);
  }
}
