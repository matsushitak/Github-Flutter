import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:github/model/github.dart';
import 'package:github/widget/card.dart';
import 'package:http/http.dart' as http;

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GitHub',
      theme: ThemeData(
        primaryColor: Colors.black,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var _repositories = List<GitHub>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("GitHub"),
      ),
      body: Container(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(16.0),
              child: TextField(
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.search),
                      hintText: 'Please enter a search repository name.',
                      labelText: "search"),
                  onChanged: (inputString) {
                    if (inputString.length >= 5) {
                      _searchRepositories(inputString).then((repositories) {
                        setState(() {
                          _repositories = repositories;
                        });
                      });
                    }
                  }),
            ),
            Expanded(
              child: ListView.builder(
                itemBuilder: (BuildContext context, int index) {
                  final repository = _repositories[index];
                  return GitHubCard(repository);
                },
                itemCount: _repositories.length,
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<List<GitHub>> _searchRepositories(String searchWord) async {
    final response = await http.get(
        'https://api.github.com/search/repositories?q=' +
            searchWord +
            '&sort=stars&order=desc');
    if (response.statusCode == 200) {
      List<GitHub> list = [];
      Map<String, dynamic> decoded = json.decode(response.body);
      for (var item in decoded['items']) {
        list.add(GitHub.fromJson(item));
      }
      return list;
    } else {
      throw Exception('Fail to search repository');
    }
  }
}
