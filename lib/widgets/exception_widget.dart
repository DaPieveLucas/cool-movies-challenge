import 'package:coolmovies/theme/app_text_style.dart';
import 'package:coolmovies/widgets/sliver_widget.dart';
import 'package:flutter/material.dart';

class ExceptionWidget extends StatelessWidget {
  const ExceptionWidget({required this.exception, Key? key}) : super(key: key);

  final String exception;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: SliverWidget(
        sliverList: SliverList(
          delegate: SliverChildBuilderDelegate(
            ((context, index) => Container(
                  padding: const EdgeInsets.all(10.0),
                  height: 100,
                  width: double.maxFinite,
                  child: Card(
                    elevation: 20,
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Text(
                        exception,
                        style: HeadingFont.headingLargeBlack,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                )),
            childCount: 1,
          ),
        ),
      ),
    );
  }
}
