// ignore_for_file: library_private_types_in_public_api, prefer_const_literals_to_create_immutables, prefer_const_constructors, sort_child_properties_last

import 'package:google_fonts/google_fonts.dart';

import '/packages/packages_import.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            color: Colors.red,
            height: 215,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Generate Your Own \n Master Recipe",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        fontFamily: GoogleFonts.laila().fontFamily,
                      ),
                    ),
                    Text(
                      " \n generate with the ingrediants you have",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontFamily: GoogleFonts.laila().fontFamily,
                          fontSize: 15,
                          fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 1),
            padding: EdgeInsets.only(top: 12),
            height: 215,
            width: double.infinity,
            color: Colors.blue,
            child: Column(
              children: [
                ElevatedButton(
                  onPressed: () {},
                  child: Text("Generate Your Own Recipe"),
                  style: ElevatedButton.styleFrom(
                    shape: BeveledRectangleBorder(),
                    backgroundColor: Color.fromARGB(175, 237, 16, 207),
                    foregroundColor: Colors.black,
                    padding: EdgeInsets.only(right: 100, left: 100),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: Text("Write Your Own Recipe"),
                  style: ElevatedButton.styleFrom(
                      shape: BeveledRectangleBorder(),
                      backgroundColor: Color.fromARGB(175, 237, 16, 207),
                      foregroundColor: Colors.black,
                      padding: EdgeInsets.only(right: 112, left: 112)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
