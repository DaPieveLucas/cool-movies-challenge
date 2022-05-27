import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

class HeadingFont {
  static final headingLargeBlack = GoogleFonts.rubik(
    fontSize: 30,
    fontWeight: FontWeight.w500,
    color: AppColors.black,
  );
  static final headingLargeWhite = GoogleFonts.rubik(
    fontSize: 30,
    fontWeight: FontWeight.w500,
    color: AppColors.white,
    shadows: <Shadow>[
      const Shadow(
        offset: Offset(3.0, 3.0),
        blurRadius: 5.0,
      ),
    ],
  );
}

class DescriptionFont {
  static final movieCaption = GoogleFonts.rubik(
    fontSize: 14,
    fontWeight: FontWeight.bold,
    color: GrayScale.gray600,
  );
  static final movieSumarry = GoogleFonts.rubik(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    color: GrayScale.gray600,
  );
}
