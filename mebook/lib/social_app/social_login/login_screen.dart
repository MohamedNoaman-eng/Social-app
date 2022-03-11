import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:mebook1/shared/components/components.dart';
import 'package:mebook1/shared/components/constants.dart';
import 'package:mebook1/social_app/bloc/bloc_cubit.dart';
import 'package:mebook1/social_app/bloc/bloc_states.dart';
import 'package:mebook1/social_app/social_home_layout/social_home.dart';
import 'package:mebook1/social_app/social_register/social_register_screen.dart';
import 'package:page_transition/page_transition.dart';


class SocialLoginScreen extends StatelessWidget {
  var keyForm = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, AllSocialStates>(
      listener: (context, state) {
        if (state is SocialLoginSuccessfullyState) {
          Navigator.pushAndRemoveUntil(
              context,
              PageTransition(child: SocialHomeLayout(), type: PageTransitionType.bottomToTop,duration: const Duration(seconds: 1)),
                  (route) => false);
          SocialCubit.get(context).getPosts(myID);

        } else if (state is SocialLoginErrorState) {
          Components()
              .showToast(text: "${state.error}", state: ToastState.Error);
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsetsDirectional.only(top: 20.0),
                  child: Image(
                    image: AssetImage("images/login.png"), fit: BoxFit.fill,),
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.only(
                      start: 30.0, end: 30.0, top: 10.0, bottom: 10.0
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30.0)
                    ),
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    child: Card(
                      color: Colors.black.withOpacity(0.9),

                      elevation: 20.0,
                      child: Padding(
                        padding: const EdgeInsetsDirectional.only(
                            start: 20.0, end: 20.0, top: 20.0, bottom: 20.0),
                        child: SingleChildScrollView(
                          child: Form(
                            key: keyForm,
                            child: Column(
                              // crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                    "Login",
                                    style:
                                    TextStyle(fontSize: 35.0,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w700)
                                ),
                                Divider(color: Colors.white,),

                                Components().buildTextFormFieldLogin(
                                  controller: emailController,
                                  onchange: (String value) {
                                    if (keyForm.currentState.validate()) {
                                      return null;
                                    }
                                    return "Email must not be empty";
                                  },
                                  validate: (String value) {
                                    if (value.isEmpty) {
                                      return "Email must not be empty";
                                    }
                                    return null;
                                  },
                                  label: "Email",
                                  type: TextInputType.emailAddress,
                                  prefix: Icon(
                                    Icons.email, color: Colors.white,),
                                ),
                                Divider(color: Colors.white,),
                                Components().buildTextFormFieldLogin(
                                  onSubmit: (value) {},
                                  controller: passwordController,
                                  secure: true,
                                  onchange: (value) {
                                    if (keyForm.currentState.validate()) {
                                      return null;
                                    } else {
                                      return "Password does not be empty!";
                                    }
                                  },
                                  type: TextInputType.number,
                                  validate: (String value) {
                                    if (value.isEmpty) {
                                      return "Password must not be empty";
                                    }
                                    return null;
                                  },
                                  label: "Password",
                                  prefix: Icon(
                                    Icons.lock_outline, color: Colors.white,),
                                ),
                                Divider(color: Colors.white,),

                                state is! SocialLoginLoadingState
                                    ? Components().buildButtonLogin(
                                  title: "Login",
                                  onPressed: () {
                                    if (keyForm.currentState.validate()) {
                                      SocialCubit.get(context).loginUser(
                                          email: emailController.text,
                                          password: passwordController.text);
                                    }
                                  },
                                )
                                    : Center(
                                  child: SpinKitCircle(
                                    duration: Duration(seconds: 1)
                                    ,
                                    color: Colors.deepOrange,
                                  ),
                                ),
                                SizedBox(
                                  height: 5.0,
                                ),
                                Padding(
                                  padding:
                                  const EdgeInsetsDirectional.only(start: 8.0),
                                  child: Row(
                                    children: [
                                      Text(
                                        "Do not have an account ?",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            color: Colors.white),
                                      ),
                                      TextButton(
                                        onPressed: () =>
                                            Navigator.pushAndRemoveUntil(
                                                context, PageTransition(
                                                child: SocialRegisterScreen(),
                                                duration: Duration(milliseconds: 700),
                                                type: PageTransitionType
                                                    .rightToLeft), (
                                                route) => false)
                                        ,
                                        child: Text(
                                          "Register",
                                          style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {},
                                  child: Text(
                                    "Forget my password ?",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
