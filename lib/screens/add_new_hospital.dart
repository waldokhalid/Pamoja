// ignore: import_of_legacy_library_into_null_safe
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddNewHospital extends StatefulWidget {
  const AddNewHospital({key}) : super(key: key);
  static const String idScreen = "AddNewHospital";

  @override
  _AddNewHospitalState createState() => _AddNewHospitalState();
}

class _AddNewHospitalState extends State<AddNewHospital> {
  TextEditingController hospitalNameTextEditingController =
      TextEditingController();
  TextEditingController hospitalPhoneTextEditingController =
      TextEditingController();
  TextEditingController hospitalLocaitonEditingController =
      TextEditingController();
  TextEditingController hospitalLatitudeAndLongitudeEditingController =
      TextEditingController();
  TextEditingController hospitalCountyEditingController =
      TextEditingController();
  TextEditingController hospitalLatitudeEditingController =
      TextEditingController();
  TextEditingController hospitalLongitudeEditingController =
      TextEditingController();

  final databaseReference = FirebaseDatabase.instance.reference();
  final firestoreInstance = FirebaseFirestore.instance;

  final int positiveCount = 1;
  final int negativeCount = -1;

  _addHospitalToDB() {
    try {
      databaseReference
          .child("Hospitals")
          .child(hospitalCountyEditingController.text)
          .child(hospitalNameTextEditingController.text)
          .set(
        {
          "HospitalName": hospitalNameTextEditingController.text,
          "HospitalPhone": hospitalPhoneTextEditingController.text,
          "HospitalAddres": hospitalLocaitonEditingController.text,
          "negativeCount": negativeCount.toInt(),
          "positiveCount": positiveCount.toInt(),
        },
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "Firebase: Error ocurred, Please try again.",
            textAlign: TextAlign.center,
          ),
        ),
      );
    }
    try {
      firestoreInstance.collection("Hospitals").add(
        {
          "HospitalName": hospitalNameTextEditingController.text,
          "HospitalPhone": hospitalPhoneTextEditingController.text,
          "Latitude": double.parse(hospitalLatitudeEditingController.text),
          "Longitude": double.parse(hospitalLongitudeEditingController.text),
        },
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "Firestore: Error ocurred, Please try again.",
            textAlign: TextAlign.center,
          ),
        ),
      );
    }
  }

  // _submitHospitalRTDB() {
  //   databaseReference
  //         .child("Hospitals")
  //         .child(hospitalCountyEditingController.text)
  //         .child(hospitalNameTextEditingController.text)
  //         .set(
  //       {
  //         "HospitalName": hospitalNameTextEditingController.text,
  //         "HospitalPhone": hospitalPhoneTextEditingController.text,
  //         "HospitalAddres": hospitalLocaitonEditingController.text,
  //       },
  //     );
  // }

  // __submitHospitalFirestore() {
  //   firestoreInstance.collection("Hospitals").add(
  //     {
  //       "HospitalName": hospitalNameTextEditingController.text,
  //       "HospitalPhone": hospitalPhoneTextEditingController.text,
  //       "Latitude": hospitalLatitudeEditingController.text,
  //       "Longitude": hospitalLongitudeEditingController.text,
  //     },
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.grey[100],
        centerTitle: true,
        elevation: 0,
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
        title: Text(
          "Pamoja",
          style: GoogleFonts.lexendMega(
            fontWeight: FontWeight.bold,
            color: Colors.black,
            fontSize: 35,
          ),
        ),
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 35,
                  ),
                  Text(
                    "Add New Hospital",
                    style: GoogleFonts.lexendMega(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 15,
                        ),
                        TextField(
                          controller: hospitalNameTextEditingController,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            border: const OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.blueGrey,
                                style: BorderStyle.solid,
                                width: 0.5,
                              ),
                            ),
                            labelText: "Hospital Name",
                            labelStyle: const TextStyle(
                              fontSize: 14,
                              color: Colors.blueGrey,
                            ),
                            hintStyle: GoogleFonts.lexendMega(
                              color: Colors.grey,
                              fontSize: 10,
                            ),
                          ),
                          style: GoogleFonts.lexendMega(
                            fontSize: 14,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        TextField(
                          controller: hospitalPhoneTextEditingController,
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                            border: const OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.blueGrey,
                                style: BorderStyle.solid,
                                width: 0.5,
                              ),
                            ),
                            labelText: "Hospital Phone",
                            labelStyle: const TextStyle(
                              fontSize: 14.0,
                              color: Colors.blueGrey,
                            ),
                            hintStyle: GoogleFonts.lexendMega(
                              color: Colors.grey,
                              fontSize: 10,
                            ),
                          ),
                          style: GoogleFonts.lexendMega(
                            fontSize: 14,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        TextField(
                          controller: hospitalLocaitonEditingController,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            border: const OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.black,
                                style: BorderStyle.solid,
                                width: 1,
                              ),
                            ),
                            labelText: "Hospital Adress",
                            labelStyle: const TextStyle(
                              fontSize: 14.0,
                              color: Colors.blueGrey,
                            ),
                            hintStyle: GoogleFonts.lexendMega(
                              color: Colors.grey,
                              fontSize: 10,
                            ),
                          ),
                          style: GoogleFonts.lexendMega(
                            fontSize: 14,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        TextField(
                          controller: hospitalCountyEditingController,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            border: const OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.black,
                                style: BorderStyle.solid,
                                width: 1,
                              ),
                            ),
                            labelText: "County",
                            labelStyle: const TextStyle(
                              fontSize: 14.0,
                              color: Colors.blueGrey,
                            ),
                            hintStyle: GoogleFonts.lexendMega(
                              color: Colors.grey,
                              fontSize: 10,
                            ),
                          ),
                          style: GoogleFonts.lexendMega(
                            fontSize: 14,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        TextField(
                          controller: hospitalLatitudeEditingController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            border: const OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.black,
                                style: BorderStyle.solid,
                                width: 1,
                              ),
                            ),
                            labelText: "Latitude",
                            labelStyle: const TextStyle(
                              fontSize: 14.0,
                              color: Colors.blueGrey,
                            ),
                            hintStyle: GoogleFonts.lexendMega(
                              color: Colors.grey,
                              fontSize: 10,
                            ),
                          ),
                          style: GoogleFonts.lexendMega(
                            fontSize: 14,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        TextField(
                          controller: hospitalLongitudeEditingController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            border: const OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.black,
                                style: BorderStyle.solid,
                                width: 1,
                              ),
                            ),
                            labelText: "Longitude",
                            labelStyle: const TextStyle(
                              fontSize: 14.0,
                              color: Colors.blueGrey,
                            ),
                            hintStyle: GoogleFonts.lexendMega(
                              color: Colors.grey,
                              fontSize: 10,
                            ),
                          ),
                          style: GoogleFonts.lexendMega(
                            fontSize: 14,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        ElevatedButton(
                          onPressed: () async {
                            // _submitHospitalRTDB();
                            // __submitHospitalFirestore();
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                backgroundColor: Colors.green,
                                content: Text(
                                  "Submitting Hospital Info",
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            );
                            _addHospitalToDB();
                            FocusScope.of(context).requestFocus(
                              FocusNode(),
                            );

                            hospitalCountyEditingController.clear();
                            hospitalLatitudeEditingController.clear();
                            hospitalNameTextEditingController.clear();
                            hospitalLocaitonEditingController.clear();
                            hospitalPhoneTextEditingController.clear();
                            hospitalLongitudeEditingController.clear();
                          },
                          child: Text(
                            "Submit",
                            style: GoogleFonts.lexendMega(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          style: TextButton.styleFrom(
                            backgroundColor: Colors.tealAccent[400],
                            elevation: 1,
                            shadowColor: Colors.transparent,
                            primary: Colors.black,
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
