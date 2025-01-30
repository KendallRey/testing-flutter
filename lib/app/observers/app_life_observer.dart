import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:normal_list/app/core/services/temp_file_manager.dart';

class AppLifecycleObserver extends StatefulWidget {
  final Widget child;

  const AppLifecycleObserver({super.key, required this.child});

  @override
  _AppLifecycleObserverState createState() => _AppLifecycleObserverState();
}

class _AppLifecycleObserverState extends State<AppLifecycleObserver>
    with WidgetsBindingObserver {
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

  // its not working, maybe in the future,
  // see more: https://github.com/flutter/flutter/issues/138737
  Future<bool?> _showExitAppDialog() async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Exit App'),
            content: Text('Are you sure you want to close the application?'),
            actions: [
              TextButton(
                onPressed: () => context.pop(false), // Cancel
                child: Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: () => context.pop(true),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                ), // Confirm
                child: Text('Exit'),
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
        canPop: true,
        onPopInvokedWithResult: (bool didPop, Object? result) async {
          if (kDebugMode) {
            print('Pop invoked!');
          }
          if (didPop) {
            return;
          }
          if (kDebugMode) {
            print('Pop invoked!: 2');
          }
          final bool shouldPop = await _showExitAppDialog() ?? false;
          if (shouldPop) {
            // Since this is the root route, quit the app where possible by
            // invoking the SystemNavigator. If this wasn't the root route,
            // then Navigator.maybePop could be used instead.
            if (context.mounted) {
              context.pop();
            }
          }
        },
        child: widget.child);
  }
}
