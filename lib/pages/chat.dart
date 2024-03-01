// import 'dart:io';
import 'package:flutter/material.dart';
// import 'package:path_provider/path_provider.dart';
import 'package:get_to_know_thiana/style/theme.dart';
import 'package:get_to_know_thiana/services/openAI.dart'; 

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  bool _isDarkMode = false; 
  late TextEditingController _messageController;
  List<String> _chatHistory = [];
  final FirestoreService _firestoreService = FirestoreService(); 

  @override
  void initState() {
    super.initState();
    _messageController = TextEditingController();
  }

  Future<void> _sendMessage() async {
    final userMessage = _messageController.text;
    final response = await _firestoreService.fetchAnswerFromFirestore(userMessage); 

    setState(() {
      _chatHistory.add('You: $userMessage');
      if (response != null) {
        _chatHistory.add('AI: $response');
      } else {
        _chatHistory.add('AI: Sorry, I do not have the answer to this question');
      }
      _messageController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    final MaterialTheme materialTheme = MaterialTheme(ThemeData.light().textTheme);
    var theme = _isDarkMode ? materialTheme.dark() : materialTheme.light();

    return MaterialApp(
      theme: theme,
      darkTheme: materialTheme.dark(),
      home: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            AppBar(
              leading: Padding(
                padding: const EdgeInsets.only(left: 20, top: 5),
                child: Image.asset(
                  'assets/logo.png',
                  width: 110,
                  height: 110,
                ),
              ),
              actions: [
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.file_upload_outlined, 
                    color: theme.colorScheme.primary,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    setState(() {
                      _isDarkMode = !_isDarkMode;
                    });
                  },
                  icon: Icon(
                    _isDarkMode ? Icons.light_mode : Icons.dark_mode,
                    color: theme.colorScheme.primary,
                  ),
                ),
              ],
            ),
            const Divider(
              height: 0,
              thickness: 1,
              color: Colors.grey,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _chatHistory.length,
                itemBuilder: (context, index) {
                  if (_chatHistory[index].startsWith('AI:')) {
                    return Container(
                      color: _isDarkMode ? Colors.grey.shade800 : Colors.grey.shade200, 
                      padding: EdgeInsets.all(8),
                      margin: EdgeInsets.symmetric(vertical: 4, horizontal: 16),
                      child: Text(
                        _chatHistory[index],
                        style: TextStyle(color: _isDarkMode ? Colors.white : Colors.black), 
                      ),
                    );
                  } else {
                    return ListTile(
                      title: Text(_chatHistory[index]),
                    );
                  }
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: TextField(
                controller: _messageController,
                decoration: InputDecoration(
                  hintText: 'Message Open AI...',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  suffixIcon: IconButton(
                    onPressed: _sendMessage,
                    icon: const Icon(Icons.send_rounded),
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
