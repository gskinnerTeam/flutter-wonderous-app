import 'package:wonders/logic/utils/string_utils.dart';

class RestUtils {
  static String encodeParams(Map<String, String> params) {
    var s = '';
    params.forEach((key, value) {
      if (!StringUtils.isEmpty(value) && value != 'null') {
        var urlEncode = Uri.encodeComponent(value);
        s += (s == '' ? '?' : '&') + '$key=$urlEncode';
      }
    });
    return s;
  }
}
