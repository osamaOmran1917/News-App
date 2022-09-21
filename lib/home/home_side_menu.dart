import 'package:flutter/material.dart';
import 'package:projects/home/home_screen.dart';

class HomeSideMenu extends StatelessWidget {
  static const int settings = 10;
  static const int categories = 20;
  Function onItemClickCallBack;

  HomeSideMenu(this.onItemClickCallBack);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(vertical: 64),
          color: Theme.of(context).primaryColor,
          child: Text(
            'News App!',
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 24),
          ),
        ),
        InkWell(
          onTap: () {
            onItemClickCallBack(categories);
            title = 'News App!';
          },
          child: Row(children: [
            ImageIcon(
              AssetImage('assets/images/ic_categories.png'),
              size: 48,
            ),
            Text(
              'Categories',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            )
          ]),
        ),
        InkWell(
          onTap: () {
            onItemClickCallBack(settings);
          },
          child: Row(children: [
            SizedBox(
              width: 6,
            ),
            Icon(
              Icons.settings,
              size: 36,
            ),
            SizedBox(
              width: 2,
            ),
            Text(
              'Settings',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            )
          ]),
        )
      ],
    );
  }
}
