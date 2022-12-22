import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class MenuPage extends StatelessWidget {
  const MenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection("highlights").snapshots(),
        builder: (context, snapshot) {
            if(snapshot.data != null){
              return Column(
                children: [
                  ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return Image.network(snapshot.data!.docs[index]["image"], fit: BoxFit.cover);
                    },
                  )
                ],
              );
            }
          else{
            return Container();
          }
        }
      ),
    );
  }

}