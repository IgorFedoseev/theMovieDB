
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HiveExampleWidgetModel{
  HiveExampleWidgetModel(){
    Hive.initFlutter(); // асинхронная функция, лучше делать в main и с await
  }
  void doSome() async {
    var box = await Hive.openBox<dynamic>('testBox'); // открываем box (коллекцию) и присваиваем имя
    final name = box.get('name') as String?;
    print(name);
  }
}