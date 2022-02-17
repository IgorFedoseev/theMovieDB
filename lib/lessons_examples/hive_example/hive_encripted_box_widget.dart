import 'dart:convert';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// импортируем пакет

class HiveEncryptedBoxWidget {
  HiveEncryptedBoxWidget() {
    Hive.initFlutter();
  }

  void doSome() async {
    const FlutterSecureStorage secureStorage = FlutterSecureStorage();
    // создаём экземпляр
    final containsEncryptionKey = await secureStorage.containsKey(key: 'bfoefibvoes');
    containsEncryptionKey; // всегда true почему-то
    // проверяем есть ли созданный ключ
    if (containsEncryptionKey) {
      // если нету - создаём
      final key = Hive.generateSecureKey(); // генерируем ключ
      await secureStorage.write(key: 'bfoefibvoes', value: base64UrlEncode(key));
      // энкодируем из байтов в строку
    }

    final key = await secureStorage.read(key: 'bfoefibvoes');
    // читаем значение ключа
    final encryptionKey = base64Url.decode(key!);
    // создаём из ключа-строки ключ с типом спика инт (байт)

    final encryptedBox = await Hive.openBox<String>(
      // создаём шифрованный бокс
      'anyEncryptedBox', // его название
      encryptionCipher: HiveAesCipher(encryptionKey),
      // создаём шифр бокса с данным ключом
    );
    await encryptedBox.put('string', 'Hive is cool');
    //await secureStorage.deleteAll();
    encryptedBox.values;
    Map<String, String> allValues = await secureStorage.readAll();
    allValues;
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
  String toString() => 'Name: $name'; // Just for print()
}
