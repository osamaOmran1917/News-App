import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:projects/home/news/news_details_screen.dart';
import 'package:projects/my_date_utils.dart';

import '../../api/model/NewsResponse.dart';

class NewsWidget extends StatelessWidget {
  News news;

  NewsWidget(this.news);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, NewsDetailsScreen.routeName,
            arguments: news);
      },
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(18),
              child: CachedNetworkImage(
                  imageUrl: news.urlToImage ?? '',
                  placeholder: (context, url) =>
                      Center(child: CircularProgressIndicator()),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                  height: 230,
                  width: double.infinity,
                  fit: BoxFit.cover),
            ),
            Text(news.author ?? '',
                style: TextStyle(color: Color(0xFF79828B), fontSize: 12)),
            Text(news.title ?? '',
                style: TextStyle(
                    color: Color(0xFF42505C),
                    fontSize: 18,
                    fontWeight: FontWeight.w500)),
            Text(
              MyDateUtils.formatNewsDate(news.publishedAt ?? ''),
              textAlign: TextAlign.end,
            ),
          ],
        ),
      ),
    );
  }
}
