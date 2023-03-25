class Utils {
  static String getFileName(String path) {
    final li = path.split("/");
    return li[li.length - 1];
  }
}
