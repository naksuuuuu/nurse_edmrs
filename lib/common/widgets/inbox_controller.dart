import 'dart:convert';

import 'package:bu_edmrs/API/api_endpoints.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class InboxController extends GetxController {
  final storage = GetStorage();
  static InboxController get instance => Get.find();

  RxList<Map<String, dynamic>> approvalData = <Map<String, dynamic>>[].obs;
  RxBool isLoading = true.obs;

  @override
  void onReady() {
    super.onReady();
    fetchData(); // Fetch data when the controller initializes
  }

  Future<void> fetchData() async {
    try {
      isLoading.value = true;
      // print(isLoading.value);
      var url =
          Uri.parse(ApiEndpoints.baseUrl + ApiEndpoints.authEndPoints.getInbox);
      String user = storage.read('username');
      String userpass = storage.read('password');
      String credentials = '$user:$userpass';
      String encodedCredentials = base64Encode(utf8.encode(credentials));
      Map<String, String> headers = {
        'authorization': 'Basic $encodedCredentials'
      };

      var response = await http.post(
        url,
        headers: headers,
      );
      var res = jsonDecode(response.body);

      if (res['success']) {
        List<dynamic> dataList = res['data'];
        List<Map<String, dynamic>> listMap =
            dataList.map((item) => item as Map<String, dynamic>).toList();
        // print(listMap);
        // approvalData = listMap;
        //  approvalData.assignAll(listMap);
        // isLoading(false);
        isLoading.value = false;
        approvalData.value = listMap;
        // approvalData.value = [];
        // print(isLoading.value);
        // isLoading(false);
        // print(approvalData);
        // isLoading(false);
      }
    } finally {
      isLoading.value = false;
      // print(isLoading.value);
    }
  }
}
