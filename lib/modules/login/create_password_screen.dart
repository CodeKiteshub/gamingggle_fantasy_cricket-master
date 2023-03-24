import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constance/constance.dart';
import '../../constance/themes.dart';
import '../../controllers/auth/auth_controller.dart';
import '../../controllers/auth/user_session.dart';
import '../../utils/api_constants.dart';
import '../../validator/validator.dart';
import '../../widgets/progress_dialog.dart';
import '../../widgets/toast_message.dart';
import 'loginView.dart';

class CreatePasswordScreen extends StatefulWidget {
  const CreatePasswordScreen({Key? key}) : super(key: key);

  @override
  State<CreatePasswordScreen> createState() => _CreatePasswordScreenState();
}

class _CreatePasswordScreenState extends State<CreatePasswordScreen> {
  var passwordController = TextEditingController();
  var confirmPasswordController = TextEditingController();
  var passwordFocusNode = FocusNode();
  var confirmPasswordFocusNode = FocusNode();
  var _obscureText = true;
  var _obscureConfirmText = true;
  final _formKey = GlobalKey<FormState>();
  UserSession userSession = Get.find();

  @override
  void dispose() {
    passwordController.dispose();
    confirmPasswordController.dispose();
    passwordFocusNode.dispose();
    confirmPasswordFocusNode.dispose();
    super.dispose();
  }

  // String? _validateEmail(String? value) {
  //   if (value!.isEmpty) {
  //     return 'Email/Mobile can not be empty';
  //   } else {
  //     if (isNumeric(value)) {
  //       if (value.length != 10) {
  //         return 'Mobile number is not valid!';
  //       }
  //     } else {
  //       if (!Validators().emailValidator(value)) {
  //         return 'Email is not valid!';
  //       } else {
  //         return null;
  //       }
  //     }
  //
  //     return null;
  //   }
  // }

  String? _validatePassword(String? value) {
    if (value!.isEmpty) {
      return 'Password can not be empty';
    } else {
      if (!Validators().passwordValidator(value)) {
        return 'Password length should be greater than 6 chars.';
      } else {
        return null;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.all(20),
            padding: EdgeInsets.only(bottom: 10),
            decoration: BoxDecoration(
              color: AllCoustomTheme.getThemeData().backgroundColor,
              borderRadius: BorderRadius.circular(12.0),
              border: Border.all(
                width: 1.0,
                color: AllCoustomTheme.getTextThemeColors().withOpacity(0.5),
              ),
              boxShadow: <BoxShadow>[
                BoxShadow(
                    color:
                        AllCoustomTheme.getTextThemeColors().withOpacity(0.5),
                    offset: Offset(0, 1),
                    blurRadius: 3.0),
              ],
            ),
            child: Form(
              key: _formKey,
              child: Container(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Create Password',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 32,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Enter new password and confirm password',
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 18,
                          color: Colors.grey),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      child: TextFormField(
                        controller: passwordController,
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.bold,
                          fontSize: ConstanceData.SIZE_TITLE16,
                          color: AllCoustomTheme.getBlackAndWhiteThemeColors(),
                        ),
                        autofocus: false,
                        focusNode: passwordFocusNode,
                        keyboardType: TextInputType.text,
                        obscureText: _obscureText,
                        decoration: InputDecoration(
                          labelStyle: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: ConstanceData.SIZE_TITLE16,
                          ),
                          labelText: 'Password',
                          icon: Padding(
                            padding: const EdgeInsets.only(top: 16),
                            child: Icon(Icons.lock),
                          ),
                          suffixIcon: GestureDetector(
                            dragStartBehavior: DragStartBehavior.down,
                            onTap: () {
                              setState(() {
                                _obscureText = !_obscureText;
                              });
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(top: 14),
                              child: Icon(
                                _obscureText
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                semanticLabel: _obscureText
                                    ? 'show password'
                                    : 'hide password',
                              ),
                            ),
                          ),
                        ),
                        validator: _validatePassword,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      child: TextFormField(
                        controller: confirmPasswordController,
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.bold,
                          fontSize: ConstanceData.SIZE_TITLE16,
                          color: AllCoustomTheme.getBlackAndWhiteThemeColors(),
                        ),
                        autofocus: false,
                        focusNode: confirmPasswordFocusNode,
                        keyboardType: TextInputType.text,
                        obscureText: _obscureConfirmText,
                        decoration: InputDecoration(
                          labelStyle: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: ConstanceData.SIZE_TITLE16,
                          ),
                          labelText: 'Confirm Password',
                          icon: Padding(
                            padding: const EdgeInsets.only(top: 16),
                            child: Icon(Icons.lock),
                          ),
                          suffixIcon: GestureDetector(
                            dragStartBehavior: DragStartBehavior.down,
                            onTap: () {
                              setState(() {
                                _obscureConfirmText = !_obscureConfirmText;
                              });
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(top: 14),
                              child: Icon(
                                _obscureConfirmText
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                semanticLabel: _obscureConfirmText
                                    ? 'show password'
                                    : 'hide password',
                              ),
                            ),
                          ),
                        ),
                        validator: _validatePassword,
                      ),
                    ),
                    SizedBox(
                      height: 24,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Center(
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color: AllCoustomTheme.getThemeData().primaryColor,
                          borderRadius: BorderRadius.circular(50.0),
                          boxShadow: <BoxShadow>[
                            BoxShadow(
                                color: AllCoustomTheme
                                        .getBlackAndWhiteThemeColors()
                                    .withOpacity(0.5),
                                offset: Offset(0, 1),
                                blurRadius: 5.0),
                          ],
                        ),
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            borderRadius: BorderRadius.circular(50.0),
                            onTap: () {
                              _submit();
                            },
                            child: Padding(
                              padding: EdgeInsets.only(
                                  top: 10, left: 15, right: 15, bottom: 10),
                              child: Text(
                                'Create Password',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: ConstanceData.SIZE_TITLE16,
                                  fontStyle: FontStyle.italic,
                                  fontWeight: FontWeight.bold,
                                  color: AllCoustomTheme.getThemeData()
                                      .backgroundColor,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _submit() async {
    FocusScope.of(context).requestFocus(FocusNode());
    if (_formKey.currentState!.validate() == false) {
      return;
    }
    if (passwordController.text.trim() !=
        confirmPasswordController.text.trim()) {
      ShowToast.show(
          title: 'Validation Error!',
          message: 'Password and Confirm Password must be same!');
      return;
    }

    _formKey.currentState!.save();
    // widget.loginCallBack!(emailtxt, password);
    ProgressDialog.showProgressDialog(context);
    AuthenticationController().verifyOTP(data: {
      "password": passwordController.text.trim(),
      "user_id": 'Email',
    }, endPoint: UPDATENEWPASSWORD).then((value) {
      Navigator.of(context).pop();
      if (value) {
        Get.offAll(() => const LoginView());
      }
    });
  }
}
