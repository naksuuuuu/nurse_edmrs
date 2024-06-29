import 'dart:convert';

import 'package:bu_edmrs/API/api_endpoints.dart';
import 'package:bu_edmrs/API/balance_model.dart';
import 'package:bu_edmrs/utils/popups/popups.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class BalanceController extends GetxController {
  List<Balance> balance = <Balance>[].obs;
  RxBool isLoading = true.obs;
  @override
  void onInit() {
    super.onInit();

    fetchUserBalance();
  }

  fetchUserBalance() async {
    final storage = GetStorage();
    var url =
        Uri.parse(ApiEndpoints.baseUrl + ApiEndpoints.authEndPoints.balance);
    String user = storage.read('username');
    String userpass = storage.read('password');
    String credentials = '$user:$userpass';
    String encodedCredentials = base64Encode(utf8.encode(credentials));
    Map<String, String> headers = {
      'Authorization': 'Basic $encodedCredentials'
    };

    try {
      isLoading(true);
      var response = await http.post(
        url,
        headers: headers,
      );

      var res = await json.decode(response.body);
      print(res);
      if (res['success']) {
        balance = UserBalance.fromJson(res).balance!;
        update();
      } else {
        PopUps.errorSnackBar(title: 'Error', message: 'Error fetching Data');
      }
    } finally {
      isLoading(false);
    }
  }
}
