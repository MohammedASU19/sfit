import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chat Page',
      home: ChatPage(),
    );
  }
}

class ChatPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircleAvatar(
                radius: 20,
                backgroundImage: AssetImage('assets/coach_pic.jpg'), // Replace with coach pic
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('Coach', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                Text('Available', style: TextStyle(fontSize: 12)),
              ],
            ),
            Spacer(),
            IconButton(
              icon: Icon(Icons.call),
              onPressed: () {
                // Handle call icon tap
              },
            ),
            IconButton(
              icon: Icon(Icons.video_call),
              onPressed: () {
                // Handle video call icon tap
              },
            ),
          ],
        ),
      ),
      body: Column(
        children: <Widget>[
          Divider(height: 1.0),
          Expanded(
            child: ChatScreen(),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.more_vert),
              onPressed: () {
                // Handle more icon tap
              },
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Type here ...',
                    border: OutlineInputBorder(),
                    suffixIcon: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.send),
                          onPressed: () {
                            // Handle send icon tap
                            // Here, you can implement sending the message
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.mic),
                          onPressed: () {
                            // Handle microphone icon tap
                            // Implement voice recording logic here
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ChatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ChatMessage(
          text: "Let's work on your technique.\nExcited for your progress.",
          isMine: false,
        ),
        Center(
          child: Text(
            'Today',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        ChatMessage(
          text: 'Sure, let\'s schedule',
          isMine: true,
        ),
        ChatMessage(
          text: 'Great session',
          isMine: false,
        ),
      ],
    );
  }
}

class ChatMessage extends StatefulWidget {
  final String text;
  final bool isMine;

  ChatMessage({required this.text, required this.isMine});

  @override
  _ChatMessageState createState() => _ChatMessageState();
}

class _ChatMessageState extends State<ChatMessage> {
  bool isLiked = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: Row(
        mainAxisAlignment: widget.isMine ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              color: widget.isMine ? Colors.pink[100] : Colors.grey[300],
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.text,
                  style: TextStyle(fontSize: 18.0),
                ),
                SizedBox(height: 6.0),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Icon(
                        isLiked ? Icons.favorite : Icons.favorite_border,
                        color: isLiked ? Colors.red : null,
                      ),
                      onPressed: () {
                        setState(() {
                          isLiked = !isLiked;
                        });
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
