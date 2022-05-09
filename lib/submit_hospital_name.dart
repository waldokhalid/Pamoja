import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SubmitHospitalName extends StatefulWidget {
  const SubmitHospitalName({key}) : super(key: key);
  static const String idScreen = "SubmitHospitalName";

  @override
  _SubmitHospitalNameState createState() => _SubmitHospitalNameState();
}

class _SubmitHospitalNameState extends State<SubmitHospitalName> {
  final databaseReference = FirebaseDatabase.instance.reference();
  TextEditingController hospitalName = TextEditingController();
  TextEditingController hospitalCounty = TextEditingController();
  TextEditingController moreHospitalInfo = TextEditingController();
  TextEditingController submittersName = TextEditingController();
  // TextEditingController submittersID = TextEditingController();

  _sendHospitalInfo() {
    try {
      databaseReference.child("New_Hospitals").child(hospitalCounty.text).set(
        {
          "Hospital Name": hospitalName.text,
          "Hospital Addres": hospitalCounty.text,
          "Submitters Name": submittersName,
        },
      );
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.green,
          content: Text(
            "Hospital Information has been submitted",
            textAlign: TextAlign.center,
          ),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.red,
          content: Text(
            "Something went wrong. Please try again.",
            textAlign: TextAlign.center,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        shadowColor: Colors.black,
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
            fontSize: 30,
          ),
        ),
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Provide Hospital Information",
                textAlign: TextAlign.center,
                style: GoogleFonts.lexendMega(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 15,),
              TextField(
                controller: submittersName,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.blueGrey,
                      style: BorderStyle.solid,
                      width: 0.5,
                    ),
                  ),
                  labelText: "Your Full Name",
                  labelStyle: const TextStyle(
                    fontSize: 12.0,
                    color: Colors.blueGrey,
                  ),
                  hintStyle: GoogleFonts.lexendMega(
                    color: Colors.grey,
                    fontSize: 12,
                  ),
                ),
                style: GoogleFonts.lexendMega(
                  fontSize: 12,
                  color: Colors.black,
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              TextField(
                controller: hospitalName,
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
                    fontSize: 12.0,
                    color: Colors.blueGrey,
                  ),
                  hintStyle: GoogleFonts.lexendMega(
                    color: Colors.grey,
                    fontSize: 12,
                  ),
                ),
                style: GoogleFonts.lexendMega(
                  fontSize: 12,
                  color: Colors.black,
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              TextField(
                controller: hospitalCounty,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.blueGrey,
                      style: BorderStyle.solid,
                      width: 0.5,
                    ),
                  ),
                  labelText: "Hospital County",
                  labelStyle: const TextStyle(
                    fontSize: 12.0,
                    color: Colors.blueGrey,
                  ),
                  hintStyle: GoogleFonts.lexendMega(
                    color: Colors.grey,
                    fontSize: 12,
                  ),
                ),
                style: GoogleFonts.lexendMega(
                  fontSize: 12,
                  color: Colors.black,
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              ElevatedButton(
                onPressed: () {
                  FocusScope.of(context).requestFocus(
                    FocusNode(),
                  );
                  _sendHospitalInfo();
                  hospitalName.clear();
                  hospitalCounty.clear();
                  submittersName.clear();
                },
                child: Text(
                  "Submit",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.lexendMega(
                    fontSize: 12,
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
      ),
    );
  }
}
