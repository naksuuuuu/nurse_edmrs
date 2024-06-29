import 'package:bu_edmrs/common/widgets/appbar.dart';
import 'package:bu_edmrs/common/widgets/header_container.dart';
import 'package:bu_edmrs/utils/constants/size.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class MedicalRecordDetails extends StatefulWidget {
  final String title;
  MedicalRecordDetails({required this.title});

  @override
  _MedicalRecordDetailsState createState() => _MedicalRecordDetailsState();
}

class _MedicalRecordDetailsState extends State<MedicalRecordDetails> {
  final TextEditingController durationDate = TextEditingController();
  final TextEditingController hospital = TextEditingController();
  final TextEditingController symptoms = TextEditingController();

  List<Widget> medsCards = [];

  void addMedsCards() {
    setState(() {
      medsCards.add(
        Stack(
          children: [
            Card(
              color: Colors.white,
              elevation: 2,
              margin: const EdgeInsets.all(8.0),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    TextFormField(
                      expands: false,
                      decoration: const InputDecoration(
                        labelText: 'Diagnostics',
                        prefixIcon: Icon(Iconsax.heart_search),
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      expands: false,
                      decoration: const InputDecoration(
                        labelText: 'Doctors Note',
                        prefixIcon: Icon(Iconsax.note_1),
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      expands: false,
                      decoration: const InputDecoration(
                        labelText: 'Prescription',
                        prefixIcon: Icon(Iconsax.document_text),
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
                  setState(() {
                    medsCards.removeLast();
                    // medsCards.removeAt();
                  });
                },
                child: const Text('X'),
                style: ElevatedButton.styleFrom(
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(32.0),
                  ),
                  minimumSize: const Size(30, 10),
                ),
              ),
            ),
          ],
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    title: Row(
                      children: [
                        const Icon(
                          Iconsax.document_text,
                          color: Colors.white,
                        ),
                        Text(
                          widget.title,
                          style: const TextStyle(color: Colors.white),
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
                    indicatorColor: Color.fromARGB(255, 75, 104, 255),
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
                                fontWeight: FontWeight.bold,
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
                                fontWeight: FontWeight.bold,
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
                    // height: 1700,
                    height: MediaQuery.of(context).size.height -
                        300, // Adjust height as per your requirement
                    child: TabBarView(
                      children: [
                        Form(
                          child: Padding(
                            padding:
                                const EdgeInsets.only(right: 16.0, left: 16.0),
                            child: Column(
                              children: [
                                Card(
                                  color: Colors.white,
                                  elevation: 2,
                                  margin: const EdgeInsets.all(8.0),
                                  child: Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Column(
                                      children: [
                                        TextFormField(
                                          controller: durationDate,
                                          expands: false,
                                          decoration: const InputDecoration(
                                            labelText: 'Duration Date',
                                            prefixIcon: Icon(
                                              Iconsax.calendar_1,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 10),
                                        TextFormField(
                                          controller: hospital,
                                          expands: false,
                                          decoration: const InputDecoration(
                                            labelText: 'Hospital',
                                            prefixIcon: Icon(
                                              Iconsax.hospital,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 10),
                                        TextFormField(
                                          controller: symptoms,
                                          expands: false,
                                          decoration: const InputDecoration(
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
                                    onPressed: addMedsCards,
                                    child: const Text('Add'),
                                  ),
                                ),
                                const SizedBox(height: 10),
                                // Container(
                                //   height: 300,
                                //   child: Column(
                                //     children: medsCards,
                                //   ),
                                // ),
                                Expanded(
                                  child: ListView.builder(
                                    itemCount: medsCards.length,
                                    itemBuilder: (context, index) =>
                                        medsCards[index],
                                  ),
                                ),
                              ],
                            ),
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
    );
  }
}
