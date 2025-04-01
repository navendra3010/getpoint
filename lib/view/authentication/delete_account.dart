import 'package:flutter/material.dart';
import '../../utilities/app_button.dart';
import '../../utilities/app_constant.dart';
import '../../utilities/app_image.dart';
import '../../utilities/app_language.dart';
import '../../utilities/app_snackbar_toast_message.dart';
import 'setting_screen.dart';

class DeleteAccount extends StatefulWidget {
  static String routeName = './DeleteAccount';
  const DeleteAccount({super.key});

  @override
  _DeleteAccountState createState() => _DeleteAccountState();
}

class _DeleteAccountState extends State<DeleteAccount> {
  TextEditingController messageTextEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  deleteAccountUserValidation(String userMessage) async {}

  deleteAccountUserApiCall(String userMessage) {
    // Navigator.pushNamed(context, Sorry.routeName);
  }
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: true,
          elevation: 1,
          backgroundColor: Colors.white,
          systemOverlayStyle: AppConstant.systemUiOverlayStyle,
          leading: InkWell(
              onTap: () {},
              child: IconButton(
                icon: Image.asset(
                  AppImage.backIcon,
                  width: MediaQuery.of(context).size.width * 8 / 100,
                  height: MediaQuery.of(context).size.height * 8 / 100,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Setting()),
                  );
                },
              )),
          title: Text("Delete", style: AppConstant.appBarTitleStyle),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Center(
              child: Container(
                color: Colors.white,
                child: Column(
                  children: [
                    SizedBox(
                        height: MediaQuery.of(context).size.height * 2.8 / 100),
                    Container(
                      width: MediaQuery.of(context).size.width * 90 / 100,
                      decoration: new BoxDecoration(
                        color: Colors.white,
                        border: Border(
                          bottom: BorderSide(
                              color: Colors.black, style: BorderStyle.solid),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 6),
                        child: TextFormField(
                          style: const TextStyle(color: Colors.black),
                          keyboardType: TextInputType.multiline,
                          cursorColor: Colors.black,
                          cursorHeight: 20.0,
                          maxLines: 5,
                          maxLength: 250,
                          controller: messageTextEditingController,
                          decoration: InputDecoration(
                              counterText: "",
                              border: InputBorder.none,
                              fillColor: Colors.white,
                              filled: true,
                              hintText: "Reason",
                              hintStyle: AppConstant.textFilledStyle),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 8 / 100,
                    ),
                    AppButton(
                      text: "Sumit",
                      onPress: () {
                        deleteAccountUserValidation(
                            messageTextEditingController.text);
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
