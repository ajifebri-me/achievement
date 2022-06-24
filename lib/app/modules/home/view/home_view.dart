import 'package:achievement/app/data/models/achivement_model.dart';
import 'package:achievement/app/modules/home/controller/home_controller.dart';
import 'package:achievement/app/modules/home/view/partials/shimmer_section.dart';
import 'package:achievement/app/routes/app_routes.dart';
import 'package:achievement/const.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class HoneView extends StatelessWidget {
  final HomeController controller = Get.find<HomeController>();
  HoneView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Home"),
          actions: [
            IconButton(
              onPressed: () {
                Get.offAndToNamed(Routes.SEARCH);
              },
              icon: Icon(Icons.search),
            ),
            IconButton(
              onPressed: () {
                Get.defaultDialog(
                    title: "Sure it will be logout?",
                    titleStyle: TextStyle(
                      fontSize: 15,
                    ),
                    titlePadding: EdgeInsets.only(top: 20),
                    content: Container(
                      margin: EdgeInsets.only(top: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                              this.controller.logout();
                            },
                            child: Text(
                              "Yes, logout",
                              style: TextStyle(
                                color: Colors.red,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          GestureDetector(
                            onTap: () {
                              Get.back();
                            },
                            child: Text("Cancel"),
                          ),
                        ],
                      ),
                    ));
              },
              icon: Icon(Icons.logout_sharp),
            ),
          ],
        ),
        body: Container(
            child: Obx(
          () => controller.loading.value
              ? ShimmerSection()
              : controller.data.length == 0
                  ? RefreshIndicator(
                      onRefresh: controller.get,
                      child: ListView.builder(
                        itemCount: 1,
                        itemBuilder: (_, __) => Container(
                          margin: EdgeInsets.only(top: 30),
                          child: Center(
                            child: Text("Data Not Found"),
                          ),
                        ),
                      ),
                    )
                  : RefreshIndicator(
                      onRefresh: controller.get,
                      child: ListView.builder(
                        physics: AlwaysScrollableScrollPhysics(),
                        itemCount: 1,
                        itemBuilder: (_, __) => Column(
                          children:
                              List.generate(controller.data.length, (index) {
                            DataAchivement item = controller.data[index];
                            return Slidable(
                              child: ListTile(
                                leading: SizedBox(
                                  height: 50,
                                  width: 50,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(50),
                                    child: SizedBox(
                                      height: 50,
                                      width: 50,
                                      child: Image.network(
                                        item.file!,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                                title: Row(
                                  children: [
                                    Expanded(
                                        child: Text(item.achievementName!)),
                                    Container(
                                      padding: EdgeInsets.fromLTRB(8, 2, 8, 2),
                                      decoration: BoxDecoration(
                                        color: Colors.green,
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      child: Text(
                                        item.level!,
                                        style: TextStyle(
                                          fontSize: 13,
                                          color: Colors.white,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                subtitle:
                                    Text("${item.organizer!} (${item.year})"),
                              ),
                              endActionPane: ActionPane(
                                motion: ScrollMotion(),
                                children: [
                                  SlidableAction(
                                    spacing: 2,
                                    onPressed: (_) {
                                      Get.offAndToNamed(
                                        Routes.ACHIVEMENT_EDIT,
                                        arguments: {
                                          "id": item.id,
                                        },
                                      );
                                    },
                                    icon: Icons.edit,
                                    backgroundColor: Colors.green,
                                    label: "edit",
                                  ),
                                  SlidableAction(
                                    spacing: 2,
                                    onPressed: (_) {
                                      Get.defaultDialog(
                                          title: "Sure it will be deleted?",
                                          titleStyle: TextStyle(
                                            fontSize: 15,
                                          ),
                                          titlePadding:
                                              EdgeInsets.only(top: 20),
                                          content: Container(
                                            margin: EdgeInsets.only(top: 20),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                GestureDetector(
                                                  onTap: () {
                                                    Get.back();
                                                    controller.delete(
                                                        id: item.id!);
                                                  },
                                                  child: Text(
                                                    "Yes, delete",
                                                    style: TextStyle(
                                                      color: Colors.red,
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 20,
                                                ),
                                                GestureDetector(
                                                  onTap: () {
                                                    Get.back();
                                                  },
                                                  child: Text("Cancel"),
                                                ),
                                              ],
                                            ),
                                          ));
                                    },
                                    icon: Icons.delete,
                                    backgroundColor: Colors.red,
                                    label: "delte",
                                  ),
                                ],
                              ),
                            );
                          }),
                        ),
                      ),
                    ),
        )),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Get.offAndToNamed(Routes.ACHIVEMENT_ADD);
          },
          child: Icon(Icons.add),
        ));
  }
}
