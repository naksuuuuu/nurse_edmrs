import 'package:bu_edmrs/API/balance_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Balances extends StatelessWidget {
  Balances({super.key});

  final controller = Get.put(BalanceController());
  // final BalanceController controller = Get.find();
  @override
  Widget build(BuildContext context) {
    return Obx(() => controller.isLoading.value
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : Center(
            child: GetBuilder<BalanceController>(builder: (controller) {
              return Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
                // const EdgeInsets.symmetric(horizontal: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: controller.balance
                      .map(
                        (bal) => Expanded(
                          child: Card(
                            color: Colors.white,
                            elevation: 5,
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    bal.balName!,
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    bal.balAmt!,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      )
                      .toList(),
                ),
              );
            }),
          ));
  }
}
