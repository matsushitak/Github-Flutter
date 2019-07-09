import 'package:flutter/cupertino.dart';
import 'package:github/github.dart';
import 'package:flutter/material.dart';

class GitHubCard extends StatefulWidget {

  final GitHub github;

  GitHubCard(this.github)

  @override
  State<StatefulWidget> createState() => _GitHubCardState(this.github);
}

class _GitHubCardState extends State<StatefulWidget> {

  final GitHub github;

  _GitHubCardState(this.github)

  @override
  Widget build(BuildContext context) {
    return Card(
        margin: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(12.0),
              child: Text(
                github.fullName,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
              ),
            ),
            github.language != null
                ? Padding(
              padding: EdgeInsets.fromLTRB(12.0, 0.0, 12.0, 12.0),
              child: Text(
                github.language,
                style: TextStyle(
                    fontWeight: FontWeight.bold, fontSize: 12.0),
              ),
            )
                : Container(),
            github.description != null
                ? Padding(
              padding: EdgeInsets.fromLTRB(12.0, 0.0, 12.0, 12.0),
              child: Text(github.description,
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
                  child: Text(github.stargazersCount.toString()),
                ),
                Icon(Icons.remove_red_eye),
                SizedBox(
                  width: 50.0,
                  child: Text(github.watchersCount.toString()),
                ),
                Text("Fork:"),
                SizedBox(
                  width: 50.0,
                  child: Text(github.forksCount.toString()),
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
