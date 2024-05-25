import 'package:receipe_generator/API/api_orcastrator.dart';
import 'package:receipe_generator/API/api_response.dart';
import 'package:receipe_generator/screens/generate_recipe_page.dart';
import 'package:receipe_generator/screens/generated_recipe_details_screen.dart';
import '/packages/packages_import.dart';

class ShowOutput extends StatefulWidget {
  final List ingredients;
  const ShowOutput(this.ingredients, {super.key});

  @override
  State<ShowOutput> createState() => _ShowOutputState();
}

class _ShowOutputState extends State<ShowOutput> {
  late List<Map<String, dynamic>> results = [];

  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    getRecipes();
  }

  void getRecipes() async {
    await ConversationOrchestrator.run(ingredients);
    setState(() {
      results = ApiResponse.generatedRecipes;
      isLoading = false;
    });
  }

  Widget displayResult(BuildContext context) {
    if (isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    } else {
      print(results);
      return GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 9 / 16),
        itemCount: results.length,
        itemBuilder: (context, index) {
          return Container(
            child: Card(
              elevation: 2,
              child: Column(
                children: [
                  Image.asset(
                    'assets/images/newrecipe.jpg',
                    width: 200,
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
                            results[index]['category'],
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Container(
                          margin:const  EdgeInsets.only(top: 8),
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
                      results[index]['title'].toString(),
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
                                    builder: (context) =>GeneratedDetails(
                                        results[index], ingredients)));
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
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: WidgetTheme.generatePagesAppBar(context),
      body: Center(
        child: Container(
          child: displayResult(context),
        ),
      ),
    );
  }
}
