import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:bu_edmrs/API/bindings.dart';
import 'package:bu_edmrs/API/employee_info.dart';
import 'package:bu_edmrs/common/widgets/appbar.dart';
import 'package:bu_edmrs/common/widgets/header_container.dart';
import 'package:bu_edmrs/pages/balance.dart';
import 'package:bu_edmrs/pages/medicaltabledtl.dart';
import 'package:bu_edmrs/common/widgets/home_appbar.dart';
import 'package:bu_edmrs/utils/constants/colors.dart';
import 'package:bu_edmrs/utils/constants/size.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:iconsax/iconsax.dart';
import 'package:lottie/lottie.dart';

class MedicalRecord extends StatelessWidget {
  // String? selectedEmployee;
  late String selectedEmployee = "";

  MedicalRecord({super.key});

  final EmployeeInfoController employeeController =
      Get.put(EmployeeInfoController());

  // final DataService dataService = Get.find();
  final localStorage = GetStorage();

  final TextEditingController hospital = TextEditingController();

  void handleRowClicked(Map<String, dynamic> rowData) {
    var columnAData = rowData['Doc Number'].toString();
    // print('Clicked row data: $columnAData');
    Get.to(() => MedicalRecordDetails(title: columnAData));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const HeaderContainer(
              height: 120,
              child: Column(
                children: [
                  TAppBar(
                    padding:
                        const EdgeInsets.symmetric(horizontal: ConstSizes.sm),
                    showBackArrow: true,
                    title: Row(
                      children: [
                        Icon(
                          // Icons.document_scanner_rounded,
                          Iconsax.receipt_search,
                          color: Colors.white,
                        ),
                        Text(
                          'Medical Reports',
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Obx(
              () => Center(
                child: employeeController.isLoading.value
                    ? LottieBuilder.asset(
                        'assets/images/animations/141397-loading-juggle.json')
                    : SingleChildScrollView(
                        child: GetBuilder<EmployeeInfoController>(
                          builder: (employeeController) {
                            List<Map<String, dynamic>> employees =
                                employeeController.employeeList;
                            List<String> employeeNames = employees
                                .map((employee) =>
                                    employee['empName'].toString())
                                .toList();
                            return Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: CustomDropdown<String>.search(
                                hintText: "Employees",
                                items: employeeNames,
                                decoration: CustomDropdownDecoration(
                                  closedBorder: Border.all(
                                    color: Color.fromARGB(255, 189, 189, 189),
                                    width: 1.0,
                                  ),
                                  expandedBorder: Border.all(
                                    color: Color.fromARGB(255, 189, 189, 189),
                                    width: 1.0,
                                  ),
                                ),
                                onChanged: (selectedEmpName) {
                                  String selectedEmpCode = employees.firstWhere(
                                      (emp) =>
                                          emp['empName'] ==
                                          selectedEmpName)['empCode'];
                                  selectedEmployee = selectedEmpCode;
                                  employeeController
                                      .setSelectedEmployee(selectedEmployee);
                                  print(selectedEmployee);
                                },
                              ),
                            );
                          },
                        ),
                      ),
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Obx(
                () => Card(
                  color: Colors.white,
                  elevation: 5,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8.0, vertical: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Department',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  employeeController.employeeInfo.isNotEmpty
                                      ? employeeController.employeeInfo[0]
                                              ['department']
                                          .toString()
                                      : '',
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelLarge!
                                      .apply(color: ConstColors.black),
                                ),
                              ],
                            ),
                            const SizedBox(
                              // width: ConstSizes.spaceBtwItems * 3,
                              width: ConstSizes.spaceBtwItems,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Position',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  employeeController.employeeInfo.isNotEmpty
                                      ? employeeController.employeeInfo[0]
                                              ['position']
                                          .toString()
                                      : '',
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelLarge!
                                      .apply(color: ConstColors.black),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Row Click
class MyData extends DataTableSource {
  final List<Map<String, dynamic>> data;
  final Function(Map<String, dynamic>) onRowClicked;

  MyData(this.data, {required this.onRowClicked});

  @override
  DataRow getRow(int index) {
    final item = data[index];
    return DataRow(
      onSelectChanged: (selected) {
        if (selected! && onRowClicked != null) {
          onRowClicked(item);
        }
      },
      cells: [
        DataCell(Text(item['Doc Number'].toString())),
        DataCell(Text(item['Type'].toString())),
        DataCell(Text(item['Date Request'].toString())),
        DataCell(Text(item['Symptoms'].toString())),
        DataCell(Text(item['Status'].toString())),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => data.length;

  @override
  int get selectedRowCount => 0;
}
