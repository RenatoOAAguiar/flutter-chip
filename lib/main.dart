import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tag/providers/tags.dart';
import 'package:tag/screens/tags_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (ctx) => Tags()),
      ],
      child: MaterialApp(
        title: 'Flutter Tags',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          primaryColor: Colors.green,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: TagsScreen(),
      ),
    );
  }
}
