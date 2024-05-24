// ignore_for_file: prefer_const_constructors

import 'package:receipe_generator/modules/recipes.dart';
import 'package:receipe_generator/packages/packages_import.dart';

class WriteRecipe extends StatefulWidget {
  const WriteRecipe({super.key});

  @override
  State<WriteRecipe> createState() => _WriteRecipeState();
}

class _WriteRecipeState extends State<WriteRecipe> {
  final List<String> categories = [
    "Breakfast",
    "Lunch",
    "Salad",
    "Desserts",
    "Drinks",
  ];

  String? _selectedCategories;
  final TextEditingController _recipeNameController = TextEditingController();
  final TextEditingController _instructionsController = TextEditingController();
  final TextEditingController _ingredientsController = TextEditingController();

  final RoundedLoadingButtonController createButton = RoundedLoadingButtonController();

  RoundedLoadingButton create() {
    return RoundedLoadingButton(
      color: const Color.fromARGB(255, 207, 165, 165),
      successIcon: Icons.done,
      successColor: Color.fromARGB(255, 61, 24, 22),
      controller: createButton,
      onPressed: () {
        _addToDatabase();
        Timer(Duration(seconds: 3), () {
          createButton.success();
        });
      },
      child: Text('Create!', style: TextStyle(color: Colors.white)),
    );
  }

  void _addToDatabase() {
    String title = _recipeNameController.text;
    String instructions = _instructionsController.text;
    String ingredients = _ingredientsController.text;
    String category = _selectedCategories ?? "";

    Recipe recipe = Recipe(
      title: title,
      instructions: instructions.split('\n').toString(), 
      category: category,
      favState: false, 
      ingrediants: ingredients.split(',').toString(), 
    );

    //  TODO Add the recipe to the database here
    // ...
  }

  Padding categoryInput() {
    return Padding(
      padding: EdgeInsets.all(15),
      child: DropdownButtonFormField<String>(
        focusColor: Colors.brown,
        decoration: InputDecoration(
          labelText: 'Category',
          hintText: 'Select a category',
          icon: Icon(Icons.category),
        ),
        value: _selectedCategories,
        onChanged: (value) {
          setState(() {
            _selectedCategories = value;
          });
        },
        items: categories
            .map((e) => DropdownMenuItem(
                  value: e,
                  child: Text(e, style: const TextStyle(fontSize: 18)),
                ))
            .toList(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: WidgetTheme.addPagesAppBar(context),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            imageShow(),
            msg(),
            recipeNameInput(),
            ingInput(),
            instructionsInput(),
            categoryInput(),
            create(),
          ],
        ),
      ),
    );
  }

  Container imageShow() {
    return Container(
      decoration: BoxDecoration(),
      margin: EdgeInsets.only(bottom: 10),
      child: Image.asset(
        'assets/images/newrecipe.jpg',
        width: double.infinity,
        height: 250,
        fit: BoxFit.cover,
      ),
    );
  }

  Padding recipeNameInput() {
    return Padding(
      padding: EdgeInsets.all(15),
      child: TextField(
        controller: _recipeNameController,
        decoration: InputDecoration(
          labelText: 'Recipe Name',
          hintText: 'What do you want to call your recipe?',
          icon: Icon(Icons.bookmark_outline_outlined),
        ),
      ),
    );
  }

  Padding instructionsInput() {
    return Padding(
      padding: EdgeInsets.all(15),
      child: TextField(
        controller: _instructionsController,
        decoration: InputDecoration(
          labelText: 'Instructions',
          hintText: 'Steps? Notes?',
          icon: Icon(Icons.list),
        ),
        maxLines: null,
        keyboardType: TextInputType.multiline,
      ),
    );
  }

  Padding ingInput() {
    return Padding(
      padding: EdgeInsets.all(15),
      child: TextField(
        controller: _ingredientsController,
        decoration: InputDecoration(
          focusColor: Color.fromARGB(255, 224, 86, 86),
          labelText: 'Ingredients',
          hintText: 'List the ingredients separated with ", "',
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
      ),
    );
  }
}
