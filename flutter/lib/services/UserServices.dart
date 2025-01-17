import '../services/Storage.dart';
import 'dart:convert';

class UserServices {
  static final UserServices _userServices = UserServices._internal();

  UserServices._internal();

  factory UserServices() {
    return _userServices;
  }

  Future<int> getUserId() async {
    // bool state = await getUserLoginState();

    // if (!state) {
    //   return -1;
    // }
    var id = await Storage().getString('user_id');
    return int.parse(id!);
  }

  Future<List> getUserInfo() async {
    List userinfo = [];
    try {
      String? jsonInfo = await Storage().getString('userInfo');
      if (jsonInfo != null) {
        List userInfoData = json.decode(jsonInfo);
        userinfo = userInfoData;
      }
    } catch (e) {
      userinfo = [];
    }
    return userinfo;
  }

  Future<bool> getUserLoginState() async {
    var userInfo = await UserServices().getUserInfo();
    if (userInfo.isNotEmpty && userInfo[0]["username"] != "") {
      return true;
    }
    return false;
  }

  void login() {
    Storage().setString('user_id', 1.toString());
  }

  void loginOut() {
    Storage().remove('userInfo');
  }
}
