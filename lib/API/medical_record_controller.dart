import 'dart:convert';

import 'package:bu_edmrs/API/api_endpoints.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class MedicalRecordController extends GetxController {
  static MedicalRecordController get instance => Get.find();

  final storage = GetStorage();
  RxBool isLoading = true.obs;
  RxList<Map<String, dynamic>> docNo = <Map<String, dynamic>>[].obs;
  var newSelectedDocNo = ''.obs;
  // get docNo => null;

  // void setDocNo(String docNo) {
  //   getDocNo.value = docNo;
  // }

  // var docNo = ''.obs;
  // void setDocNo(String getDocNo) {
  //   docNo.value = getDocNo;
  //   print(docNo);
  // }

  Future<void> setDocNo(String getDocNo) async {
    isLoading.value = false;
    newSelectedDocNo.value = getDocNo;
    loadMedicalInfo();
    // docNo.value = getDocNo;
  }

  Future<void> loadMedicalInfo() async {
    try {
      isLoading.value = true;
      var url = Uri.parse(
          ApiEndpoints.baseUrl + ApiEndpoints.authEndPoints.medicalInfo);
      String user = storage.read('username');
      String userpass = storage.read('password');
      String credentials = '$user:$userpass';
      String encodedCredentials = base64Encode(utf8.encode(credentials));
      Map<String, String> headers = {
        'Authorization': 'Basic $encodedCredentials'
      };

      Map<String, String> body = {'getDocNo': newSelectedDocNo.value};

      var response = await http.post(url, headers: headers, body: body);
      var res = jsonDecode(response.body);

      if (res['success']) {
        print(res['data']);

        List<dynamic> dataList = res['data'];
        List<Map<String, dynamic>> listMap =
            dataList.map((item) => item as Map<String, dynamic>).toList();
        // print(listMap);
        isLoading.value = false;
        docNo.value = listMap;
      }
    } finally {
      isLoading.value = false;
    }
  }
}
