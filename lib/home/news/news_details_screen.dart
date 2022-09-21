import 'package:flutter/material.dart';
import 'package:projects/api/model/NewsResponse.dart';
import 'package:url_launcher/url_launcher.dart';

import '../home_screen.dart';

class NewsDetailsScreen extends StatelessWidget {
  static const String routeName = 'News Details';

  @override
  Widget build(BuildContext context) {
    News news = ModalRoute.of(context)!.settings.arguments as News;

    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/background.png'),
              fit: BoxFit.cover),
          color: Colors.white),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(35))),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                  child: Text(
                'News Details',
                textAlign: TextAlign.center,
              )),
            ],
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                ClipRRect(
                  child: Image.network(news.urlToImage ?? ''),
                  borderRadius: BorderRadius.circular(15),
                ),
                const SizedBox(
                  height: 8,
                ),
                Container(
                  width: double.infinity,
                  child: Text(
                    news.source!.name ?? '',
                    style: TextStyle(
                        fontSize: 12, color: Color.fromRGBO(121, 130, 139, 1)),
                    textAlign: TextAlign.start,
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Container(
                  child: Text(
                    news.title ?? '',
                    style: TextStyle(fontSize: 17),
                    textAlign: TextAlign.start,
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Container(
                  width: double.infinity,
                  child: Text(
                    news.publishedAt ?? '',
                    style: TextStyle(
                        fontSize: 17, color: Color.fromRGBO(121, 130, 139, 1)),
                    textAlign: TextAlign.end,
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20)),
                  child: Column(
                    children: [
                      Text(
                        news.description ?? '',
                        style: TextStyle(fontSize: 14),
                      ),
                      const SizedBox(
                        height: 35,
                      ),
                      InkWell(
                        onTap: () {
                          _launchInBrowser(Uri.parse(news.url ?? ''));
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              'View Full Article',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            Icon(
                              Icons.play_arrow_sharp,
                              size: 20,
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _launchInBrowser(Uri url) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      throw 'Could not launch $url';
    }
  }
}
