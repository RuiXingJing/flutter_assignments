class FormatUtils {
  static bool isNumber(String str) {
    final reg = RegExp(r"^[0-9_]+$");
    return reg.hasMatch(str);
  }
}
