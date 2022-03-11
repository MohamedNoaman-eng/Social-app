import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mebook1/shared/components/components.dart';
import 'package:mebook1/social_app/bloc/bloc_cubit.dart';
import 'package:mebook1/social_app/bloc/bloc_states.dart';
import 'package:mebook1/social_app/social_login/login_screen.dart';
import 'package:mebook1/social_app/social_register/social_register_screen.dart';
import 'package:page_transition/page_transition.dart';

class ChooseLogin extends StatelessWidget {
  var controller = PageController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, AllSocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text("MeBook", style: TextStyle(fontSize: 25.0),),
            centerTitle: true,
           
            actions: [
              SizedBox(width: 10.0,),
              IconButton(icon: Icon(Icons.menu, size: 35,),
                  onPressed: () {}),
              SizedBox(width: 15.0,),
            ],
          ),
          body: Container(
            width: double.infinity,
            height: double.infinity,
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                children: [

                  Padding(
                    padding: const EdgeInsetsDirectional.only(top: 80.0),
                    child: Image(
                      image: AssetImage(
                        "images/page2.png",
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    height: 370,
                    decoration: BoxDecoration(
                      color: Colors.indigo,
                      borderRadius: BorderRadiusDirectional.only(
                        topEnd: Radius.circular(150.0),
                        topStart: Radius.circular(150.0),
                      ),
                    ),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 30.0,
                        ),
                        Components().buildButton(
                            title: "LOG IN", onPressed: () {
                        Navigator.pushAndRemoveUntil (
                            context, PageTransition(
                            child: SocialLoginScreen(),
                            duration: Duration(milliseconds: 700),
                            type: PageTransitionType.bottomToTop), (route) => false);
                        }),
                        Components().buildButton(
                            title: "SIGN IN", onPressed: () {
                          Navigator.pushAndRemoveUntil (
                              context, PageTransition(
                              child: SocialRegisterScreen(),
                              duration: Duration(milliseconds: 700),
                              type: PageTransitionType.bottomToTop), (route) => false);

                        }),
                        SizedBox(
                          height: 25.0,
                        ),
                        Padding(
                          padding: const EdgeInsetsDirectional.only(
                            start: 40.0, end: 40.0,),
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.5),
                                borderRadius: BorderRadius.circular(15.0)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Learn more about app",
                                  style:
                                  TextStyle(
                                      fontSize: 20.0, color: Colors.white),
                                ),
                                SizedBox(
                                  width: 5.0,
                                ),
                                TextButton(
                                    onPressed: () {},
                                    child: Text(
                                      "More",
                                      style: TextStyle(color: Colors.blue),
                                    ))
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsetsDirectional.
                          only(start: 50.0, end: 50.0, bottom: 5.0, top: 25.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CircleAvatar(

                                backgroundImage: NetworkImage(
                                    "https://assets.materialup.com/uploads/8738f55d-547d-4667-91f6-2ce758957d10/preview.png"),
                                radius: 30.0,
                                backgroundColor: Colors.white,
                              ),
                              CircleAvatar(

                                backgroundImage: NetworkImage(
                                    "https://cdn130.picsart.com/330352023042211.png?type=webp&to=min&r=640"),
                                radius: 30.0,
                                backgroundColor: Colors.white,
                              ),
                              CircleAvatar(

                                backgroundImage: NetworkImage(
                                    "https://listimg.pinclipart.com/picdir/s/109-1097804_analyze-cracked-facebook-logo-clipart.png"),
                                radius: 30.0,
                                backgroundColor: Colors.white,
                              ),
                              CircleAvatar(

                                backgroundImage: NetworkImage(
                                    "https://www.pngitem.com/pimgs/m/57-575376_whatsapp-splash-png-image-free-download-searchpng-instagram.png"),
                                radius: 30.0,
                                backgroundColor: Colors.white,
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
