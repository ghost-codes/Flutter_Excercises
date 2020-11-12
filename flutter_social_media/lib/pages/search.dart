import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_social_media/util.dart';
import 'package:flutter_social_media/models/models.dart';
import 'package:flutter_social_media/widgets/progress.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  Future<QuerySnapshot> searchResults;
  TextEditingController searchController = TextEditingController();
  handleSearch(String searchQuery) {
    Future<QuerySnapshot> users = usersRef
        .where("displayname", isGreaterThanOrEqualTo: searchQuery)
        .get();
    setState(() {
      searchResults = users;
    });
  }

  clearSearch() {
    searchController.clear();
  }

  buildSearchfield() {
    return AppBar(
      backgroundColor: Colors.white,
      title: TextField(
        controller: searchController,
        style: TextStyle(
          fontSize: 18.0,
        ),
        decoration: InputDecoration(
            filled: true,
            hintStyle: TextStyle(
              fontSize: 18.0,
            ),
            hintText: "Search for user",
            // fillColor: Colors.grey,
            prefixIcon: Icon(
              Icons.account_box,
              size: 28.0,
            ),
            suffix: IconButton(
              icon: Icon(Icons.clear),
              //iconSize: 28.0,
              color: Colors.grey,
              onPressed: () => clearSearch(),
            )),
        onSubmitted: handleSearch,
      ),
    );
  }

  buildNoContent() {
    final Orientation orientation = MediaQuery.of(context).orientation;
    return Container(
      color: Theme.of(context).primaryColor.withOpacity(0.8),
      child: Center(
        child: ListView(
          children: [
            SvgPicture.asset(
              'assets/images/search.svg',
              height: orientation == Orientation.portrait ? 300.00 : 200.00,
            ),
            Text(
              'Find Users',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.w600,
                fontSize: 60.0,
              ),
            ),
          ],
          shrinkWrap: true,
        ),
      ),
    );
  }

  buildSearchResults() {
    return FutureBuilder(
      future: searchResults,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return circularProgressBar(context);
        }
        List<UserResult> searchedFor = [];
        snapshot.data.docs.forEach((doc) {
          Users user = Users.fromDocument(doc);
          UserResult searchResult = UserResult(user);
          searchedFor.add(searchResult);
        });
        return ListView(
          children: searchedFor,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildSearchfield(),
      body: searchResults == null ? buildNoContent() : buildSearchResults(),
    );
  }
}

class UserResult extends StatefulWidget {
  final Users user;

  UserResult(this.user);

  @override
  _UserResultState createState() => _UserResultState();
}

class _UserResultState extends State<UserResult> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).primaryColor.withOpacity(0.8),
      child: Column(
        children: [
          GestureDetector(
            onTap: () => print('tapped'),
            child: ListTile(
              leading: CircleAvatar(
                backgroundImage:
                    CachedNetworkImageProvider(widget.user.photoUrl),
                backgroundColor: Colors.grey,
              ),
              title: Text(
                widget.user.displayname,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              subtitle: Text(
                widget.user.username,
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ),
          Divider(
            height: 2,
            color: Colors.white54,
          )
        ],
      ),
    );
  }
}
