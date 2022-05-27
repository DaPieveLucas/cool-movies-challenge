import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import '../widgets/film_card_widget.dart';
import '../widgets/sliver_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ValueNotifier<Map<String, dynamic>?> _data = ValueNotifier(null);

  Future<void> _fetchData() async {
    print('Fetching data...');
    final client = GraphQLProvider.of(context).value;

    final QueryResult result = await client.query(
      QueryOptions(
        document: gql(
          r'''
          query AllMovies {
            allMovies {
              nodes {
                id
                imgUrl
                movieDirectorId
                userCreatorId
                title
                releaseDate
                nodeId
                userByUserCreatorId {
                  id
                  name
                  nodeId
                }
              }
            }
          }
        ''',
        ),
      ),
    );

    if (result.hasException) {
      print(result.exception.toString());
    }

    if (result.data != null) {
      _data.value = result.data!['allMovies'];
      print(result.data.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: SliverWidget(
        sliverList: SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) => const FilmCardWidget(),
            childCount: 200,
          ),
        ),
      ),
    );
  }
}

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       // backgroundColor: Theme.of(context).backgroundColor,
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 16.0),
//           child: Center(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: <Widget>[
//                 const Padding(
//                   padding: EdgeInsets.only(top: 36.0),
//                   child: Text(
//                     '''Thank you for taking the time to take our test. We really appreciate it.
// All the information on what is required can be found in the README at the root of this repo.
// Please dont spend ages on this and just get through as much of it as you can.
// Good luck! :)''',
//                     textAlign: TextAlign.center,
//                   ),
//                 ),
//                 const SizedBox(height: 16),
//                 OutlinedButton.icon(
//                   onPressed: _fetchData,
//                   icon: const Icon(Icons.download),
//                   label: const Text('Fetch data'),
//                 ),
//                 const SizedBox(height: 16),
//                 ValueListenableBuilder(
//                   valueListenable: _data,
//                   builder: (
//                     BuildContext context,
//                     Map<String, dynamic>? data,
//                     Widget? _,
//                   ) {
//                     return data != null
//                         ? Container(
//                             padding: const EdgeInsets.all(8),
//                             decoration: BoxDecoration(
//                               color: Colors.grey[300],
//                               border: Border.all(color: Colors.grey.shade700),
//                               borderRadius: BorderRadius.circular(4),
//                             ),
//                             child: Text(
//                               data.toString(),
//                             ),
//                           )
//                         : Container();
//                   },
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
      
      
      
//      

