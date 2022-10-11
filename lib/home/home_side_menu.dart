import 'package:flutter/material.dart';
import 'package:projects/home/home_screen.dart';

enum SideMenuItems {
  Settings,
  Categories
}

class HomeSideMenu extends StatelessWidget {
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
            onItemClickCallBack(SideMenuItems.Categories);
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
            onItemClickCallBack(SideMenuItems.Settings);
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
