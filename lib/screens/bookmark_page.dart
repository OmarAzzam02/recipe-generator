import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:receipe_generator/Services/database_services.dart';
import 'package:receipe_generator/modules/recipes.dart';
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
  "Drinks": []
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

    return "WEEE DONT KNOWWWWWWWWWW";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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

          return  categoryList();
        },
      ),
    );
  }

  void assignData(final recipesInstance) {
    organizedData.forEach((key, value) => value.clear());

    for (int i = 0; i < recipesInstance.length; i++) {
      String cat = determineCategory(recipesInstance[i].data().category);
      Recipe temp = recipesInstance[i].data();
      organizedData[cat]!.add(temp);
    }
  }

  ListView categoryList() {
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
          children: recipes
              .asMap()
              .map((recipeIndex, recipe) => MapEntry(
                    recipeIndex,
                    ListTile(
                      title: Text(recipe.title),
                      subtitle: Text(recipe.instructions),
                    ),
                  ))
              .values
              .toList(),
        );
      },
    );
  }

  void sortByCategory(List recipesInstance) {
    // Clear previous data
    organizedData.forEach((key, value) => value.clear());

    for (var doc in recipesInstance) {
      Recipe temp = doc.data();
      String category = determineCategory(temp.category);
      organizedData[category]!.add(temp);
    }
  }
}
