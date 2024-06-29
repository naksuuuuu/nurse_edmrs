import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:bu_edmrs/API/bindings.dart';
import 'package:bu_edmrs/API/employee_info_controller.dart';
import 'package:bu_edmrs/API/medical_record_controller.dart';
import 'package:bu_edmrs/common/widgets/appbar.dart';
import 'package:bu_edmrs/common/widgets/header_container.dart';
import 'package:bu_edmrs/pages/balance.dart';
import 'package:bu_edmrs/pages/medical_record_dtl.dart';
import 'package:bu_edmrs/common/widgets/home_appbar.dart';
import 'package:bu_edmrs/pages/nurse_balance.dart';
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
  late String selectedEmployee = "";

  MedicalRecord({super.key});

  final EmployeeInfoController employeeController =
      Get.put(EmployeeInfoController());

  final MedicalRecordController docNoController =
      Get.put(MedicalRecordController());

  // final DataService dataService = Get.find();
  final localStorage = GetStorage();

  // void handleRowClicked(Map<String, dynamic> rowData) {
  //   var columnAData = rowData['docNo'].toString();
  //   Get.to(() => MedicalRecordDetails(docNo: columnAData));
  // }

  void handleRowClicked(Map<String, dynamic> rowData) {
    var columnAData = rowData['docNo'].toString();
    Get.find<MedicalRecordController>().setDocNo(columnAData);
    Get.to(() => MedicalRecordDetails());
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
                    padding: EdgeInsets.symmetric(horizontal: ConstSizes.sm),
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
                child: employeeController.empList.value
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
                                  // print(selectedEmployee);
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
                () {
                  if (employeeController.employeeInfo.isNotEmpty) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Card(
                          color: Color.fromARGB(255, 236, 236, 236),
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          'Department',
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Container(
                                          constraints: const BoxConstraints(
                                              maxWidth: 150),
                                          child: Text(
                                            employeeController
                                                    .employeeInfo.isNotEmpty
                                                ? employeeController
                                                    .employeeInfo[0]
                                                        ['department']
                                                    .toString()
                                                : '',
                                            overflow: TextOverflow.ellipsis,
                                            style: Theme.of(context)
                                                .textTheme
                                                .labelLarge!
                                                .apply(
                                                    color: ConstColors.black),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      width: ConstSizes.spaceBtwItems,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          'Position',
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Container(
                                          constraints: const BoxConstraints(
                                              maxWidth: 150),
                                          child: Text(
                                            employeeController
                                                    .employeeInfo.isNotEmpty
                                                ? employeeController
                                                    .employeeInfo[0]['position']
                                                    .toString()
                                                : '',
                                            overflow: TextOverflow.ellipsis,
                                            style: Theme.of(context)
                                                .textTheme
                                                .labelLarge!
                                                .apply(
                                                    color: ConstColors.black),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 15),
                        NurseBalances(),
                        const SizedBox(height: 15),
                        SizedBox(
                          width: 750,
                          child: Padding(
                            padding: const EdgeInsets.all(0),
                            child: Obx(
                              () {
                                int medTblLength =
                                    employeeController.medTableData.length;
                                if (medTblLength == 0) {
                                  return const Card(
                                    // color: Colors.white,
                                    color: Color.fromARGB(255, 236, 236, 236),
                                    elevation: 5,
                                    child: Center(
                                      child: Text(
                                        'No Medical Records Found',
                                        style: TextStyle(fontSize: 16),
                                      ),
                                    ),
                                  );
                                } else {
                                  int rowsPerPage = employeeController
                                              .medTableData.length <
                                          10
                                      ? employeeController.medTableData.length
                                      : 10;
                                  double rowHeight = 56.0;
                                  double tableHeight =
                                      rowHeight * (rowsPerPage + 2);
                                  return SizedBox(
                                    height: tableHeight,
                                    child: PaginatedDataTable2(
                                      showCheckboxColumn: false,
                                      headingTextStyle: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                      headingRowColor:
                                          WidgetStateColor.resolveWith(
                                        (states) {
                                          return const Color.fromARGB(
                                              255, 75, 104, 255);
                                        },
                                      ),
                                      columnSpacing: 10.0,
                                      horizontalMargin: 10,
                                      minWidth: 600,
                                      columns: const [
                                        DataColumn2(
                                          label: Text('Doc Number'),
                                          size: ColumnSize.L,
                                        ),
                                        DataColumn2(
                                          label: Text('Type'),
                                          size: ColumnSize.L,
                                        ),
                                        DataColumn2(
                                          label: Text('Date Request'),
                                          size: ColumnSize.L,
                                        ),
                                        DataColumn2(
                                          label: Text('Symptoms'),
                                          size: ColumnSize.L,
                                        ),
                                        DataColumn2(
                                          label: Text('Status'),
                                          size: ColumnSize.L,
                                        ),
                                      ],
                                      source: MyData(
                                        employeeController.medTableData,
                                        onRowClicked: handleRowClicked,
                                      ),
                                      rowsPerPage: rowsPerPage,
                                    ),
                                  );
                                }
                              },
                            ),
                          ),
                        ),
                      ],
                    );
                  } else {
                    return const SizedBox.shrink();
                  }
                },
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
        DataCell(Text(item['docNo'].toString())),
        DataCell(Text(item['welfareType'].toString())),
        DataCell(Text(item['docData'].toString())),
        DataCell(Text(item['symptoms'].toString())),
        DataCell(Text(item['nurseFlag'].toString())),
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
