import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../controller/specifications_page_controller.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_style.dart';

class ReviewDialogWidget extends StatefulWidget {
  const ReviewDialogWidget({
    required this.isEdited,
    required this.editButton,
    required this.submitButton,
    required this.controller,
    Key? key,
  }) : super(key: key);

  final void Function(double) submitButton;
  final void Function(double) editButton;
  final bool isEdited;
  final SpecificationsPageController controller;

  @override
  State<ReviewDialogWidget> createState() => _ReviewDialogWidgetState();
}

class _ReviewDialogWidgetState extends State<ReviewDialogWidget> {
  double submitRating = 0.0;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        'Moview review',
        style: DescriptionFont.movieCaption,
      ),
      content: SingleChildScrollView(
        child: Column(
          children: [
            TextField(
              autofocus: true,
              controller: widget.controller.textTitleController,
              decoration: const InputDecoration(
                hintText: 'title of review',
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              controller: widget.controller.textBodyController,
              autofocus: true,
              decoration: const InputDecoration(
                hintText: 'body of review',
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            RatingBar.builder(
              itemSize: 15,
              itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
              itemBuilder: (context, _) => const Icon(
                Icons.star,
                color: AppColors.gold,
                size: 10,
              ),
              onRatingUpdate: (rating) {
                setState(() {
                  submitRating = rating;
                  print(submitRating.toString());
                });
              },
            )
          ],
        ),
      ),
      actions: [
        widget.isEdited
            ? TextButton(
                onPressed: () => widget.editButton(submitRating),
                child: const Text('Edit'),
              )
            : TextButton(
                onPressed: () => widget.submitButton(submitRating),
                child: const Text('Submit'),
              ),
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        )
      ],
    );
  }
}
