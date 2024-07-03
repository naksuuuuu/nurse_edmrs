import 'package:bu_edmrs/API/bindings.dart';
import 'package:bu_edmrs/common/widgets/appbar.dart';
import 'package:bu_edmrs/common/widgets/header_container.dart';
import 'package:bu_edmrs/utils/constants/colors.dart';
import 'package:bu_edmrs/utils/constants/size.dart';
import 'package:bu_edmrs/utils/device/device_utility.dart';
import 'package:bu_edmrs/utils/popups/popups.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:iconsax/iconsax.dart';
import 'package:lottie/lottie.dart';

class ItemDetailsScreen extends StatelessWidget {
  final Map<String, dynamic> item;

  ItemDetailsScreen({super.key, required this.item});
  final localStorage = GetStorage();

  final DataService dataService = Get.find();

  @override
  Widget build(BuildContext context) {
    // final controller = Get.put(TabbarController());
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              child: ElevatedButton(
                style: const ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll<Color>(Colors.red),
                  foregroundColor: WidgetStatePropertyAll<Color>(Colors.white),
                  side: WidgetStatePropertyAll(
                    BorderSide(color: Colors.red),
                  ),
                ),
                onPressed: () {
                  // Add your onPressed logic here
                  PopUps.showReject(context: context, docNo: item['docNo']);
                },
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(3.0),
                      child: Icon(Icons.thumb_down),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text('Reject'),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 16), // Optional space between buttons
            Expanded(
              child: ElevatedButton(
                style: const ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll<Color>(Colors.green),
                  foregroundColor: WidgetStatePropertyAll<Color>(Colors.white),
                  side: WidgetStatePropertyAll(
                    BorderSide(color: Colors.green),
                  ),
                ),
                onPressed: () {
                  // Add your onPressed logic here
                  PopUps.showApprove(context: context, docNo: item['docNo']);
                },
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(3.0),
                      child: Icon(Icons.thumb_up),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text('Approve'),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            HeaderContainer(
              height: 120,
              child: Column(
                children: [
                  TAppBar(
                    padding:
                        const EdgeInsets.symmetric(horizontal: ConstSizes.sm),
                    showBackArrow: true,
                    // leadingIcon: Iconsax.direct_left,
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Icon(
                          Iconsax.direct_inbox,
                          color: Colors.white,
                        ),
                        const SizedBox(width: 10),
                        Text(
                          'Request Details',
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium!
                              .apply(color: ConstColors.grey),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SingleChildScrollView(
              child: Column(
                children: [
                  Center(
                    child: SizedBox(
                      width: double.infinity,
                      height: DeviceUtils.getScreenHeight() / 1.2,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: FutureBuilder<List<dynamic>?>(
                          future:
                              dataService.requestDetails(docNo: item['docNo']),
                          builder: (context, snapshot) {
                            // print(snapshot.data);
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Center(
                                child: Lottie.asset(
                                    'assets/images/animations/141397-loading-juggle.json'),
                              );
                            } else if (snapshot.hasError) {
                              return Center(
                                child: Text('Error: ${snapshot.error}'),
                              );
                            } else if (!snapshot.hasData) {
                              return Center(
                                child: Lottie.asset(
                                    'assets/images/animations/Animation-1718951538417.json'),
                              );
                            } else {
                              return Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: ListView.builder(
                                  padding: EdgeInsets.zero,
                                  itemCount: snapshot.data!.length,
                                  itemBuilder: (context, index) {
                                    final item = snapshot.data![index];
                                    // print(item);
                                    return Column(
                                      children: [
                                        ReqDtls(items: item),
                                      ],
                                    );
                                  },
                                ),
                              );
                            }
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ReqDtls extends StatelessWidget {
  const ReqDtls({super.key, required this.items});

  final Map items;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Column(
        children: [
          ListTile(
            title: const Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(Iconsax.user, color: Colors.blue),
                SizedBox(
                  width: ConstSizes.sm,
                ),
                TitleText(
                  title: 'Employee',
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue),
                ),
              ],
            ),
            subtitle: Padding(
              padding: const EdgeInsets.only(left: 35, top: 10),
              child: Text(
                items['empName'],
                style: const TextStyle(fontSize: 17),
              ),
            ),
            // onTap: () {
            //   // Handle item tap
            //   print('Tapped on ${items['bu']}');
            // },
          ),
          const Divider(
            color: ConstColors.grey,
            height: 1,
          ),
          ListTile(
            title: const Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(Iconsax.buildings, color: Colors.blue),
                SizedBox(
                  width: ConstSizes.sm,
                ),
                TitleText(
                  title: 'Business Unit',
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue),
                ),
              ],
            ),
            subtitle: Padding(
              padding: const EdgeInsets.only(left: 35, top: 10),
              child: Text(
                items['bu'],
                style: const TextStyle(fontSize: 17),
              ),
            ),
            // onTap: () {
            //   // Handle item tap
            //   print('Tapped on ${items['bu']}');
            // },
          ),
          const Divider(
            color: ConstColors.grey,
            height: 1,
          ),
          ListTile(
            title: const Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(Iconsax.people, color: Colors.blue),
                SizedBox(
                  width: ConstSizes.sm,
                ),
                TitleText(
                  title: 'Department',
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue),
                ),
              ],
            ),
            subtitle: Padding(
              padding: const EdgeInsets.only(left: 35, top: 10),
              child: Text(
                items['deptName'],
                style: const TextStyle(fontSize: 17),
              ),
            ),
            // onTap: () {
            //   // Handle item tap
            //   print('Tapped on ${items['deptName']}');
            // },
          ),
          const Divider(
            color: ConstColors.grey,
            height: 1,
          ),
          ListTile(
            title: const Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(Iconsax.briefcase, color: Colors.blue),
                SizedBox(
                  width: ConstSizes.sm,
                ),
                TitleText(
                  title: 'Position',
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue),
                ),
              ],
            ),
            subtitle: Padding(
              padding: const EdgeInsets.only(left: 35, top: 10),
              child: Text(
                items['position'],
                style: const TextStyle(fontSize: 17),
              ),
            ),
            // onTap: () {
            //   // Handle item tap
            //   print('Tapped on ${items['position']}');
            // },
          ),
          const Divider(
            color: ConstColors.grey,
            height: 1,
          ),
          ListTile(
            title: const Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(
                  Iconsax.hospital,
                  color: Colors.blue,
                ),
                SizedBox(
                  width: ConstSizes.sm,
                ),
                TitleText(
                  title: 'Hospital',
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue),
                ),
              ],
            ),
            subtitle: Padding(
              padding: const EdgeInsets.only(left: 35, top: 10),
              child: Text(
                items['hospital'],
                style: const TextStyle(fontSize: 17),
              ),
            ),

            // onTap: () {
            //   // Handle item tap
            //   print('Tapped on ${items['hospital']}');
            // },
          ),
          const Divider(
            color: ConstColors.grey,
            height: 1,
          ),
          ListTile(
            title: const Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(
                  Iconsax.emoji_sad,
                  color: Colors.red,
                ),
                SizedBox(
                  width: ConstSizes.sm,
                ),
                TitleText(
                  title: 'Symptoms',
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.red),
                ),
              ],
            ),
            subtitle: Padding(
              padding: const EdgeInsets.only(left: 35, top: 10),
              child: Text(
                items['symptoms'],
                style: const TextStyle(fontSize: 17),
              ),
            ),
            // onTap: () {
            //   // Handle item tap
            //   print('Tapped on ${items['symptoms']}');
            // },
          ),
          const Divider(
            color: ConstColors.grey,
            height: 1,
          ),
        ],
      ),
    );
  }
}

class TitleText extends StatelessWidget {
  const TitleText({super.key, required this.title, required this.style});
  final String title;
  final TextStyle style;
  @override
  Widget build(BuildContext context) {
    return Text(title, style: style);
  }
}
