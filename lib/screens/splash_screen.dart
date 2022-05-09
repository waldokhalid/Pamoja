import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pamoja/screens/dashboard.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class SplasScreen extends StatefulWidget {
  const SplasScreen({key}) : super(key: key);
  static const String idScreen = "SplasScreen";

  @override
  _SplasScreenState createState() => _SplasScreenState();
}

class _SplasScreenState extends State<SplasScreen> {
  @override
  void initState() {
    super.initState();
    // Timer(Duration(seconds: 3), () {
    //   Navigator.of(context).pushReplacement(StartScreen.idScreen);
    // });
    Future.delayed(const Duration(milliseconds: 1400), () {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => DashBoardScreen()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      // appBar: AppBar(
      //   backgroundColor: Colors.grey[100],
      //   centerTitle: true,
      //   elevation: 0,
      //   title: Text(
      //     "Pamoja",
      //     style: TextStyle(
      //       color: Colors.black,
      //       fontSize: 35,
      //     ),
      //   ),
      // ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "PAMOJA",
              style: GoogleFonts.lexendMega(
                fontSize: 55,
                fontWeight: FontWeight.bold,
              ),
            ),
            Column(
              children: [
                Text(
                  "Together",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.lexendMega(
                    fontSize: 25,
                  ),
                ),
                // Text(
                //   "We vaccinate Kenya",
                //   textAlign: TextAlign.center,
                //   style: GoogleFonts.lexendMega(
                //     fontSize: 25,
                //     color: Colors.green
                //   ),
                // ),
                SizedBox(
                  child: DefaultTextStyle(
                    style: GoogleFonts.lexendMega(
                      fontSize: 25,
                      color: Colors.green,
                    ),
                    child: AnimatedTextKit(
                      animatedTexts: [
                        ScaleAnimatedText(
                          "We vaccinate Kenya",
                          textAlign: TextAlign.center,
                          // speed: const Duration(milliseconds: 180),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
