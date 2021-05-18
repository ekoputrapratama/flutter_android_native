import 'dart:async';
import 'dart:developer';

import 'package:android_native/android_native.dart';

const _REGISTER_CONTENT_OBSERVER = "ContentResolver.registerContentObserver";
const _UNREGISTER_CONTENT_OBSERVER =
    "ContentResolver.unregisterContentObserver";
const _ON_CHANGE = "ContentResolver.onChange";

typedef ContentObserverCallback = FutureOr<void> Function(
    bool selfChange, Uri? uri, int flags);

mixin ContentResolverMixin on AndroidNativeObject {
  static Map<String, List<ContentObserverCallback>> _contentObserverCallbacks =
      Map<String, List<ContentObserverCallback>>();
  void registerContentObserver(Uri uri, ContentObserverCallback callback) {
    log("callbacks uris ${_contentObserverCallbacks.keys}");
    if (!_contentObserverCallbacks.containsKey(uri.toString())) {
      _contentObserverCallbacks[uri.toString()] = [];
      invokeMethod(_REGISTER_CONTENT_OBSERVER, {"uri": uri.toString()});
    }
    _contentObserverCallbacks[uri.toString()]!.add(callback);
  }

  void unregisterContentObserver(ContentObserverCallback callback) {
    String? uri;
    _contentObserverCallbacks.entries.forEach((entry) {
      var list = entry.value;
      if (list.contains(callback) && list.length == 1) {
        uri = entry.key;
      }

      _contentObserverCallbacks[entry.key]!
          .removeWhere((element) => element == callback);
    });

    if (uri != null) {
      invokeMethod(_UNREGISTER_CONTENT_OBSERVER, {"uri": uri});
    }
  }

  void onContentResolverMethodCall(String method, dynamic arguments) {
    log("onContentResolverMethodCall");
    switch (method) {
      case "onChange":
        var uri = arguments["uri"] as String?;
        var selfChange = arguments["selfChange"] as bool;
        var flags = arguments["flags"] as int;
        var observedUri = arguments["observedUri"] as String;
        log("onChange selfChange=$selfChange, uri=$uri, flags=$flags, observedUri=$observedUri");
        List<ContentObserverCallback> callbacks =
            _contentObserverCallbacks[observedUri] ??
                <ContentObserverCallback>[];
        if (uri != null) {
          _contentObserverCallbacks.entries
              .where((entry) =>
                  uri.startsWith(entry.key) && entry.key != observedUri)
              .map<List<ContentObserverCallback>>((e) => e.value)
              .forEach((cbs) {
            callbacks.addAll(cbs);
          });
        }
        log("callbacks lenght ${callbacks.length}");
        if (callbacks.length > 0) {
          callbacks.forEach((cb) {
            cb(selfChange, (uri != null) ? Uri.parse(uri) : null, flags);
          });
        }
        break;
    }
  }
}

class ContentResolver extends AndroidNativeObject with ContentResolverMixin {
  ContentResolver() : super() {
    registerMethodCallListener("ContentResolver", onContentResolverMethodCall);
    init();
  }
}
