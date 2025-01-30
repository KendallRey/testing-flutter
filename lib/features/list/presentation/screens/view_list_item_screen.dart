import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:normal_list/app/core/widgets/button.dart';
import 'package:normal_list/app/router.dart';
import 'package:normal_list/features/list/data/list_item_model.dart';
import 'package:normal_list/features/list/data/list_service.dart';

class ViewListItemScreen extends StatefulWidget {
  final String id;

  const ViewListItemScreen({
    super.key,
    required this.id,
  });

  @override
  State<ViewListItemScreen> createState() => _ViewListItemScreenState();
}

class _ViewListItemScreenState extends State<ViewListItemScreen> {
  final User? user = FirebaseAuth.instance.currentUser;
  final ListService _listService = ListService();

  Future<void> _handleDeleteItem(BuildContext ctx, String id) async {
    setState(() {});
    final isDeleted = await _listService.deleteUserItem(user!.uid, id);
    if (!isDeleted) {
      if (ctx.mounted) {
        ScaffoldMessenger.of(ctx)
            .showSnackBar(SnackBar(content: Text('Item delete failed')));
      }
    } else {
      if (ctx.mounted) {
        ScaffoldMessenger.of(ctx)
            .showSnackBar(SnackBar(content: Text('Item deleted!')));
        if (ctx.canPop()) {
          ctx.pop();
        }
      }
      setState(() {});
    }
  }

  Future<void> _promptDeleteConfirmation(BuildContext ctx, String id) async {
    final bool? confirmDelete = await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Delete Item'),
          content: Text('Are you sure you want to delete this item?'),
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
              child: Text('Delete'),
            ),
          ],
        );
      },
    );

    if (confirmDelete == true) {
      if (ctx.mounted) _handleDeleteItem(ctx, id);
    }
  }

  void _handleUpdateItem(BuildContext ctx, ListItemModel item) {
    if (ctx.mounted) {
      ctx.pushNamed(AppRoutes.updateListItemName,
          pathParameters: {AppRoutes.id: item.id}, extra: item);
    }
  }

  void _handleOnTapText(BuildContext ctx, String? textToCopy) {
    if (textToCopy == null) return;
    if (ctx.mounted) {
      Clipboard.setData(ClipboardData(text: textToCopy));
      ScaffoldMessenger.of(ctx)
          .showSnackBar(SnackBar(content: Text('Copied: $textToCopy')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _listService.getUserItemDecrypted(user!.uid, widget.id),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        if (!snapshot.hasData || snapshot.data == null) {
          return Center(
              child: Text(
            'No data found',
            style: Theme.of(context).textTheme.labelMedium,
          ));
        }
        final item = snapshot.data!;
        return Scaffold(
          appBar: AppBar(
            title: Text(item.code),
          ),
          body: Padding(
            padding: EdgeInsets.all(24),
            child: Column(
              children: [
                Expanded(
                    child: ListView(
                  children: [
                    Card(
                      child: SizedBox(
                          height: 320.0,
                          width: 320.0,
                          child: item.image != null
                              ? Image(image: FileImage(item.image!))
                              : Center(
                                  child: Text('No image.'),
                                )),
                    ),
                    SizedBox(height: 20),
                    GestureDetector(
                      onTap: () => _handleOnTapText(context, item.code),
                      child: Text(
                        item.code,
                        style: Theme.of(context).textTheme.titleLarge,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      item.title,
                      style: Theme.of(context).textTheme.bodyLarge,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 30),
                    GestureDetector(
                      onTap: () => _handleOnTapText(context, item.url),
                      child: Text(
                        item.url ?? '---',
                        style: Theme.of(context).textTheme.bodyLarge,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                )),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  spacing: 24,
                  children: [
                    AppButton(
                      onPressed: () {
                        _promptDeleteConfirmation(context, item.id);
                      },
                      label: 'Delete',
                      width: 150.0,
                      disabled: ListService.isLoading,
                    ),
                    AppButton(
                      onPressed: () {
                        _handleUpdateItem(context, item);
                      },
                      label: 'Edit',
                      width: 150.0,
                      disabled: ListService.isLoading,
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
