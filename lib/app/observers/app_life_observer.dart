import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:normal_list/app/core/services/temp_file_manager.dart';

class AppLifecycleObserver extends StatefulWidget {
  final Widget child;

  const AppLifecycleObserver({super.key, required this.child});

  @override
  _AppLifecycleObserverState createState() => _AppLifecycleObserverState();
}

class _AppLifecycleObserverState extends State<AppLifecycleObserver> with WidgetsBindingObserver {

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      // Perform cleanup or save data when the app is paused (backgrounded)
      if (kDebugMode) {
        print('App is paused, do cleanup');
      }
    } else if (state == AppLifecycleState.resumed) {
      // Refresh data or re-establish resources when the app is resumed (foreground)
      if (kDebugMode) {
        print('App resumed, perform tasks');
      }
    } else if (state == AppLifecycleState.detached) {
      // Cleanup before the app is terminated
      TempFileManager.cleanUp();
      if (kDebugMode) {
        print('App is detached, final cleanup');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}