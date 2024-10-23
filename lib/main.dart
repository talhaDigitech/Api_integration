import 'package:api_integration/api_service.dart';
import 'package:api_integration/posts_model.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  final ApiService _apiService = ApiService();

  @override
  void initState() {
    _fetchPosts();
    super.initState();
  }

  bool isLoading = true;
  bool hasEror = false;
  String errorMsg = '';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: (isLoading)
            ? const Center(child: CircularProgressIndicator())
            : hasEror
                ? Center(child: Text(errorMsg))
                : ListView.separated(
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                        title: Text(posts?[index].title ?? ''),
                        subtitle: Text(posts?[index].body ?? ''),
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return const Divider();
                    },
                    itemCount: posts?.length ?? 0,
                  ),
      ),
    );
  }

  List<PostsModel>? posts;

  _fetchPosts() async {
    try {
      posts = await _apiService.fetchPosts();
    } catch (e) {
      print(e);
      hasEror = true;
      errorMsg = e.toString();
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }
}
