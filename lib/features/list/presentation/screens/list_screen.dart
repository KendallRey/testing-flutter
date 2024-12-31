import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:normal_list/app/router.dart';
import 'package:normal_list/features/list/data/list_service.dart';

class ListScreen extends StatelessWidget {
  ListScreen({super.key});

  final User? user = FirebaseAuth.instance.currentUser;
  final ListService _listService = ListService();

  void handleClickItem (BuildContext ctx, String id) async {
    if(ctx.mounted){
      ctx.pushNamed(AppRoutes.viewListItemName, pathParameters: { AppRoutes.id: id });
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _listService.getUserItemsDecrypted(user!.uid),
      builder: (ctx, snapshot) {
        if(snapshot.connectionState == ConnectionState.waiting){
          return Center(child: CircularProgressIndicator());
        }
        if(!snapshot.hasData || snapshot.data!.isEmpty){
          return Center(child: Text('No data found'));
        }
        final items = snapshot.data!;
        return GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
          ),
          padding: EdgeInsets.all(8.0),
          itemCount: items.length,
          itemBuilder: (ctx, index) {
          var item = items[index];
          var imageDisplay = item.image != null ? FileImage(item.image!) : AssetImage('assets/sample.png');
            return Card(
              child: InkWell(
                borderRadius: BorderRadius.circular(16),
                onTap: () {
                  handleClickItem(context, item.id);
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: imageDisplay as ImageProvider<Object>,
                        fit: BoxFit.cover,
                      )
                    ),
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
                                  style: Theme.of(context).textTheme.titleLarge,
                                ),
                                Text(
                                  item.title,
                                  style: Theme.of(context).textTheme.labelLarge,
                                )
                              ],
                            ),
                          )
                        )
                      ],
                    ),
                  ),
                ),
              ),
              
            );
          },
        );
      });
  }
}