import 'package:flutter/material.dart';
import 'package:lazyload_flutter_course/lessons_examples/shared_preference_and_security_storage_example/shared_security_model.dart';

class SharedSecurityExampleWidget extends StatefulWidget {
  const SharedSecurityExampleWidget({Key? key}) : super(key: key);

  @override
  _SharedSecurityExampleWidgetState createState() =>
      _SharedSecurityExampleWidgetState();
}

class _SharedSecurityExampleWidgetState
    extends State<SharedSecurityExampleWidget> {
  final _model = SharedSecurityExampleModel();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              ElevatedButton(
                onPressed: _model.setName,
                child: const Text('Save the name'),
              ),
              ElevatedButton(
                onPressed: _model.readName,
                child: const Text('Read the name'),
              ),
              ElevatedButton(
                onPressed: _model.setToken,
                child: const Text('Save the token'),
              ),
              ElevatedButton(
                onPressed: _model.readToken,
                child: const Text('Read the token'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
