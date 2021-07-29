import 'package:dev_tools/ui/pages/list_menu/list_menu_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../pages/pages.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Application test",
      debugShowCheckedModeBanner: false,
      home: ListMenuPage(),
    );
  }
}
