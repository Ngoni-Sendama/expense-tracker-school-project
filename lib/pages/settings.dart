import 'package:flutter/material.dart';  // Add this import

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _isDarkMode = false;

  void _toggleTheme() {
    setState(() {
      _isDarkMode = !_isDarkMode;
      // Update the app theme
      final ThemeMode newThemeMode = _isDarkMode ? ThemeMode.dark : ThemeMode.light;
      ThemeProvider.of(context)?.updateThemeMode(newThemeMode);
    });
  }

  @override
  void initState() {
    super.initState();
    // Initialize the dark mode value based on current theme
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _isDarkMode = Theme.of(context).brightness == Brightness.dark;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Appearance',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 16),
            SwitchListTile(
              title: Text('Dark Mode'),
              subtitle: Text(_isDarkMode ? 'Currently using dark theme' : 'Currently using light theme'),
              value: _isDarkMode,
              onChanged: (value) {
                _toggleTheme();
              },
              secondary: Icon(_isDarkMode ? Icons.dark_mode : Icons.light_mode),
            ),
          ],
        ),
      ),
    );
  }
}

// You'll need to add this ThemeProvider class to your app
class ThemeProvider extends InheritedWidget {
  final ThemeMode themeMode;
  final Function(ThemeMode) updateThemeMode;

  ThemeProvider({
    required this.themeMode,
    required this.updateThemeMode,
    required Widget child,
  }) : super(child: child);

  static ThemeProvider? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<ThemeProvider>();
  }

  @override
  bool updateShouldNotify(ThemeProvider oldWidget) {
    return themeMode != oldWidget.themeMode;
  }
}
