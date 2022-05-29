import 'package:coolmovies/controller/home_page_controller.dart';
import 'package:coolmovies/model/movies_model.dart';
import 'package:flutter/material.dart';

import '../widgets/empty_state.dart';

import '../widgets/film_card_widget.dart';
import '../widgets/sliver_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final HomePageController controller = HomePageController();

  @override
  void initState() {
    super.initState();

    controller.fetchMovies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: ValueListenableBuilder<List<MoviesModel>?>(
        valueListenable: controller.data,
        builder: (context, movies, _) {
          if (movies == null) {
            return const EmptyState();
          }
          return SliverWidget(
            sliverList: SliverList(
              delegate: SliverChildBuilderDelegate(
                ((context, index) {
                  final MoviesModel movie = movies[index];

                  return FilmCardWidget(
                    moviesModel: movie,
                  );
                }),
                childCount: movies.length,
              ),
            ),
          );
        },
      ),
    );
  }
}

        // if (result.hasException) {
        //   return ExceptionWidget(exception: result.exception.toString());
        // }
        // if (result.isLoading) {
        //   return const LoadingScreen();
        // }

        // final List? movies = result.data?['allMovies']['nodes'];

        // if (movies == null) {
        //   return const EmptyState();
        // }


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
