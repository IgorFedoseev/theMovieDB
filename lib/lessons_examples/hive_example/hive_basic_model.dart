
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HiveExampleWidgetModel{
  HiveExampleWidgetModel(){
    Hive.initFlutter(); // асинхронная функция, лучше делать в main и с await
  }
  void doSome() async {
    var box = await Hive.openBox<dynamic>('testBox'); // открываем box (коллекцию) и присваиваем имя
    // Hive.box('testBox'); // возвращает инстанс уже открытого бокса
    // box.isOpen // проверка - открыт ли бокс
    await box.put('name', 'Ivan'); // записать данные (ключ, значение)
    await box.put('age', 32);
    await box.put('friends', ['Lexa', 'Dima', 'Vasya']);
    // final name = box.get('name') as String?; //получить данные по ключу
    // final age = box.get('age') as int?;
    // final friends = box.get('friends') as List<String>?;
    // final surname = box.get('surname', defaultValue: 'Petrov') as String; // значение по умолчанию
    // print(name);
    // print(surname);
    // print(age);
    // print(friends);
    // box.putAll({'key1': 'value1', 42: 'life'}); можно добавлять сразу несколько записей с ключем любого типа
    // final index = await box.add('Anything else'); // добавляет значение без ключа и возвращает индекс
    // final anythingElse = box.getAt(index); // и по этому индексу получаем значение
    // print(anythingElse);

    // await box.deleteAt(0); // удалить по индексу
    // await box.delete('surname'); // удалить по ключу
    // await box.deleteFromDisk(); // удалить всё

    // final boxValues = box.values.toList(); // все значения
    // print(boxValues);
    // final boxKeys = box.keys.toList(); // все ключи
    // print(boxKeys);

    box.close(); // закрываем box, чтобы выгрузился из памяти
  }
}