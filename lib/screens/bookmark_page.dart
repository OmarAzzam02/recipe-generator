// ignore_for_file: prefer_const_constructors

import '/packages/packages_import.dart';


class BookMark extends StatefulWidget {
  @override
  State<BookMark> createState() => _BookMark();
}
//////// Change the code here
class _BookMark extends State<BookMark> {

  final data = {
    "Favorites": [
      "Item 1 (F)",
      "Item 2 (F)",
      "Item 3 (F)",
      "Item 4 (F)",
      "Item 5 (F)",
    ],
    "Breakfast": [
      "Item 1 (A)",
      "Item 2 (A)",
      "Item 3 (A)",
      "Item 4 (A)",
    ],
    "Lunch": [
      "Item 1 (B)",
      "Item 2 (B)",
    ],
    "Salad": [
      "Item 1 (C)",
      "Item 2 (C)",
      "Item 3 (C)",
      "Item 4 (C)",
      "Item 5 (C)",
    ],
    "Desserts": [
      "Item 1 (D)",
      "Item 2 (D)",
      "Item 3 (D)",
      "Item 4 (D)",
      "Item 5 (D)",
    ],
    "Soup": [
      "Item 1 (E)",
      "Item 2 (E)",
      "Item 3 (E)",
      "Item 4 (E)",
      "Item 5 (E)",
    ],
    "Drinks": [
      "Item 1 (F)",
      "Item 2 (F)",
      "Item 3 (F)",
      "Item 4 (F)",
      "Item 5 (F)",
    ]
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Book Marked resipes",
          style: TextStyle(
            color: Color.fromARGB(255, 224, 86, 86), // Change the text color
            fontSize: 20.0, // Change the font size
            fontWeight: FontWeight.bold, // Change the font weight
            fontStyle: FontStyle.italic, // Change the font style
            letterSpacing: 2.0, // Change the letter spacing
          ),
        ),
      ),
      body: ScrollableListTabScroller(
        itemCount: data.length,
        tabBuilder: (BuildContext context, int index, bool active) => Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            data.keys.elementAt(index),
            style: !active
                ? null
                : TextStyle(fontWeight: FontWeight.bold, color: Color.fromARGB(255, 212, 109, 109)),
          ),
        ),
        itemBuilder: (BuildContext context, int index) => Column(
          children: [
            Text(
              data.keys.elementAt(index),
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            ...data.values
                .elementAt(index)
                .asMap()
                .map(
                  (index, value) => MapEntry(
                    index,
                    ListTile(
                      leading: Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle, color: Color.fromARGB(255, 156, 212, 216)),
                        alignment: Alignment.center,
                        child: Text(index.toString()),
                      ),
                      title: Text(value),
                    ),
                  ),
                )
                .values
          ],
        ),
      ),
    );
  }
}
