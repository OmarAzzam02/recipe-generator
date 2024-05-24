class Recipe {
  final String title;
  final String ingrediants;
  final String instructions;
  final String category;
  bool? favState;

  Recipe(
      {required this.title,
      required this.instructions,
      required this.category,
      required this.favState,
      required this.ingrediants});

  set setFavourite(bool status) => favState = status;

  get getTitle => title;
  get getInstruction => instructions;
  get getCategory => category;
  get isFavourite => favState;

  Recipe.fromjson(Map<String, Object?> json)
      : this(
          title: json['title']! as String,
          ingrediants: json['ingrediants'] as String,
          instructions: json['instructions']! as String,
          category: json['category']! as String,
          favState: json['favState']! as bool,
        );

  Map<String, Object?> tojson() {
    return {
      'title': title,
      'ingrediants': ingrediants,
      'instructions': instructions,
      'category': category,
      'favState': favState
    };
  }
}
