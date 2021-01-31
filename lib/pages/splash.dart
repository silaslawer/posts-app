import 'package:random_user/data/models/Post.dart';
import 'package:random_user/providers/PostProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SplashPage extends StatefulWidget {
  SplashPage({Key key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {

  PostProvider _postsProvider;

  @override
  Widget build(BuildContext context) {
    _postsProvider = Provider.of<PostProvider>(context);

    List<Post> _postList = _postsProvider.posts;


    ThemeData _themeData = Theme.of(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: _postList == null
          ? Center(child: CircularProgressIndicator())
          : SafeArea(
            child: RefreshIndicator(
        onRefresh: () async {
            await _postsProvider.getPosts();
        },
        child: SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            child: Column(
              children: <Widget>[
                if (_postList.isEmpty) ...[
                  Image.asset('assets/img/empty_stocks.jpg'),
                  SizedBox(height: 32),
                  Container(
                    width: 200,
                    padding: const EdgeInsets.all(20),
                   // color: fromHex('#b2dd4c').withOpacity(0.4),
                    child: Column(
                      children: <Widget>[
                       // SvgPicture.asset('assets/img/search.svg'),
                        SizedBox(height: 16),
                        Text(
                          'Your posts are empty',
                          style: Theme.of(context).textTheme.subtitle2.copyWith(
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                  )
                ] else
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 10),
                    child: Text(
                      'POSTS',
                      style: _themeData.textTheme.headline6),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 16,
                    ),
                    child: ListView.builder(
                      shrinkWrap: true,
                      primary: false,
                      itemBuilder: (context, index) => PostItem(post: _postList[index]),
                      itemCount: _postList.length,
                    ),
                  ),
              ],
            ),
        ),
      ),
          ),
    );
  }

  @override
  void initState() {
    Provider.of<PostProvider>(context, listen: false)
        .getPosts();
    super.initState();
  }
}

class PostItem extends StatelessWidget {
  final Post post;

  const PostItem({
    Key key,
    @required this.post,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData _themeData = Theme.of(context);

    return Card(
      elevation: 2,
      child: Container(
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.all(10),
        child: ListTile(title: Text(
          '${post.title}',
          style: _themeData.textTheme.headline6.copyWith(fontSize: 16),
        ),
          subtitle: Container(
          margin: EdgeInsets.symmetric(vertical: 10),
          child: Text(
            '${post.body}',
            style: _themeData.textTheme.bodyText2.copyWith(fontSize: 12),
          ),
        ),),
      ),
    );
  }
}
