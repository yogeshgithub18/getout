import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import 'colors.dart';

class AppTexts extends StatelessWidget {
  final String titleText;
  final Color? textColor;
  final TextStyle? style;
  final int? maxLines;
  final TextOverflow? overflow;
  final FontWeight? fontWeight;
  final double? fontSize;
  final TextAlign? textAlign;

  const AppTexts(
      this.titleText, {
        super.key,
        this.textColor,
        this.style,
        this.maxLines,
        this.overflow,
        this.fontWeight,
        this.fontSize,
        this.textAlign,
      });

  const AppTexts.plusJakaSan12W500(
      this.titleText, {
        super.key,
        this.textColor = ColoRRes.textColor,
        this.style = const TextStyle(
          fontFamily: 'Plus Jakarta Sans',
        ),
        this.maxLines,
        this.overflow,
        this.fontWeight = FontWeight.w500,
        this.fontSize = 12,
        this.textAlign,
      });

  const AppTexts.inter15W400(
      this.titleText, {
        super.key,
        this.textColor = ColoRRes.textColor,
        this.style = const TextStyle(
          fontFamily: 'Inter',
        ),
        this.maxLines,
        this.overflow,
        this.fontWeight = FontWeight.w400,
        this.fontSize = 15,
        this.textAlign,
      });

  const AppTexts.poppins12W500(
      this.titleText, {
        super.key,
        this.textColor = ColoRRes.textColor,
        this.style = const TextStyle(
          fontFamily: 'Poppins',
        ),
        this.maxLines,
        this.overflow,
        this.fontWeight = FontWeight.w500,
        this.fontSize = 12,
        this.textAlign,
      });

  const AppTexts.poppins8W300(
      this.titleText, {
        super.key,
        this.textColor = ColoRRes.white,
        this.style = const TextStyle(
          fontFamily: 'Poppins',
        ),
        this.maxLines,
        this.overflow,
        this.fontWeight = FontWeight.w300,
        this.fontSize = 8,
        this.textAlign,
      });
  const AppTexts.poppins18W500(
      this.titleText, {
        super.key,
        this.textColor = ColoRRes.white,
        this.style = const TextStyle(
          fontFamily: 'Poppins',
        ),
        this.maxLines,
        this.overflow,
        this.fontWeight = FontWeight.w300,
        this.fontSize = 18,
        this.textAlign,
      });
  const AppTexts.poppins12W400(
      this.titleText, {
        super.key,
        this.textColor = ColoRRes.black,
        this.style = const TextStyle(
          fontFamily: 'Poppins',
        ),
        this.maxLines,
        this.overflow,
        this.fontWeight = FontWeight.w400,
        this.fontSize = 12,
        this.textAlign,
      });

  const AppTexts.inter12W600(
      this.titleText, {
        super.key,
        this.textColor = ColoRRes.textColor,
        this.style = const TextStyle(
          fontFamily: 'Inter',
        ),
        this.maxLines,
        this.overflow,
        this.fontWeight = FontWeight.w600,
        this.fontSize = 12,
        this.textAlign,
      });
  const AppTexts.inter12W400(
      this.titleText, {
        super.key,
        this.textColor = ColoRRes.textColor,
        this.style = const TextStyle(
          fontFamily: 'Inter',
        ),
        this.maxLines,
        this.overflow,
        this.fontWeight = FontWeight.w400,
        this.fontSize = 12,
        this.textAlign,
      });

  const AppTexts.inter16W400(
      this.titleText, {
        super.key,
        this.textColor = ColoRRes.textColor,
        this.style = const TextStyle(
          fontFamily: 'Inter',
        ),
        this.maxLines,
        this.overflow,
        this.fontWeight = FontWeight.w400,
        this.fontSize = 16,
        this.textAlign,
      });
  // const AppTexts.inter10W400(
  //     this.titleText, {
  //       super.key,
  //       this.textColor = ColoRRes.white,
  //       this.style = const TextStyle(
  //         fontFamily: 'Inter',
  //       ),
  //       this.maxLines,
  //       this.overflow,
  //       this.fontWeight = FontWeight.w400,
  //       this.fontSize = 10,
  //       this.textAlign,
  //     });

  const AppTexts.inter18W600(
      this.titleText, {
        super.key,
        this.textColor = ColoRRes.black,
        this.style = const TextStyle(
          fontFamily: 'Inter',
        ),
        this.maxLines,
        this.overflow,
        this.fontWeight = FontWeight.w600,
        this.fontSize = 18,
        this.textAlign,
      });

  const AppTexts.inter20W500(
      this.titleText, {
        super.key,
        this.textColor = ColoRRes.black,
        this.style = const TextStyle(
          fontFamily: 'Inter',
        ),
        this.maxLines,
        this.overflow,
        this.fontWeight = FontWeight.w500,
        this.fontSize = 20,
        this.textAlign,
      });

  const AppTexts.inter16W600(
      this.titleText, {
        super.key,
        this.textColor = ColoRRes.black,
        this.style = const TextStyle(
          fontFamily: 'Inter',
        ),
        this.maxLines,
        this.overflow,
        this.fontWeight = FontWeight.w600,
        this.fontSize = 16,
        this.textAlign,
      });


  const AppTexts. inter18W500(
      this.titleText, {
        super.key,
        this.textColor = ColoRRes.white,
        this.style = const TextStyle(
          fontFamily: 'Inter',
        ),
        this.maxLines,
        this.overflow,
        this.fontWeight = FontWeight.w500,
        this.fontSize = 18,
        this.textAlign,
      });

  const AppTexts. inter12W500(
      this.titleText, {
        super.key,
        this.textColor = ColoRRes.black,
        this.style = const TextStyle(
          fontFamily: 'Inter',
        ),
        this.maxLines,
        this.overflow,
        this.fontWeight = FontWeight.w500,
        this.fontSize = 12,
        this.textAlign,
      });

  const AppTexts. inter14W500(
      this.titleText, {
        super.key,
        this.textColor = ColoRRes.black,
        this.style = const TextStyle(
          fontFamily: 'Inter',
        ),
        this.maxLines,
        this.overflow,
        this.fontWeight = FontWeight.w500,
        this.fontSize = 14,
        this.textAlign,
      });


  const AppTexts. inter15W500(
      this.titleText, {
        super.key,
        this.textColor = ColoRRes.textColor,
        this.style = const TextStyle(
          fontFamily: 'Inter',
        ),
        this.maxLines,
        this.overflow,
        this.fontWeight = FontWeight.w500,
        this.fontSize = 15,
        this.textAlign,
      });

  const AppTexts. inter10W500(
      this.titleText, {
        super.key,
        this.textColor = ColoRRes.textSubColor,
        this.style = const TextStyle(
          fontFamily: 'Inter',
        ),
        this.maxLines,
        this.overflow,
        this.fontWeight = FontWeight.w500,
        this.fontSize = 10,
        this.textAlign,
      });
  const AppTexts. inter14W600(
      this.titleText, {
        super.key,
        this.textColor = ColoRRes.black,
        this.style = const TextStyle(
          fontFamily: 'Inter',
        ),
        this.maxLines,
        this.overflow,
        this.fontWeight = FontWeight.w600,
        this.fontSize = 14,
        this.textAlign,
      });
  const AppTexts. inter14W400(
      this.titleText, {
        super.key,
        this.textColor = ColoRRes.black,
        this.style = const TextStyle(
          fontFamily: 'Inter',
        ),
        this.maxLines,
        this.overflow,
        this.fontWeight = FontWeight.w400,
        this.fontSize = 14,
        this.textAlign,
      });
  const AppTexts.inter24W600(
      this.titleText, {
        super.key,
        this.textColor = ColoRRes.black,
        this.style = const TextStyle(
          fontFamily: 'Inter',
        ),
        this.maxLines,
        this.overflow,
        this.fontWeight = FontWeight.w600,
        this.fontSize = 24,
        this.textAlign,
      });
  const AppTexts.inter15W600(
      this.titleText, {
        super.key,
        this.textColor = ColoRRes.cardTextColor,
        this.style = const TextStyle(
          fontFamily: 'Inter',
        ),
        this.maxLines,
        this.overflow,
        this.fontWeight = FontWeight.w600,
        this.fontSize = 15,
        this.textAlign,
      });

  const AppTexts.inter10W300(
      this.titleText, {
        super.key,
        this.textColor = ColoRRes.textSubColor,
        this.style = const TextStyle(
          fontFamily: 'Inter',
        ),
        this.maxLines,
        this.overflow,
        this.fontWeight = FontWeight.w300,
        this.fontSize = 10,
        this.textAlign,
      });

  @override
  Widget build(BuildContext context) {
    final effectiveStyle = style?.copyWith(
      color: textColor ?? ColoRRes.black,
      fontWeight: fontWeight ?? style?.fontWeight,
      fontSize: fontSize ?? style?.fontSize,
    ) ?? TextStyle(
      color: textColor ?? ColoRRes.black,
      fontWeight: fontWeight,
      fontSize: fontSize,
    );

    return Text(
      titleText.tr,
      style: effectiveStyle,
      maxLines: maxLines,
      overflow: overflow,
      textAlign: textAlign ?? TextAlign.start,
    );
  }
}
