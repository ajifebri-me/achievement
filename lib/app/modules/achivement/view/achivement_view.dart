import 'package:achievement/app/modules/achivement/controller/achivement_controller.dart';
import 'package:achievement/app/routes/app_routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AchimenetView extends StatelessWidget {
  final AchivementController controller = Get.find<AchivementController>();
  AchimenetView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.offAndToNamed(Routes.HOME);
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () => Get.offAndToNamed(Routes.HOME),
          ),
          title: Text("Tambah Achivement"),
        ),
        body: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.fromLTRB(15, 20, 15, 20),
            child: Column(
              children: [
                inputField(
                  label: "Achivement Name",
                  hintText: "type achievement here",
                  textcontroller: controller.achivementName,
                ),
                SizedBox(height: 15),
                inputField(
                  label: "Level",
                  hintText: "type level here",
                  textcontroller: controller.level,
                ),
                SizedBox(height: 15),
                inputField(
                  label: "Organizer",
                  hintText: "type organizer here",
                  textcontroller: controller.organizer,
                ),
                SizedBox(height: 15),
                inputField(
                  label: "Year",
                  hintText: "type year here",
                  textcontroller: controller.year,
                  typeInput: "number",
                ),
                SizedBox(height: 15),
                GetBuilder(init: controller, builder: (_) => inputImage()),
                SizedBox(
                  height: 15,
                ),
                Container(
                  width: Get.width,
                  height: 45,
                  child: ElevatedButton(
                    onPressed: () {
                      controller.create();
                    },
                    child: Text(
                      "Submit",
                    ),
                    style: ElevatedButton.styleFrom(
                      shadowColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Column inputImage() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("File"),
        SizedBox(
          height: 10,
        ),
        SizedBox(
          child: Row(
            children: [
              Flexible(
                child: Container(
                  height: 50,
                  child: TextFormField(
                    readOnly: true,
                    controller: controller.file,
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.fromLTRB(15, 5, 15, 5),
                        hintText: "File name",
                        hintStyle: TextStyle(
                          fontSize: 14,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        )),
                  ),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Container(
                height: 45,
                child: ElevatedButton(
                  onPressed: () {
                    controller.getImage();
                  },
                  child: Icon(
                    Icons.image,
                  ),
                  style: ElevatedButton.styleFrom(
                    shadowColor: Colors.transparent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }

  Column inputField(
      {required String label,
      required String hintText,
      required TextEditingController textcontroller,
      String typeInput = "text"}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label),
        SizedBox(
          height: 10,
        ),
        Container(
          height: 50,
          child: TextFormField(
            controller: textcontroller,
            keyboardType:
                typeInput == "text" ? TextInputType.text : TextInputType.number,
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
