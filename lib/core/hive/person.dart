import 'package:hive/hive.dart';

part 'person.g.dart';

@HiveType(typeId: 1)
class Person {
  Person({
    required this.Name,
    required this.lastName,
    required this.Age,
    required this.PhoneNumber,
    required this.CreatedAt,
    required this.UpdatedAt,
  });

  @HiveField(0)
  String Name;
  @HiveField(1)
  String lastName;
  @HiveField(2)
  String Age;
  @HiveField(3)
  String PhoneNumber;
  @HiveField(4)
  DateTime CreatedAt;
  @HiveField(5)
  DateTime UpdatedAt;
}
