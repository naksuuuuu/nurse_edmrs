import 'dart:convert';

import 'package:bu_edmrs/API/api_endpoints.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class EmployeeInfoController extends GetxController {
  static EmployeeInfoController get instance => Get.find();

  final storage = GetStorage();
  RxBool isLoading = true.obs;
  RxList<Map<String, dynamic>> employeeList = <Map<String, dynamic>>[].obs;
  RxList<Map<String, dynamic>> employeeInfo = <Map<String, dynamic>>[].obs;
  var newSelectedEmpCode = ''.obs;
  @override
  void onInit() {
    super.onInit();

    fetchEmployeeInfo();
  }

  Future<void> fetchEmployeeInfo() async {
    try {
      // RxList listMap = [].obs;
      isLoading.value = true;
      var url =
          Uri.parse(ApiEndpoints.baseUrl + ApiEndpoints.authEndPoints.employee);
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
        isLoading.value = false;
        employeeList.value = listMap;
      }
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> setSelectedEmployee(String empCode) async {
    print(empCode);
    isLoading.value = false;
    newSelectedEmpCode.value = empCode;
    loadEmpInfo();

    // try {
    // isLoading.value = false;
    // var url =
    //     Uri.parse(ApiEndpoints.baseUrl + ApiEndpoints.authEndPoints.empInfo);
    // String user = storage.read('username');
    // String userpass = storage.read('password');
    // String credentials = '$user:$userpass';
    // String encodedCredentials = base64Encode(utf8.encode(credentials));
    // Map<String, String> headers = {
    //   'Authorization': 'Basic $encodedCredentials'
    // };

    // Map<String, String> body = {'empCode': empCode};

    // var response = await http.post(url, headers: headers, body: body);
    // var res = jsonDecode(response.body);

    // if (res['success']) {
    //   List<dynamic> dataList = res['data'];
    //   List<Map<String, dynamic>> listMap =
    //       dataList.map((item) => item as Map<String, dynamic>).toList();
    //   // print(listMap);
    //   isLoading.value = false;
    //   employeeInfo.value = listMap;
    // }
    // } finally {
    //   isLoading.value = false;
    // }
  }

  Future<void> loadEmpInfo() async {
    try {
      isLoading.value = true;
      var url =
          Uri.parse(ApiEndpoints.baseUrl + ApiEndpoints.authEndPoints.empInfo);
      String user = storage.read('username');
      String userpass = storage.read('password');
      String credentials = '$user:$userpass';
      String encodedCredentials = base64Encode(utf8.encode(credentials));
      Map<String, String> headers = {
        'Authorization': 'Basic $encodedCredentials'
      };

      Map<String, String> body = {'empCode': newSelectedEmpCode.value};

      var response = await http.post(url, headers: headers, body: body);
      var res = jsonDecode(response.body);

      if (res['success']) {
        List<dynamic> dataList = res['data'];
        List<Map<String, dynamic>> listMap =
            dataList.map((item) => item as Map<String, dynamic>).toList();
        // print(listMap);
        isLoading.value = false;
        employeeInfo.value = listMap;
      }
    } finally {
      isLoading.value = false;
    }
  }
}
