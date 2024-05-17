import 'package:receipe_generator/packages/packages_import.dart';

class GenerateRecipe extends StatefulWidget {
  const GenerateRecipe({super.key});

  @override
  State<GenerateRecipe> createState() => _GenerateRecipeState();
}

final RoundedLoadingButtonController submit = RoundedLoadingButtonController();

List<String> ingredients = [];

class _GenerateRecipeState extends State<GenerateRecipe> {
  TextEditingController ingController = TextEditingController();

  Padding ingInputFeild() {
    return Padding(
        padding: EdgeInsets.all(10),
        child: TextField(
            expands: false,
            controller: ingController,
            decoration: InputDecoration(
              hintStyle: TextStyle(
                fontSize: 15,
                fontStyle: FontStyle.italic,
              ),
              hintText: 'Add your ingredients here',
              icon: Icon(Icons.search),
            )));
  }

  OutlinedButton addButton() {
    return OutlinedButton(
        child: Text('ADD',
            selectionColor: Color.fromARGB(255, 19, 5, 4),
            style: TextStyle(fontStyle: FontStyle.italic)),
        style: OutlinedButton.styleFrom(
          textStyle: TextStyle(
            fontSize: 15,
            fontStyle: FontStyle.italic,
          ),
          foregroundColor: Colors.black,
        ),
        onPressed: () {
            setState(() {
              ingredients.add(ingController.text);
              ingController.clear();
            });
        });
  }

Expanded showAddedIngList() {
    return Expanded(
      child: ListView.builder(
        itemCount: ingredients.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(ingredients[index]),
            trailing: IconButton(
              icon: Icon(Icons.delete,),
              onPressed: () {
                setState(() {
                  ingredients.removeAt(index);
                });
              },
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: WidgetTheme.addPagesAppBar(context),//routing line dont play 
      body: Column(children: [
        titleSubtitle(),
        ingInputFeild(),
        addButton(),
        addedIngList(),
        showAddedIngList(),
        create(),
      ]),
    );
  }
}


Padding titleSubtitle() {
  return Padding(
    padding: EdgeInsets.all(10),
    child: RichText(
        text: TextSpan(
            style: TextStyle(
              color: Colors.black,
              fontSize: 24.0,
            ),
            children: [
          TextSpan(
            text: 'What is in your kitchen?\n',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          TextSpan(
            text: 'Enter some ingredients to start cooking!',
            style: TextStyle(
              fontStyle: FontStyle.italic,
              fontSize: 13.0,
            ),
          ),
        ])),
  );
}

Padding addedIngList() {
  return Padding(
    padding: EdgeInsets.all(10),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          'Submitted Ingredients',
          style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
        ),
      ],
    ),
  );
}

RoundedLoadingButton create() {
  return RoundedLoadingButton(
    color: const Color.fromARGB(255, 207, 165, 165),
    successIcon: Icons.done,
    successColor: Color.fromARGB(255, 61, 24, 22),
    failedIcon: Icons.error,
    child: Text('Generate ^_^', style: TextStyle(color: Colors.white)),
    controller: submit,
    onPressed: () {
      Timer(Duration(seconds: 3), () {
        if (ingredients.length >= 3)
          submit.success();
        else {
          submit.error();
          Text("Please enter atleast 3 food items...");
        }
      });
    },
  );
}
