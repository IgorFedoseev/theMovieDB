// import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

// для генерации адаптеров в dev_dependencies нужно добавить два пакета:
// hive_generator: ^1.1.2
// build_runner: ^2.1.7

class HiveAdapterWidgetModel {
  HiveAdapterWidgetModel() {
    Hive.initFlutter(); // асинхронная функция, лучше делать в main и с await
  }

  void doSome() async {
    if (!Hive.isAdapterRegistered(0)){ // проверка чтобы повторно не регистрировать
      Hive.registerAdapter(UserAdapter()); // регистрируем только 1 раз!
    }
    var box = await Hive.openBox<dynamic>('testBox');
    final user = User('Victor', 20);
    // await box.add(user);
    final userFromBox = box.getAt(1);
    print(userFromBox);
  }
}

class User {
  String name;
  int age;

  User(this.name, this.age);

  @override
  String toString() => 'Name: $name, age: $age'; // Just for print()
}

class UserAdapter extends TypeAdapter<User>{ // всегда наследует TypeAdapter с дженериком нужного типа
  @override
  final typeId = 0; // необходимо указать уникальный id

  @override
  User read(BinaryReader reader) {
    final name = reader.readString();
    final age = reader.readInt();
    return User(name, age);
  }

  @override
  void write(BinaryWriter writer, User obj) {
    // writer.write(obj.name); // универсальный метод ля записи
    writer.writeString(obj.name); // для записи строк
    writer.writeInt(obj.age); // для записи интов
  }

}