import 'package:flutter/material.dart';

class AppTextStyles {
  static TextStyle normalBold(context) => Theme.of(
    context,
  ).textTheme.titleSmall!.copyWith(fontWeight: FontWeight.w700); // 14,  700

  static TextStyle normalLight(context) => Theme.of(
    context,
  ).textTheme.labelLarge!.copyWith(fontWeight: FontWeight.w500); // 14,  400

  static TextStyle xsmallLight(context) => Theme.of(context)
      .textTheme
      .labelSmall!
      .copyWith(fontWeight: FontWeight.w400, fontSize: 10); // 10,  400
  static TextStyle xsmallBold(context) => Theme.of(context)
      .textTheme
      .labelSmall!
      .copyWith(fontWeight: FontWeight.w800, fontSize: 10); // 10,  400
  static TextStyle xsmallBold16(context) => Theme.of(context)
      .textTheme
      .labelSmall!
      .copyWith(fontWeight: FontWeight.w800, fontSize: 16); // 10,  400

  static TextStyle docSmallLight(context) =>
      Theme.of(context).textTheme.labelSmall!.copyWith(fontSize: 6); // 8,  400
  static TextStyle docSmallBold(context) => Theme.of(context)
      .textTheme
      .labelSmall!
      .copyWith(fontWeight: FontWeight.w800, fontSize: 6); // 8,  400
  static TextStyle docBigLight(context) =>
      Theme.of(context).textTheme.labelSmall!.copyWith(fontSize: 8); // 10,  400
  static TextStyle docBigBold(context) => Theme.of(context)
      .textTheme
      .labelSmall!
      .copyWith(fontWeight: FontWeight.w800, fontSize: 8); // 10,  400

  static TextStyle smallLight(context) => Theme.of(
    context,
  ).textTheme.bodySmall!.copyWith(fontWeight: FontWeight.w400); // 12,  400

  static TextStyle smallBold(context) => Theme.of(
    context,
  ).textTheme.bodySmall!.copyWith(fontWeight: FontWeight.w700);

  static TextStyle smallBold16(context) => Theme.of(
    context,
  ).textTheme.bodySmall!.copyWith(fontSize:16,fontWeight: FontWeight.w700);
  static TextStyle smalText(context) => Theme.of(
    context,
  ).textTheme.bodySmall!.copyWith(fontSize: 12,); // 12,  800

  static TextStyle bigBold(context) => Theme.of(
    context,
  ).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.w700); // 16,  900

  static TextStyle vbigBold(context) => Theme.of(context).textTheme.titleMedium!
      .copyWith(fontWeight: FontWeight.w800, fontSize: 20); // 20,  500

  static TextStyle vBigLight(context) =>
      Theme.of(context).textTheme.headlineMedium!; // 28,  400

  static TextStyle vvBigBold(context) => Theme.of(
    context,
  ).textTheme.headlineMedium!.copyWith(fontWeight: FontWeight.w800); // 28,  400
}
