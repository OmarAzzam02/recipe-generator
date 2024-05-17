// ignore_for_file: curly_braces_in_flow_control_structures, prefer_const_constructors

import 'package:google_fonts/google_fonts.dart';
import 'package:receipe_generator/packages/packages_import.dart';

class WidgetTheme {
  // ignore: non_constant_identifier_names
  static IconTheme(BuildContext context) {
    if (ThemeInfo.isDarkMode(context))
      return AppThemes.getDarkTheme().iconTheme;

    return AppThemes.getLighTheme().iconTheme;
  }

  static selectedItem(BuildContext context) {
    if (ThemeInfo.isDarkMode(context))
      return AppThemes.getDarkTheme().iconTheme;

    return AppThemes.getLighTheme().iconTheme;
  }

// Define a static method to return the font family
  static String textFont() {
    return GoogleFonts.montserrat().fontFamily ?? 'montserrat';
  }

  static AppBar addPagesAppBar(BuildContext context) {
    return AppBar(actions: const [
      Icon(
        Icons.notifications,
        size: 25,
       
      ),
    ], centerTitle: true, backgroundColor: const Color.fromARGB(197, 211, 199, 177) ,
    leading: IconButton( 
      icon: Icon(Icons.arrow_back , size: 20,),
      onPressed: () => Navigator.pop(context),
    ),
    
      
      );
  }
}
