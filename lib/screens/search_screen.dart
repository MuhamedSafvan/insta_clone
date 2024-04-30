import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:instagram_clone/screens/profile_screen.dart';
import 'package:instagram_clone/utils/colors.dart';
import 'package:instagram_clone/utils/global_variables.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _searchController = TextEditingController();
  bool _isShowUser = false;
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _searchController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mobileBackgroundColor,
        title: TextFormField(
          controller: _searchController,
          decoration: InputDecoration(labelText: 'Search for a user'),
          onFieldSubmitted: (value) {
            setState(() {
              _isShowUser = true;
            });
          },
        ),
      ),
      body: _isShowUser
          ? FutureBuilder(
              future: FirebaseFirestore.instance
                  .collection('users')
                  .where('username',
                      isGreaterThanOrEqualTo: _searchController.text)
                  .get(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (!snapshot.hasData) {
                  return Center(
                    child: Text('No results found'),
                  );
                }
                return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) => InkWell(
                    onTap: () => Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => ProfileScreen(
                            uid: snapshot.data!.docs[index]['uid']))),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(
                            snapshot.data!.docs[index]['photoUrl']),
                      ),
                      title: Text(snapshot.data!.docs[index]['username']),
                    ),
                  ),
                );
              },
            )
          : FutureBuilder(
              future: FirebaseFirestore.instance.collection('posts').get(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return StaggeredGridView.countBuilder(
                  crossAxisCount: 3,
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Image.network(
                      snapshot.data!.docs[index]['postUrl'],
                      fit: BoxFit.cover,
                    );
                  },
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                  staggeredTileBuilder: (int index) =>
                      MediaQuery.sizeOf(context).width > webScreenSize
                          ? StaggeredTile.count((index % 7 == 0) ? 1 : 1,
                              (index % 7 == 0) ? 1 : 1)
                          : StaggeredTile.count((index % 7 == 0) ? 2 : 1,
                              (index % 7 == 0) ? 2 : 1),
                );
              },
            ),
    );
  }
}
