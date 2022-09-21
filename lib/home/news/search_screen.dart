import 'package:flutter/material.dart';
import 'package:projects/api/api_manager.dart';
import 'package:projects/home/news/news_widget.dart';

import '../../api/model/NewsResponse.dart';

class SearchScreen extends StatefulWidget {
  static const String routeName = 'Search Screen';

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String query = '';

  List<News> newsList = [];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/background.png'),
              fit: BoxFit.cover),
          color: Colors.white),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(
          children: [
            Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Container(
                  width: double.infinity,
                  height: 80,
                  decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(35),
                          bottomRight: Radius.circular(35))),
                ),
                Container(
                  margin: EdgeInsets.only(left: 40, right: 40, bottom: 10),
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: TextFormField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(40),
                          borderSide: BorderSide.none),
                      fillColor: Colors.white,
                      filled: true,
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(40),
                          borderSide: BorderSide.none),
                      prefixIcon: IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(Icons.clear),
                      ),
                      suffixIcon: IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.search),
                      ),
                    ),
                    onChanged: (String? value) {
                      setState(() {
                        query = value!;
                      });
                    },
                    /*onFieldSubmitted: (String? value) {
                      setState(() {
                        query = value!;
                      });
                    },*/
                  ),
                ),
              ],
            ),
            Expanded(
              child: ListView.builder(
                itemBuilder: (context, index) {
                  return NewsWidget(search().elementAt(index));
                },
                itemCount: search().length,
              ),
            )
          ],
        ),
      ),
    );
  }

  List search() {
    ApiManager.getNews(query: query).then((newsResponse) {
      newsList = newsResponse.newsList ?? [];
    }).catchError((error) {
      print('Error During Search $error');
    });
    return newsList;
  }
}
