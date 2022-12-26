import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:login/models/category.dart';
import 'package:login/ui/menu/menu_controller.dart';

class MenuPage extends StatelessWidget {
  MenuPage({super.key});

  final MenuController menuController = MenuController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: (){
              menuController.logout(context);
            }, 
            icon: const Icon(Icons.logout))
        ],
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection("highlights").snapshots(),
        builder: (context, snapshot) {
            if(snapshot.data != null){
              return SingleChildScrollView(
                child: Column(
                  children: [
                    buildSlider(snapshot.data!.docs),
                    Padding(
                      padding: const EdgeInsets.fromLTRB( 20, 10, 20, 0),
                      child: Column(
                        children: [
                          buildCategories(
                            [
                              Category(name: "DESENVOLVIMENTO", color: Colors.pink[100]!),
                              Category(name: "FINANCAS", color: Colors.yellow[100]!),
                              Category(name: "NEGÓCIOS", color: Colors.purple[100]!),
                              Category(name: "TI E SOFTWARE", color: Colors.orange[100]!),
                            ]
                          ),
                          buildPopularsCourses(["MISTÉRIO", "POESIA", "CLÁSSICOS", "ROMANCE"])
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }
          else{
            return Container();
          }
        }
      ),
    );
  }

  buildSlider(List<QueryDocumentSnapshot<Map<String, dynamic>>> data){
    return SizedBox(
      width: double.infinity,
      height: 200,
      child: ListView.builder(
        itemCount: data.length,
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return SizedBox(
            width: 400,
            child: Image.network(data[index]["image"], fit: BoxFit.fitWidth),
          );
        },
      ),
    );
  }

  buildCategories(List<Category> categories){
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection("categories").snapshots(),
      builder: (context, snapshot) {
        if(snapshot.data != null){
            return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text("Categories", style: TextStyle(fontSize: 20 ,fontWeight: FontWeight.w600)), 
                  Text("VIEW ALL"), 
                ],
              ),
              const SizedBox(height: 15),
              Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 130,
                      width: double.maxFinite,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: 3,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.fromLTRB(0, 10, 15, 10),
                            child: Container(
                              width: 250,
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: categories[index].color),
                              child: Row(
                                children: [
                                  const SizedBox(width: 15),
                                  Container(
                                    height: 80,
                                    width: 80,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(40),
                                      color: Colors.white,
                                      image: DecorationImage(image: NetworkImage(snapshot.data!.docs[index]["image"]), fit: BoxFit.fitHeight)
                                    ),
                                  ),
                                  const SizedBox(width: 15),
                                  Text(categories[index].name, style: const TextStyle(fontWeight: FontWeight.w500))
                                ],
                              ),
                            ),
                          );
                        } ,
                      ),
                    ),
                  )
                ],
              )
            ]
          );
        }
        return Container();
      }
    );
  }

  buildPopularsCourses(List<String> categories){
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection("courses").snapshots(),
      builder: (context, snapshot) {
        if(snapshot.data != null){
            return Padding(
            padding: const EdgeInsets.fromLTRB( 0, 30, 0, 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text("Popular courses", style: TextStyle(fontSize: 20 ,fontWeight: FontWeight.w600)), 
                    Text("VIEW ALL"), 
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 270,
                        width: double.maxFinite,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: 4,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.fromLTRB(0, 10, 15, 10),
                              child: Container(
                                width: 240,
                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Colors.grey),
                                child: Stack(
                                  children: [
                                    Container(
                                    decoration: BoxDecoration(
                                      color: Colors.black, 
                                      image: DecorationImage(image: NetworkImage(snapshot.data!.docs[index]["image"]), fit: BoxFit.fill),
                                    ),
                                    height: 150,
                                    ),
                                    Positioned(
                                      bottom: 70,
                                      right: 10,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(30),
                                          color: Colors.blue[700],
                                        ),
                                        height: 60,
                                        width: 60,
                                        child: const Icon(Icons.play_arrow, color: Colors.white, size: 30),
                                      ),
                                    ),
                                    Positioned(
                                      width: 200,
                                      bottom: 5,
                                      left: 10,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(snapshot.data!.docs[index].id, style: const TextStyle(fontWeight: FontWeight.w600)),
                                          Row(
                                            children: [
                                              const Text("by ", style: TextStyle(fontWeight: FontWeight.w400)),
                                              Text(snapshot.data!.docs[index]["teacher"], style: const TextStyle(fontWeight: FontWeight.w500)),
                                            ],
                                          ),
                                          const SizedBox(height: 15),
                                          Row(
                                            children: [
                                              Row(
                                                children: [
                                                    const Icon(Icons.thumb_up, size: 17), 
                                                    const SizedBox(width: 5),
                                                    Text("${snapshot.data!.docs[index]["likes"]}"),
                                                ],
                                              ),
                                              const SizedBox(width: 100),
                                              Row(
                                                children: [
                                                  const Icon(Icons.access_time, size: 17,), 
                                                  const SizedBox(width: 5),
                                                  Text("${snapshot.data!.docs[index]["time"]/3600}H"), 
                                                ],
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 10),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            );
                          } ,
                        ),
                      ),
                    )
                  ],
                )
              ]
            ),
          );
        }
       return Container(); 
      }
    );
  }



}