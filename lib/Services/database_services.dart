import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:receipe_generator/modules/recipes.dart';

// ignore: constant_identifier_names
const String RECIPE_COLLECTION_REF = 'recipes';

class DatabaseService {
  final _firestore = FirebaseFirestore.instance;
    late final CollectionReference<Recipe> _recipeRef; 

  DatabaseService() {
    _recipeRef = _firestore
        .collection(RECIPE_COLLECTION_REF)
        .withConverter<Recipe>(
          fromFirestore: (snapshots, _) => Recipe.fromjson(snapshots.data()!),
          toFirestore: (Recipe, _) => Recipe.tojson(),
        );
  }

      Stream<QuerySnapshot> getRecipes(){
         
         return  _recipeRef.snapshots();
      }


      void addRecipe(Recipe recipe) async {
        _recipeRef.add(recipe);
      }


      




}
