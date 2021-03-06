import 'package:flutter/material.dart';
import 'package:lazyload_flutter_course/lessons_examples/hive_example/hive_flutter_listenable.dart';

// Необходимо по-правильному инициализировать в мэйне
// import 'package:hive/hive.dart';
// import 'package:hive_flutter/hive_flutter.dart';
//
// void main() async {
//   WidgetsFlutterBinding.ensureInitialized(); // для запуска после инициализации
//   await Hive.initFlutter(); // инициализируем здесь же Хайв
//   Hive.registerAdapter(UserAdapter()); // (не обяз здесь) и регистрируем сразу здесь же адаптер
//   const app = MyApp();
//   runApp(app);
// }

class HiveExampleWidget extends StatefulWidget {
  const HiveExampleWidget({Key? key}) : super(key: key);

  @override
  _HiveExampleWidgetState createState() => _HiveExampleWidgetState();
}

class _HiveExampleWidgetState extends State<HiveExampleWidget> {
  final model = HiveFlutterListenableWidget();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              ElevatedButton(
                onPressed: model.doSome,
                child: const Text('Add'),
              ),
              ElevatedButton(
                onPressed: model.setup,
                child: const Text('Setup'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
