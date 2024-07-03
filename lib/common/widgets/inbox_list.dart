import 'package:bu_edmrs/common/widgets/inbox_controller.dart';
import 'package:bu_edmrs/common/widgets/inbox_details.dart';
import 'package:bu_edmrs/utils/device/device_utility.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class ItemListScreen extends StatelessWidget {
  // final List<Items> items;
  final InboxController inboxController = Get.put(InboxController());
  ItemListScreen({super.key});
  // final DataService dataService = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Center(
        child: inboxController.isLoading.value
            ? LottieBuilder.asset(
                'assets/images/animations/141397-loading-juggle.json')
            : inboxController.approvalData.isEmpty
                ? RefreshIndicator(
                    onRefresh: () => inboxController.fetchData(),
                    child: SingleChildScrollView(
                      child: SizedBox(
                        width: double.infinity,
                        height: DeviceUtils.getScreenHeight() / 1.2,
                        child: LottieBuilder.asset(
                            'assets/images/animations/Animation-1718951538417.json'),
                      ),
                    ),
                  )
                : GetBuilder<InboxController>(
                    builder: (inboxController) {
                      return RefreshIndicator(
                        color: Colors.blue,
                        displacement: 30,
                        onRefresh: () => inboxController.fetchData(),
                        child: ListView.builder(
                          padding: EdgeInsets.zero,
                          itemCount: inboxController.approvalData.length,
                          itemBuilder: (context, index) {
                            final item = inboxController.approvalData[index];
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: InkWell(
                                onTap: () {
                                  // Navigate to details screen
                                  Get.to(() => ItemDetailsScreen(item: item));
                                },
                                child: Container(
                                  height: 105,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10.0),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        spreadRadius: 2,
                                        blurRadius: 5,
                                        offset: const Offset(0, 3),
                                      ),
                                    ],
                                  ),
                                  child: Row(
                                    children: [
                                      Container(
                                        width: 30,
                                        height: double.infinity,
                                        decoration: BoxDecoration(
                                          borderRadius: const BorderRadius.only(
                                            topLeft: Radius.circular(10.0),
                                            bottomLeft: Radius.circular(10.0),
                                          ),
                                          color:
                                              _getStatusColor(item['status']),
                                        ),
                                        child: Center(
                                          child: RotatedBox(
                                            quarterTurns: 3,
                                            child: Text(
                                              item['status'],
                                              style: const TextStyle(
                                                fontSize: 13,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Employee: ${item['empName']}',
                                                style: const TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              Text(
                                                'Doc. No: ${item['docNo']}',
                                                style: const TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.black,
                                                ),
                                              ),
                                              Text(
                                                'Req. Date: ${item['reqDate']}',
                                                style: const TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.black,
                                                ),
                                              ),
                                              Text(
                                                'Req. Type: ${item['type']}',
                                                style: const TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    },
                  ),
      ),
    );
  }

  Color? _getStatusColor(String status) {
    Color? color;
    switch (status.toLowerCase()) {
      case 'completed':
        color = Colors.green;
        break;
      case 'in progress':
        color = Colors.blue;
        break;
      case 'pending':
      default:
        color = Colors.amber[700];
    }
    return color;
  }
}
