import 'package:flutter/material.dart';

class InheritedExample extends StatelessWidget {
  const InheritedExample({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: DataOwnerStateful(),
      ),
    );
  }
}

class DataOwnerStateful extends StatefulWidget {
  const DataOwnerStateful({Key? key}) : super(key: key);

  @override
  _DataOwnerStatefulState createState() => _DataOwnerStatefulState();
}

class _DataOwnerStatefulState extends State<DataOwnerStateful> {
  var _valueOne = 0;
  var _valueTwo = 0;

  void _incrementOne() {
    _valueOne += 1;
    setState(() {});
  }

  void _incrementTwo() {
    _valueTwo += 1;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: _incrementOne,
          child: const Text('Push me'),
        ),
        ElevatedButton(
          onPressed: _incrementTwo,
          child: const Text('Push me again'),
        ),
        DataProviderInherited(
          child: const DataComsumerStateless(),
          valueOne: _valueOne,
          valueTwo: _valueTwo,
        ),
      ],
    );
  }
}

class DataComsumerStateless extends StatelessWidget {
  const DataComsumerStateless({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final value = context
            .dependOnInheritedWidgetOfExactType<DataProviderInherited>()
            ?.valueOne ??
        0;
    // dependOnInheritedWidgetOfExactType - подписываемся и получаем инхерит
    //findAncestorStateOfType<_DataOwnerStatefulState>()?._value ?? 0;
    //был доступ к значению стейта через контекст
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text('$value'),
        const DataConsumerStateful(),
      ],
    );
  }
}

class DataConsumerStateful extends StatefulWidget {
  const DataConsumerStateful({Key? key}) : super(key: key);

  @override
  _DataConsumerStatefulState createState() => _DataConsumerStatefulState();
}

class _DataConsumerStatefulState extends State<DataConsumerStateful> {
  @override
  Widget build(BuildContext context) {
    final value = getInherit<DataProviderInherited>(context)?.valueTwo ?? 0;
    return Text('$value');
  }
}

T? getInherit<T>(BuildContext context) {
  final element =
      context.getElementForInheritedWidgetOfExactType<DataProviderInherited>();
  // getElementForInheritedWidgetOfExactType - только получаем элемент
  if(element != null){
    context.dependOnInheritedElement(element);
    // dependOnInheritedElement - только подписываемся на элемент
  }
  final widget = element?.widget;
  if (widget is T) {
    return widget as T;
  } else {
    return null;
  }
}

class DataProviderInherited extends InheritedWidget {
  final int valueOne;
  final int valueTwo;
  const DataProviderInherited({
    Key? key,
    required this.valueOne,
    required this.valueTwo,
    required Widget child,
  }) : super(key: key, child: child);

  // static DataProviderInherited of(BuildContext context) {
  //   final DataProviderInherited? result =
  //       context.dependOnInheritedWidgetOfExactType<DataProviderInherited>();
  //   assert(result != null, 'No DataProviderInherited found in context');
  //   return result!;
  // }

  @override
  bool updateShouldNotify(DataProviderInherited oldWidget) {
    return valueOne != oldWidget.valueOne || valueTwo != oldWidget.valueTwo;
  }
}
