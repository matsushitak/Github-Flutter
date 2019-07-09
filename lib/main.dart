import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:github/github.dart';
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
                  return _buildCard(repository);
                },
                itemCount: _repositories.length,
              );,
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

  Widget _buildCard(GitHub repository) {
    return Card(
        margin: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(12.0),
              child: Text(
                repository.fullName,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
              ),
            ),
            repository.language != null
                ? Padding(
              padding: EdgeInsets.fromLTRB(12.0, 0.0, 12.0, 12.0),
              child: Text(
                repository.language,
                style: TextStyle(
                    fontWeight: FontWeight.bold, fontSize: 12.0),
              ),
            )
                : Container(),
            repository.description != null
                ? Padding(
              padding: EdgeInsets.fromLTRB(12.0, 0.0, 12.0, 12.0),
              child: Text(repository.description,
                  style: TextStyle(
                      fontWeight: FontWeight.w200, color: Colors.grey)),
            )
                : Container(),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Icon(Icons.star),
                SizedBox(
                  width: 50.0,
                  child: Text(repository.stargazersCount.toString()),
                ),
                Icon(Icons.remove_red_eye),
                SizedBox(
                  width: 50.0,
                  child: Text(repository.watchersCount.toString()),
                ),
                Text("Fork:"),
                SizedBox(
                  width: 50.0,
                  child: Text(repository.forksCount.toString()),
                ),
              ],
            ),
            SizedBox(
              height: 16.0,
            )
          ],
        ));
  }
}
