import 'dart:html' as html;

bool get isWasmOptInFromBootstrap {
  final params = Uri.base.queryParameters;
  final wasm = params['wasm'];
  final hasWasmParam = params.containsKey('wasm');
  final wasmParam = (wasm ?? '').toLowerCase();
  final explicitWasmSetting = wasmParam == '1' || wasmParam == 'true';

  final ua = html.window.navigator.userAgent.toLowerCase();
  final vendor = html.window.navigator.vendor.toLowerCase();
  final isFirefox = RegExp(r'firefox/\d+', caseSensitive: false).hasMatch(ua);
  final isSafari =
      RegExp(r'safari/\d+', caseSensitive: false).hasMatch(ua) &&
      vendor.contains('apple') &&
      !RegExp(r'chrome|crios|edg|opr|fxios|android', caseSensitive: false).hasMatch(ua);

  final defaultWasmSetting = !(isFirefox || isSafari);
  return hasWasmParam ? explicitWasmSetting : defaultWasmSetting;
}
