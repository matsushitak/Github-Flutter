import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:github/model/github.dart';

class GitHubCard extends StatefulWidget {
  final GitHub github;

  GitHubCard(this.github);

  @override
  State<StatefulWidget> createState() => _GitHubCardState();
}

class _GitHubCardState extends State<GitHubCard> {
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
                widget.github.fullName,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
              ),
            ),
            widget.github.language != null
                ? Padding(
                    padding: EdgeInsets.fromLTRB(12.0, 0.0, 12.0, 12.0),
                    child: Text(
                      widget.github.language,
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 12.0),
                    ),
                  )
                : Container(),
            widget.github.description != null
                ? Padding(
                    padding: EdgeInsets.fromLTRB(12.0, 0.0, 12.0, 12.0),
                    child: Text(widget.github.description,
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
                  child: Text(widget.github.stargazersCount.toString()),
                ),
                Icon(Icons.remove_red_eye),
                SizedBox(
                  width: 50.0,
                  child: Text(widget.github.watchersCount.toString()),
                ),
                Text("Fork:"),
                SizedBox(
                  width: 50.0,
                  child: Text(widget.github.forksCount.toString()),
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
