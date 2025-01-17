import 'package:dio/dio.dart';

import '../services/UserServices.dart';
import 'request.dart';

class AddressInfo {
  int? id;
  final String name;
  final String phone;
  final String area;
  final String detail;

  AddressInfo(this.name, this.phone, this.area, this.detail);
}

/// global sinlenton class
class AddressManager {
  static final AddressManager _addressManager = AddressManager._internal();

  factory AddressManager() {
    return _addressManager;
  }

  AddressManager._internal();

  List<AddressInfo> addressInfos = [];

  Future<AddressInfo?> getDefaultAddressInfo() async {
    List<AddressInfo> infos = await fetchAddressInfos();
    if (infos.isNotEmpty) {
      return infos[0];
    }
    return null;
  }

  Future<List<AddressInfo>> fetchAddressInfos() async {
    int userId = await UserServices().getUserId();

    var tempJson = {
      "userId": userId,
    };

    try {
      Response response = await Request()
          .get("/express/address/getAddressList", queryParameters: tempJson);

      List<dynamic> addressInfoList = response.data['data'];
      List<AddressInfo> infos = [];
      for (var jsonInfo in addressInfoList) {
        infos.add(AddressInfo(jsonInfo['name'], jsonInfo['phone'],
            jsonInfo['address'], jsonInfo['detailAddress']));
      }

      return infos;
    } catch (error) {}

    return [];
  }

  Future<bool> addAddress(AddressInfo info) async {
    int userId = await UserServices().getUserId();
    var tempJson = {
      "userId": userId,
      "name": info.name,
      "phone": info.phone,
      "address": info.area,
      "detailAddress": info.detail
    };

    try {
      Response response =
          await Request().post("/express/address/addAddress", data: tempJson);
      if (response.data['msg'] == "成功") {
        return true;
      }
    } catch (error) {
      print(error);
    }

    return false;
  }

  // Future<bool> deleteAddress() {}
}
