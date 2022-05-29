import 'dart:io';

import 'package:coolmovies/theme/main_theme.dart';
import 'package:coolmovies/utils/navigation_service.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import 'pages/home_page_view.dart';

void main() async {
  // We're using HiveStore for persistence,
  // so we need to initialize Hive.
  await initHiveForFlutter();

  final HttpLink httpLink = HttpLink(
    // 'https://api.spacex.land/graphql/',

    //real url
    Platform.isAndroid
        ? 'http://10.0.2.2:5001/graphql'
        : 'http://localhost:5001/graphql',
  );

  final AuthLink authLink = AuthLink(
    getToken: () async => 'Bearer <YOUR_PERSONAL_ACCESS_TOKEN>',
  );

  final Link link = authLink.concat(httpLink);

  final ValueNotifier<GraphQLClient> client = ValueNotifier(
    GraphQLClient(
      link: link,
      cache: GraphQLCache(store: HiveStore()),
    ),
  );

  runApp(
    GraphQLProvider(
      client: client,
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: NavigationService.navigatorKey,
      debugShowCheckedModeBanner: false,
      title: 'Cool Movies',
      theme: MainTheme.standardTheme,
      home: const HomePage(),
    );
  }
}
