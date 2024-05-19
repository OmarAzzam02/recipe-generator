// ignore_for_file: prefer_const_constructors

import 'package:receipe_generator/packages/packages_import.dart';

//// Mariam add the writing the recipe secrtion here
class WriteRecipe extends StatefulWidget {
  const WriteRecipe({super.key});

  @override
  State<WriteRecipe> createState() => _WriteRecipeState();
}

List<String> categories = <String>[];
var index = 0;

class _WriteRecipeState extends State<WriteRecipe> {
  final List<String> categories = [
    "Breakfast",
    "Lunch",
    "Salad",
    "Desserts",
    "Drinks",
  ];

  String? _selectedCategories;

  final RoundedLoadingButtonController createButton =
      RoundedLoadingButtonController();

  RoundedLoadingButton create() {
    return RoundedLoadingButton(
      color: const Color.fromARGB(255, 207, 165, 165),
      successIcon: Icons.done,
      successColor: Color.fromARGB(255, 61, 24, 22),
      controller: createButton,
      onPressed: () {
        Timer(Duration(seconds: 3), () {
          createButton.success();
        });
      },
      child: Text('Create!', style: TextStyle(color: Colors.white)),
    );
  }

  Padding categoryInput() {
    return Padding(
      padding: EdgeInsets.all(15),
      child: DropdownButton<String>(
        value: _selectedCategories,
        onChanged: (value) {
          setState(() {
            _selectedCategories = value;
          });
        },
        hint: Center(
            child: Text(
          'categories',
          style: const TextStyle(fontSize: 18),
        )),
        underline: Container(),
        icon: Icon(
          Icons.arrow_downward,
          color: Color.fromARGB(255, 0, 0, 0),
        ),
        isExpanded: true,
        items: categories
            .map((e) => DropdownMenuItem(
                  value: e,
                  child: Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      e,
                      style: const TextStyle(fontSize: 18),
                    ),
                  ),
                ))
            .toList(),
        selectedItemBuilder: (context) => categories
            .map((e) => Center(
                  child: Text(
                    e,
                    style: const TextStyle(
                      fontSize: 18,
                      color: Color.fromARGB(255, 0, 0, 0),
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ))
            .toList(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: WidgetTheme.addPagesAppBar(context), // routing line dont play
            body: SingleChildScrollView(
                child: Column(children: <Widget>[
          imageShow(),
          msg(),
          recipeNameInput(),
          ingInput(),
          instructionsInput(),
          categoryInput(),
          create(),
        ])));
  }
}

Card imageShow() {
  return Card(
    borderOnForeground: true,
    shape: CircleBorder(),
    semanticContainer: true,
    margin: EdgeInsets.all(20),
    child: Image.asset(
      'images/newrecipe.jpg',
      width: double.maxFinite,
      height: 250,
      fit: BoxFit.cover,
    ),
  );
}

Padding recipeNameInput() {
  return Padding(
    padding: EdgeInsets.all(15),
    child: TextField(
      decoration: InputDecoration(
          labelText: 'Recipe Name',
          hintText: 'What do you want to call your recipe?',
          icon: Icon(Icons.bookmark_outline_outlined)),
    ),
  );
}

Padding instructionsInput() {
  return Padding(
    padding: EdgeInsets.all(15),
    child: TextField(
      decoration: InputDecoration(
        labelText: 'Instructions',
        hintText: 'Steps? Notes?',
        icon: Icon(Icons.list),
      ),
    ),
  );
}

Padding ingInput() {
  return Padding(
    padding: EdgeInsets.all(15),
    child: TextField(
      decoration: InputDecoration(
        focusColor: Color.fromARGB(255, 224, 86, 86),
        labelText: 'Ingredients',
        hintText: 'List the ingredients seperated with " , "',
        icon: Icon(Icons.food_bank_rounded),
      ),
    ),
  );
}

ListTile msg() {
  return ListTile(
      title: Text(
        "Let us create a delicious recipe!!",
        style: TextStyle(
          fontSize: 16.0,
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: Text(
        "Ingredients List",
        style: TextStyle(
          fontSize: 14.0,
        ),
      ));
}
