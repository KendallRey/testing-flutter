import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:normal_list/app/core/widgets/button.dart';
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
                          child: item.image != null ?
                            Image(
                                image: FileImage(item.image!)
                            ) :
                            Center(
                              child: Text('No image.'),
                            )
                          ),
                        ),
                        SizedBox(height: 20),
                        Text(item.code,
                          style: Theme.of(context).textTheme.titleLarge,
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 20),
                        Text(item.title,
                          style: Theme.of(context).textTheme.bodyLarge,
                          textAlign: TextAlign.center,
                        ),
                      ],
                    )
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    spacing: 24,
                    children: [
                      AppButton(onPressed: (){},
                        label: 'Delete',
                        width: 150.0,
                        disabled: true,
                      ),
                      AppButton(onPressed: (){},
                        label: 'Edit',
                        width: 150.0,
                        disabled: true,
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
