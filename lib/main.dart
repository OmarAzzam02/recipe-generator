
import 'package:firebase_core/firebase_core.dart';
import 'package:receipe_generator/screens/splashscreen.dart';
import 'firebase_options.dart';  
import '/packages/packages_import.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();  // Ensure that this is called

  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    runApp(const RecipeApp());
  } catch (e) {
   
    print('Firebase initialization failed: $e');
  }
}
