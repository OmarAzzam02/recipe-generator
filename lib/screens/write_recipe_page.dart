import 'package:receipe_generator/packages/packages_import.dart';

//// Mariam add the writing the recipe secrtion here
class WriteRecipe extends StatefulWidget {
  const WriteRecipe({super.key});

  @override
  State<WriteRecipe> createState() => _WriteRecipeState();
}

class _WriteRecipeState extends State<WriteRecipe> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: WidgetTheme.addPagesAppBar(context),// routing line dont play
      body: Container(), // add code here
    );
  }
}
