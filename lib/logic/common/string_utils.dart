class StringUtils {
  static bool isEmpty(String? s) {
    return s == null || s.trim().isEmpty;
  }

  static bool isNotEmpty(String? s) => !isEmpty(s);

  static bool isLink(String str) =>
      str.contains(RegExp(r'^(https?:\/\/)?([\w\d_-]+)\.([\w\d_\.-]+)\/?\??([^#\n\r]*)?#?([^\n\r]*)'));

  static String truncateWithEllipsis(int cutoff, String myString) {
    return (myString.length <= cutoff) ? myString : '${myString.substring(0, cutoff)}...';
  }

  static String printMap(Map<String, dynamic>? map) {
    String str = '';
    map?.forEach((key, value) => str += '$key: ${value.toString}, ');
    return str;
  }
}
