import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:mebook1/shared/components/components.dart';
import 'package:mebook1/social_app/bloc/bloc_cubit.dart';
import 'package:mebook1/social_app/bloc/bloc_states.dart';
import 'package:mebook1/social_app/social_login/login_screen.dart';
import 'package:page_transition/page_transition.dart';


class SocialRegisterScreen extends StatelessWidget {
  Widget buildTextField({
    @required label,
    @required icon,
    @required controller,
    obSecure = false,
    type = TextInputType.text,
    @required Function validate,
  }) {
    return Padding(
      padding: const EdgeInsetsDirectional.only(start: 20.0, end: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label,
            style: const TextStyle(fontSize: 15.0, fontWeight: FontWeight.w700),),
          const SizedBox(height: 10.0,),
          TextFormField(
            controller: controller,
            keyboardType: type,
            obscureText: obSecure,
            validator: validate,
            autocorrect: true,
            decoration: InputDecoration(
                labelText: label,
                labelStyle: const TextStyle(color: Colors.blue),
                fillColor: Colors.grey[300],
                filled: true,
                prefixIcon: icon,
                border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(5.0))),
          ),
        ],
      ),
    );
  }

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, AllSocialStates>(
      listener: (context, state) {
        if(state is SocialRegisterSuccessfullyState){
          Navigator.pushAndRemoveUntil(
              context,
              PageTransition(child: SocialLoginScreen(), type: PageTransitionType.rightToLeft,duration: const Duration(seconds: 1)),
                  (route) => false);
        }
      },
      builder: (context, state) {
        var keyForm = GlobalKey<FormState>();
        return Scaffold(
          body: SingleChildScrollView(
            physics: const NeverScrollableScrollPhysics(),
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsetsDirectional.only(top: 20.0),
                  child: const Image(
                    image: AssetImage("images/login.png"), fit: BoxFit.fill,),
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.only(
                      start: 30.0, end: 30.0, top: 10.0, bottom: 10.0
                  ),
                  child: Container(
                    height: 480,
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
                        child: Form(
                          key: keyForm,
                          child: Column(
                            // crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                  "Register",
                                  style:
                                  const TextStyle(fontSize: 35.0,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700)
                              ),
                              const Divider(color: Colors.white,),
                              Container(
                                height: 200,
                                child: SingleChildScrollView(
                                  physics: const BouncingScrollPhysics(),
                                  child: Column(
                                    children: [

                                      Components().buildTextFormFieldLogin(
                                        onSubmit: (value) {},
                                        controller: SocialCubit
                                            .get(context)
                                            .nameController,
                                        onchange: (value){
                                          if(keyForm.currentState.validate()){
                                            return null;
                                          }else{
                                            return "Name must not be empty!";
                                          }
                                        },
                                        validate: (String value) {
                                          if (value.isEmpty) {
                                            return "Name must not be empty";
                                          }
                                          return null;
                                        },
                                        label: "Name",
                                        prefix: const Icon(Icons.person_outline,
                                          color: Colors.white,),
                                      ),
                                      const Divider(color: Colors.white,),
                                      Components().buildTextFormFieldLogin(
                                        controller: SocialCubit
                                            .get(context)
                                            .emailController,
                                        onchange: (value){
                                          if(keyForm.currentState.validate()){
                                            return null;
                                          }else{
                                            return "Email must not be empty!";
                                          }
                                        },
                                        validate: (String value) {
                                          if (value.isEmpty) {
                                            return "Email must not be empty";
                                          }
                                          return null;
                                        },
                                        label: "Email",
                                        type: TextInputType.emailAddress,
                                        prefix: const Icon(
                                          Icons.email, color: Colors.white,),
                                      ),
                                      const Divider(color: Colors.white,),
                                      Components().buildTextFormFieldLogin(
                                        onSubmit: (value) {},
                                        controller: SocialCubit
                                            .get(context)
                                            .passwordController,
                                        secure: true,
                                        onchange: (String value){
                                          if(value.length>=6){
                                            return null;
                                          }else{
                                            return "Password must not be empty!";
                                          }
                                        },
                                        type: TextInputType.visiblePassword,
                                        validate: (String value) {
                                          if (value.isEmpty) {
                                            return "Password must not be empty";
                                          }
                                          return null;
                                        },
                                        label: "Password",
                                        prefix: const Icon(Icons.lock_outline,
                                          color: Colors.white,),
                                      ),
                                      const Divider(color: Colors.white,),
                                      Components().buildTextFormFieldLogin(
                                        onSubmit: (value) {},
                                        controller: SocialCubit
                                            .get(context)
                                            .confirmPasswordController,
                                        secure: true,
                                        onchange: (String value){
                                          if(value == SocialCubit.get(context).passwordController.text){
                                            return null;
                                          }else{
                                            return "Password does  not match!";
                                          }
                                        },
                                        type: TextInputType.visiblePassword,
                                        validate: (String value) {
                                          if (value.isEmpty) {
                                            return "Password dose not match!";
                                          }
                                          return null;
                                        },
                                        label: "Confirm Password",
                                        prefix: const Icon(
                                          Icons.lock, color: Colors.white,),
                                      ),

                                      const Divider(color: Colors.white,),
                                      Components().buildTextFormFieldLogin(
                                        onSubmit: (value) {},
                                        controller: SocialCubit
                                            .get(context)
                                            .phoneController,

                                        type: TextInputType.number,
                                        onchange: (String value){
                                          if(value.length==11){
                                            return null;
                                          }else{
                                            return "Name must not be empty!";
                                          }
                                        },
                                        validate: (String value) {
                                          if (value.isEmpty) {
                                            return "phone must not be empty";
                                          }
                                          return null;
                                        },
                                        label: "Phone",
                                        prefix: const Icon(
                                          Icons.phone, color: Colors.white,),
                                      ),


                                    ],
                                  ),
                                ),
                              ),

                              state is! SocialRegisterLoadingState
                                  ? Components().buildButtonLogin(
                                title: "Register",
                                onPressed: () {
                                  SocialCubit.get(context).registerUser(
                                      email: SocialCubit
                                          .get(context)
                                          .emailController
                                          .text,
                                      password: SocialCubit
                                          .get(context)
                                          .passwordController
                                          .text,
                                      name: SocialCubit
                                          .get(context)
                                          .nameController
                                          .text,
                                      phone: SocialCubit
                                          .get(context)
                                          .phoneController
                                          .text);
                                },
                              )
                                  : Center(
                                child: SpinKitCircle(
                                  duration: const Duration(seconds: 1)
                                  ,
                                  color: Colors.deepOrange,
                                ),
                              ),
                              const SizedBox(
                                height: 5.0,
                              ),
                              Padding(
                                padding:
                                const EdgeInsetsDirectional.only(start: 8.0),
                                child: Row(
                                  children: [
                                    const Text(
                                      "Already have an account ! ",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white),
                                    ),
                                    TextButton(
                                      onPressed: () =>
                                          Navigator.pushAndRemoveUntil(
                                              context, PageTransition(
                                              child: SocialLoginScreen(),
                                              duration: const Duration(milliseconds: 700),
                                              type: PageTransitionType
                                                  .leftToRight), (
                                              route) => false)
                                      ,
                                      child: const Text(
                                        "Login",
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsetsDirectional.only(start:
                                35.0, end: 35.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment
                                      .spaceBetween,
                                  children: [
                                    const CircleAvatar(

                                      backgroundImage: NetworkImage(
                                          "https://assets.materialup.com/uploads/8738f55d-547d-4667-91f6-2ce758957d10/preview.png"),
                                      radius: 20.0,
                                      backgroundColor: Colors.white,
                                    ),
                                    const CircleAvatar(

                                      backgroundImage: const NetworkImage(
                                          "https://cdn130.picsart.com/330352023042211.png?type=webp&to=min&r=640"),
                                      radius: 20.0,
                                      backgroundColor: Colors.white,
                                    ),
                                    const CircleAvatar(

                                      backgroundImage: const NetworkImage(
                                          "https://listimg.pinclipart.com/picdir/s/109-1097804_analyze-cracked-facebook-logo-clipart.png"),
                                      radius: 20.0,
                                      backgroundColor: Colors.white,
                                    ),
                                    const CircleAvatar(

                                      backgroundImage: const NetworkImage(
                                          "https://www.pngitem.com/pimgs/m/57-575376_whatsapp-splash-png-image-free-download-searchpng-instagram.png"),
                                      radius: 20.0,
                                      backgroundColor: Colors.white,
                                    )
                                  ],
                                ),
                              )

                            ],
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
