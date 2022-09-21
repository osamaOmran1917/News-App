import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:projects/home/categories/categories.dart';
import 'package:projects/home/home_side_menu.dart';
import 'package:projects/home/news/news_fragment.dart';
import 'package:projects/home/news/search_screen.dart';
import 'package:projects/home/settings/settings.dart';

import '../api/api_manager.dart';
import '../api/model/NewsResponse.dart';
import 'news/news_widget.dart';

String title = 'News App!';

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
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(35))),
          title: Text(
            title,
            textAlign: TextAlign.center,
          ),
          centerTitle: true,
          actions: [
            CurrentWidget == null
                ? Container()
                : IconButton(
                    onPressed: () {
                      Navigator.pushNamed(context, SearchScreen.routeName);
                      /*showSearch(
                          context: context, delegate: NewsSearchDelegate());*/
                    },
                    icon: Icon(
                      Icons.search,
                      size: 36,
                    ),
                  ),
            SizedBox(
              width: 15,
            )
          ],
        ),
        body: CurrentWidget == null
            ? CategoriesFragment(onCategoryClick)
            : CurrentWidget,
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    // CurrentWidget = CategoriesFragment(onCategoryClick);
    CurrentWidget = null;
  }

  Widget? CurrentWidget;

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
    CurrentWidget = null;
    setState(() {});
  }
}

class NewsSearchDelegate extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            showResults(context);
          },
          icon: Icon(Icons.search, size: 30))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.clear),
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return FutureBuilder<NewsResponse>(
      future: ApiManager.getNews(query: query),
      builder: (_, snapShot) {
        if (snapShot.hasError) {
          return Center(child: Text('${snapShot.error.toString()}'));
        } else if (snapShot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        var data = snapShot.data;
        if ('error' == data?.status) {
          return Center(child: Text('${data?.message}'));
        }
        return Expanded(
          child: ListView.builder(
            itemBuilder: (_, index) {
              return NewsWidget((data?.newsList![index])!);
            },
            itemCount: data?.newsList?.length ?? 0,
          ),
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Center(child: Text('Suggestions Here'));
  }
}
