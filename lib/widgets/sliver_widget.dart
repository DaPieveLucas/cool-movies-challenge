import 'package:flutter/material.dart';

class SliverWidget extends StatelessWidget {
  const SliverWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          pinned: true,
          expandedHeight: 150.0,
          flexibleSpace: FlexibleSpaceBar(
            title: const Text('Avaiable seats'),
            background: Image.network(
              'https://r-cf.bstatic.com/images/hotel/max1024x768/116/116281457.jpg',
              fit: BoxFit.fitWidth,
            ),
          ),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              return Text('this $index');
            },
          ),
        ),
      ],
    );
  }
}
