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
}
