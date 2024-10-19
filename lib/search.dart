// lib/search_screen.dart

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:url_launcher/url_launcher.dart';


class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _response = '';
  String _feedback = '';

  void _search() async {
    final query = _searchController.text;
    if (query.isEmpty) return;

    // You can choose whether to use ChatGPT or a web search
    // Here we're using ChatGPT
    final response = await http.post(
      Uri.parse('https://api.openai.com/v1/chat/completions'), // Update with actual ChatGPT API endpoint
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer YOUR_API_KEY', // Replace with your API key
      },
      body: json.encode({
        'model': 'gpt-3.5-turbo', // Adjust the model as necessary
        'messages': [
          {'role': 'user', 'content': query}
        ],
      }),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        _response = data['choices'][0]['message']['content']; // Adjust according to the actual API response
      });
    } else {
      setState(() {
        _response = 'Error: ${response.statusCode}';
      });
    }
  }

  void _submitFeedback() {
    // Handle feedback submission logic here
    // For now, just print it to the console
    print('Feedback: $_feedback');
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Feedback submitted!')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('ChatGPT Search')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: 'Enter your search query',
                suffixIcon: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: _search,
                ),
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Response:', style: TextStyle(fontWeight: FontWeight.bold)),
                    SizedBox(height: 10),
                    Text(_response),
                    SizedBox(height: 20),
                    TextField(
                      decoration: InputDecoration(
                        labelText: 'Your Feedback',
                      ),
                      onChanged: (value) {
                        _feedback = value;
                      },
                    ),
                    SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: _submitFeedback,
                      child: Text('Submit Feedback'),
                    ),
                    ElevatedButton(
  onPressed: _launchWebSearch,
  child: Text('Search the Web'),
),

                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  void _launchWebSearch() async {
  final query = _searchController.text;
  if (query.isEmpty) return;

  final url = 'https://www.google.com/search?q=${Uri.encodeComponent(query)}';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

}
