import 'package:flutter/material.dart';
import 'package:get/get.dart';

void alertValidation({required List content}) {
  Get.rawSnackbar(
    messageText: Row(
      children: [
        Icon(
          Icons.error_outline,
          size: 30,
        ),
        SizedBox(
          width: 10,
        ),
        Column(
          children: List.generate(content.length,
              (index) => Text(content.elementAt(index).text)).toList(),
        ),
      ],
    ),
    padding: EdgeInsets.all(15),
    margin: EdgeInsets.all(10),
    backgroundColor: Color(0xffffda46),
    forwardAnimationCurve: Curves.easeOutBack,
    borderRadius: 10,
    snackPosition: SnackPosition.TOP,
  );
}

void alertError({required content}) {
  Get.rawSnackbar(
    messageText: Row(
      children: [
        Icon(
          Icons.dangerous_outlined,
          size: 30,
        ),
        SizedBox(
          width: 10,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: List.generate(
              content.length,
              (index) => Text(
                content[index],
              ),
            ).toList(),
          ),
        ),
      ],
    ),
    padding: EdgeInsets.all(15),
    margin: EdgeInsets.all(10),
    backgroundColor: Color(0xfff73e3e),
    forwardAnimationCurve: Curves.easeOutBack,
    borderRadius: 10,
    snackPosition: SnackPosition.TOP,
  );
}

void alertSuccess({required content}) {
  Get.rawSnackbar(
    messageText: Row(
      children: [
        Icon(
          Icons.check_circle_outline_rounded,
          size: 30,
        ),
        SizedBox(
          width: 10,
        ),
        Expanded(
          child: Text(content),
        ),
      ],
    ),
    padding: EdgeInsets.all(15),
    margin: EdgeInsets.all(10),
    backgroundColor: Color(0xff1fb871),
    forwardAnimationCurve: Curves.easeOutBack,
    borderRadius: 10,
    snackPosition: SnackPosition.TOP,
  );
}

void alertWarning({required content}) {
  List message = [];
  if (content.message.runtimeType == String) {
    message.add(content.message);
  } else {
    Map<String, dynamic> validation = content.message;
    validation.forEach((key, value) {
      message.add(value[0]);
    });
  }

  Get.rawSnackbar(
    messageText: Row(
      children: [
        Icon(
          Icons.dangerous_outlined,
          size: 30,
        ),
        SizedBox(
          width: 10,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: List.generate(
              message.length,
              (index) => Text(
                message[index],
              ),
            ).toList(),
          ),
        ),
      ],
    ),
    padding: EdgeInsets.all(15),
    margin: EdgeInsets.all(10),
    backgroundColor: Color(0xffffda46),
    forwardAnimationCurve: Curves.easeOutBack,
    borderRadius: 10,
    snackPosition: SnackPosition.TOP,
  );
}

void dialogCircular() {
  Get.dialog(
    Container(
      width: Get.width,
      color: Colors.black.withOpacity(0.5),
      height: Get.height,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
              child: Container(
            width: 100,
            height: 100,
            padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5),
            ),
            child: SizedBox(
              height: 30,
              width: 30,
              child: Center(
                child: CircularProgressIndicator(
                  backgroundColor: Colors.grey[200],
                  strokeWidth: 3,
                ),
              ),
            ),
          )),
        ],
      ),
    ),
  );
}
