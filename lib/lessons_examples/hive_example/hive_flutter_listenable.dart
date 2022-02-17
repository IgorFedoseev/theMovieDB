import 'package:hive_flutter/hive_flutter.dart';

part 'hive_flutter_listenable.g.dart';

class HiveFlutterListenableWidget {
  HiveFlutterListenableWidget() {
    Hive.initFlutter();
  }

  Future<Box<User>>? userBox;

  void setup() async{
    if(!Hive.isAdapterRegistered(0)){
      Hive.registerAdapter(UserAdapter());
    }
    userBox = Hive.openBox<User>('user_box');
    userBox?.then((box) {
      box.listenable().addListener(() {
        box.values;
      });
    });
  }

  void doSome() async {
    final box = await userBox;
    final user = User('Semen', 34);
    await box?.add(user);
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

  User(this.name, this.age, {this.surname, this.pets});

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
  String toString() => 'Name: $name'; // Just for print()
}