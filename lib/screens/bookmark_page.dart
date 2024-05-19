
import '/packages/packages_import.dart';

class BookMark extends StatefulWidget {
  const BookMark({super.key});

  @override
  State<BookMark> createState() => _BookMark();
}

final data = {
  "Breakfast": [
    "Item 1 (A)",
    "Item 2 (A)",
    "Item 3 (A)",
  ],
  "Lunch": [
    "Item 1 (B)",
    "Item 2 (B)",
  ],
  "Salad": [
    "Item 1 (C)",
    "Item 2 (C)",
    "Item 3 (C)",
  ],
  "Desserts": [
    "Item 1 (D)",
    "Item 2 (D)",
    "Item 3 (D)",
  ],
  "Soup": [
    "Item 1 (E)",
    "Item 2 (E)",
    "Item 3 (E)",
  ],
  "Drinks": [
    "Item 1 (F)",
    "Item 2 (F)",
    "Item 3 (F)",
  ]
};

//////// Change the code here
class _BookMark extends State<BookMark> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Bookmarked Recipes",
           style: TextStyle(
            color: Color.fromARGB(197, 211, 199, 177),
            fontSize: 22.0,
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.italic,
            letterSpacing: 2.0,
          ),
        ),
      ),
      body: const CategoryList(),
    );
  }
}

class CategoryList extends StatelessWidget {
  const CategoryList({super.key});

  @override
  Widget build(BuildContext context) {
    return categoryList();
  }
}

ListView categoryList() {
  return ListView.builder(
    itemCount: data.length,
    itemBuilder: (context, index) {
      String category = data.keys.elementAt(index); //tables
      List<String> recipes =
          data[category]!; //each recipe is a row in the table

      return ExpansionTile(
        title: Text(
          category,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        children: recipes
            .asMap()
            .map((recipeIndex, recipe) => MapEntry(
                  recipeIndex,
                  ListTile(
                    title: Text(recipe),
                  ),
                ))
            .values
            .toList(),
      );
    },
  );
}
