import 'package:wonders/logic/common/web_wasm_info_stub.dart'
    if (dart.library.html) 'package:wonders/logic/common/web_wasm_info_web.dart'
    as impl;

bool get isWasmOptInFromBootstrap => impl.isWasmOptInFromBootstrap;
