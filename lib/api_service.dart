import 'package:api_integration/posts_model.dart';
import 'package:http/http.dart';

class ApiService {
  Future<List<PostsModel>> fetchPosts() async {
    try {
      Response response = await get(
        Uri.parse('https://jsonplaceholder.typicode.com/posts'),
      );
      print(response.body);
      return postsModelFromJson(response.body);
    } catch (e) {
      print(e);
      throw('Error fetching posts');
    }
  }
}
