import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

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
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 24, 24, 24),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle:
            false, // Change this to false to align the title to the start
        title: Center(
          child: Row(
            mainAxisSize:
                MainAxisSize.min, // Constrain the Row's size to its children
            mainAxisAlignment:
                MainAxisAlignment.center, // Center the children in the Row

            children: [
              Image.asset(
                "assets/icon/960x960.png", // Path to your logo asset
                height: 20, // Set a suitable height for the logo
              ),
              SizedBox(width: 10),
              const Text(
                'Community',
                style: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
              ),
            ],
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 24, 24, 24),
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

class PostItem extends StatefulWidget {
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
  _PostItemState createState() => _PostItemState();
}

class _PostItemState extends State<PostItem> {
  bool isFavorited = false; // Initial state of the heart icon
  bool isExpanded = false; // State to track if comments are expanded
  List<String> comments = []; // List to store comments

  void _handleFavorite() {
    setState(() {
      isFavorited = !isFavorited; // Toggle the favorite state
    });
    Fluttertoast.showToast(msg: "You Favorite");
  }

  void _handleComment() async {
    final String? newComment = await _showCommentDialog();
    if (newComment != null && newComment.isNotEmpty) {
      setState(() {
        comments.add(newComment); // Add new comment to the list
        isExpanded = true; // Automatically expand to show the new comment
      });
      Fluttertoast.showToast(msg: "Comment added");
    }
  }

  Future<String?> _showCommentDialog() {
    TextEditingController commentController = TextEditingController();
    return showDialog<String>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Add a Comment"),
          content: TextField(
            controller: commentController,
            decoration: InputDecoration(hintText: "Type your comment here"),
          ),
          actions: [
            TextButton(
              child: Text("Cancel"),
              onPressed: () => Navigator.pop(context),
            ),
            TextButton(
              child: Text("Add"),
              onPressed: () {
                Navigator.pop(context, commentController.text);
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey[900],
      margin: const EdgeInsets.all(8),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: Colors.deepOrange,
                  child: Text(widget.username[0],
                      style: const TextStyle(color: Colors.black)),
                ),
                SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'SomeOne',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                      Text(
                        widget.date,
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 8),
            Text(
              widget.content,
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(height: 8),
            if (isExpanded && comments.isNotEmpty)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: comments
                    .map((c) => Text("comment $c",
                        style: TextStyle(
                            color: const Color.fromARGB(255, 148, 148, 148))))
                    .toList(),
              ),
            if (comments.length > 1 && !isExpanded)
              TextButton(
                onPressed: () => setState(() => isExpanded = !isExpanded),
                child: Text(
                  "View all comments (${comments.length})",
                  style: TextStyle(color: Colors.blue),
                ),
              ),
            Divider(color: Colors.grey),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  onTap: _handleFavorite,
                  child: Icon(
                    isFavorited ? Icons.favorite : Icons.favorite_border,
                    color: isFavorited ? Colors.red : Colors.white,
                  ),
                ),
                GestureDetector(
                  onTap: _handleComment,
                  child: Icon(Icons.comment, color: Colors.white),
                ),
                /* GestureDetector(
                  onTap: () => Fluttertoast.showToast(msg: "You Share"),
                  child: Icon(Icons.share, color: Colors.white),
                ), */
              ],
            ),
          ],
        ),
      ),
    );
  }
}
