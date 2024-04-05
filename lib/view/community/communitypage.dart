import 'package:flutter/material.dart';

class CommunityPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CommunityBlockPage();
  }
}

class CommunityBlockPage extends StatelessWidget {
  final List<String> posts = [
    "First post content goes here. This is a mock post.",
    "Second post content can be seen here. Another mock post.",
    "Here's a third post with some more mock content.",
    // You can add more posts as needed.
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // Scaffold's background color is black
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(
          'Community',
          style: TextStyle(
              color: Colors.white), // AppBar title text color is white
        ),
        backgroundColor: Colors.black, // AppBar background color is black
      ),
      body: ListView.builder(
        itemCount: posts.length,
        itemBuilder: (context, index) {
          return PostItem(
            username: "@username",
            content: posts[index],
            date: "Mar 22",
          );
        },
      ),
    );
  }
}

class PostItem extends StatelessWidget {
  final String username;
  final String content;
  final String date;

  const PostItem({
    Key? key,
    required this.username,
    required this.content,
    required this.date,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey[900], // Card widget background color is a dark shade
      margin: EdgeInsets.all(8),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: Colors.deepOrange,
                  child: Text(username[0],
                      style: TextStyle(
                          color: Colors
                              .black)), // First letter of the username for the avatar
                ),
                SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'SomeOne',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color:
                                Colors.white), // Username text color is white
                      ),
                      Text(
                        date,
                        style: TextStyle(
                            color: Colors.grey), // Date text color is grey
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 8),
            Text(
              content,
              style: TextStyle(
                  color: Colors.white), // Post content text color is white
            ),
            SizedBox(height: 8),
            Divider(color: Colors.grey), // Divider color is grey
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Icon(Icons.favorite_border, color: Colors.white),
                Icon(Icons.comment, color: Colors.white),
                Icon(Icons.share, color: Colors.white),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
