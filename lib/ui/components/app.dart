import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../pages/list_repo/list_repo.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Application test",
      debugShowCheckedModeBanner: false,
      home: ListRepoPage(),
    );
  }
}
