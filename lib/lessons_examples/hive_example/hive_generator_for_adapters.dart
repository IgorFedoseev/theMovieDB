import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'hive_generator_for_adapters.g.dart';
// команда для запуска в терминале - flutter packages pub run build_runner build

class HiveGeneratorWidgetModel {
  HiveGeneratorWidgetModel() {
    Hive.initFlutter(); // асинхронная функция, лучше делать в main и с await
  }

  void doSome() async {
    if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter(UserAdapter());
    }
    if (!Hive.isAdapterRegistered(1)) { // для каждого нового класса свой адаптер
      Hive.registerAdapter(PetAdapter());
    }
    // Hive.deleteBoxFromDisk('testBox'); // если бокс уже был создан вручную - удалить и пересоздать
    var box = await Hive.openBox<dynamic>('testBox');
    var petBox = await Hive.openBox<Pet>('petBox'); // открываем новый бокс
    final pet = Pet('Sharik'); // создаём экземпляр класса
    await petBox.add(pet); // добавляем в новый бокс новый экземпляр
    final victorsPets = HiveList(petBox, objects: [pet]); // ссылка на животных Виктора
    final user = User('Victor', 20, 'Petrov', victorsPets);
    //final user = box.get('victor');
    await box.put('victor', user);
    if (user != null) {
      user.age = 18;
      await user.save(); // за счет наследования класса User от HiveObject, можем устанавливать и сохранять новые значения
      //await user.delete(); // или удалить
    }
    //await box.deleteAt(0);
    //final userFromBox = box.getAt(3);
    final firstPet = user.pets?.first;
    print(box.length);
    print(box.keys);
    //print(box.values);
    print(firstPet);
    await box.compact();
    await petBox.compact();
    await box.close();
    await petBox.close();
  }
}

@HiveType(typeId: 0)
class User extends HiveObject {
  // removed HiveField(3)
  // если удаляем - новые поля нельзя делать с тем же индексом, тк старые значения могли остаться

  // можем наследовать наш генерируемый класс от HiveObject
  @HiveField(2) // не обязательно по порядку
  String? surname; // можно переименовывать и удалять поля
  // новые поля надо делать с опциональным типом - так как создавались с null до этого
  // лучше писать в коде коммент если было удалено поле, чтобы не заводить под таким id новое

  @HiveField(0) // id полей не менять!
  String name;

  @HiveField(1)
  int age;

  @HiveField(4) // создаём связь между объектами
  HiveList<Pet>? pets; // типом будет список хайв объектов

  User(this.name, this.age, this.surname, this.pets);

  @override
  String toString() =>
      'Name: $name, age: $age, surname: $surname, pets: $pets'; // Just for print()
}

@HiveType(typeId: 1)
class Pet extends HiveObject {

  @HiveField(0)
  String name;

  Pet(this.name);

  @override
  String toString() =>
      'Name: $name'; // Just for print()
}
