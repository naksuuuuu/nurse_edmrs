import 'dart:async';
import 'dart:convert';

import 'package:bu_edmrs/API/api_endpoints.dart';
import 'package:bu_edmrs/pages/home.dart';
import 'package:bu_edmrs/utils/popups/popups.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class LoginController extends GetxController {
  final hidePassword = true.obs;
  final username = TextEditingController();
  final password = TextEditingController();

  final localStorage = GetStorage();

  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();

  Future<void> usernamePasswordLogin(context) async {
    try {
      if (!loginFormKey.currentState!.validate()) {
        return;
      } else {
        var url =
            Uri.parse(ApiEndpoints.baseUrl + ApiEndpoints.authEndPoints.login);
        String user = username.text;
        String userpass = password.text;
        String credentials = '$user:$userpass';
        String encodedCredentials = base64Encode(utf8.encode(credentials));
        Map<String, String> headers = {
          'authorization': 'Basic $encodedCredentials'
        };

        var response = await http.post(
          url,
          headers: headers,
        );
        print(response.body);
        if (response.statusCode == 200) {
          Map<String, dynamic> result = json.decode(response.body);

          if (result['success'] == true) {
            // localStorage.write('username', result);
            List<dynamic> data = result['data'];
            localStorage.write('greeting', result['greeting']);
            localStorage.write('fullname', data[0]['EMPL_NAME']);
            localStorage.write('position', data[0]['POSITION']);
            localStorage.write('business', data[0]['BUSINESS_UNIT']);
            localStorage.write('department', data[0]['DEPARTMENT']);
            localStorage.write('isLoggedIn', true);
            localStorage.write('username', user);
            localStorage.write('password', userpass);

            PopUps.successToast(
                title: 'Success', message: result['message'], context: context);

            Future.delayed(
              const Duration(seconds: 3),
              () {
                username.clear();
                password.clear();
                Get.to(() => Home());
              },
            );
          } else {
            // throw resultDecode(response.body)['message'];
            PopUps.errorSnackBar(title: 'Error', message: result['message']);
          }
        }
      }
    } catch (error) {
      Get.back();
    }
  }
}
