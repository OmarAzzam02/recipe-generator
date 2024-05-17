// ignore_for_file: library_private_types_in_public_api, use_super_parameters, prefer_const_constructors, sort_child_properties_last

import 'package:receipe_generator/packages/packages_import.dart';
import 'package:receipe_generator/screens/fav_page.dart';
import 'package:receipe_generator/screens/generate_recipe_page.dart';
import 'package:receipe_generator/screens/home_page.dart';
import 'package:receipe_generator/screens/write_recipe_page.dart';

class RecipeApp extends StatefulWidget {
  const RecipeApp({Key? key}) : super(key: key);

  @override
  _RecipeAppState createState() => _RecipeAppState();
}
////////// Touch it and i will kill you
class _RecipeAppState extends State<RecipeApp> {
  var list = ["eggs", "carrots", "oil"];
  bool isDark = false;
  get isDarkMode => isDark;

  @override
  void initState() {
    super.initState();
    //ConversationOrchestrator.run(list);
  } // DONT TOUCH !!!!!! STILL TESTING THE API

  ThemeData lightTheme = ThemeData.light();
  ThemeData darkTheme = ThemeData.dark();

  void toggleTheme(bool value) {
    setState(() {
      isDark = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: Routes.home,
      routes: {
        Routes.home : (context) => Home(isDark: isDark, onThemeToggle: toggleTheme,),
        Routes.write: (context) => WriteRecipe(),
        Routes.generate: (context) => GenerateRecipe(),
        
      },
      theme: _getTheme(),
    
    );
  }

  ThemeData _getTheme() {
    return isDark ? darkTheme : lightTheme;
  }
}

class Home extends StatefulWidget {
  final bool isDark;
  final Function(bool) onThemeToggle;
  bool get isDarkMode => isDark;

  const Home({
    Key? key,
    required this.isDark,
    required this.onThemeToggle,
  }) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    List<Widget> tabs = [
      HomePage(),
      FavPage(),
      BookMark(),
      Add(),
    ];
Color bkgc = Color.fromARGB(255, 210, 207, 202);
    return Scaffold(
      
      backgroundColor: bkgc,
      appBar: _homeAppbar(widget.isDark),
      drawer: _homeDrawer(context, widget.isDark, widget.onThemeToggle),
      bottomNavigationBar: _bottomNavigationBar(context),
      
      body: tabs[_currentIndex],
    );
  }

  BottomNavigationBar _bottomNavigationBar(BuildContext context) {
    List<Map> list = [
      {"title": "home", "icon": Icon(Icons.home)},
      {"title": "favourite", "icon": Icon(Icons.favorite)},
      {"title": "book", "icon": Icon(Icons.book)},
      {"title": "Add", "icon": Icon(Icons.add)},
    ];
    return BottomNavigationBar(
      selectedItemColor: Color.fromARGB(202, 131, 81, 16),
      unselectedItemColor: Colors.black,
      items: list.map((e) {
        return BottomNavigationBarItem(
          icon: e["icon"],
          label: e["title"],
        );
      }).toList(),
      currentIndex: _currentIndex,
      onTap: (value) {
        setState(() {
          _currentIndex = value;
        });
      },
    );
  }
}

AppBar _homeAppbar(bool isDark) {
  return AppBar(
      actions: const [
        Icon(Icons.notifications , size: 25,),
      ],
      centerTitle: true,
      backgroundColor: isDark
          ? Color.fromARGB(197, 211, 199, 177)
          : Color.fromARGB(197, 211, 199, 177));
}

Drawer _homeDrawer(
    BuildContext context, bool isDark, Function(bool) onThemeToggle) {
  return Drawer(
    
    child: ListView(
      children: [
        DrawerHeader(
          child: Text("Setting"),
          decoration: BoxDecoration(
            color: isDark ? Colors.black : Colors.white,
          ),
        ),
        ListTile(
          title: Text(isDark ? "Dark Mode" : "Light Mode"),
          leading: Icon(
            isDark ? Icons.dark_mode : Icons.light_mode,
            color: isDark ? Colors.white : Colors.black,
          ),
          trailing: Switch(
            value: isDark,
            onChanged: (value) => onThemeToggle(value),
          ),
        ),
      ],
    ),
  );
}
