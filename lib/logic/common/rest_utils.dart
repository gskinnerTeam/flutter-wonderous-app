class RestUtils {
  static String encodeParams(Map<String, String> params) {
    var s = '';
    params.forEach((key, value) {
      if (value.isNotEmpty && value != 'null') {
        var urlEncode = Uri.encodeComponent(value);
        s += '${s == '' ? '?' : '&'}$key=$urlEncode';
      }
    });
    return s;
  }
}
