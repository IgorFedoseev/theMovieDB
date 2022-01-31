import 'package:lazyload_flutter_course/lessons_examples/json_lesson/address.dart';

class Human {
  String name;
  String surname;
  int age;
  List<Address> adresses;

  Human({
    required this.name,
    required this.surname,
    required this.age,
    required this.adresses,
  });

  factory Human.fromJson(Map<String, dynamic> json){
    return Human(
      name: json['name'] as String,
      surname: json['surname'] as String,
      age: json['age'] as int,
      adresses: (json['addresses'] as List<dynamic>)
          .map((e) => Address.fromJson(e as Map<String, dynamic>)).toList(),
    );
  }
}
