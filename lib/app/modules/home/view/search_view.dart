import 'package:achievement/app/data/models/achivement_model.dart';
import 'package:achievement/app/modules/home/controller/home_controller.dart';
import 'package:achievement/app/modules/home/view/partials/shimmer_section.dart';
import 'package:achievement/app/routes/app_routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';

class SearchView extends StatelessWidget {
  SearchView({Key? key}) : super(key: key);
  final HomeController controller = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.offAndToNamed(Routes.HOME);
        return true;
      },
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 15, vertical: 40),
            child: Column(
              children: [
                inputField(
                    hintText: "Search Data",
                    onChange: (value) {
                      this.controller.get(search: value);
                    }),
                Container(
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
                          : ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: 1,
                              itemBuilder: (_, __) => Column(
                                children: List.generate(controller.data.length,
                                    (index) {
                                  DataAchivement item = controller.data[index];
                                  return Slidable(
                                    child: ListTile(
                                      leading: SizedBox(
                                        height: 50,
                                        width: 50,
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(50),
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
                                              child:
                                                  Text(item.achievementName!)),
                                          Container(
                                            padding:
                                                EdgeInsets.fromLTRB(8, 2, 8, 2),
                                            decoration: BoxDecoration(
                                              color: Colors.green,
                                              borderRadius:
                                                  BorderRadius.circular(5),
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
                                      subtitle: Text(
                                          "${item.organizer!} (${item.year})"),
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
                                                title:
                                                    "Sure it will be deleted?",
                                                titleStyle: TextStyle(
                                                  fontSize: 15,
                                                ),
                                                titlePadding:
                                                    EdgeInsets.only(top: 20),
                                                content: Container(
                                                  margin:
                                                      EdgeInsets.only(top: 20),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
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
                )),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Column inputField(
      {String? label,
      String? hintText,
      TextEditingController? textcontroller,
      Function(String)? onChange,
      String typeInput = "text"}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Visibility(
            visible: label == null ? true : false, child: Text(label ?? "")),
        SizedBox(
          height: label == null ? 0 : 10,
        ),
        Container(
          height: 50,
          child: TextFormField(
            controller: textcontroller,
            keyboardType:
                typeInput == "text" ? TextInputType.text : TextInputType.number,
            onChanged: onChange,
            decoration: InputDecoration(
                contentPadding: EdgeInsets.fromLTRB(15, 5, 15, 5),
                hintText: hintText,
                hintStyle: TextStyle(
                  fontSize: 14,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                )),
          ),
        ),
      ],
    );
  }
}
