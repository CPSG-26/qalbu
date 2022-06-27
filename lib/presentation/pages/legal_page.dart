import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class LegalPage extends StatelessWidget {
  static const routeName = 'legal';

  final String title;
  final String content;

  const LegalPage({Key? key, required this.title, required this.content})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: FutureBuilder(
        future: rootBundle.loadString("legal/$content"),
        builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
          if (snapshot.hasData) {
            return Container(
              margin: const EdgeInsets.all(8),
              padding: const EdgeInsets.all(8),
              child: SingleChildScrollView(
                child: MarkdownBody(data: snapshot.data ?? '-'),
              ),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
