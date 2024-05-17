import 'package:receipe_generator/packages/packages_import.dart';

class GenerateRecipe extends StatefulWidget {
  const GenerateRecipe({super.key});

  @override
  State<GenerateRecipe> createState() => _GenerateRecipeState();
}

class _GenerateRecipeState extends State<GenerateRecipe> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: WidgetTheme.addPagesAppBar(context),//routing line dont play 
      body: Container(),
    );
  }
}
