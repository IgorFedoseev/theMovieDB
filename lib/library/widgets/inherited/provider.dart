import 'package:flutter/material.dart';

class NotifierProvider<Model extends ChangeNotifier> extends StatefulWidget {
  final Widget child;
  final bool isManagingModel;
  final Model Function() create;

  const NotifierProvider({
    Key? key,
    required this.create,
    this.isManagingModel = true,
    required this.child,
  }) : super(key: key);

  @override
  _NotifierProviderState<Model> createState() =>
      _NotifierProviderState<Model>();

  static Model? watch<Model extends ChangeNotifier>(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<InheritedNotifierProvider<Model>>()
        ?.model;
  }

  static Model? read<Model extends ChangeNotifier>(BuildContext context) {
    final widget = context
        .getElementForInheritedWidgetOfExactType<
            InheritedNotifierProvider<Model>>()
        ?.widget;
    return widget is InheritedNotifierProvider<Model> ? widget.model : null;
  }
}

class _NotifierProviderState<Model extends ChangeNotifier>
    extends State<NotifierProvider<Model>> {
  late final Model _model;

  @override
  void initState() {
    super.initState();
    _model = widget.create();
  }

  @override
  Widget build(BuildContext context) {
    return InheritedNotifierProvider(
      model: _model,
      child: widget.child,
    );
  }

  @override
  void dispose() {
    super.dispose();
    if (widget.isManagingModel) {
      _model.dispose();
    }
  }
}

class InheritedNotifierProvider<Model extends ChangeNotifier>
    extends InheritedNotifier {
  final Model model;

  const InheritedNotifierProvider({
    Key? key,
    required Widget child,
    required this.model,
  }) : super(key: key, notifier: model, child: child);
}

class Provider<Model> extends InheritedWidget {
  final Model model;
  const Provider({
    Key? key,
    required this.model,
    required Widget child,
  }) : super(key: key, child: child);

  @override
  bool updateShouldNotify(Provider oldWidget) {
    return model != oldWidget.model;
  }
}
