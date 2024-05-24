import 'package:receipe_generator/Services/database_services.dart';

import 'package:receipe_generator/modules/recipes.dart';
import 'package:receipe_generator/packages/packages_import.dart';

class DetailsScreen extends StatefulWidget {
  final Map pickedRecipe;
  final List ingredients;
  DetailsScreen(this.pickedRecipe, this.ingredients, {super.key});
  final DatabaseService _databaseService = DatabaseService();
  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: WidgetTheme.addPagesAppBar(context),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 20),
              child: Image.asset('assets/images/newrecipe.jpg'),
            ),
            Container(
              width: 370,
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
                boxShadow: const [
                  BoxShadow(
                    color: Colors.grey,
                    offset: Offset(2, 2),
                    blurRadius: 5,
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Ingredients:",
                    style: TextStyle(
                      fontFamily: WidgetTheme.textFont(),
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    widget.ingredients.join(', '),
                    style: TextStyle(
                      fontFamily: WidgetTheme.textFont(),
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Container(
              width: 370,
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
                boxShadow: const [
                  BoxShadow(
                    color: Colors.grey,
                    offset: Offset(2, 2),
                    blurRadius: 5,
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Instructions",
                    style: TextStyle(
                      fontFamily: WidgetTheme.textFont(),
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(height: 15),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      widget.pickedRecipe['instructions'].join(
                          '\n \n '), // Ensure instructions are formatted as a list
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        fontFamily: WidgetTheme.textFont(),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 15, bottom: 15),
                        child: ElevatedButton(
                          onPressed: () {
                            _addToDB();
                          },
                          style: ElevatedButton.styleFrom(
                            shape: const BeveledRectangleBorder(),
                            backgroundColor: Colors.brown,
                            padding:
                                const EdgeInsets.only(right: 150, left: 150),
                          ),
                          child: Text("Save",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: WidgetTheme.textFont(),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18)),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _addToDB() {
    print(widget.pickedRecipe['instructions'].runtimeType);
    Recipe recipe = Recipe(
        title: widget.pickedRecipe['title'].toString(),
        instructions: widget.pickedRecipe['instructions'].join(''),
        category: widget.pickedRecipe['category'].toString(),
        favState: false,
        ingrediants: widget.ingredients.join(','));

    widget._databaseService.addRecipe(recipe);
  }
}
