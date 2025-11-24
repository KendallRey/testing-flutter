import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:normal_list/app/router.dart';
import 'package:normal_list/features/list/data/list_item_model.dart';
import 'package:normal_list/features/list/data/list_service.dart';

class ListScreen extends StatefulWidget {
  const ListScreen({super.key});
  @override
  State<ListScreen> createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  final ScrollController _scrollController = ScrollController();

  final User? user = FirebaseAuth.instance.currentUser;
  final ListService _listService = ListService();

  final List<ListItemModel> _items = [];
  DocumentSnapshot? _lastDoc;

  final int _limit = 20;
  bool _isLoading = false;
  bool _hasMore = true;

  @override
  void initState() {
    super.initState();
    _fetchData();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
              _scrollController.position.maxScrollExtent - 200 &&
          !_isLoading &&
          _hasMore) {
        _fetchData();
      }
    });
  }

  Future<void> _fetchData() async {
    if (_isLoading || !_hasMore) return;

    setState(() => _isLoading = true);

    final newItems = await _listService.getUserItemsDecryptedPaginated(
      userId: user!.uid,
      startAfter: _lastDoc,
      limit: _limit,
    );

    if (newItems.isNotEmpty) {
      final lastDoc = await _listService.getUserItemsPaginatedLastDoc(
        userId: user!.uid,
        startAfter: _lastDoc,
        limit: _limit,
      );

      _lastDoc = lastDoc;
    }
    print("======================");
    print(newItems.last.title);
    print(_lastDoc?.data());
    print("======================");
    setState(() {
      _items.addAll(newItems);
      if (newItems.length < _limit) _hasMore = false;
      _isLoading = false;
    });
  }

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
    return Stack(
      children: [
        GridView.builder(
          controller: _scrollController,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
          ),
          padding: EdgeInsets.all(8.0),
          itemCount: _items.length,
          itemBuilder: (ctx, index) {
            var item = _items[index];
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
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    item.code,
                                    style:
                                        Theme.of(context).textTheme.labelLarge,
                                  ),
                                  Text(
                                    overflow: TextOverflow.ellipsis,
                                    item.title,
                                    style:
                                        Theme.of(context).textTheme.labelMedium,
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
  }
}
