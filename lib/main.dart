import '/packages/packages_import.dart';

void main() {
  runApp(MaterialApp(
    home: HomePage(),
  ));
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    BookMarkScreen(),
    NewScreen(),
  ];
  void _handleIndexChanged(int i) {
    setState(() {
      _selectedIndex = i;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: CrystalNavigationBar(
          currentIndex: _selectedIndex,
          height: 50,
          indicatorColor: const Color.fromARGB(0, 175, 104, 104),
          unselectedItemColor: Color.fromARGB(179, 22, 22, 22),
          backgroundColor:
              const Color.fromARGB(255, 133, 53, 53).withOpacity(0.1),
          onTap: _handleIndexChanged,
          items: [

            CrystalNavigationBarItem(
              icon: Icons.home,
              selectedColor: const Color.fromARGB(255, 8, 8, 8),
            ),

            CrystalNavigationBarItem(
              icon: Icons.bookmark,
              selectedColor: const Color.fromARGB(255, 0, 0, 0),
            ),

            CrystalNavigationBarItem(
              icon: Icons.add,
              selectedColor: const Color.fromARGB(255, 0, 0, 0),
            ),
          ],
        ),
      ),
    );
  }
}
