import 'package:json_annotation/json_annotation.dart';
import 'package:lazyload_flutter_course/lessons_examples/json_lesson/address.dart';

part 'human.g.dart';

@JsonSerializable()
class Human {
  // @JsonKey(name: 'first_name') - если отлич переменная от ключа в json файле
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

  factory Human.fromJson(Map<String, dynamic> json) => _$HumanFromJson(json);

  Map<String, dynamic> toJson() => _$HumanToJson(this);

  // factory Human.fromJson(Map<String, dynamic> json){
  //   return Human(
  //     name: json['name'] as String,
  //     surname: json['surname'] as String,
  //     age: json['age'] as int,
  //     adresses: (json['addresses'] as List<dynamic>)
  //         .map((e) => Address.fromJson(e as Map<String, dynamic>)).toList(),
  //   );
  // }
  //
  // Map<String, dynamic> toJson(){
  //   return <String, dynamic>{
  //     'name': name,
  //     'surname': surname,
  //     'age': age,
  //     'addresses': adresses.map((e) => e.toJson()).toList(),
  //   };
  // }
}
