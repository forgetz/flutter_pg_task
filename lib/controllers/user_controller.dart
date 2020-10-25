import 'package:get/get.dart';
import 'package:task/models/user_model.dart';

class UserController extends GetxController {
  final user = UserModel().obs;
}
