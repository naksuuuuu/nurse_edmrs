import 'dart:convert';

import 'package:bu_edmrs/API/api_endpoints.dart';
import 'package:bu_edmrs/utils/popups/popups.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class DataService extends GetxController {
  final storage = GetStorage();
  final isLoading = true.obs;

  // final medTableData = <Map<String, dynamic>>[].obs;

  // Fetch Employee
  // Future<List<Map<String, dynamic>>?> fetchEmployee() async {
  //   RxList listMap = [].obs;
  //   var url =
  //       Uri.parse(ApiEndpoints.baseUrl + ApiEndpoints.authEndPoints.employee);
  //   String user = storage.read('username');
  //   String userpass = storage.read('password');
  //   String credentials = '$user:$userpass';
  //   String encodedCredentials = base64Encode(utf8.encode(credentials));
  //   Map<String, String> headers = {
  //     'authorization': 'Basic $encodedCredentials'
  //   };
  //   var response = await http.post(
  //     url,
  //     headers: headers,
  //   );
  //   var res = jsonDecode(response.body);

  //   if (res['success']) {
  //     List<dynamic> dataList = res['data'];
  //     List<Map<String, dynamic>> listMap =
  //         dataList.map((item) => item as Map<String, dynamic>).toList();
  //     // print(listMap);
  //     return listMap;
  //   }
  // }

  // Fetch employee Info
  // Future<List<Map<String, dynamic>>?> fetchEmployeeInfo(
  //     {required selectedEmployee}) async {
  //   Uri.parse(ApiEndpoints.baseUrl + ApiEndpoints.authEndPoints.empInfo);
  //   String user = storage.read('username');
  //   String userpass = storage.read('password');
  //   String credentials = '$user:$userpass';
  //   String encodedCredentials = base64Encode(utf8.encode(credentials));
  //   Map<String, String> headers = {
  //     'authorization': 'Basic $encodedCredentials'
  //   };

  //   Map<String, String> body = {'docNo': '$docNo'};

  //   var response = await http.post(
  //     url,
  //     headers: headers,
  //   );
  //   var res = jsonDecode(response.body);
  // }

  // Fetch Medical Table Data
  Future<List<Map<String, dynamic>>?> fetchMedTableData() async {
    // Simulate fetching data from a database or API
    await Future.delayed(Duration(seconds: 2));
    // return ['Data 1', 'Data 2', 'Data 3'];
    return [
      {
        'Doc Number': 'AD2400001',
        'Type': 'Admission',
        'Date Request': 'June 15, 2024',
        'Symptoms': 'Cough',
        'Status': 'Pending'
      },
      {
        'Doc Number': 'AD2400002',
        'Type': 'Admission',
        'Date Request': 'June 15, 2024',
        'Symptoms': 'Cough',
        'Status': 'Pending'
      },
      {
        'Doc Number': 'AD2400003',
        'Type': 'Admission',
        'Date Request': 'June 15, 2024',
        'Symptoms': 'Cough',
        'Status': 'Pending'
      },
      {
        'Doc Number': 'AD2400004',
        'Type': 'Admission',
        'Date Request': 'June 15, 2024',
        'Symptoms': 'Cough',
        'Status': 'Pending'
      },
      {
        'Doc Number': 'AD2400005',
        'Type': 'Admission',
        'Date Request': 'June 15, 2024',
        'Symptoms': 'Cough',
        'Status': 'Pending'
      },
      {
        'Doc Number': 'AD2400006',
        'Type': 'Admission',
        'Date Request': 'June 15, 2024',
        'Symptoms': 'Cough',
        'Status': 'Pending'
      },
      {
        'Doc Number': 'AD2400007',
        'Type': 'Admission',
        'Date Request': 'June 15, 2024',
        'Symptoms': 'Cough',
        'Status': 'Pending'
      },
      {
        'Doc Number': 'AD2400008',
        'Type': 'Admission',
        'Date Request': 'June 15, 2024',
        'Symptoms': 'Cough',
        'Status': 'Pending'
      },
      {
        'Doc Number': 'AD2400009',
        'Type': 'Admission',
        'Date Request': 'June 15, 2024',
        'Symptoms': 'Cough',
        'Status': 'Pending'
      },
      {
        'Doc Number': 'AD2400010',
        'Type': 'Admission',
        'Date Request': 'June 15, 2024',
        'Symptoms': 'Cough',
        'Status': 'Pending'
      },
      {
        'Doc Number': 'AD2400011',
        'Type': 'Admission',
        'Date Request': 'June 15, 2024',
        'Symptoms': 'Cough',
        'Status': 'Pending'
      }
    ];
  }

  // Fetch Balance
  Future<Map<String, dynamic>> fetchBalance() async {
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
      // print(res);
      if (res['success']) {
        return res;
      } else {
        return {'error': 'error'};
        // PopUps.errorSnackBar(title: 'Error', message: 'Error fetching Data');
      }
    } finally {
      isLoading(false);
    }
  }
}
