// ignore_for_file: prefer_final_fields

import 'package:receipe_generator/Services/database_services.dart';
import 'package:receipe_generator/Themes/widget_theme.dart';
import 'package:receipe_generator/modules/recipes.dart';
import 'package:receipe_generator/packages/packages_import.dart';

class WriteRecipe extends StatefulWidget {
  const WriteRecipe({Key? key}) : super(key: key);

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

  final RoundedLoadingButtonController createButton =
      RoundedLoadingButtonController();

  List<String> _ingredientsList = [];
  List<String> _instructionsList = [];

  bool _recipeNameError = false;
  bool _instructionsError = false;
  bool _ingredientsError = false;
  bool _categoryError = false;
  final _databaseService = DatabaseService();

  RoundedLoadingButton create() {
    return RoundedLoadingButton(
      color: Colors.brown,
      successIcon: Icons.done,
      successColor: Colors.green,
      controller: createButton,
      onPressed: () {
        if (_validateInputs()) {
          _addToDatabase();
          Timer(const Duration(seconds: 3), () {
            createButton.success();
          });
        } else {
          Timer(const Duration(seconds: 5), () {
            createButton.error();
          });
          Timer(const Duration(seconds: 6), () {
            createButton.reset();
          });
          _showErrorBorders();
        }
      },
      child: Text('Save Recipe',
          style: TextStyle(
            color: Colors.white,
            fontFamily: WidgetTheme.textFont(),
          )),
    );
  }

  bool _validateInputs() {
    bool isValid = true;

    if (_recipeNameController.text.isEmpty) {
      isValid = false;
      _recipeNameError = true;
    } else {
      _recipeNameError = false;
    }

    if (_instructionsList.isEmpty) {
      isValid = false;
      _instructionsError = true;
    } else {
      _instructionsError = false;
    }

    if (_ingredientsList.isEmpty) {
      isValid = false;
      _ingredientsError = true;
    } else {
      _ingredientsError = false;
    }

    if (_selectedCategories == null) {
      isValid = false;
      _categoryError = true;
    } else {
      _categoryError = false;
    }

    return isValid;
  }

  void _showErrorBorders() {
    setState(() {});
  }

  void _addToDatabase() {
    String title = _recipeNameController.text;
    String instructions = _instructionsList.join('-');
    String ingrediants = _ingredientsList.join(',');
    String category = _selectedCategories!;

    Recipe recipe = Recipe(
        title: title,
        instructions: instructions,
        category: category,
        favState: false,
        ingrediants: ingrediants);

    _databaseService.addRecipe(recipe);
  }

  Padding categoryInput() {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: DropdownButtonFormField<String>(
        focusColor: Colors.brown,
        decoration: InputDecoration(
          labelText: 'Category',
          hintText: 'Select a category',
          icon: const Icon(Icons.category),
          errorText: _categoryError ? 'Category cannot be empty' : null,
          errorBorder: _categoryError
              ? const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red),
                )
              : null,
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
      appBar: AppBar(
        title: const Text('Write Recipe'),
      ),
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
      decoration: const BoxDecoration(),
      margin: const EdgeInsets.only(bottom: 10),
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
      padding: const EdgeInsets.all(15),
      child: TextField(
        controller: _recipeNameController,
        decoration: InputDecoration(
          labelText: 'Recipe Name',
          hintText: 'What do you want to call your recipe?',
          icon: const Icon(Icons.bookmark_outline_outlined),
          errorText: _recipeNameError ? 'Recipe name cannot be empty' : null,
          errorBorder: _recipeNameError
              ? const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red),
                )
              : null,
        ),
      ),
    );
  }

  Padding instructionsInput() {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextField(
            controller: _instructionsController,
            decoration: InputDecoration(
              labelText: 'Instructions',
              hintText: 'Steps? Notes?',
              icon: const Icon(Icons.list),
              errorText:
                  _instructionsError ? 'Instructions cannot be empty' : null,
              errorBorder: _instructionsError
                  ? const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red),
                    )
                  : null,
            ),
            maxLines: null,
            keyboardType: TextInputType.multiline,
          ),
          const SizedBox(height: 10),
          Wrap(
            spacing: 8.0,
            runSpacing: 4.0,
            children: _buildInstructionsChips(),
          ),
          const SizedBox(height: 10),
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: Colors.brown,
            ),
            onPressed: _addInstruction,
            icon: const Icon(Icons.add),
            label: Text(
              'Add Instruction',
              style: TextStyle(
                fontFamily: WidgetTheme.textFont(),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _addInstruction() {
    setState(() {
      String instruction = _instructionsController.text.trim();
      if (instruction.isNotEmpty) {
        _instructionsList.add(instruction);
        _instructionsController.clear();
      }
    });
  }

  List<Widget> _buildInstructionsChips() {
    List<Widget> chips = [];
    for (int i = 0; i < _instructionsList.length; i++) {
      Widget chip = Chip(
        label: Text(_instructionsList[i]),
        deleteIcon: const Icon(Icons.cancel),
        onDeleted: () {
          _removeInstruction(i);
        },
      );
      chips.add(chip);
    }
    return chips;
  }

  void _removeInstruction(int index) {
    setState(() {
      _instructionsList.removeAt(index);
    });
  }

  Padding ingInput() {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextField(
            controller: _ingredientsController,
            decoration: InputDecoration(
              labelText: 'Ingredients',
              hintText: 'List the ingredients separated with   ',
              icon: const Icon(Icons.food_bank_rounded),
              errorText:
                  _ingredientsError ? 'Ingredients cannot be empty' : null,
              errorBorder: _ingredientsError
                  ? const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red),
                    )
                  : null,
            ),
          ),
          const SizedBox(height: 10),
          Wrap(
            spacing: 8.0,
            runSpacing: 4.0,
            children: _buildIngredientsChips(),
          ),
          const SizedBox(height: 10),
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.brown,
              foregroundColor: Colors.white,
            ),
            onPressed: _addIngredient,
            icon: const Icon(Icons.add),
            label: Text(
              'Add Ingredient',
              style: TextStyle(
                fontFamily: WidgetTheme.textFont(),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _addIngredient() {
    setState(() {
      String ingredient = _ingredientsController.text.trim();
      if (ingredient.isNotEmpty) {
        _ingredientsList.add(ingredient);
        _ingredientsController.clear();
      }
    });
  }

  List<Widget> _buildIngredientsChips() {
    List<Widget> chips = [];
    for (int i = 0; i < _ingredientsList.length; i++) {
      Widget chip = Chip(
        label: Text(_ingredientsList[i]),
        deleteIcon: const Icon(Icons.cancel),
        onDeleted: () {
          _removeIngredient(i);
        },
      );
      chips.add(chip);
    }
    return chips;
  }

  void _removeIngredient(int index) {
    setState(() {
      _ingredientsList.removeAt(index);
    });
  }

  ListTile msg() {
    return const ListTile(
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
