
import 'package:random_user/pages/splash.dart';
import 'package:random_user/providers/PostProvider.dart';
import 'package:random_user/util/routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PostApp extends StatelessWidget {
  const PostApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<PostProvider>(create: (_) => PostProvider()),
      ],
      child: MaterialApp(
        title: 'Posts',
        debugShowCheckedModeBanner: false,
        initialRoute: Routes.Splash,
        routes: {
          Routes.Splash: (_) => SplashPage(),
        },
      ),
    );
  }
}
