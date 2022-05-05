import 'package:hive/hive.dart';

part 'model_user.g.dart';

@HiveType(typeId: 1)
class ModelUser extends HiveObject {
  @HiveField(0)
  String name = '';

  @HiveField(1)
  String email = '';

  @HiveField(2)
  String jwtToken = '';

  @HiveField(3)
  String imagePath = '';

  ModelUser();
}
