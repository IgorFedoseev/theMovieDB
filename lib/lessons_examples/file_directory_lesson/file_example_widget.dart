import 'package:flutter/material.dart';
import 'package:lazyload_flutter_course/lessons_examples/file_directory_lesson/file_example_model.dart';

class FileExampleWidget extends StatefulWidget {
  const FileExampleWidget({Key? key}) : super(key: key);

  @override
  _FileExampleWidgetState createState() => _FileExampleWidgetState();
}

class _FileExampleWidgetState extends State<FileExampleWidget> {
  final _model = FileExampleModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: FileExampleModelProvider(
            model: _model,
            child: Column(
              children: const [
                _ReadFileButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ReadFileButton extends StatelessWidget {
  const _ReadFileButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: FileExampleModelProvider.read(context)!.model.readFile,
      child: const Text('Read file'),
    );
  }
}
