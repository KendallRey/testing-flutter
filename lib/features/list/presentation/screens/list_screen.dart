import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:normal_list/app/router.dart';
import 'package:normal_list/features/list/data/list_item_model.dart';
import 'package:normal_list/features/list/data/list_service.dart';

class ListScreen extends StatelessWidget {
  ListScreen({super.key});

  final ScrollController _scrollController = ScrollController();

  final User? user = FirebaseAuth.instance.currentUser;
  final ListService _listService = ListService();

  void handleClickItem(BuildContext ctx, String id) async {
    if (ctx.mounted) {
      ctx.pushNamed(AppRoutes.viewListItemName,
          pathParameters: {AppRoutes.id: id});
    }
  }

  void _scrollToBottom() {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: Duration(milliseconds: 500),
      curve: Curves.easeOut,
    );
  }

  void _scrollToTop() {
    _scrollController.animateTo(
      _scrollController.position.minScrollExtent,
      duration: Duration(milliseconds: 500),
      curve: Curves.easeOut,
    );
  }

  void _handleOnTapText(BuildContext ctx, String? textToCopy) {
    if (textToCopy == null) return;
    if (ctx.mounted) {
      Clipboard.setData(ClipboardData(text: textToCopy));
      ScaffoldMessenger.of(ctx)
          .showSnackBar(SnackBar(content: Text('Copied: $textToCopy')));
    }
  }

  Future<bool?> _showItemViewDialog(
      BuildContext ctx, ListItemModel item) async {
    return showDialog(
        context: ctx,
        builder: (context) {
          return AlertDialog(
            title: GestureDetector(
              onTap: () => _handleOnTapText(context, item.code),
              child: Text(
                item.code,
                style: Theme.of(context).textTheme.titleLarge,
                textAlign: TextAlign.center,
              ),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
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
            ),
            actions: [
              TextButton(
                onPressed: () => context.pop(false),
                child: Text('Close'),
              ),
              ElevatedButton(
                onPressed: () => handleClickItem(ctx, item.id),
                child: Text('View'),
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: _listService.getUserItemsDecrypted(user!.uid),
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No data found'));
          }
          final items = snapshot.data!;
          return Stack(
            children: [
              GridView.builder(
                controller: _scrollController,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                ),
                padding: EdgeInsets.all(8.0),
                itemCount: items.length,
                itemBuilder: (ctx, index) {
                  var item = items[index];
                  ImageProvider<Object> imageDisplay = item.image != null
                      ? FileImage(item.image!)
                      : AssetImage('assets/sample.png');
                  return Card(
                    child: InkWell(
                      borderRadius: BorderRadius.circular(16),
                      onTap: () {
                        _showItemViewDialog(context, item);
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Container(
                          decoration: BoxDecoration(
                              image: DecorationImage(
                            image: imageDisplay,
                            fit: BoxFit.cover,
                          )),
                          child: Stack(
                            alignment: Alignment.bottomCenter,
                            children: [
                              Positioned(
                                  bottom: 0,
                                  left: 0,
                                  right: 0,
                                  child: Container(
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      color: Theme.of(context).primaryColorDark,
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          item.code,
                                          style: Theme.of(context)
                                              .textTheme
                                              .labelLarge,
                                        ),
                                        Text(
                                          overflow: TextOverflow.ellipsis,
                                          item.title,
                                          style: Theme.of(context)
                                              .textTheme
                                              .labelMedium,
                                        )
                                      ],
                                    ),
                                  ))
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
              Positioned(
                  left: 20,
                  bottom: 20,
                  child: Opacity(
                    opacity: 0.3,
                    child: Column(
                      children: [
                        FloatingActionButton.small(
                          onPressed: _scrollToTop,
                          child: Icon(Icons.arrow_upward),
                        ),
                        FloatingActionButton.small(
                          onPressed: _scrollToBottom,
                          child: Icon(Icons.arrow_downward),
                        )
                      ],
                    ),
                  ))
            ],
          );
        });
  }
}
