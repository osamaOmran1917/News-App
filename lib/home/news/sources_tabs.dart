import 'package:flutter/material.dart';
import 'package:projects/home/news/news_list.dart';
import 'package:projects/home/news/source_tab.dart';

import '../../api/model/SourcesResponse.dart';

class SourcesTabs extends StatefulWidget {
  List<Source> sources;

  SourcesTabs(this.sources);

  @override
  State<SourcesTabs> createState() => _SourcesTabsState();
}

class _SourcesTabsState extends State<SourcesTabs> {
  int selectedTab = 0;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: DefaultTabController(
          length: widget.sources.length,
          child: Column(
            children: [
              TabBar(
                tabs: widget.sources.map((source) {
                  var isSelected =
                      widget.sources.indexOf(source) == selectedTab;
                  return SourceTab(source, isSelected);
                }).toList(),
                isScrollable: true,
                indicatorColor: Colors.transparent,
                onTap: (index) {
                  selectedTab = index;
                  setState(() {});
                },
              ),
              NewsList(widget.sources[selectedTab])
            ],
          )),
    );
  }
}
