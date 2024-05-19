// ignore_for_file: avoid_print

class ApiResponse {
  static late List<Map<String, dynamic>> _recipes;

  static get generatedRecipes => _recipes;

  static setResponse(var response) {
    _recipes = formatRecipes(response);
    print(_recipes[1]['category']);
  }

}

List<Map<String, dynamic>> formatRecipes(String str) {
  List<Map<String, dynamic>> recipes = [];

  // Split the string into individual recipe strings
  List<String> recipeStrings = str.split(RegExp(r'\d+\.'));

  // Remove any empty strings resulting from the split
  recipeStrings.removeWhere((element) => element.trim().isEmpty);

  // Iterate over each recipe string to extract title, instructions, and category
  for (var recipeString in recipeStrings) {
    // Extract title
    String title = RegExp(r'([^\n]+)').stringMatch(recipeString)?.trim() ?? '';

    // Extract instructions
    List<String> instructions = recipeString
        .split('\n')
        .where((line) => line.trim().isNotEmpty && !line.contains('Category'))
        .map((line) => line.trim())
        .toList();

    // Extract category
    String category = RegExp(r'Category:\s*([^\n]+)')
            .stringMatch(recipeString)
            ?.split(':')[1]
            .trim() ??
        '';

    // Add the formatted recipe to the recipes list
    recipes.add(
        {'title': title, 'instructions': instructions, 'category': category});
  }

  return recipes;
}
