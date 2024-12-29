import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:normal_list/app/core/model/model.dart';
import 'package:normal_list/app/router.dart';
import 'package:normal_list/features/list/data/list_item_model.dart';
import 'package:normal_list/features/list/data/list_service.dart';

class ListScreen extends StatelessWidget {
  ListScreen({super.key});

  final User? user = FirebaseAuth.instance.currentUser;
  final ListService _listService = ListService();

  void handleClickItem (BuildContext ctx, String id) async {
    if(ctx.mounted){
      ctx.push(AppRoutes.viewListItem.replaceAll(AppRoutes.id, id));
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _listService.getUserItems(user!.uid),
      builder: (ctx, snapshot) {
        if(snapshot.connectionState == ConnectionState.waiting){
          return Center(child: CircularProgressIndicator());
        }
        if(!snapshot.hasData || snapshot.data!.isEmpty){
          return Center(child: Text('No data found'));
        }
        final users = snapshot.data!;
        return GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
          ),
          padding: EdgeInsets.all(8.0),
          itemCount: users.length,
          itemBuilder: (ctx, index) {
          var user = users[index];
            return Card(
              child: InkWell(
                borderRadius: BorderRadius.circular(16),
                onTap: () {
                  handleClickItem(context, user[Model.idKey]);
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('images/sample.png'),
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
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  user[ListItemModel.codeKey],
                                  style: Theme.of(context).textTheme.titleLarge,
                                ),
                                Text(
                                  user[ListItemModel.titleKey],
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