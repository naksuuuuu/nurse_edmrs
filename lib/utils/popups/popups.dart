import 'dart:convert';

import 'package:art_sweetalert/art_sweetalert.dart';
import 'package:bu_edmrs/API/api_endpoints.dart';
import 'package:bu_edmrs/pages/medical_record_dtl.dart';
import 'package:bu_edmrs/utils/constants/colors.dart';
import 'package:bu_edmrs/utils/constants/size.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:iconsax/iconsax.dart';
import 'package:lottie/lottie.dart';
import 'package:toastification/toastification.dart';
import 'package:http/http.dart' as http;

class PopUps {
  static errorSnackBar({required title, required message}) {
    Get.snackbar(title, message,
        isDismissible: true,
        shouldIconPulse: true,
        colorText: ConstColors.white,
        backgroundColor: Colors.red,
        duration: const Duration(seconds: 2));
  }

  static successToast({required title, required message, required context}) {
    toastification.show(
        context: context, // optional if you use ToastificationWrapper
        title: Text(
          title,
          style: const TextStyle(
              fontSize: ConstSizes.lg, fontWeight: FontWeight.bold),
        ),
        description: RichText(text: TextSpan(text: message)),
        autoCloseDuration: const Duration(milliseconds: 2500),
        showProgressBar: false,
        type: ToastificationType.success,
        style: ToastificationStyle.fillColored,
        icon: const Icon(Icons.check),
        closeOnClick: false,
        pauseOnHover: false,
        alignment: Alignment.topCenter);
  }

  static errorToast({required title, required message, required context}) {
    toastification.show(
        context: context, // optional if you use ToastificationWrapper
        title: Text(
          title,
          style: const TextStyle(
              fontSize: ConstSizes.lg, fontWeight: FontWeight.bold),
        ),
        description: RichText(text: TextSpan(text: message)),
        autoCloseDuration: const Duration(milliseconds: 2500),
        showProgressBar: false,
        type: ToastificationType.error,
        style: ToastificationStyle.fillColored,
        icon: const Icon(Icons.error),
        closeOnClick: false,
        pauseOnHover: false,
        alignment: Alignment.topCenter);
  }

  static successSnackBar({required title, required message}) {
    Get.snackbar(title, message,
        isDismissible: true,
        shouldIconPulse: true,
        colorText: ConstColors.white,
        backgroundColor: Colors.green,
        duration: const Duration(seconds: 2));
  }

  static showForgotPass({required context, required icon, required message}) {
    ArtSweetAlert.show(
      context: context,
      artDialogArgs:
          ArtDialogArgs(type: ArtSweetAlertType.success, title: message),
    );
  }

  static submitTrn(
      {required context,
      required String docNoValue,
      required String durationDate,
      required String hospitalValue,
      required String symptomsValue,
      required List<MedicalData> medicalDataList}) {
    final controller = Get.put(SubmitController());
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return FractionallySizedBox(
          heightFactor: 1 / 1.2,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Center(
                child: Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 160,
                        width: double.infinity,
                        child: Center(
                          child: Lottie.asset(
                              'assets/images/animations/Animation - 1719364337556.json',
                              repeat: false),
                        ),
                      ),
                      const Text(
                        'Submit Data',
                        style: TextStyle(
                            fontSize: 19, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: ConstSizes.spaceBtwItems,
                      ),
                      const Text(
                        'Are you sure you want to Submit this Data?',
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: ConstSizes.spaceBtwItems,
                      ),
                      const SizedBox(
                        height: ConstSizes.spaceBtwSections,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              style: const ButtonStyle(
                                backgroundColor:
                                    WidgetStatePropertyAll<Color>(Colors.red),
                                foregroundColor:
                                    WidgetStatePropertyAll<Color>(Colors.white),
                                side: WidgetStatePropertyAll(
                                  BorderSide(color: Colors.red),
                                ),
                              ),
                              child: const Text('No'),
                              onPressed: () => Navigator.pop(context),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: ElevatedButton(
                              style: const ButtonStyle(
                                backgroundColor:
                                    WidgetStatePropertyAll<Color>(Colors.green),
                                foregroundColor:
                                    WidgetStatePropertyAll<Color>(Colors.white),
                                side: WidgetStatePropertyAll(
                                  BorderSide(color: Colors.green),
                                ),
                              ),
                              child: const Text('Yes'),
                              onPressed: () => controller.submitMedRecord(
                                context,
                                docNoValue,
                                durationDate,
                                hospitalValue,
                                symptomsValue,
                                medicalDataList,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
} // end of Class PopUps

class SubmitController extends GetxController {
  final storage = GetStorage();
  Future<void> submitMedRecord(context, docNoValue, durationDate, hospitalValue,
      symptomsValue, List<MedicalData> medicalDataList) async {
    print('docNoValue: $docNoValue');
    print('durationDate: $durationDate');
    print('hospitalValue: $hospitalValue');
    print('symptomsValue: $symptomsValue');
    print('medicalDataList: $medicalDataList');
    showDialog(
      context: context,
      barrierDismissible:
          false, // Dialog cannot be dismissed by tapping outside
      builder: (context) {
        return Dialog(
          elevation: 4,
          backgroundColor: Colors.white, // Makes background transparent
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Lottie.asset(
                  'assets/images/animations/141397-loading-juggle.json', // Replace with your Lottie animation file
                  width: 150,
                ),
                const Text(
                  'Please Wait', // Display custom text or default 'Loading...'
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
        );
      },
    );
    var url = Uri.parse(
        ApiEndpoints.baseUrl + ApiEndpoints.authEndPoints.medicalRecord);
    String user = storage.read('username');
    String userpass = storage.read('password');
    String credentials = '$user:$userpass';
    String encodedCredentials = base64Encode(utf8.encode(credentials));
    Map<String, String> headers = {
      'Authorization': 'Basic $encodedCredentials',
      'Content-Type': 'application/json'
    };

    Map<dynamic, dynamic> medicalDataListJson =
        jsonEncode(medicalDataList.map((data) => data.toJson()).toList())
            as Map;

    Map<String, dynamic> body = {
      'docNoValue': docNoValue,
      'durationDate': durationDate,
      'hospitalValue': hospitalValue,
      'symptomsValue': symptomsValue,
      'medicalDataListJson': [medicalDataListJson],
      'userCreate': storage.read('username')
    };

    var response =
        await http.post(url, headers: headers, body: jsonEncode(body));
    print(response.statusCode);
    if (response.statusCode == 200) {
      Map<String, dynamic> result = json.decode(response.body);
      if (result['success'] == true) {
        Navigator.pop(context);
        PopUps.successToast(
            title: 'Success', message: result['message'], context: context);
      } else {
        Navigator.pop(context);
        PopUps.errorToast(
            title: 'Error', message: result['message'], context: context);
      }
    }
  }
}
