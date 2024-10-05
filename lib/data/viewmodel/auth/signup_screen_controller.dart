import 'package:JazakAllah/data/viewmodel/auth/user_data_controller.dart';
import 'package:get/get.dart';
import '../../../data/models/network_response.dart';
import '../../../data/services/network_caller.dart';
import '../../../data/utility/urls.dart';
import '../../utility/token_manager.dart';

class SignUpScreenController extends GetxController {
  String _message = '';
  String _token = '';

  String get message => _message;

  Future<bool> signUp(String name, String email, String password, String userAdId) async {
    update();
    Map<String, dynamic> requestBody = {
      "fullName": name,
      "email": email,
      "password": password,
      "oneSignalId": userAdId,
    };
    final NetworkResponse response =
        await NetworkCaller().postRequest(Urls.userSignUp, requestBody);
    update();
    if (response.isSuccess) {
      /*_token = response.responseJson['token'];
      await AuthController.setAccessToken(_token);*/
      await UserDataController.setUserId(
          response.responseJson['newUser']['_id']);
      await UserDataController.setUserName(
          response.responseJson['newUser']['fullName']);
      await UserDataController.setUserMail(
          response.responseJson['newUser']['email']);
      DateTime expireTime = DateTime.now().add(const Duration(days: 6));
      await AuthController.setExpireDateAndTime(expireTime.toString());
      // print(response.responseJson['newUser']['_id']);
      // print(response.responseJson['newUser']['fullName']);
      // print(response.responseJson['newUser']['email']);
      print(_token);
      return true;
    } else {
      if (response.statusCode == 500) {
        _message = 'dup_user';
      }
      print(_message);
      return false;
    }
  }
}
