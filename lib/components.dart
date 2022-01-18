import 'package:flutter/material.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:news_app/screens/web_view_screen.dart';

Widget buildArticleItem(article, context) => InkWell(
      onTap: () {
        navigateTo(context, WebViewScreen(article, url: article['url']));
      },
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Row(
          children: [
            Container(
              height: 120,
              width: 120,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  image: DecorationImage(
                      image: NetworkImage('${article['urlToImage']}'),
                      fit: BoxFit.cover)),
            ),
            const SizedBox(width: 20.0),
            Expanded(
              child: SizedBox(
                height: 120,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        '${article['title']}',
                        style: const TextStyle(
                          fontSize: 15.0,
                          fontWeight: FontWeight.w600,
                        ),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Text('${article['publishedAt']}',
                        style: const TextStyle(color: Colors.grey)),
                    ConditionalBuilder(
                      condition: article['author'] != null,
                      builder: (context) => Text('${article['author']}',
                          style: const TextStyle(
                              color: Colors.grey, fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );

Widget articleBuilder(list, {isSearch = false}) => ConditionalBuilder(
      condition: list.isNotEmpty,
      builder: (context) => ListView.separated(
          itemBuilder: (context, index) =>
              buildArticleItem(list[index], context),
          separatorBuilder: (context, index) => myDivider(),
          itemCount: list.length),
      fallback: (context) => isSearch
          ? const Center(
              child: Text(
              'Enter Text To Search',
              style: TextStyle(color: Colors.grey),
            ))
          : const Center(child: CircularProgressIndicator()),
    );

Widget myDivider() => Padding(
      padding: const EdgeInsets.only(right: 10.0, left: 10.0),
      child: Container(
        height: 1.0,
        width: double.infinity,
        color: Colors.brown,
      ),
    );

navigateTo(context, widget) {
  return Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => widget),
  );
}
