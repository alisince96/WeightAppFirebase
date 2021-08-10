import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import 'package:weight_app_firebase/AppConsts/AppConsts.dart';
import 'package:weight_app_firebase/CommonFunctions/CommonFunctions.dart';
import 'package:weight_app_firebase/Screens/Home/Home.dart';
import 'package:weight_app_firebase/Screens/Login/bloc/login_bloc.dart';
import 'package:weight_app_firebase/Screens/Splash/Splash.dart';

class Login extends StatefulWidget {
  static String id = 'Login';

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  LoginBloc loginBloc;
  GlobalKey<ScaffoldState> globalKey = GlobalKey();
  @override
  void initState() {
    super.initState();
    loginBloc = BlocProvider.of<LoginBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: BlocConsumer(
            bloc: loginBloc,
            listener: (context, state) {
              if (state is LoadingState) {
              } else if (state is LoginError) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(state.error),
                ));
              } else if (state is LoginSuccess) {
                Navigator.pushNamedAndRemoveUntil(
                    context, HomeScreen.id, (route) => false);
              }
            },
            builder: (context, state) {
              return Scaffold(
                backgroundColor: AppConsts.primaryColor,
                //keyboard
                // resizeToAvoidBottomPadding: false,
                resizeToAvoidBottomInset: true,
                body: SingleChildScrollView(
                  child: Container(
                    height: MediaQuery.of(context).size.height * 1.0,
                    child: ModalProgressHUD(
                      inAsyncCall: state is LoadingState,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 24.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            SizedBox(
                              height: 40.0,
                            ),
                            Center(
                              child: AutoSizeText(
                                'Login',
                                style: AppConsts.whiteBold,
                                presetFontSizes: [44],
                              ),
                            ),
                            SizedBox(
                              height: 40.0,
                            ),
                            SizedBox(
                              height: 50,
                              width: deviceWidth(context) * 0.8,
                              child: RaisedButton(
                                  color: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  child: AutoSizeText(
                                    "Anonymous Login",
                                    style: AppConsts.blackBold,
                                    presetFontSizes: [22],
                                  ),
                                  onPressed: () async {
                                    loginBloc.add(CheckLogin());
                                  }),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }));
  }
}
