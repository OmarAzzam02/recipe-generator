// ignore_for_file: curly_braces_in_flow_control_structures

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
        padding: const EdgeInsets.all(10),
        child: TextField(
            expands: false,
            controller: ingController,
            decoration: const InputDecoration(
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
        style: OutlinedButton.styleFrom(
          textStyle: const TextStyle(
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
        },
        child: const Text('ADD',
            selectionColor: Color.fromARGB(255, 19, 5, 4),
            style: TextStyle(fontStyle: FontStyle.italic)));
  }

  Expanded showAddedIngList() {
    return Expanded(
      child: ListView.builder(
        itemCount: ingredients.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(ingredients[index]),
            trailing: IconButton(
              icon: const Icon(
                Icons.delete,
              ),
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
      appBar: WidgetTheme.addPagesAppBar(context), //routing line dont play
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
    padding: const EdgeInsets.all(10),
    child: RichText(
        text: const TextSpan(
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
  return const Padding(
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
    successColor: Colors.green,
    failedIcon: Icons.error,
    controller: submit,
    onPressed: () {
      Timer(const Duration(seconds: 3), () {
        if (ingredients.length >= 3)
          submit.success();
        else {
          submit.error();
          const Text("Please enter atleast 3 food items...");
        }
      });
      Timer(const Duration(seconds: 5), () {
        submit.reset();
      });
    },
    child: const Text('Generate ^_^', style: TextStyle(color: Colors.white)),
  );
}
