// ignore_for_file: curly_braces_in_flow_control_structures

import 'package:google_fonts/google_fonts.dart';
import 'package:receipe_generator/packages/packages_import.dart';

class WidgetTheme {
  static IconTheme(BuildContext context) {
    if (ThemeInfo.isDarkMode(context))
      return AppThemes.getDarkTheme().iconTheme;

    return AppThemes.getLighTheme().iconTheme;
  }

 static  selectedItem(BuildContext context){
     if (ThemeInfo.isDarkMode(context))
      return AppThemes.getDarkTheme().iconTheme;

    return AppThemes.getLighTheme().iconTheme;
 }



// Define a static method to return the font family
static String textFont() {
  return GoogleFonts.laila().fontFamily ?? 'Arial';
}
}




