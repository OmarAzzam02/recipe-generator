// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, library_private_types_in_public_api

import '/packages/packages_import.dart';

////DONT TOUCHHHHHHHHHHHH

class Add extends StatefulWidget {
  const Add({super.key});

  @override
  _AddState createState() => _AddState();
}

class _AddState extends State<Add> {
  int val = -1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 210, 207, 202),
      body: Container(
        margin: EdgeInsets.only(top: 15),
        padding: EdgeInsets.all(12),
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 15),
              child: Text(
                "How do you want to \n create this recipe ? ",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
             fontFamily: WidgetTheme.textFont(),
              fontSize: 32,
            letterSpacing: 1.0,
                ),
              ),
            ),
            Card(
              color: Color.fromARGB(255, 209, 192, 139),
              child: RadioListTile(
                value: 0,
                groupValue: val,
                onChanged: (value) {
                  setState(() {
                    val = value!;
                  });
                },
                title: Text("Write your recipe  "),
                subtitle: Text("Write your own recipe details "),
                secondary: Icon(Icons.colorize_rounded),
                toggleable: true,
                controlAffinity: ListTileControlAffinity.trailing,
                activeColor: const Color.fromARGB(255, 159, 113, 43),
              ),
            ),
            Card(
              color: Color.fromARGB(255, 209, 192, 139),
              child: RadioListTile(
                value: 1,
                groupValue: val,
                onChanged: (value) {
                  setState(() {
                    val = value!;
                  });
                },
                title: Text("Generate "),
                subtitle: Text(
                    "Generate a recipe with the ingrediants you have using AI "),
                secondary: Icon(Icons.android_rounded),
                toggleable: true,
                controlAffinity: ListTileControlAffinity.trailing,
                activeColor: const Color.fromARGB(255, 159, 113, 43),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () => setState(() {
                _determineRoute(context, val);
              }),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromARGB(202, 131, 81, 16),
                padding: EdgeInsets.only(left: 150, right: 150),
              ),
              child: Text(
                "Continue",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.white,
                    fontFamily: WidgetTheme.textFont(),
                    fontWeight: FontWeight.bold,
                    fontSize: 14),
              ),
            )
          ],
        ),
      ),
    );
  }

  void _determineRoute(BuildContext context, int val) {
    if (val == 0) {
      goToWritePage(context);
    } else if (val == 1) {
      goToGeneratePage(context);
    }
  }

  void goToWritePage(BuildContext context) {
    Navigator.pushNamed(context, Routes.write);
  }

  void goToGeneratePage(BuildContext context) {
    Navigator.pushNamed(context, Routes.generate);
  }
}
