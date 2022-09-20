import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:projects/home/categories/categories.dart';
import 'package:projects/home/home_side_menu.dart';
import 'package:projects/home/news/news_fragment.dart';
import 'package:projects/home/settings/settings.dart';

String title = 'News App!';
bool isVisible = false;

class HomeScreen extends StatefulWidget {
  static const String routeName = 'home screen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage('assets/images/background.png'))),
      child: Scaffold(
        drawer: Drawer(
          child: HomeSideMenu(onSideMenuItemClick),
        ),
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                  child: Text(
                title,
                textAlign: TextAlign.center,
              )),
              Visibility(visible: isVisible, child: Icon(Icons.search))
            ],
          ),
        ),
        body: CurrentWidget,
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    CurrentWidget = CategoriesFragment(onCategoryClick);
  }

  late Widget CurrentWidget;

  void onCategoryClick(Category category) {
    CurrentWidget = NewsFragment(category);
    setState(() {});
  }

  void onSideMenuItemClick(int type) {
    if (type == HomeSideMenu.categories) {
      CurrentWidget = CategoriesFragment(onCategoryClick);
    } else if (type == HomeSideMenu.settings) {
      CurrentWidget = SettingsFragment();
    }
    Navigator.pop(context);
    setState(() {});
  }
}
