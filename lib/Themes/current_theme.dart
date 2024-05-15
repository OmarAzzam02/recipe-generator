import 'package:receipe_generator/packages/packages_import.dart';

class ThemeInfo {
  static isDarkMode(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark;
}
