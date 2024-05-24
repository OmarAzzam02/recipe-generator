import 'package:receipe_generator/screens/show_output.dart';

import '/packages/packages_import.dart';

class GenerateRecipe extends StatefulWidget {
  const GenerateRecipe({super.key});

  @override
  State<GenerateRecipe> createState() => _GenerateRecipeState();
}

final RoundedLoadingButtonController submit = RoundedLoadingButtonController();

List<String> ingredients = [];

class _GenerateRecipeState extends State<GenerateRecipe> {
  TextEditingController ingController = TextEditingController();
  bool isInputEmpty = false;

  Padding ingInputField() {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: TextField(
        controller: ingController,
        decoration: InputDecoration(
          hintStyle: const TextStyle(
            fontSize: 15,
            fontStyle: FontStyle.italic,
          ),
          hintText: 'Add your ingredients here',
          icon: const Icon(Icons.search),
          errorText: isInputEmpty ? 'Ingredient cannot be empty' : null,
          errorBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red),
          ),
          focusedErrorBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red),
          ),
        ),
      ),
    );
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
          if (ingController.text.trim().isEmpty) {
            isInputEmpty = true;
          } else {
            ingredients.add(ingController.text.trim());
            ingController.clear();
            isInputEmpty = false;
          }
        });
      },
      child: const Text(
        'ADD',
        style: TextStyle(fontStyle: FontStyle.italic),
      ),
    );
  }

  Expanded showAddedIngList() {
    return Expanded(
      child: ListView.builder(
        itemCount: ingredients.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(ingredients[index]),
            trailing: IconButton(
              icon: const Icon(Icons.delete),
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

   void navigateToShowResults (BuildContext context){

       Navigator.push(context, MaterialPageRoute(builder: (context) => ShowOutput(ingredients)  ));
   }

  Container create() {
    return Container(
      margin: const EdgeInsets.only(bottom: 25),
      child: RoundedLoadingButton(
        color: const Color.fromARGB(255, 207, 165, 165),
        successIcon: Icons.done,
        successColor: Colors.green,
        failedIcon: Icons.error,
        controller: submit,
        onPressed: () {
          Future.delayed(const Duration(seconds: 3), () {
            if (ingredients.length >= 3) {
              submit.success();
              Future.delayed(const Duration(seconds: 1), () {
                 setState(() {
                 navigateToShowResults(context);
              });
              });
             
            } else {
              submit.error();
            }
          });
          Future.delayed(const Duration(seconds: 5), () {
            submit.reset();
          });
        },
        child: const Text('Generate',
            textAlign: TextAlign.center, style: TextStyle(color: Colors.white)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: WidgetTheme.generatePagesAppBar(context),
      body: Column(
        children: [
          titleSubtitle(),
          ingInputField(),
          addButton(),
          addedIngList(),
          showAddedIngList(),
          create(),
        ],
      ),
    );
  }
}

Padding titleSubtitle() {
  return Padding(
    padding: const EdgeInsets.all(10),
    child: RichText(
      text: const TextSpan(
        style: TextStyle(color: Colors.black, fontSize: 24.0),
        children: [
          TextSpan(
            text: 'What is in your kitchen?\n',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          TextSpan(
            text: 'Enter some ingredients to start cooking!',
            style: TextStyle(fontStyle: FontStyle.italic, fontSize: 13.0),
          ),
        ],
      ),
    ),
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
