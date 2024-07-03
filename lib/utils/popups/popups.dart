import 'dart:convert';

import 'package:art_sweetalert/art_sweetalert.dart';
import 'package:bu_edmrs/API/api_endpoints.dart';
import 'package:bu_edmrs/API/medical_record_controller.dart';
import 'package:bu_edmrs/common/widgets/inbox_controller.dart';
import 'package:bu_edmrs/pages/inbox_request.dart';
import 'package:bu_edmrs/pages/medical_record_dtl.dart';
import 'package:bu_edmrs/utils/constants/colors.dart';
import 'package:bu_edmrs/utils/constants/size.dart';
import 'package:bu_edmrs/utils/validators/validation.dart';
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

  static showReject({required context, required docNo}) {
    final controller = Get.put(RejectController());

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return FractionallySizedBox(
          heightFactor: 1 / 1.2, // Takes one-third of the screen height
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Form(
                key: controller.loginFormKey,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 140,
                        width: double.infinity,
                        child: Center(
                          child: Lottie.asset(
                              'assets/images/animations/Animation - 1719299632486.json',
                              repeat: false),
                        ),
                      ),
                      const Text(
                        'Reject Request',
                        style: TextStyle(
                            fontSize: 19, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: ConstSizes.spaceBtwItems,
                      ),
                      Text(
                        textAlign: TextAlign.center,
                        'Are you sure to Reject this request? If YES, please input reason.',
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey[600]),
                      ),
                      const SizedBox(
                        height: ConstSizes.spaceBtwItems,
                      ),
                      TextFormField(
                        validator: (value) => TValidator.validateReason(value),
                        maxLines: 3,
                        controller: controller.rejectReason,
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
                                      WidgetStatePropertyAll<Color>(
                                          Colors.white),
                                  side: WidgetStatePropertyAll(
                                    BorderSide(color: Colors.red),
                                  ),
                                ),
                                child: const Text('No'),
                                onPressed: () => Navigator.pop(context)),
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
                              onPressed: () =>
                                  controller.confirmReject(context, docNo),
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

  static showApprove({required context, required docNo}) {
    final controller = Get.put(RejectController());
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return FractionallySizedBox(
          heightFactor: 1 / 1.2, // Takes one-third of the screen height
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
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
                        'Approve Request',
                        style: TextStyle(
                            fontSize: 19, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: ConstSizes.spaceBtwItems,
                      ),
                      Text(
                        'Are you sure to Approve this request?',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[600],
                        ),
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
                                      WidgetStatePropertyAll<Color>(
                                          Colors.white),
                                  side: WidgetStatePropertyAll(
                                    BorderSide(color: Colors.red),
                                  ),
                                ),
                                child: const Text('No'),
                                onPressed: () => Navigator.pop(context)),
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
                              onPressed: () =>
                                  controller.confirmApprove(context, docNo),
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

  static submitTrn(
      {required context,
      required String docNoValue,
      required String durationDate,
      required String treatmentDaysValue,
      required String hospitalValue,
      required String symptomsValue,
      required String welfareTypeCodeValue,
      required List<MedicalData> medicalDataList,
      required List<BillsData> billsDataList}) {
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
                                treatmentDaysValue,
                                hospitalValue,
                                symptomsValue,
                                welfareTypeCodeValue,
                                medicalDataList,
                                billsDataList,
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

// class SubmitController extends GetxController {
//   final storage = GetStorage();
//   Future<void> submitMedRecord(context, docNoValue, durationDate, hospitalValue,
//       symptomsValue, List<MedicalData> medicalDataList) async {
//     // print('docNoValue: $docNoValue');
//     // print('durationDate: $durationDate');
//     // print('hospitalValue: $hospitalValue');
//     // print('symptomsValue: $symptomsValue');
//     // print('medicalDataList: $medicalDataList');
//     showDialog(
//       context: context,
//       barrierDismissible:
//           false, // Dialog cannot be dismissed by tapping outside
//       builder: (context) {
//         return Dialog(
//           elevation: 4,
//           backgroundColor: Colors.white, // Makes background transparent
//           child: Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 Lottie.asset(
//                   'assets/images/animations/141397-loading-juggle.json', // Replace with your Lottie animation file
//                   width: 150,
//                 ),
//                 const Text(
//                   'Please Wait', // Display custom text or default 'Loading...'
//                   style: TextStyle(fontSize: 16),
//                 ),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//     var url = Uri.parse(
//         ApiEndpoints.baseUrl + ApiEndpoints.authEndPoints.medicalRecord);
//     String user = storage.read('username');
//     String userpass = storage.read('password');
//     String credentials = '$user:$userpass';
//     String encodedCredentials = base64Encode(utf8.encode(credentials));
//     Map<String, String> headers = {
//       'Authorization': 'Basic $encodedCredentials',
//       'Content-Type': 'application/json'
//     };

//     // String medicalDataJsonList =
//     //     jsonEncode(medicalDataList.map((data) => data.toJson()).toList());

//     List<Map<String, dynamic>> medicalDataJsonList =
//         medicalDataList.map((data) => data.toJson()).toList();

//     Map<String, dynamic> body = {
//       'docNoValue': docNoValue,
//       'durationDate': durationDate,
//       'hospitalValue': hospitalValue,
//       'symptomsValue': symptomsValue,
//       // 'medicalDataListJson': [medicalDataListJson],
//       'medicalDataListJson': medicalDataJsonList,
//       'userCreate': storage.read('username')
//     };

//     var response =
//         await http.post(url, headers: headers, body: jsonEncode(body));
//     print(response.statusCode);
//     if (response.statusCode == 200) {
//       Map<String, dynamic> result = json.decode(response.body);
//       if (result['success'] == true) {
//         Navigator.pop(context);
//         PopUps.successToast(
//             title: 'Success', message: result['message'], context: context);
//       } else {
//         Navigator.pop(context);
//         PopUps.errorToast(
//             title: 'Error', message: result['message'], context: context);
//       }
//     }
//   }
// }

class SubmitController extends GetxController {
  final storage = GetStorage();

  Future<void> submitMedRecord(
      context,
      docNoValue,
      durationDate,
      treatmentDaysValue,
      hospitalValue,
      symptomsValue,
      welfareTypeCodeValue,
      List<MedicalData> medicalDataList,
      List<BillsData> billsDataList) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return Dialog(
          elevation: 4,
          backgroundColor: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Lottie.asset(
                  'assets/images/animations/141397-loading-juggle.json',
                  width: 150,
                ),
                const Text(
                  'Please Wait',
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

    List<Map<String, dynamic>> medicalDataJsonList =
        medicalDataList.map((data) => data.toJson()).toList();

    List<Map<String, dynamic>> billsDataJsonList =
        billsDataList.map((data) => data.toJson()).toList();

    Map<String, dynamic> body = {
      'docNoValue': docNoValue,
      'durationDate': durationDate,
      'treatmentDaysValue': treatmentDaysValue,
      'hospitalValue': hospitalValue,
      'symptomsValue': symptomsValue,
      'welfareTypeCodeValue': welfareTypeCodeValue,
      'medicalDataJsonList': medicalDataJsonList,
      'billsDataJsonList': billsDataJsonList,
      'userCreate': storage.read('username')
    };

    try {
      var response =
          await http.post(url, headers: headers, body: jsonEncode(body));

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

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
      } else {
        // Handle non-200 status code (error from server)
        Navigator.pop(context);
        PopUps.errorToast(
            title: 'Error',
            message: 'Failed to submit medical record. Please try again later.',
            context: context);
      }
    } catch (e) {
      // Handle general error (e.g., network error)
      print('Error submitting medical record: $e');
      Navigator.pop(context);
      PopUps.errorToast(
          title: 'Error',
          message: 'Failed to submit medical record. Please try again later.',
          context: context);
    }
  }
}

class RejectController extends GetxController {
  final rejectReason = TextEditingController();
  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  final storage = GetStorage();
  final InboxController inboxController = Get.put(InboxController());

  Future<void> confirmApprove(context, docNo) async {
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

    var url =
        Uri.parse(ApiEndpoints.baseUrl + ApiEndpoints.authEndPoints.approve);
    String user = storage.read('username');
    String userpass = storage.read('password');
    String credentials = '$user:$userpass';
    String encodedCredentials = base64Encode(utf8.encode(credentials));
    Map<String, String> headers = {
      'authorization': 'Basic $encodedCredentials'
    };

    Map<String, dynamic> body = {
      'docNo': docNo,
      'userApprove': storage.read('username')
    };

    var response = await http.post(url, headers: headers, body: body);
    print(response.statusCode);
    if (response.statusCode == 200) {
      Map<String, dynamic> result = json.decode(response.body);
      if (result['success'] == true) {
        Navigator.pop(context);
        PopUps.successToast(
            title: 'Success', message: result['message'], context: context);
        inboxController.isLoading.value = true;
        // localStorage.write('username', result);
        // List<dynamic> data = result['data'];
        // storage.write('greeting', result['greeting']);
        // storage.write('fullname', data[0]['EMPL_NAME']);
        // storage.write('position', data[0]['POSITION']);
        // storage.write('business', data[0]['BUSINESS_UNIT']);
        // storage.write('department', data[0]['DEPARTMENT']);
        // storage.write('isLoggedIn', true);
        // storage.write('username', user);
        // storage.write('password', userpass);

        // PopUps.successToast(
        //     title: 'Success', message: result['message'], context: context);

        //   Future.delayed(
        //     const Duration(seconds: 3),
        //     () {
        //       rejectReason.clear();
        //       Get.offAll(() => Home());
        //     },
        //   );
        // } else {
        //   // throw resultDecode(response.body)['message'];
        //   PopUps.errorSnackBar(title: 'Error', message: result['message']);
        // }
      } else {
        Navigator.pop(context);
        PopUps.errorToast(
            title: 'Success', message: result['message'], context: context);
      }
    }
  } // end of approve

  Future<void> confirmReject(context, docNo) async {
    if (!loginFormKey.currentState!.validate()) {
      return;
    } else {
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

      var url =
          Uri.parse(ApiEndpoints.baseUrl + ApiEndpoints.authEndPoints.reject);
      String user = storage.read('username');
      String userpass = storage.read('password');
      String credentials = '$user:$userpass';
      String encodedCredentials = base64Encode(utf8.encode(credentials));
      Map<String, String> headers = {
        'authorization': 'Basic $encodedCredentials'
      };

      Map<String, dynamic> body = {
        'docNo': docNo,
        'userApprove': storage.read('username'),
        'reason': rejectReason.text
      };

      var response = await http.post(url, headers: headers, body: body);
      print(response.statusCode);
      if (response.statusCode == 200) {
        Map<String, dynamic> result = json.decode(response.body);
        if (result['success'] == true) {
          Navigator.pop(context);
          PopUps.successToast(
              title: 'Success', message: result['message'], context: context);
          Future.delayed(const Duration(seconds: 3), () {
            rejectReason.clear();
            Get.off(() => InboxRequest());
          });
          // localStorage.write('username', result);
          // List<dynamic> data = result['data'];
          // storage.write('greeting', result['greeting']);
          // storage.write('fullname', data[0]['EMPL_NAME']);
          // storage.write('position', data[0]['POSITION']);
          // storage.write('business', data[0]['BUSINESS_UNIT']);
          // storage.write('department', data[0]['DEPARTMENT']);
          // storage.write('isLoggedIn', true);
          // storage.write('username', user);
          // storage.write('password', userpass);

          // PopUps.successToast(
          //     title: 'Success', message: result['message'], context: context);

          //   Future.delayed(
          //     const Duration(seconds: 3),
          //     () {
          //       rejectReason.clear();
          //       Get.offAll(() => Home());
          //     },
          //   );
          // } else {
          //   // throw resultDecode(response.body)['message'];
          //   PopUps.errorSnackBar(title: 'Error', message: result['message']);
          // }
        } else {
          Navigator.pop(context);
          PopUps.errorToast(
              title: 'Success', message: result['message'], context: context);
        }
      }
    }
  }
}
