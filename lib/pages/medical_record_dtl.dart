import 'package:bu_edmrs/utils/popups/popups.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:lottie/lottie.dart';
import 'package:bu_edmrs/API/medical_record_controller.dart';
import 'package:bu_edmrs/common/widgets/appbar.dart';
import 'package:bu_edmrs/common/widgets/header_container.dart';
import 'package:bu_edmrs/utils/constants/size.dart';

class MedicalData {
  String disease;
  String doctorsNote;
  String prescription;

  MedicalData({
    required this.disease,
    required this.doctorsNote,
    required this.prescription,
  });

  // toJson() {}
  // @override
  // String toString() {
  //   return '{ disease: $disease, doctorsNote: $doctorsNote, prescription: $prescription }';
  // }

  Map<String, String> toJson() {
    return {
      'disease': disease,
      'doctorsNote': doctorsNote,
      'prescription': prescription,
    };
  }
}

class MedicalRecordDetails extends StatelessWidget {
  MedicalRecordDetails({super.key});

  final MedicalRecordController docNoController =
      Get.put(MedicalRecordController());

  final TextEditingController durationDate = TextEditingController();
  final TextEditingController hospital = TextEditingController();
  final TextEditingController symptoms = TextEditingController();

  final List<MedicalData> medicalDataList = [];

  void addMedsCards(BuildContext context) {
    medicalDataList.add(MedicalData(
      disease: '',
      doctorsNote: '',
      prescription: '',
    ));
    (context as Element).reassemble();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => docNoController.isLoading.value
            ? Center(
                child: LottieBuilder.asset(
                    'assets/images/animations/141397-loading-juggle.json'),
              )
            : GetBuilder<MedicalRecordController>(
                builder: (docNoController) {
                  if (docNoController.docNo.isNotEmpty) {
                    hospital.text = docNoController.docNo[0]['hospital'];
                    symptoms.text = docNoController.docNo[0]['symptoms'];
                  }
                  return Stack(
                    children: [
                      SingleChildScrollView(
                        child: Column(
                          children: [
                            HeaderContainer(
                              height: 120,
                              child: Column(
                                children: [
                                  TAppBar(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: ConstSizes.sm),
                                    showBackArrow: true,
                                    title: Row(
                                      children: [
                                        const Icon(
                                          Iconsax.document_text,
                                          color: Colors.white,
                                        ),
                                        Text(
                                          docNoController.docNo[0]['docNo'],
                                          style: const TextStyle(
                                              color: Colors.white),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            DefaultTabController(
                              length: 3,
                              child: Column(
                                children: [
                                  const TabBar(
                                    indicatorColor:
                                        Color.fromARGB(255, 75, 104, 255),
                                    tabs: [
                                      Tab(
                                        child: Row(
                                          children: [
                                            Icon(
                                              Icons.edit_document,
                                              color: Colors.black,
                                            ),
                                            Text(
                                              'Medical',
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 14,
                                                // fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Tab(
                                        child: Row(
                                          children: [
                                            Icon(
                                              Icons.attach_money,
                                              color: Colors.black,
                                            ),
                                            Text(
                                              'Bills',
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 14,
                                                // fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Tab(
                                        icon: Icon(Icons.directions_bike),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height -
                                        250,
                                    child: TabBarView(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              right: 16.0, left: 16.0),
                                          child: Column(
                                            children: [
                                              Card(
                                                color: Colors.white,
                                                elevation: 2,
                                                margin:
                                                    const EdgeInsets.all(8.0),
                                                child: Padding(
                                                  padding: const EdgeInsets.all(
                                                      16.0),
                                                  child: Column(
                                                    children: [
                                                      // TextFormField(
                                                      //   controller:
                                                      //       durationDate,
                                                      //   expands: false,
                                                      //   decoration:
                                                      //       const InputDecoration(
                                                      //     labelText:
                                                      //         'Duration Date',
                                                      //     prefixIcon: Icon(
                                                      //       Iconsax.calendar_1,
                                                      //     ),
                                                      //   ),
                                                      // ),
                                                      TextFormField(
                                                        controller:
                                                            durationDate,
                                                        decoration:
                                                            const InputDecoration(
                                                          labelText:
                                                              'Duration Date',
                                                          prefixIcon: Icon(
                                                              Iconsax
                                                                  .calendar_1),
                                                        ),
                                                        onTap: () async {
                                                          FocusScope.of(context)
                                                              .requestFocus(
                                                                  FocusNode());
                                                          DateTime? pickedDate =
                                                              await showDatePicker(
                                                            context: context,
                                                            initialDate:
                                                                DateTime.now(),
                                                            firstDate:
                                                                DateTime(2000),
                                                            lastDate:
                                                                DateTime(2101),
                                                          );

                                                          if (pickedDate !=
                                                              null) {
                                                            durationDate.text =
                                                                "${pickedDate.toLocal()}"
                                                                    .split(
                                                                        ' ')[0];
                                                          }
                                                        },
                                                      ),
                                                      const SizedBox(
                                                          height: 10),
                                                      TextFormField(
                                                        controller: hospital,
                                                        expands: false,
                                                        readOnly: true,
                                                        decoration:
                                                            const InputDecoration(
                                                          filled: true,
                                                          fillColor:
                                                              Color.fromARGB(
                                                                  255,
                                                                  236,
                                                                  236,
                                                                  236),
                                                          labelText: 'Hospital',
                                                          prefixIcon: Icon(
                                                            Iconsax.hospital,
                                                          ),
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                          height: 10),
                                                      TextFormField(
                                                        controller: symptoms,
                                                        expands: false,
                                                        readOnly: true,
                                                        decoration:
                                                            const InputDecoration(
                                                          filled: true,
                                                          fillColor:
                                                              Color.fromARGB(
                                                                  255,
                                                                  236,
                                                                  236,
                                                                  236),
                                                          labelText: 'Symptoms',
                                                          prefixIcon: Icon(
                                                            Iconsax.health,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(height: 10),
                                              Align(
                                                alignment: Alignment.centerLeft,
                                                child: ElevatedButton(
                                                  onPressed: () =>
                                                      addMedsCards(context),
                                                  child: const Text('Add'),
                                                ),
                                              ),
                                              const SizedBox(height: 10),
                                              Expanded(
                                                child: ListView.builder(
                                                  padding: EdgeInsets.zero,
                                                  itemCount:
                                                      medicalDataList.length,
                                                  itemBuilder:
                                                      (context, index) {
                                                    MedicalData medicalData =
                                                        medicalDataList[index];
                                                    return Stack(
                                                      children: [
                                                        Card(
                                                          color: Colors.white,
                                                          elevation: 2,
                                                          margin:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(16.0),
                                                            child: Column(
                                                              children: [
                                                                TextFormField(
                                                                  initialValue:
                                                                      medicalData
                                                                          .disease,
                                                                  onChanged:
                                                                      (value) {
                                                                    medicalDataList[
                                                                            index]
                                                                        .disease = value;
                                                                  },
                                                                  expands:
                                                                      false,
                                                                  decoration:
                                                                      const InputDecoration(
                                                                    labelText:
                                                                        'Disease',
                                                                    prefixIcon:
                                                                        Icon(Iconsax
                                                                            .heart_search),
                                                                  ),
                                                                ),
                                                                const SizedBox(
                                                                    height: 10),
                                                                TextFormField(
                                                                  initialValue:
                                                                      medicalData
                                                                          .doctorsNote,
                                                                  onChanged:
                                                                      (value) {
                                                                    medicalDataList[
                                                                            index]
                                                                        .doctorsNote = value;
                                                                  },
                                                                  expands:
                                                                      false,
                                                                  decoration:
                                                                      const InputDecoration(
                                                                    labelText:
                                                                        'Doctors Note',
                                                                    prefixIcon:
                                                                        Icon(Iconsax
                                                                            .note_1),
                                                                  ),
                                                                ),
                                                                const SizedBox(
                                                                    height: 10),
                                                                TextFormField(
                                                                  initialValue:
                                                                      medicalData
                                                                          .prescription,
                                                                  onChanged:
                                                                      (value) {
                                                                    medicalDataList[
                                                                            index]
                                                                        .prescription = value;
                                                                  },
                                                                  expands:
                                                                      false,
                                                                  decoration:
                                                                      const InputDecoration(
                                                                    labelText:
                                                                        'Prescription',
                                                                    prefixIcon:
                                                                        Icon(Iconsax
                                                                            .document_text),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                        Positioned(
                                                          top: 0,
                                                          right: 0,
                                                          child: ElevatedButton(
                                                            onPressed: () {
                                                              medicalDataList
                                                                  .removeAt(
                                                                      index);
                                                              (context
                                                                      as Element)
                                                                  .reassemble();
                                                            },
                                                            style:
                                                                ElevatedButton
                                                                    .styleFrom(
                                                              elevation: 3,
                                                              shape:
                                                                  RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            32.0),
                                                              ),
                                                              minimumSize:
                                                                  const Size(
                                                                      30, 10),
                                                            ),
                                                            child:
                                                                const Text('X'),
                                                          ),
                                                        ),
                                                      ],
                                                    );
                                                  },
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        const Center(
                                          child: Icon(Icons.directions_transit),
                                        ),
                                        const Center(
                                          child: Icon(Icons.directions_bike),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],
                  );
                },
              ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
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
                  List<MedicalData> medicalData = [];
                  String duration = durationDate.text;
                  String hospitalValue = hospital.text;
                  String symptomsValue = symptoms.text;

                  for (var data in medicalDataList) {
                    medicalData.add(MedicalData(
                      disease: data.disease,
                      doctorsNote: data.doctorsNote,
                      prescription: data.prescription,
                    ));
                  }
                  PopUps.submitTrn(
                    context: context,
                    docNoValue: docNoController.docNo[0]['docNo'],
                    durationDate: duration,
                    hospitalValue: hospitalValue,
                    symptomsValue: symptomsValue,
                    medicalDataList: medicalData,
                  );
                },
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(3.0),
                      child: Icon(Icons.file_copy),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text('Submit'),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
