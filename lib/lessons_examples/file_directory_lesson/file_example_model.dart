import 'package:flutter/material.dart';

class FileExampleModel extends ChangeNotifier {
  void readFile() async {}
}

class FileExampleModelProvider extends InheritedNotifier {
  final FileExampleModel model;
  const FileExampleModelProvider({
    Key? key,
    required this.model,
    required Widget child,
  }) : super(key: key, notifier: model, child: child);

  static FileExampleModelProvider? watch(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<FileExampleModelProvider>();
  }

  static FileExampleModelProvider? read(BuildContext context) {
    final widget = context
        .getElementForInheritedWidgetOfExactType<FileExampleModelProvider>()
        ?.widget;
    return widget is FileExampleModelProvider ? widget : null;
  }
}
