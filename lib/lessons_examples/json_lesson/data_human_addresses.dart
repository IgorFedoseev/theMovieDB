import 'dart:html';

import 'package:lazyload_flutter_course/lessons_examples/json_lesson/address.dart';
import 'package:lazyload_flutter_course/lessons_examples/json_lesson/human.dart';

final humans = [
  Human(
    name: 'Ivan',
    surname: 'Sergeev',
    age: 17,
    adresses: [
      Address(city: 'Moscow', street: 'Baumana', house: '17A', flat: 3),
      Address(city: 'Samara', street: 'Volzhskaya', house: '45', flat: 121),
      Address(city: 'Piter', street: 'Nevskaya', house: '22', flat: 33),
    ],
  ),
  Human(
    name: 'Semen',
    surname: 'Petrov',
    age: 77,
    adresses: [
      Address(city: 'Tula', street: 'Tokareva', house: '111', flat: 37),
      Address(city: 'Chita', street: 'Gornaya', house: '49B', flat: 77),
      Address(city: 'Penza', street: 'Surskaya', house: '1', flat: 1),
    ],
  ),
];

const jsonString = '''
  [
    {
      "name": "Ivan",
      "surname": "Sergeev",
      "age": 17,
      "addresses": [
        {
        "city": "Moscow",
        "street": "Baumana",
        "house": "17A",
        "flat": 3
        }
        {
        "city": "Samara",
        "street": "Volzhskaya",
        "house": "45",
        "flat": 121
        }
        {
        "city": "Piter",
        "street": "Nevskaya",
        "house": "22",
        "flat": 33
        }
      ]
    },
    {
    "name": "Semen",
      "surname": "Petrov",
      "age": 77,
      "addresses": [
        {
        "city": "Tula",
        "street": "Tokareva",
        "house": "111",
        "flat": 37
        }
        {
        "city": "Chita",
        "street": "Gornaya",
        "house": "49B",
        "flat": 77
        }
        {
        "city": "Penza",
        "street": "Surskaya",
        "house": "1",
        "flat": 1
        }
      ]
    }
  ]
''';