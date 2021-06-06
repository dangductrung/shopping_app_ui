import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shopping_app/common/form_error.dart';
import 'package:shopping_app/constants/constants.dart';
import 'package:shopping_app/generated/assets.gen.dart';
import 'package:shopping_app/pages/signin/signin.dart';
import 'package:shopping_app/theme/ui_color.dart';
import 'package:shopping_app/theme/ui_text_style.dart';

class SignUp extends StatefulWidget {
  @override
  SignUpState createState() => new SignUpState();
}

class SignUpState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>();
  String username;
  String password;
  String confirmPassword;
  TextEditingController _username, _password, _confirmPassword;
  final List<String> errors = [];
  void initState() {
    super.initState();
    setState(() {
      username = "";
      password = "";
      _username = TextEditingController();
      _password = TextEditingController();
      _confirmPassword = TextEditingController();
    });
  }

  void dispose() {
    _username.dispose();
    _password.dispose();
    _confirmPassword.dispose();
    super.dispose();
  }

  void addError({String error}) {
    if (!errors.contains(error))
      setState(() {
        errors.add(error);
      });
  }

  void removeError({String error}) {
    if (errors.contains(error))
      setState(() {
        errors.remove(error);
      });
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height / 100;
    final width = MediaQuery.of(context).size.width / 100;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: height * 15),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Assets.icons.icLogo.image(height: 120, width: 120),
              SizedBox(
                height: 16.0,
              ),
              Container(
                margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
                child: Text("Đăng ký ngay để nhận thêm nhiều ưu đãi", style: UITextStyle.black54_16_w400),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: height * 1),
                child: TextFormField(
                  validator: (value) {
                    if (value.isEmpty) {
                      addError(error: usernameNullError);
                      return "";
                    }
                    return null;
                  },
                  autocorrect: false,
                  controller: _username,
                  style: UITextStyle.mediumBlack_16_w400,
                  decoration: const InputDecoration(
                      contentPadding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
                      border: OutlineInputBorder(),
                      hintText: "Tên đăng nhập",
                      labelText: "Tên đăng nhập",
                      labelStyle: TextStyle(color: Colors.black45),
                      focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black))),
                  onChanged: (String value) {
                    if (value.isNotEmpty) {
                      removeError(error: usernameNullError);
                    }
                    username = value;
                  },
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: height * 1),
                child: TextFormField(
                  validator: (value) {
                    if (value.isEmpty) {
                      addError(error: kPassNullError);
                      return "";
                    } else if (value.isNotEmpty && value.length < 8) {
                      addError(error: kShortPassError);
                      return "";
                    } else if (value.contains(' ')) {
                      addError(error: kPassContainBlankError);
                    }
                    return null;
                  },
                  autocorrect: false,
                  obscureText: true,
                  controller: _password,
                  style: UITextStyle.mediumBlack_16_w400,
                  decoration: const InputDecoration(
                      contentPadding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
                      border: OutlineInputBorder(),
                      hintText: "Mật khẩu",
                      labelText: "Mật khẩu",
                      labelStyle: TextStyle(color: Colors.black45),
                      focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black))),
                  onChanged: (String value) {
                    if (value.isNotEmpty) {
                      removeError(error: kPassNullError);
                    } else if (value.isNotEmpty && value.length >= 8) {
                      removeError(error: kShortPassError);
                    }
                    password = value;
                  },
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: height * 1),
                child: TextFormField(
                  validator: (value) {
                    if (value.isEmpty) {
                      addError(error: kConfirmPassNullError);
                      return "";
                    } else if (value.isNotEmpty && password != confirmPassword) {
                      addError(error: kMatchPassError);
                      return "";
                    }
                    return null;
                  },
                  autocorrect: false,
                  obscureText: true,
                  controller: _confirmPassword,
                  style: UITextStyle.mediumBlack_16_w400,
                  decoration: const InputDecoration(
                      contentPadding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
                      border: OutlineInputBorder(),
                      hintText: "Nhập lại mật khẩu",
                      labelText: "Xác nhận mật khẩu",
                      labelStyle: TextStyle(color: UIColor.black45),
                      focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black))),
                  onChanged: (String value) {
                    if (value.isNotEmpty) {
                      removeError(error: kConfirmPassNullError);
                    } else if (value.isNotEmpty && password == confirmPassword) {
                      removeError(error: kMatchPassError);
                    }
                    confirmPassword = value;
                  },
                ),
              ),
              FormError(errors: errors),
              Container(
                height: 50,
                width: 400,
                margin: EdgeInsets.symmetric(vertical: height * 2),
                child: CupertinoButton(
                  color: UIColor.orangeBtn,
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      _formKey.currentState.save();
                      // if all are valid then go to success screen
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SignIn()),
                      );
                    }
                  },
                  child: Text("Đăng ký", style: UITextStyle.white_18_w400),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.baseline,
                children: <Widget>[
                  Text("Bạn đã có tài khoản? ", style: UITextStyle.grayText_16_w400),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SignIn(),
                        ),
                      );
                    },
                    child: Text("Đăng nhập ", style: UITextStyle.darkYellow_16_w600),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
