import 'package:flutter/foundation.dart';
import 'package:wonders/logic/common/json_prefs_file.dart';
import 'package:wonders/logic/common/throttler.dart';

abstract class PersistentLogic {
  late final _file = JsonPrefsFile(fileName);
  final throttle = Throttler(const Duration(seconds: 2));

  Future<void> load() async {
    final results = await _file.load();
    try {
      copyFromJson(results);
    } on Exception catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> save() async {
    debugPrint('Saving...');
    await _file.save(toJson());
  }

  Future<void> scheduleSave() async => throttle.call(save);

  /// Serialization
  String get fileName;
  Map<String, dynamic> toJson();
  void copyFromJson(Map<String, dynamic> value);
}
