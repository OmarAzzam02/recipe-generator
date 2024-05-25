// ignore_for_file: library_private_types_in_public_api, prefer_const_literals_to_create_immutables, prefer_const_constructors, sort_child_properties_last

import '/packages/packages_import.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}


class _HomePageState extends State<HomePage> {
  List<Map> cardItems = [
    {"title": "assets/images/egg.png"},
    {"title": "assets/images/salad.png"},
    {"title": "assets/images/pizza.png"},
    {"title": "assets/images/cake.png"},
  ];

  List<String> slideItems = [
    'assets/images/slide-1.png',
    'assets/images/slide-2.png',
    'assets/images/slide-3.png',
    'assets/images/slide-4.png',
    'assets/images/slide-5.png',
    'assets/images/slide-6.png',
  ];
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  'assets/images/backimage.png',
                ),
                fit: BoxFit.fill,
                colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.47),
                  BlendMode.dstATop,
                ),
              ),
            ),
            height: 300,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Generate Your Own \n Master Recipe",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 35,
                        fontWeight: FontWeight.bold,
                        fontFamily: WidgetTheme.textFont(),
                        color: Colors.brown,
                        letterSpacing: 2,
                      ),
                    ),
                    Text(
                      " \n generate with the ingrediants you have",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontFamily: WidgetTheme.textFont(),
                          fontSize: 15,
                          fontWeight: FontWeight.w900),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 20),
                      child: ElevatedButton(
                        onPressed: () {},
                        child: Text(
                          "Generate Your Own Recipe",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 255, 255, 255),
                            fontFamily: WidgetTheme.textFont(),
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          shape: BeveledRectangleBorder(),
                          backgroundColor: Color.fromARGB(197, 211, 199, 177),
                          padding: EdgeInsets.only(right: 90, left: 90),
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      child: Text(
                        "Write Your Own Recipe",
                        style: TextStyle(
                          color: Color.fromARGB(255, 255, 255, 255),
                          fontFamily: WidgetTheme.textFont(),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                          shape: BeveledRectangleBorder(),
                          backgroundColor: Color.fromARGB(197, 211, 199, 177),
                          padding: EdgeInsets.only(right: 102, left: 102)),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            height: 150,
            margin: EdgeInsets.only(top: 12, bottom: 12),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: cardItems.length,
              itemBuilder: (context, index) {
                final item = cardItems[index];
                return SizedBox(
                  width: 200,
                  height: double.infinity,
                  child: Card(
                    color: Color.fromARGB(255, 212, 203, 177),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          item["title"]!,
                          fit: BoxFit.fill,
                          height: 100,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          ImageSlideshow(
            onPageChanged: (value) {},
            autoPlayInterval: 3000,
            isLoop: true,
            indicatorBackgroundColor: Colors.grey[400],
            indicatorColor: Colors.black,
            children: slideItems.map((e) {
              return Card(
                color: Color.fromARGB(255, 214, 185, 131),
                child: Image.asset(
                  e,
                  fit: BoxFit.fill,
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
