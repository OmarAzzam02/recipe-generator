
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
        title: Text(
          "Bookmarked Recipes",
           style: TextStyle(
             fontWeight: FontWeight.bold,
             fontFamily: WidgetTheme.textFont(),
              fontSize: 32,
            letterSpacing: 1.0,
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
          
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
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
