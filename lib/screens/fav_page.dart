// ignore_for_file: prefer_const_constructors, library_private_types_in_public_api

import 'package:receipe_generator/Services/database_services.dart';
import 'package:receipe_generator/modules/recipes.dart';
import 'package:receipe_generator/screens/saves_recipe_details_screen.dart';

import '/packages/packages_import.dart';

class FavPage extends StatefulWidget {
  const FavPage({super.key});

  @override
  _FavPageState createState() => _FavPageState();
}
// add fav code hereeeeeeee

class _FavPageState extends State<FavPage> {
  final _databaseService = DatabaseService();
  final favoriteRecipes = [
    // get from database
  ];

  void assignData(final recipesInstance) {
    print(recipesInstance.length);
    favoriteRecipes.clear();
    for (int i = 0; i < recipesInstance.length; i++) {
      if (recipesInstance[i].data().favState) {
        Recipe temp = recipesInstance[i].data();
        print(temp.favState);
        favoriteRecipes.add(temp);
      }
    }
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
          assignData(recipesInstances);
          if(favoriteRecipes.isEmpty){
              return Center( 
                child : Text("There Is No Recipes Added to Favorites", textAlign: TextAlign.center , style: TextStyle(  
                    fontFamily:  WidgetTheme.textFont(),
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                   
                ),),
              );
          }
           else return GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 9 / 16),
            itemCount: favoriteRecipes.length,
            itemBuilder: (context, index) {
              return Container(
                child: Card(
                  elevation: 2,
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          Image.asset(
                            'assets/images/newrecipe.jpg',
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
                                            recipesInstances[index].id;
                                        _databaseService.deleteRecipe(
                                            recipeId,);

                                        setState(() {
                                          favoriteRecipes.removeAt(index);
                                        });
                                      },
                                    ),
                                  ),
                          Positioned(
                            top: 8,
                            right: 8,
                            child: IconButton(
                              icon: Icon(
                                favoriteRecipes[index].favState
                                    ? Icons.favorite
                                    : Icons.favorite_border,
                                color: favoriteRecipes[index].favState
                                    ? Colors.red
                                    : Colors.white,
                              ),
                              onPressed: () {
                                setState(() {
                                  bool newFavState =
                                      !favoriteRecipes[index].favState;
                                  favoriteRecipes[index].favState = newFavState;

                                  String recipeId =
                                      recipesInstances[index].id;
                                  Recipe updateRecipe = favoriteRecipes[index]
                                      .copyWith(favState: newFavState);

                                  _databaseService.updateRecipe(
                                      recipeId, updateRecipe);
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 7),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                favoriteRecipes[index].category,
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
                        margin: const EdgeInsets.only(top: 8, bottom: 8),
                        child: Text(
                          favoriteRecipes[index].title,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontFamily: WidgetTheme.textFont(),
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 1, left: 1),
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              shape: const BeveledRectangleBorder(),
                              elevation: 0.5,
                              backgroundColor: Colors.brown,
                              foregroundColor: Colors.white,
                            ),
                            onPressed: () {
                              setState(() {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => SavedDetails(
                                            favoriteRecipes[index])));
                              });
                            },
                            child: const Text("View Details")),
                      )
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
