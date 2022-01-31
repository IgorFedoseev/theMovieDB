import 'package:flutter/material.dart';

class InheritedExample extends StatelessWidget {
  const InheritedExample({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
  var _value = 0;

  void _increment() {
    _value += 1;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: _increment,
          child: const Text('Push me'),
        ),
        DataComsumerStateless(),
      ],
    );
  }
}

class DataComsumerStateless extends StatelessWidget {
  const DataComsumerStateless({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final value =
        context.findAncestorStateOfType<_DataOwnerStatefulState>()?._value ?? 0;
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text('$value'),
          DataConsumerStateful(),
        ],
      ),
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
    final value = context.findAncestorStateOfType<_DataOwnerStatefulState>()?._value ?? 0;
    return Text('$value');
  }
}
