import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
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

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _listService.getUserItemDecrypted(user!.uid, widget.id),
      builder: (context, snapshot) {
        if(snapshot.connectionState == ConnectionState.waiting){
          return Center(child: CircularProgressIndicator());
        }
        if(!snapshot.hasData || snapshot.data == null){
          return Center(child: Text('No data found'));
        }
        return Scaffold(
          appBar: AppBar(
            title: Text(snapshot.data!.code),
          ),
        );
      },
    );
  }
}
