import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ListScreen extends StatelessWidget {
  const ListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('users').snapshots(),
      builder: (ctx, snapshot) {
        if(snapshot.connectionState == ConnectionState.waiting){
          return Center(child: CircularProgressIndicator());
        }
        if(!snapshot.hasData || snapshot.data!.docs.isEmpty){
          return Center(child: Text('No data found'));
        }
        final users = snapshot.data!.docs;
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
                                  user['name'],
                                  style: Theme.of(context).textTheme.titleLarge,
                                ),
                                Text(
                                  user['name'],
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