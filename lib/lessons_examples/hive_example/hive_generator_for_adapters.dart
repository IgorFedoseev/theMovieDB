import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'hive_generator_for_adapters.g.dart';
// команда для запуска в терминале - flutter packages pub run build_runner build

class HiveGeneratorWidgetModel {
  HiveGeneratorWidgetModel() {
    Hive.initFlutter(); // асинхронная функция, лучше делать в main и с await
  }

  void doSome() async {
    if (!Hive.isAdapterRegistered(0)){ // проверка чтобы повторно не регистрировать
      Hive.registerAdapter(UserAdapter()); // регистрируем только 1 раз!
    }
    // Hive.deleteBoxFromDisk('testBox'); // если бокс уже был создан вручную - удалить и пересоздать
    var box = await Hive.openBox<dynamic>('testBox');
    final user = User('Victor', 20);
    await box.add(user);
    final userFromBox = box.getAt(0);
    print(userFromBox);
  }
}

@HiveType(typeId: 0)
class User {
  @HiveField(0)
  String name;

  @HiveField(1)
  int age;

  User(this.name, this.age);

  @override
  String toString() => 'Name: $name, age: $age'; // Just for print()
}
