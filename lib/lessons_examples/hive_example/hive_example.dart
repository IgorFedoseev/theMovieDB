import 'package:flutter/material.dart';
import 'package:lazyload_flutter_course/lessons_examples/hive_example/hive_adapter_model.dart';

class HiveExampleWidget extends StatefulWidget {
  const HiveExampleWidget({Key? key}) : super(key: key);

  @override
  _HiveExampleWidgetState createState() => _HiveExampleWidgetState();
}

class _HiveExampleWidgetState extends State<HiveExampleWidget> {
  final model = HiveAdapterWidgetModel();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: ElevatedButton(
            onPressed: model.doSome,
            child: const Text('push me'),
          ),
        ),
      ),
    );
  }
}
