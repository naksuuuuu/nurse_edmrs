import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:bu_edmrs/API/employee_info_controller.dart';

class NurseBalances extends StatelessWidget {
  NurseBalances({super.key});

  final EmployeeInfoController employeeController =
      Get.put(EmployeeInfoController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => employeeController.isLoading.value
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Center(
              child: GetBuilder<EmployeeInfoController>(
                builder: (employeeController) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: employeeController.employeeBal
                        .map(
                          (bal) => Expanded(
                            child: Card(
                              // color: Colors.white,
                              color: Color.fromARGB(255, 236, 236, 236),
                              elevation: 5,
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      bal['balName'].toString(),
                                      style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      bal['balNo'].toString(),
                                      style: const TextStyle(
                                        fontFamily: 'Roboto',
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        )
                        .toList(),
                  );
                },
              ),
            ),
    );
  }
}
