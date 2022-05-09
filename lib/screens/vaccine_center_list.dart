import 'package:colour/colour.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:shared_preferences/shared_preferences.dart';

class VaccineCenterList extends StatefulWidget {
  const VaccineCenterList({key}) : super(key: key);
  static const String idScreen = "VaccineCenterList";

  @override
  _VaccineCenterListState createState() => _VaccineCenterListState();
}

class _VaccineCenterListState extends State<VaccineCenterList> {
  TextEditingController hospitalCountyEditingController =
      TextEditingController();
  final databaseReference = FirebaseDatabase.instance.reference();
  final firestoreInstance = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;
  List<Hospitals> driverList = [];

  late String isTrueOrFalse = "False";

  // // double percentageInt = 0.0;
  int totalVotes = 0;
  // int percentage = 0;

  int positiveCount = 0;
  int negativeCount = 0;

  // bool buttonPressed = true;
  List<bool> buttonPressed = [];
  // Map<String, List> buttonPressed = {};

  Future<List<Hospitals>> getHospitalDetails() async {
    try {
      if ((hospitalCountyEditingController.text != "") &&
          (hospitalCountyEditingController.text != " ")) {
        databaseReference
            .child("Hospitals")
            .child(hospitalCountyEditingController.text)
            .onValue
            .listen(
          (event) {
            setState(
              () {
                var value = event.snapshot.value;
                driverList = Map.from(value)
                    .values
                    .map((e) => Hospitals.fromJson(Map.from(e)))
                    .toList();
              },
            );
          },
        );
      } else {}
    } catch (e) {
      // ScaffoldMessenger.of(context).showSnackBar(
      //   const SnackBar(
      //     content: Text(
      //       "$e",
      //       textAlign: TextAlign.center,
      //     ),
      //   ),
      // );
      // return driverList;
    }
    return driverList;
  }

  calculatePositivePercentage(positiveCount, negativeCount) {
    double votePercentage = 0;

    if (positiveCount == 0 && negativeCount == 0) {
      try {
        return votePercentage.toInt();
      } catch (e) {
        print(e);
      }
    } else {
      try {
        totalVotes = positiveCount + negativeCount;
        int percentage = positiveCount * 100;
        votePercentage = percentage / totalVotes;
        return votePercentage.toInt();
      } catch (e) {
        print(e);
      }
    }
  }

  undoPositiveIncrement(hospitalName) {
    databaseReference
        .child("Hospitals")
        .child(hospitalCountyEditingController.text)
        .child(hospitalName)
        .update({
      "poitiveCount": ServerValue.increment(-1),
    });
  }

  undoNegativeIncrement(hospitalName) {
    databaseReference
        .child("Hospitals")
        .child(hospitalCountyEditingController.text)
        .child(hospitalName)
        .update({
      "negativeCount": ServerValue.increment(-1),
    });
  }

  positiveIncrement(hospitalName, index) {
    // print(hospitalName);
    buttonPressed[index] = false;
    databaseReference
        .child("Hospitals")
        .child(hospitalCountyEditingController.text)
        .child(hospitalName)
        .update({
      "poitiveCount": ServerValue.increment(1),
    });
  }

  negativeIncrement(hospitalName, index) {
    buttonPressed[index] = false;
    databaseReference
        .child("Hospitals")
        .child(hospitalCountyEditingController.text)
        .child(hospitalName)
        .update({
      "negativeCount": ServerValue.increment(1),
    });
  }

  buttonControls(numOfLocations) {
    print(numOfLocations);
    int checker = 0;
    if (numOfLocations > buttonPressed.length) {
      try {
        while (numOfLocations >= checker) {
          buttonPressed.add(true);
          checker = checker + 1;
        }
      } catch (e) {
        print("$e");
      }
    } else {}
    // while (numOfLocations >= checker) {
    //   buttonPressed.add(true);
    //   checker = checker + 1;
    //   if (numOfLocations == checker) {
    //     break;
    //   }
    // }
    print(buttonPressed);
  }

  @override
  void initState() {
    super.initState();
    print("I'm in the vaccine list search screen");
  }

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
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                // textfield
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: hospitalCountyEditingController,
                  keyboardType: TextInputType.text,
                  textCapitalization: TextCapitalization.words,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.black,
                        style: BorderStyle.solid,
                        width: 1,
                      ),
                    ),
                    labelText: "Search County",
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
              ),
              ElevatedButton(
                // search button
                onPressed: () {
                  setState(() {
                    FocusScope.of(context).requestFocus(
                      FocusNode(),
                    );
                    driverList.clear();
                    if (hospitalCountyEditingController.text == "" ||
                        hospitalCountyEditingController.text == " ") {
                      isTrueOrFalse = "False";
                    } else {
                      isTrueOrFalse = "True";
                    }
                  });
                  getHospitalDetails();
                },
                child: Text(
                  "Search",
                  style: GoogleFonts.lexendMega(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height,
                      // height: 50,

                      // color: Colors.black,
                      child: Padding(
                        padding: const EdgeInsets.only(
                          right: 12.0,
                          left: 12.0,
                          bottom: 12.0,
                        ),
                        child: driverList.isEmpty
                            ? Center(
                                // child: CircularProgressIndicator(),
                                child: (isTrueOrFalse == "True")
                                    ? const CircularProgressIndicator()
                                    : Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                                "Search for one of the counties below",
                                                style:
                                                    GoogleFonts.lexendMega()),
                                          ),
                                          Text(
                                            "Nairobi, Baringo, Busia, Bomet, Bungoma, Elgeyo Marakwet, Embu, Garissa, Homa Bay, Isiolo, Kajiado, Kakamega, Kericho, Kiambu, Kilifi, Kirinyaga, Kisii, Kisumu, Kitui, Kwale, Laikipia, Lamu, Machakos, Makueni, Mandera, Marsabit, Meru, Migori, Mombasa, Muranga, Nakuru, Nandi, Narok, Nyamira, Nyandarua, Nyeri, Samburu, Siaya County, Taita Taveta, Tana River County, Tharaka Nithi, Trans Nzoia, Turkana, Uasin Gishu, Vihiga, Wajir, West Pokot",
                                            textAlign: TextAlign.center,
                                            style: GoogleFonts.lexendMega(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                              )
                            : ListView.builder(
                                itemCount: driverList.length,
                                itemBuilder: (context, index) {
                                  final Hospitals hospitals = driverList[index];
                                  final String hospitalLocaiton =
                                      hospitals.location;
                                  final String hospitalPhone = hospitals.phone;
                                  final String hospitalName = hospitals.name;

                                  positiveCount = hospitals.positiveCount;
                                  negativeCount = hospitals.negativeCount;

                                  final int setpercentage =
                                      calculatePositivePercentage(
                                          positiveCount, negativeCount);

                                  buttonControls(driverList.length);

                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Card(
                                      elevation: 0,
                                      child: ExpansionTile(
                                        title: Text(
                                          hospitalName.toUpperCase(),
                                          style: GoogleFonts.lexendMega(),
                                          textAlign: TextAlign.center,
                                        ),
                                        children: [
                                          Column(
                                            children: [
                                              Container(
                                                child: (hospitalPhone
                                                        .isNotEmpty)
                                                    ? ElevatedButton(
                                                        onPressed: () {
                                                          Clipboard.setData(
                                                            ClipboardData(
                                                              text:
                                                                  hospitalPhone,
                                                            ),
                                                          );
                                                          ScaffoldMessenger.of(
                                                                  context)
                                                              .showSnackBar(
                                                            const SnackBar(
                                                              backgroundColor:
                                                                  Colors.green,
                                                              content: Text(
                                                                "Number Copied",
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                              ),
                                                            ),
                                                          );
                                                        },
                                                        child: Text(
                                                          hospitalPhone,
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: GoogleFonts
                                                              .lexendMega(
                                                                  fontSize: 13),
                                                        ),
                                                        style: ElevatedButton
                                                            .styleFrom(
                                                          elevation: 0,
                                                        ),
                                                      )
                                                    : const Text(""),
                                              ),
                                              const SizedBox(
                                                height: 5,
                                              ),
                                              hospitalLocaiton.isNotEmpty
                                                  ? Container(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8),
                                                      decoration: BoxDecoration(
                                                        border: Border.all(
                                                          color: Colors.black,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                      ),
                                                      child: Text(
                                                        hospitalLocaiton,
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: GoogleFonts
                                                            .lexendMega(
                                                          fontSize: 12,
                                                        ),
                                                      ),
                                                    )
                                                  : Text(
                                                      hospitalLocaiton,
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: GoogleFonts
                                                          .lexendMega(
                                                        fontSize: 12,
                                                      ),
                                                    ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              Text(
                                                "$setpercentage% (percent) of voters say this hospital administer vaccines.",
                                                textAlign: TextAlign.center,
                                                style: GoogleFonts.lexendMega(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 12,
                                                  color: Colors.deepPurple[400],
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              const Divider(
                                                // thickness: 1,
                                                indent: 20,
                                                endIndent: 20,
                                                color: Colors.black87,
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              Text(
                                                "Does this Hospital administer Vaccines?\n(To help the public, please vote only if you know.)",
                                                textAlign: TextAlign.center,
                                                style: GoogleFonts.lexendMega(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              Column(
                                                children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
                                                    children: [
                                                      ElevatedButton(
                                                        onPressed:
                                                            buttonPressed[index]
                                                                ? () {
                                                                    positiveIncrement(
                                                                        hospitalName,
                                                                        index);
                                                                    buttonPressed[
                                                                            index] =
                                                                        false;
                                                                    ScaffoldMessenger.of(
                                                                            context)
                                                                        .showSnackBar(
                                                                      const SnackBar(
                                                                        backgroundColor:
                                                                            Colors.redAccent,
                                                                        content:
                                                                            Text(
                                                                          "Voted",
                                                                          textAlign:
                                                                              TextAlign.center,
                                                                        ),
                                                                      ),
                                                                    );
                                                                  }
                                                                : null,
                                                        child: Text(
                                                          "Yes",
                                                          style: GoogleFonts
                                                              .lexendMega(),
                                                        ),
                                                        style: ElevatedButton
                                                            .styleFrom(
                                                          primary:
                                                              Colour("#87D68D"),
                                                        ),
                                                      ),
                                                      ElevatedButton(
                                                        onPressed:
                                                            buttonPressed[index]
                                                                ? () {
                                                                    negativeIncrement(
                                                                        hospitalName,
                                                                        index);
                                                                    buttonPressed[
                                                                            index] =
                                                                        false;
                                                                    ScaffoldMessenger.of(
                                                                            context)
                                                                        .showSnackBar(
                                                                      const SnackBar(
                                                                        backgroundColor:
                                                                            Colors.redAccent,
                                                                        content:
                                                                            Text(
                                                                          "Voted",
                                                                          textAlign:
                                                                              TextAlign.center,
                                                                        ),
                                                                      ),
                                                                    );
                                                                  }
                                                                : null,
                                                        child: Text(
                                                          "No",
                                                          style: GoogleFonts
                                                              .lexendMega(),
                                                        ),
                                                        style: ElevatedButton
                                                            .styleFrom(
                                                          primary:
                                                              Colour("#E3655B"),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                  Text(
                                                    "1 - To vote, tap once\n2 - To Undo vote, tap and hold",
                                                    style:
                                                        GoogleFonts.lexendMega(
                                                      fontSize: 12,
                                                    ),
                                                    textAlign: TextAlign.start,
                                                  ),
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                      ),
                    ),
                    // SizedBox(height: 40),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Hospitals {
  final String name;
  final String phone;
  final String location;
  // final String county;
  final int positiveCount;
  final int negativeCount;
  // final int intPercentage;
  // final int totalVotes;

  Hospitals({
    required this.name,
    required this.phone,
    required this.location,
    // required this.county,
    required this.positiveCount,
    required this.negativeCount,
    // required this.intPercentage,
    // required this.totalVotes,
  });

  static Hospitals fromJson(Map<String, dynamic> json) {
    return Hospitals(
      name: json['HospitalName'],
      phone: json['HospitalPhone'],
      // county: json['county'],
      location: json['HospitalAddres'],
      positiveCount: json['poitiveCount'],
      negativeCount: json['negativeCount'],
      // intPercentage: json['intPercentage'],
      // totalVotes: json['totalVotes']
    );
  }
}
