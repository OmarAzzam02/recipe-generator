import '/packages/packages_import.dart';


class NewScreen extends StatefulWidget {
  @override
  _NewScreen createState() => _NewScreen();
}

class _NewScreen extends State<NewScreen> {
  TextEditingController nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "New Recipe",
            style: TextStyle(
              color: Color.fromARGB(255, 224, 86, 86), // Change the text color
              fontSize: 20.0, // Change the font size
              fontWeight: FontWeight.bold, // Change the font weight
              fontStyle: FontStyle.italic, // Change the font style
              letterSpacing: 2.0, // Change the letter spacing
            ),
          ),
        ),
        body: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(15),
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Recipe Name',
                  hintText: 'What do you want to call your recipe?',
                ),
              ),
            ),
//////////////////////////Category/////////////////////////////////
            Padding(
              padding: EdgeInsets.all(15),
              child: TextField(
                decoration: InputDecoration(
                  focusColor: Color.fromARGB(255, 224, 86, 86),
                  border: OutlineInputBorder(),
                  labelText: 'Category',
                  //hintText: '',
                ),
              ),
            ),
/////////////////////////////////////////////////////////////////////
            Padding(
              padding: EdgeInsets.all(15),
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Instructions',
                  hintText: 'Steps? Notes?',
                ),
              ),
            ),

////////////////////////////////////////////////////////////////////
            Padding(
              padding: EdgeInsets.all(15),
              child: TextField(
                decoration: InputDecoration(
                  focusColor: Color.fromARGB(255, 224, 86, 86),
                  border: OutlineInputBorder(),
                  labelText: 'Ingredients',
                  hintText: 'List the ingredients seperated with " , "',
                ),
              ),
            ),
           
          ],
        ));
  }
}
