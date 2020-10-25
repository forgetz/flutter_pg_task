import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task/models/user_model.dart';
import 'package:task/views/login_screen.dart';

class UserController extends GetxController {
  final user = UserModel().obs;

  Future<void> getUser() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String getusername = preferences.getString('username');
    String gettoken = preferences.getString('token');
    String getuserId = preferences.getString('userId');
    print('getUser username=$getusername userId=$getuserId');

    if ((getusername?.isEmpty ?? true) || (getuserId?.isEmpty ?? true)) {
      Get.offAll(LoginScreen());
    }

    user.value = UserModel(
      accessToken: gettoken,
      userId: getuserId,
      username: getusername,
    );

    update();
  }
}
