import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mebook1/shared/bloc_observable.dart';
import 'package:mebook1/shared/components/constants.dart';
import 'package:mebook1/social_app/bloc/bloc_cubit.dart';
import 'package:mebook1/social_app/bloc/bloc_states.dart';
import 'package:mebook1/social_app/social_login/choose_login.dart';

import 'package:firebase_core/firebase_core.dart';

import 'networking/dio/cach_helper.dart';
import 'networking/dio/dio_healper.dart';
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  await  CacheHelper.init();
  await Firebase.initializeApp();
  bool onBoard = CacheHelper.getData(key: "onBoarding");
  myID =  CacheHelper.getData(key: "UserID");
  bool  appMode =  CacheHelper.getData(key: "mode");
  print("my app mode is $appMode");
  myToken = CacheHelper.getData(key: "token");
  DioHelper.init();
  Widget widget;
  // if(onBoarding){
  //   if(myToken == null){
  //     widget = LoginShopSreen();
  //   }else{
  //     widget = HomeShopLayout();
  //
  //   }
  //
  // }else{
  //   widget = OnBoardingScreen();
  // }
  runApp(MyApp(widget: widget,mode: appMode,userId: myID,onboard: onBoard,));

}
class MyApp extends StatelessWidget {
  final Widget widget;
  final String userId;
  final bool mode;
  final bool onboard;
  MyApp({@required this.widget,@required this.mode,@required this.userId,@required this.onboard});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (context)=>SocialCubit()),

        ],
        child: BlocConsumer<SocialCubit,AllSocialStates>(
          listener: (context,state){},
          builder: (context,state){
            return MaterialApp(
              theme: ThemeData(
                  primaryColor: Colors.deepPurpleAccent,
                  accentColor: Colors.deepOrange,
                  scaffoldBackgroundColor: Colors.white,
                  appBarTheme: AppBarTheme(
                      backwardsCompatibility: false,
                      systemOverlayStyle: SystemUiOverlayStyle(
                        statusBarColor: Colors.white,
                        statusBarIconBrightness: Brightness.dark,
                      ),
                      iconTheme: IconThemeData(
                          color: Colors.deepPurpleAccent
                      ),
                      backgroundColor: Colors.white,
                      elevation: 2.0,
                      titleTextStyle: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      )

                  ),
                  bottomNavigationBarTheme: BottomNavigationBarThemeData(
                      type: BottomNavigationBarType.fixed,
                      selectedItemColor: Colors.deepOrange,
                      elevation: 20.0
                  )
              ),
              darkTheme: ThemeData(
                primarySwatch: Colors.blue,
                scaffoldBackgroundColor: Colors.grey[900],
                appBarTheme: AppBarTheme(
                    backwardsCompatibility: false,
                    systemOverlayStyle: SystemUiOverlayStyle(
                      statusBarColor: Colors.black,
                      statusBarIconBrightness: Brightness.light,
                    ),
                    iconTheme: IconThemeData(
                        color: Colors.deepOrange
                    ),
                    backgroundColor: Colors.grey[800],
                    elevation: 2.0,
                    titleTextStyle: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    )

                ),
                bottomNavigationBarTheme: BottomNavigationBarThemeData(
                    type: BottomNavigationBarType.fixed,
                    selectedItemColor: Colors.deepOrange,
                    elevation: 20.0,
                    backgroundColor: Colors.grey[900]
                ),

              ),
              themeMode: SocialCubit.get(context).Mode==false?ThemeMode.light:ThemeMode.dark,
              debugShowCheckedModeBanner: false,
              title: "Voice Me",
              // home: onboard==false||onboard==null?

              home:ChooseLogin(),
            );
          },
        )
    );
  }
}


