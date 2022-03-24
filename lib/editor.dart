import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/services.dart';
import 'package:window_interface/window_interface.dart';
import 'package:wonders/common_libs.dart';
import 'package:wonders/logic/data/wonder_data.dart';
import 'package:wonders/ui/common/buttons.dart';

/// A simple single-page app that enables designers to update the various .json files for each wonder.
void main() {
  runApp(MaterialApp(
      theme: ThemeData.dark(),
      home: Provider<AppStyle>(
          create: (_) => AppStyle(
                colors: ColorTheme(ColorThemeType.green),
                screenSize: Size(0, 0),
              ),
          child: _EditorApp()),
      debugShowCheckedModeBanner: false));
}

class _EditorApp extends StatefulWidget {
  @override
  State<_EditorApp> createState() => _EditorAppState();
}

class _EditorAppState extends State<_EditorApp> {
  final _controller = TextEditingController();
  WonderData _wonder = WonderData(type: WonderType.petra, title: '', desc: '');
  set wonder(WonderData value) {
    _wonder = value;
    setState(() {});
  }

  WonderData? _lastSavedWonder;

  String? _currentPath;

  String? get _currentFileName => _currentPath?.split(Platform.pathSeparator).last;

  @override
  void initState() {
    super.initState();
    _controller.text = _wonder.title;
    WindowInterface.setWindowMinSize(1024, 700);
  }

  @override
  Widget build(BuildContext context) {
    bool isDataDirty = _lastSavedWonder != _wonder;
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              key: ValueKey(_wonder.type), // Use a key to rebuild form when a new wonder data file is loaded
              children: [
                Center(child: Text('File: ${_currentFileName ?? '--'}', style: context.style.text.h1)),
                Row(
                  children: [
                    Text('Wonder Type:   '),
                    DropdownButton<WonderType>(
                        value: _wonder.type,
                        items: WonderType.values.map((e) {
                          return DropdownMenuItem<WonderType>(
                            value: e,
                            child: Text(e.name, style: TextStyle(fontSize: 32, height: 1)),
                          );
                        }).toList(),
                        onChanged: _handleTypeChanged),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 6,
                      child: _LabelledTextField(
                        _wonder.title,
                        label: 'Title',
                        onChanged: (v) => wonder = _wonder.copyWith(title: v),
                      ),
                    ),
                    Gap(24),
                    SizedBox(
                      width: 600,
                      child: Row(
                        children: [
                          Flexible(
                            child: _LabelledTextField('0', label: 'Start Year', numeric: true, onChanged: (v) {
                              return wonder = _wonder.copyWith(startYr: int.tryParse(v) ?? 0);
                            }),
                          ),
                          Flexible(
                            child: _LabelledTextField('0', numeric: true, label: 'End Year', onChanged: (v) {
                              return wonder = _wonder.copyWith(endYr: int.tryParse(v) ?? 0);
                            }),
                          ),
                          Gap(24),
                          Flexible(
                            flex: 3,
                            child: _LabelledTextField('0', label: 'Lat', onChanged: (v) {
                              return wonder = _wonder.copyWith(lat: double.tryParse(v));
                            }),
                          ),
                          Flexible(
                            flex: 3,
                            child: _LabelledTextField('0', label: 'Lng', onChanged: (v) {
                              return wonder = _wonder.copyWith(lng: double.tryParse(v));
                            }),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                TextFormField(
                    initialValue: _wonder.desc,
                    minLines: 1,
                    maxLines: 16,
                    decoration: InputDecoration(label: Text('Description')),
                    onChanged: (v) => wonder = _wonder.copyWith(desc: v)),
                Gap(12),
                Expanded(
                  child: _EditorTabs(
                    wonder: _wonder,
                    tabs: [
                      _EditorTab('images', _wonder.imageIds, (List<String> v) => _wonder.copyWith(imageUrls: v)),
                      _EditorTab('facts', _wonder.facts, (List<String> v) => _wonder.copyWith(facts: v)),
                    ],
                    onChanged: (v) => wonder = v,
                  ),
                ),
              ],
            ),
          ),
          Gap(12),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AppBtn.tight(context,
                  child: Icon(Icons.refresh, size: 20),
                  onPressed: _currentPath == null || !isDataDirty ? null : _handleReloadPressed),
              Gap(12),
              Flexible(
                child: AppBtn.wide(context, child: Text('Save'), onPressed: isDataDirty ? _handleSavePressed : null),
              ),
              Gap(12),
              Flexible(child: AppBtn.wide(context, child: Text('Load'), onPressed: _handleLoadPressed)),
              Gap(12),
              AppBtn.wide(context, child: Text('New'), onPressed: _handleResetPressed),
            ],
          ),
        ],
      ),
    ));
  }

  void _handleTypeChanged(value) => setState(() => _wonder = _wonder.copyWith(type: value));

  void _handleLoadPressed() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.custom, allowedExtensions: ['json']);
    if (result != null && result.files.isNotEmpty) {
      _currentPath = result.files.first.path!;
      _loadFromPath(_currentPath);
    }
  }

  void _handleSavePressed() async {
    String? path = _currentPath;
    path ??= await FilePicker.platform.saveFile(
      dialogTitle: 'Please select an output file:',
      fileName: _currentFileName ?? 'wonder_new.json',
    );
    if (path != null) {
      _currentPath = path;
      File(path).writeAsString(jsonEncode(_wonder.toJson()));
      setState(() => _lastSavedWonder = _wonder);
    }
  }

  void _handleResetPressed() async {
    bool? result = await showOkCancelDialog('Clear everything?');
    if (result == true) {
      _currentPath = null;
      _wonder = WonderData(type: WonderType.petra, title: '', desc: '');
      _lastSavedWonder = null;
      setState(() {});
    }
  }

  void _handleReloadPressed() async {
    bool? result = await showOkCancelDialog('Reload from disk?');
    if (result == true) {
      _loadFromPath(_currentPath);
    }
  }

  void _loadFromPath(String? path) async {
    var json = jsonDecode(await File(path!).readAsString());
    setState(() {
      _wonder = WonderData.fromJson(json);
      _lastSavedWonder = _wonder;
    });
  }

  Future<bool?> showOkCancelDialog(String msg) => showDialog(
      context: context,
      builder: (context) => AlertDialog(
            content: Text(msg),
            actions: [
              OutlinedButton(onPressed: () => Navigator.pop(context, true), child: Text('Ok')),
              OutlinedButton(onPressed: () => Navigator.pop(context, false), child: Text('Cancel')),
            ],
          ));
}

class _LabelledTextField extends StatelessWidget {
  const _LabelledTextField(this.initial, {Key? key, required this.label, required this.onChanged, this.numeric = false})
      : super(key: key);
  final bool numeric;
  final String initial;
  final String label;
  final WonderData Function(String v) onChanged;

  @override
  Widget build(BuildContext context) => TextFormField(
        initialValue: initial,
        inputFormatters: numeric ? [FilteringTextInputFormatter.digitsOnly] : [],
        decoration: InputDecoration(label: Text(label)),
        onChanged: onChanged,
      );
}

class _EditorTab {
  _EditorTab(this.label, this.items, this.updateItems);

  final String label;
  final List<String> items;
  final WonderData Function(List<String> value) updateItems;
}

class _EditorTabs extends StatefulWidget {
  const _EditorTabs({Key? key, required this.wonder, required this.onChanged, required this.tabs}) : super(key: key);

  final List<_EditorTab> tabs;
  final WonderData wonder;
  final void Function(WonderData value) onChanged;

  @override
  State<_EditorTabs> createState() => _EditorTabsState();
}

class _EditorTabsState extends State<_EditorTabs> with SingleTickerProviderStateMixin {
  _EditorTabsState();
  late final _tabController = TabController(length: widget.tabs.length, vsync: this)
    ..addListener(() => setState(() {}));
  final _addTextController = TextEditingController();
  final _addFocus = FocusNode();
  _EditorTab get tabData => widget.tabs[_tabController.index];

  @override
  void dispose() {
    _tabController.dispose();
    _addFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget buildTab(String label) => Padding(padding: const EdgeInsets.all(12.0), child: Text(label));
    Widget buildRow(String t) {
      bool isImage = t.startsWith('https://');
      return Row(
        children: [
          if (isImage) SizedBox(width: 120, height: 80, child: Image.network(t, fit: BoxFit.cover)),
          Gap(24),
          Expanded(child: TextFormField(initialValue: t)),
          Gap(24),
          AppBtn(child: Icon(Icons.delete), onPressed: () => _handleRowDeleted(t)),
        ],
      );
    }

    final children = tabData.items.map((e) => Padding(padding: EdgeInsets.all(8), child: buildRow(e))).toList();
    return Column(
      children: [
        TabBar(
          controller: _tabController,
          tabs: widget.tabs.map((e) => buildTab(e.label)).toList(),
        ),
        Row(
          children: [
            Expanded(
              child: TextField(
                focusNode: _addFocus,
                decoration: InputDecoration(hintText: 'Add item...'),
                controller: _addTextController,
                onSubmitted: (_) => _handleAddSubmit(),
              ),
            ),
            AppBtn(child: Icon(Icons.add), onPressed: _handleAddSubmit),
          ],
        ),
        Expanded(child: ListView(children: children)),
      ],
    );
  }

  void _handleAddSubmit() {
    String text = _addTextController.text;
    widget.onChanged(tabData.updateItems(List.of(tabData.items)..add(text)));
    _addTextController.clear();
    _addFocus.requestFocus();
  }

  void _handleRowDeleted(String row) {
    final items = List.of(tabData.items)..remove(row);
    widget.onChanged(tabData.updateItems(items));
  }
}
