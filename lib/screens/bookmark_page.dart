import 'package:receipe_generator/Services/database_services.dart';
import 'package:receipe_generator/modules/recipes.dart';
import 'package:receipe_generator/screens/saves_recipe_details_screen.dart';
import '/packages/packages_import.dart';

class BookMark extends StatefulWidget {
  const BookMark({super.key});

  @override
  State<BookMark> createState() => _BookMarkState();
}

Map<String, List<Recipe>> organizedData = {
  "Breakfast": [],
  "Lunch": [],
  "Salad": [],
  "Desserts": [],
  "Soup": [],
  "Drinks": [],
  "Other":[],
};

class _BookMarkState extends State<BookMark> {
  final DatabaseService _databaseService = DatabaseService();

  String determineCategory(String recipeCategory) {
    if (recipeCategory.startsWith('B')) return "Breakfast";
    if (recipeCategory.startsWith('L')) return "Lunch";
    if (recipeCategory.startsWith('Sal')) return "Salad";
    if (recipeCategory.startsWith('Sou')) return "Soup";
    if (recipeCategory.startsWith('Drin')) return "Drinks";
    if (recipeCategory.startsWith('Dess')) return "Desserts";

    return "Other";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: StreamBuilder(
        stream: _databaseService.getRecipes(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          List recipesInstances = snapshot.data?.docs ?? [];
          print(recipesInstances);

    organizedData.forEach((key, value) => value.clear());
          assignData(recipesInstances);

          return ListView.builder(
            shrinkWrap: true,
            itemCount: organizedData.length,
            itemBuilder: (context, index) {
              String category = organizedData.keys.elementAt(index);
              final recipes = organizedData[category] ?? [];

              return ExpansionTile(
                title: Text(
                  category,
                  style: const TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                children: [
                  GridView.builder(
                    shrinkWrap: true,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      childAspectRatio: 9 / 16,
                    ),
                    itemCount: recipes.length,
                    itemBuilder: (context, recipeIndex) {
                      return Container(
                        child: Card(
                          elevation: 2,
                          child: Column(
                            children: [
                              Stack(
                                children: [
                                  Image.asset(
                                    'assets/images/newrecipe.jpg', // Adjust image path as necessary
                                    width: 200,
                                  ),
                                  Positioned(
                                    top: 8,
                                    left: 8,
                                    child: IconButton(
                                      icon: const Icon(
                                        Icons.delete,
                                        color: Colors.white,
                                      ),
                                      onPressed: () {
                                        String recipeId =
                                            recipesInstances[recipeIndex].id;
                                        _databaseService.deleteRecipe(
                                            recipeId,);

                                        setState(() {
                                          recipes.removeAt(recipeIndex);
                                        });
                                      },
                                    ),
                                  ),
                                  Positioned(
                                    top: 8,
                                    right: 8,
                                    child: IconButton(
                                      icon: Icon(
                                        recipes[recipeIndex].favState
                                            ? Icons.favorite
                                            : Icons.favorite_border,
                                        color: recipes[recipeIndex].favState
                                            ? Colors.red
                                            : Colors.white,
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          bool newFavState =
                                              !recipes[recipeIndex].favState;
                                          recipes[recipeIndex].favState =
                                              newFavState;

                                          String recipeId =
                                              recipesInstances[recipeIndex].id;
                                          Recipe updateRecipe =
                                              recipes[recipeIndex].copyWith(
                                                  favState: newFavState);

                                          _databaseService.updateRecipe(
                                              recipeId, updateRecipe);
                                        });
                                      },
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 7),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.only(top: 8),
                                      padding: const EdgeInsets.all(3),
                                      width: 100,
                                      decoration: BoxDecoration(
                                        color: Colors.brown,
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      child: Text(
                                        recipes[recipeIndex].category,
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.only(top: 8),
                                      padding: const EdgeInsets.all(3),
                                      width: 55,
                                      decoration: BoxDecoration(
                                        color: Colors.brown,
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      child: const Text(
                                        "Recipe",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                margin:
                                    const EdgeInsets.only(top: 8, bottom: 8),
                                child: Text(
                                  recipes[recipeIndex].title,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(right: 1, left: 1),
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    shape: const BeveledRectangleBorder(),
                                    elevation: 0.5,
                                    backgroundColor: Colors.brown,
                                    foregroundColor: Colors.white,
                                  ),
                                  child: const Text("View Details"),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            SavedDetails(recipes[recipeIndex]),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }

  void assignData(final recipesInstance) {



    for (int i = 0; i < recipesInstance.length; i++) {
      String cat = determineCategory(recipesInstance[i].data().category);
      print(recipesInstance[i].data().category);
      Recipe temp = recipesInstance[i].data();
      organizedData[cat]?.add(temp);
    }
  }
}
