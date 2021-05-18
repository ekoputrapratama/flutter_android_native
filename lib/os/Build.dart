// ignore_for_file: non_constant_identifier_names

import 'package:android_native/android_native.dart';

class Build {
  static const VERSION_CODES = _VersionCodes._();
  static const VERSION = _BuildVersion._();
}

class _VersionCodes {
  const _VersionCodes._();

  final BASE = 1;
  final BASE_1_1 = 2;
  final CUPCAKE = 3;
  final CUR_DEVELOPMENT = 10000;
  final DONUT = 4;
  final ECLAIR = 5;
  final ECLAIR_0_1 = 6;
  final ECLAIR_MR1 = 7;
  final FROYO = 8;
  final GINGERBREAD = 9;
  final GINGERBREAD_MR1 = 10;
  final HONEYCOMB = 11;
  final HONEYCOMB_MR1 = 12;
  final HONEYCOMB_MR2 = 13;
  final ICE_CREAM_SANDWICH = 14;
  final ICE_CREAM_SANDWICH_MR1 = 15;
  final JELLY_BEAN = 16;
  final JELLY_BEAN_MR1 = 17;
  final JELLY_BEAN_MR2 = 18;
  final KITKAT = 19;
  final KITKAT_WATCH = 20;
  final LOLLIPOP = 21;
  final LOLLIPOP_MR1 = 22;
  final M = 23;
  final N = 24;
  final N_MR1 = 25;
  final O = 26;
  final O_MR1 = 27;
  final P = 28;
  final Q = 29;
}

class _BuildVersion {
  const _BuildVersion._();

  get SDK_INT => AndroidNativeObject.ANDROID_SDK_INT;
  get PREVIEW_SDK_INT => AndroidNativeObject.ANDROID_PREVIEW_SDK_INT;
  get BASE_OS => AndroidNativeObject.ANDROID_BASE_OS;
  get CODENAME => AndroidNativeObject.ANDROID_CODENAME;
  get INCREMENTAL => AndroidNativeObject.ANDROID_INCREMENTAL;
  get RELEASE => AndroidNativeObject.ANDROID_RELEASE;
  get RELEASE_OR_CODENAME => AndroidNativeObject.ANDROID_RELEASE_OR_CODENAME;
  get SDK => AndroidNativeObject.ANDROID_SDK;
  get SECURITY_PATCH => AndroidNativeObject.ANDROID_SECURITY_PATCH;
  // get
}
