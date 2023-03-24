import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tempalteflutter/modules/login/create_password_screen.dart';

import '../../constance/constance.dart';
import '../../constance/themes.dart';
import '../../controllers/auth/auth_controller.dart';
import '../../controllers/auth/user_session.dart';
import '../../utils/api_constants.dart';
import '../../validator/validator.dart';
import '../../widgets/progress_dialog.dart';
import 'forget_verify_otp_screen.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  var emailController = TextEditingController();
  var emailFocusNode = FocusNode();

  final _formKey = GlobalKey<FormState>();
  UserSession userSession = Get.find();

  var emailtxt = '';
  var password = '';

  @override
  void dispose() {
    emailFocusNode.dispose();
    emailController.dispose();
    super.dispose();
  }

  String? _validateEmail(String? value) {
    if (value!.isEmpty) {
      return 'Email/Mobile can not be empty';
    } else {
      if (isNumeric(value)) {
        if (value.length != 10) {
          return 'Mobile number is not valid!';
        }
      } else {
        if (!Validators().emailValidator(value)) {
          return 'Email is not valid!';
        } else {
          return null;
        }
      }

      return null;
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
                      'Forget Password',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 32,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Enter email or mobile number',
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
                        controller: emailController,
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.bold,
                          fontSize: ConstanceData.SIZE_TITLE16,
                          color: AllCoustomTheme.getBlackAndWhiteThemeColors(),
                        ),
                        autofocus: false,
                        focusNode: emailFocusNode,
                        decoration: InputDecoration(
                            labelText: 'Email Address/Mobile',
                            icon: Padding(
                              padding: const EdgeInsets.only(top: 16),
                              child: Icon(Icons.person),
                            )),
                        validator: _validateEmail,
                        // onSaved: (value) {
                        //   emailtxt = value!;
                        // },
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
                                'Forget Password',
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
    _formKey.currentState!.save();
    ProgressDialog.showProgressDialog(context);
    AuthenticationController().forgetPassword(data: {
      "EmailorNumber": emailController.text.trim(),
      "type": isNumeric(emailController.text.trim()) ? 'Number' : 'Email',
    }, endPoint: FORGOTPASSWORD).then((value) {
      Navigator.of(context).pop();
      if (value) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ForgetVerifyOTPScreen(
                emailMobile: emailController.text.trim(),
                type: isNumeric(emailController.text.trim())
                    ? 'Number'
                    : 'Email'),
          ),
        );
      }
    });
  }

  bool isNumeric(String s) {
    if (s == null) {
      return false;
    }
    return double.tryParse(s) != null;
  }
}
