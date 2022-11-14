import 'dart:developer';

import 'package:android_native/content/Context.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../android_native.dart';

mixin ApplicationMixin on AndroidNativeObject {
  final Context _context = Context();
  Context getApplicationContext() {
    return _context;
  }
}

class Application extends StatelessWidget
    with AndroidNativeObject, ApplicationMixin {
  Application({
    Key? key,
    this.navigatorKey,
    this.home,
    this.routes = const <String, WidgetBuilder>{},
    this.initialRoute,
    this.onGenerateRoute,
    this.onGenerateInitialRoutes,
    this.onUnknownRoute,
    this.navigatorObservers = const <NavigatorObserver>[],
    this.builder,
    this.textDirection,
    this.title = '',
    this.onGenerateTitle,
    this.color,
    this.theme,
    this.darkTheme,
    this.themeMode = ThemeMode.system,
    this.locale,
    this.fallbackLocale,
    this.localizationsDelegates,
    this.localeListResolutionCallback,
    this.localeResolutionCallback,
    this.supportedLocales = const <Locale>[Locale('en', 'US')],
    this.debugShowMaterialGrid = false,
    this.showPerformanceOverlay = false,
    this.checkerboardRasterCacheImages = false,
    this.checkerboardOffscreenLayers = false,
    this.showSemanticsDebugger = false,
    this.debugShowCheckedModeBanner = true,
    this.shortcuts,
    this.customTransition,
    this.translationsKeys,
    this.translations,
    this.onInit,
    this.onReady,
    this.onDispose,
    this.routingCallback,
    this.defaultTransition,
    this.getPages,
    this.opaqueRoute,
    this.enableLog,
    this.logWriterCallback,
    this.popGesture,
    this.transitionDuration,
    this.defaultGlobalState,
    this.smartManagement = SmartManagement.full,
    this.initialBinding,
    this.unknownRoute,
    this.highContrastTheme,
    this.highContrastDarkTheme,
    this.actions,
  })  : assert(routes != null),
        assert(navigatorObservers != null),
        assert(title != null),
        assert(debugShowMaterialGrid != null),
        assert(showPerformanceOverlay != null),
        assert(checkerboardRasterCacheImages != null),
        assert(checkerboardOffscreenLayers != null),
        assert(showSemanticsDebugger != null),
        assert(debugShowCheckedModeBanner != null),
        routeInformationProvider = null,
        routeInformationParser = null,
        routerDelegate = null,
        backButtonDispatcher = null,
        super(key: key);

  final GlobalKey<NavigatorState>? navigatorKey;
  final Widget? home;
  final Map<String, WidgetBuilder>? routes;
  final String? initialRoute;
  final RouteFactory? onGenerateRoute;
  final InitialRouteListFactory? onGenerateInitialRoutes;
  final RouteFactory? onUnknownRoute;
  final List<NavigatorObserver>? navigatorObservers;
  final TransitionBuilder? builder;
  final String title;
  final GenerateAppTitle? onGenerateTitle;
  final ThemeData? theme;
  final ThemeData? darkTheme;
  final ThemeMode themeMode;
  final CustomTransition? customTransition;
  final Color? color;
  final Map<String, Map<String, String>>? translationsKeys;
  final Translations? translations;
  final TextDirection? textDirection;
  final Locale? locale;
  final Locale? fallbackLocale;
  final Iterable<LocalizationsDelegate<dynamic>>? localizationsDelegates;
  final LocaleListResolutionCallback? localeListResolutionCallback;
  final LocaleResolutionCallback? localeResolutionCallback;
  final Iterable<Locale> supportedLocales;
  final bool showPerformanceOverlay;
  final bool checkerboardRasterCacheImages;
  final bool checkerboardOffscreenLayers;
  final bool showSemanticsDebugger;
  final bool debugShowCheckedModeBanner;
  final Map<LogicalKeySet, Intent>? shortcuts;
  final ThemeData? highContrastTheme;
  final ThemeData? highContrastDarkTheme;
  final Map<Type, Action<Intent>>? actions;
  final bool debugShowMaterialGrid;
  final ValueChanged<Routing?>? routingCallback;
  final Transition? defaultTransition;
  final bool? opaqueRoute;
  final VoidCallback? onInit;
  final VoidCallback? onReady;
  final VoidCallback? onDispose;
  final bool? enableLog;
  final LogWriterCallback? logWriterCallback;
  final bool? popGesture;
  final SmartManagement smartManagement;
  final Bindings? initialBinding;
  final Duration? transitionDuration;
  final bool? defaultGlobalState;
  final List<GetPage>? getPages;
  final GetPage? unknownRoute;
  final RouteInformationProvider? routeInformationProvider;
  final RouteInformationParser<Object>? routeInformationParser;
  final RouterDelegate<Object>? routerDelegate;
  final BackButtonDispatcher? backButtonDispatcher;

  Application.router({
    Key? key,
    this.routeInformationProvider,
    @required this.routeInformationParser,
    @required this.routerDelegate,
    this.backButtonDispatcher,
    this.builder,
    this.title = '',
    this.onGenerateTitle,
    this.color,
    this.theme,
    this.darkTheme,
    this.highContrastTheme,
    this.highContrastDarkTheme,
    this.themeMode = ThemeMode.system,
    this.locale,
    this.localizationsDelegates,
    this.localeListResolutionCallback,
    this.localeResolutionCallback,
    this.supportedLocales = const <Locale>[Locale('en', 'US')],
    this.debugShowMaterialGrid = false,
    this.showPerformanceOverlay = false,
    this.checkerboardRasterCacheImages = false,
    this.checkerboardOffscreenLayers = false,
    this.showSemanticsDebugger = false,
    this.debugShowCheckedModeBanner = true,
    this.shortcuts,
    this.actions,
    this.customTransition,
    this.translationsKeys,
    this.translations,
    this.textDirection,
    this.fallbackLocale,
    this.routingCallback,
    this.defaultTransition,
    this.opaqueRoute,
    this.onInit,
    this.onReady,
    this.onDispose,
    this.enableLog,
    this.logWriterCallback,
    this.popGesture,
    this.smartManagement = SmartManagement.full,
    this.initialBinding,
    this.transitionDuration,
    this.defaultGlobalState,
    this.getPages,
    this.unknownRoute,
  })  : assert(routeInformationParser != null),
        assert(routerDelegate != null),
        assert(title != null),
        assert(debugShowMaterialGrid != null),
        assert(showPerformanceOverlay != null),
        assert(checkerboardRasterCacheImages != null),
        assert(checkerboardOffscreenLayers != null),
        assert(showSemanticsDebugger != null),
        assert(debugShowCheckedModeBanner != null),
        navigatorObservers = null,
        navigatorKey = null,
        onGenerateRoute = null,
        home = null,
        onGenerateInitialRoutes = null,
        onUnknownRoute = null,
        routes = null,
        initialRoute = null,
        super(key: key);

  // static Context _context = Context();

  // Context getApplicationContext() {
  //   return _context;
  // }

  Future init() async {
    log("initializing Application");
    var map = await invokeMethod("Build", null);
    AndroidNativeObject.ANDROID_SDK_INT = map["SDK_INT"];
    AndroidNativeObject.ANDROID_SDK = map["SDK"];
    AndroidNativeObject.ANDROID_PREVIEW_SDK_INT = map["PREVIEW_SDK_INT"];
    AndroidNativeObject.ANDROID_BASE_OS = map["BASE_OS"];
    AndroidNativeObject.ANDROID_CODENAME = map["CODENAME"];
    AndroidNativeObject.ANDROID_INCREMENTAL = map["INCREMENTAL"];
    AndroidNativeObject.ANDROID_RELEASE = map["RELEASE"];
    AndroidNativeObject.ANDROID_RELEASE_OR_CODENAME =
        map["RELEASE_OR_CODENAME"];
    AndroidNativeObject.ANDROID_SECURITY_PATCH = map["SECURITY_PATCH"];
    AndroidNativeObject.SERIAL = map["SERIAL"];
  }

  // Widget getView();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: init(),
      builder: (context, snapshot) => GetMaterialApp(
        navigatorKey: this.navigatorKey,
        home: this.home,
        routes: this.routes ?? const <String, WidgetBuilder>{},
        initialRoute: this.initialRoute,
        onGenerateRoute: this.onGenerateRoute,
        onGenerateInitialRoutes: this.onGenerateInitialRoutes,
        onUnknownRoute: this.onUnknownRoute,
        navigatorObservers: (navigatorObservers == null
            ? <NavigatorObserver>[GetObserver(routingCallback, Get.routing)]
            : <NavigatorObserver>[GetObserver(routingCallback, Get.routing)]
          ..addAll(navigatorObservers!)),
        builder: this.builder,
        textDirection: this.textDirection,
        title: this.title,
        onGenerateTitle: this.onGenerateTitle,
        color: this.color,
        theme: this.theme,
        darkTheme: this.darkTheme,
        themeMode: this.themeMode,
        locale: this.locale,
        fallbackLocale: this.fallbackLocale,
        localizationsDelegates: this.localizationsDelegates,
        localeListResolutionCallback: this.localeListResolutionCallback,
        localeResolutionCallback: this.localeResolutionCallback,
        supportedLocales: this.supportedLocales,
        debugShowMaterialGrid: this.debugShowMaterialGrid,
        showPerformanceOverlay: this.showPerformanceOverlay,
        checkerboardRasterCacheImages: this.checkerboardRasterCacheImages,
        checkerboardOffscreenLayers: this.checkerboardOffscreenLayers,
        showSemanticsDebugger: this.showSemanticsDebugger,
        debugShowCheckedModeBanner: this.debugShowCheckedModeBanner,
        shortcuts: this.shortcuts,
        customTransition: this.customTransition,
        translationsKeys: this.translationsKeys,
        translations: this.translations,
        onInit: this.onInit,
        onReady: this.onReady,
        onDispose: this.onDispose,
        routingCallback: this.routingCallback,
        defaultTransition: this.defaultTransition,
        getPages: this.getPages,
        opaqueRoute: this.opaqueRoute,
        enableLog: this.enableLog,
        logWriterCallback: this.logWriterCallback,
        popGesture: this.popGesture,
        transitionDuration: this.transitionDuration,
        defaultGlobalState: this.defaultGlobalState,
        smartManagement: this.smartManagement,
        initialBinding: this.initialBinding,
        unknownRoute: this.unknownRoute,
        highContrastTheme: this.highContrastTheme,
        highContrastDarkTheme: this.highContrastDarkTheme,
        actions: this.actions,
      ),
    );
  }
}
