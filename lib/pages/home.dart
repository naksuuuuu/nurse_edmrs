// import 'package:carousel_slider/carousel_slider.dart';

import 'package:bu_edmrs/common/widgets/header_container.dart';
import 'package:bu_edmrs/common/widgets/home_appbar.dart';
import 'package:bu_edmrs/pages/balance.dart';
import 'package:bu_edmrs/pages/medical_record.dart';
import 'package:bu_edmrs/utils/constants/image_strings.dart';
import 'package:bu_edmrs/utils/constants/menu_const.dart';
import 'package:bu_edmrs/utils/constants/size.dart';
import 'package:bu_edmrs/utils/device/device_utility.dart';
import 'package:bu_edmrs/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:iconsax/iconsax.dart';
import 'package:responsive_grid/responsive_grid.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = THelperFunctions.isDarkMode(context);

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            HeaderContainer(
              height: 200,
              child: Column(
                children: [
                  HomeAppBar(
                    showBackArrow: false,
                  ),
                  Balances(),
                  // const Center(
                  //   child: Padding(
                  //     padding:
                  //         EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
                  //     child: Row(
                  //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  //       children: [
                  //         Expanded(
                  //           child: Card(
                  //             elevation: 5,
                  //             child: Padding(
                  //               padding: EdgeInsets.all(10.0),
                  //               child: Column(
                  //                 crossAxisAlignment: CrossAxisAlignment.start,
                  //                 children: [
                  //                   Text(
                  //                     'Personal',
                  //                     style: TextStyle(fontSize: 12),
                  //                   ),
                  //                   Text('100,000.00')
                  //                 ],
                  //               ),
                  //             ),
                  //           ),
                  //         ),
                  //         SizedBox(
                  //             width: 20), // Add some space between the cards
                  //         Expanded(
                  //           child: Card(
                  //             elevation: 5,
                  //             child: Padding(
                  //               padding: EdgeInsets.all(10.0),
                  //               child: Column(
                  //                 crossAxisAlignment: CrossAxisAlignment.start,
                  //                 children: [
                  //                   Text(
                  //                     'Accident',
                  //                     style: TextStyle(fontSize: 12),
                  //                   ),
                  //                   Text('100,000.00')
                  //                 ],
                  //               ),
                  //             ),
                  //           ),
                  //         ),
                  //         SizedBox(
                  //             width: 20), // Add some space between the cards
                  //         Expanded(
                  //           child: Card(
                  //             color: Colors.white,
                  //             elevation: 5,
                  //             child: Padding(
                  //               padding: EdgeInsets.all(10.0),
                  //               child: Column(
                  //                 crossAxisAlignment: CrossAxisAlignment.start,
                  //                 children: [
                  //                   Text(
                  //                     'Dependent',
                  //                     style: TextStyle(fontSize: 12),
                  //                   ),
                  //                   Text('50,000.00')
                  //                 ],
                  //               ),
                  //             ),
                  //           ),
                  //         ),
                  //       ],
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ),

            // gridMenu
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ResponsiveGridRow(
                    children: List.generate(
                      Menutitle.length,
                      (index) => ResponsiveGridCol(
                        xs: 6,
                        md: 3,
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(20.0),
                            splashColor: Colors.blue.withOpacity(0.5),
                            highlightColor: Colors.blue.withOpacity(0.5),
                            onTap: () {
                              if (index == 5) {
                                Get.to(() => MedicalRecord());
                                // alert(
                                //   "IMPORTANT NOTICE",
                                //   "This accredited hospital request form is specifically designed for employees who have availed the hospitalization benefit at our affiliated hospitals. Please do not use this form for your Medical Expense Reimbursement.",
                                //   context,
                                //   onConfirm: () {
                                //     Navigator.of(context, rootNavigator: true)
                                //         .pop();
                                //     Navigator.pushNamed(context, '/Admission');
                                //     // intent(context, Admission(toggleTheme: toggleTheme, isDarkMode: isDarkMode),'/Admission');
                                //   },
                                // );
                              } else if (index == 2) {
                                alert(
                                  "Welfare Claim Procedure:",
                                  """1. Fill-up welfare claim form and attach supporting documents
                                    2. Submit documents to HR Dept. for checking
                                    3. Retrieve documents from HR Dept. and have it approved by supervisor.
                                    4. Park document at SAP system for payment
                                    5. Submit approved park document to Accounting Department.""",
                                  context,
                                  onConfirm: () {
                                    // Navigator.of(context, rootNavigator: true)
                                    //     .pop();
                                    // Navigator.pushNamed(
                                    //     context, '/Reimbursement');
                                    // Get.to(() => Reimbursement);
                                  },
                                );
                              }
                              if (index == 3) {
                                print("New Card tapped!");
                              }
                            },
                            child: index == 0
                                ? Stack(
                                    children: [
                                      Card(
                                        elevation: 5,
                                        color: isDarkMode
                                            ? const Color.fromARGB(
                                                255, 81, 81, 81)
                                            : const Color.fromARGB(
                                                255, 255, 255, 255),
                                        shadowColor: isDarkMode
                                            ? const Color.fromARGB(
                                                255, 109, 109, 109)
                                            : const Color.fromARGB(
                                                255, 67, 67, 67),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20.0),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Center(
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: <Widget>[
                                                buildImage(Menuicons[index], 90,
                                                    90, Alignment.center),
                                                const SizedBox(height: 10),
                                                Text(
                                                  Menutitle[index]
                                                      .toUpperCase(),
                                                  style: TextStyle(
                                                    color: isDarkMode
                                                        ? const Color.fromARGB(
                                                            255, 255, 255, 255)
                                                        : const Color.fromARGB(
                                                            255, 0, 0, 0),
                                                    fontSize: 10.0,
                                                    fontWeight: FontWeight.w900,
                                                    fontFamily: 'Urbanist',
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        right: 0,
                                        // left: 0,
                                        child: Container(
                                          width: 25,
                                          height: 25,
                                          decoration: BoxDecoration(
                                            color: Colors.red,
                                            borderRadius:
                                                BorderRadius.circular(100),
                                          ),
                                          child: Center(
                                            child: Text(
                                              '5',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .labelLarge!
                                                  .apply(
                                                      color: Colors.white,
                                                      fontSizeFactor: 0.8),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                : Card(
                                    elevation: 5,
                                    color: isDarkMode
                                        ? const Color.fromARGB(255, 81, 81, 81)
                                        : const Color.fromARGB(
                                            255, 255, 255, 255),
                                    shadowColor: isDarkMode
                                        ? const Color.fromARGB(
                                            255, 109, 109, 109)
                                        : const Color.fromARGB(255, 67, 67, 67),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20.0),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Center(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: <Widget>[
                                            buildImage(Menuicons[index], 90, 90,
                                                Alignment.center),
                                            const SizedBox(height: 10),
                                            Text(
                                              Menutitle[index].toUpperCase(),
                                              style: TextStyle(
                                                color: isDarkMode
                                                    ? const Color.fromARGB(
                                                        255, 255, 255, 255)
                                                    : const Color.fromARGB(
                                                        255, 0, 0, 0),
                                                fontSize: 10.0,
                                                fontWeight: FontWeight.w900,
                                                fontFamily: 'Urbanist',
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                          ),
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
