
import 'package:flutter/material.dart';
import 'package:nightmodeexample/prefs/style.dart';
import 'package:nightmodeexample/prefs/themeprovider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool switchValue = false;
  ThemeProvider themeProvider = ThemeProvider();

  void getCurrentTheme() async {
    themeProvider.darkTheme = await themeProvider.preference.getTheme();
  }

  @override
  void initState() {
    getCurrentTheme();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => themeProvider,
      child: Consumer<ThemeProvider>(
        builder: (context, value, child){
          return MaterialApp(
            theme: Style.themeData(themeProvider.darkTheme),
            home: Scaffold(
              appBar: AppBar(
                title: Text(
                    'Toggle DarkTheme'
                ),
              ),
              body: Center(
                child: Switch(
                  value: switchValue,
                  onChanged: (val){
                    themeProvider.darkTheme = !themeProvider.darkTheme;
                    setState(() {
                      switchValue = val;
                    });
                  },
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}