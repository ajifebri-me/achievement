import 'package:achievement/app/modules/auth/controllers/auth_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginView extends StatelessWidget {
  LoginView({Key? key}) : super(key: key);

  final AuthController controller = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(
            vertical: 100,
            horizontal: 15,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 80,
                width: 80,
                child: CircleAvatar(
                  child: Icon(Icons.lock),
                ),
              ),
              inputField(
                label: "Email",
                hintText: "",
                textcontroller: this.controller.email,
              ),
              inputField(
                label: "Password",
                hintText: "",
                obscureText: true,
                textcontroller: this.controller.password,
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                width: Get.width,
                height: 45,
                child: ElevatedButton(
                  onPressed: () {
                    this.controller.login();
                  },
                  child: Text(
                    "Login",
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
    );
  }

  Column inputField(
      {required String label,
      required String hintText,
      bool obscureText = false,
      TextEditingController? textcontroller,
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
            obscureText: obscureText,
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
