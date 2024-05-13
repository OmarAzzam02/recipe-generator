import '/packages/packages_import.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreen createState() => _HomeScreen();
}

class _HomeScreen extends State<HomeScreen> {
  TextEditingController ingController = TextEditingController();
  String? toGPT = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "Search",
            style: TextStyle(
              color: Color.fromARGB(255, 224, 86, 86), // Change the text color
              fontSize: 20.0, // Change the font size
              fontWeight: FontWeight.bold, // Change the font weight
              fontStyle: FontStyle.italic, // Change the font style
              letterSpacing: 2.0, // Change the letter spacing
            ),
          ),
        ),
        body: Column(children: [
          Padding(
            padding: EdgeInsets.all(20),
            child: RichText(
                text: TextSpan(
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 24.0,
                    ),
                    children: [
                  TextSpan(
                    text: 'What\'s in your kitchen?\n',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextSpan(
                    text: 'Enter some ingredients to start cooking!',
                    style: TextStyle(
                      fontStyle: FontStyle.italic,
                      fontSize: 16.0,
                    ),
                  ),
                ])),
          ),
          Padding(
              padding: EdgeInsets.all(20),
              child: TextField(
                  expands: false,
                  controller: ingController,
                  decoration: InputDecoration(
                    hintStyle: TextStyle(
                      fontSize: 15,
                      fontStyle: FontStyle.italic,
                    ),
                    border: OutlineInputBorder(),
                    hintText: 'Type your ingredients seperated with " , " ',
                    icon: Icon(Icons.search),
                  ))),
          OutlinedButton(
              child: Text('Generate a recipe',
                  selectionColor: Color.fromARGB(255, 19, 5, 4),
                  style: TextStyle(fontStyle: FontStyle.italic)),
              style: OutlinedButton.styleFrom(
                backgroundColor: Color.fromARGB(255, 207, 100, 100),
                textStyle: TextStyle(
                  fontSize: 15,
                  fontStyle: FontStyle.italic,
                ),
                foregroundColor: Colors.black,
              ),
              onPressed: () {
                setState(() {
                  toGPT = ingController.text;
                });
              }),
          Text(toGPT!, // remove this its only for testing ther output
              style: TextStyle(
                  color: Colors.grey[800],
                  fontWeight: FontWeight.bold,
                  fontSize: 40)),
        ]));
  }
}
