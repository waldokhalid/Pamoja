import 'package:colour/colour.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:hexcolor/hexcolor.dart';
import 'package:pamoja/screens/add_new_hospital.dart';
import 'package:pamoja/submit_hospital_name.dart';
import 'package:url_launcher/url_launcher.dart';

class AppDeveloperIdentity extends StatelessWidget {
  const AppDeveloperIdentity({key}) : super(key: key);
  static const String idScreen = "AppDeveloperIdentity";

  // ignore: non_constant_identifier_names
  _launchUrl_linkedIn() async {
    const url = "https://www.linkedin.com/in/waldokhalid/";
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw "Could not launch $url";
    }
  }

  // ignore: non_constant_identifier_names
  _launchUrl_instagram() async {
    const url = "https://www.instagram.com/waldokhalid/";
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw "Could not launch $url";
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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(70),
              child: const Image(
                height: 200,
                width: 150,
                fit: BoxFit.fill,
                image: AssetImage("assets/images/me.JPG"),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Text(
              "Khalid Ahmed",
              style: GoogleFonts.lexendMega(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: 14,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              "khalld.ahhmd@gmail.com",
              style: GoogleFonts.lexendMega(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: 14,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            GestureDetector(
              onTap: () {
                _launchUrl_linkedIn();
              },
              child: Container(
                height: 30,
                width: 120,
                decoration: BoxDecoration(
                  color: Colour("#81D2C7"),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                child: Center(
                  child: FittedBox(
                    fit: BoxFit.contain,
                    child: Text(
                      "LinkedIn",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.lexendMega(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            GestureDetector(
              onTap: () {
                _launchUrl_instagram();
              },
              child: Container(
                height: 30,
                width: 120,
                decoration: BoxDecoration(
                  color: Colour("#416788"),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                child: Center(
                  child: FittedBox(
                    fit: BoxFit.contain,
                    child: Text(
                      "Instagram",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.lexendMega(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.local_hospital_sharp,
                  color: Colors.black,
                ),
                const SizedBox(
                  width: 10,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      AddNewHospital.idScreen,
                    );
                  },
                  child: Container(
                    height: 50,
                    width: 150,
                    decoration: const BoxDecoration(
                      color: Colors.redAccent,
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        "Add Hospital",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.lexendMega(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  SubmitHospitalName.idScreen,
                );
              },
              child: Text(
                "If you know a hospital that administers vaccines\nbut isn't listed here, CLICK ME!",
                textAlign: TextAlign.center,
                style: GoogleFonts.lexendMega(
                  fontSize: 12,
                  color: Colors.white,
                ),
              ),
              style: TextButton.styleFrom(
                backgroundColor: Colors.black,
              ),
            )
          ],
        ),
      ),
    );
  }
}
