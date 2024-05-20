// ignore_for_file: prefer_const_constructors, library_private_types_in_public_api

import '/packages/packages_import.dart';

class FavPage extends StatefulWidget {
  const FavPage({super.key});

  @override
  _FavPageState createState() => _FavPageState();
}
// add fav code hereeeeeeee

class _FavPageState extends State<FavPage> {
  final List<String> favoriteRecipes = [
    'Spaghetti',
    'Chicken Tikka Masala',
    'Beef Stroganoff',
    'Shawarma',
    'Shrimps',
  ];

  ListView favs() {
    return ListView.builder(
      itemCount: favoriteRecipes.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
              color: Color.fromARGB(255, 209, 192, 139),
            child: ListTile(
              contentPadding: EdgeInsets.all(16.0),
              title: Text(
                favoriteRecipes[index],
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              trailing: Icon(Icons.favorite, color: Colors.red),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Favorites",
          style: TextStyle(
            fontWeight: FontWeight.bold,
             fontFamily: WidgetTheme.textFont(),
              fontSize: 32,
            letterSpacing: 1.0,
          ),
        ),
      ),
      body: favs(),
    );
  }
}
