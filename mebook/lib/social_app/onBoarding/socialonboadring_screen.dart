import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../networking/dio/cach_helper.dart';
import '../../shared/components/components.dart';
import '../social_login/choose_login.dart';


class OnBoardingScreen extends StatefulWidget {
  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  List<Map<String, String>> pageList = [

    { 'title': "Welcome to our Social App ",

      "subTitle": "Wish you have a nice trip",
      'url':"images/page1.png"
    },
    { "title": "Communicate with all in the world ",
      "subTitle": "Invite your friends!",
      'url':"images/page2.png"
    },
    { "title": "Take care of latest news around the world ",
      "subTitle": "be up to date",
      'url':"images/page3.png"
    }
  ];

  var controller = PageController();

  bool isLast = false;
  bool welcom = false;
  void submit(){
    CacheHelper.saveData(key: 'onBoarding', value: true).then((value){
      if(value){
        Navigator.pushAndRemoveUntil(context,
            PageTransition(child: ChooseLogin(), type: PageTransitionType.fade),
                (route)=>false
        );
      }
    }).catchError((error){
      print("sharedPrefrences error: $error");
    });

  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(

      body: Column(
        children: [
          Padding(
            padding: const EdgeInsetsDirectional.only(top: 10.0),
            child: IconButton(icon:
            welcom? Icon(Icons.keyboard_arrow_up,size: 60.0,):Icon(Icons.keyboard_arrow_down_outlined,size: 60.0,), onPressed:
            (){
              setState(() {
                welcom = !welcom;
              });
            }),
          ),
          AnimatedContainer(
            duration: Duration(milliseconds: 200),
            curve: Curves.easeInOutQuart,
            width: double.infinity,
           height: welcom? 200:0,
           decoration: BoxDecoration(
             color: Colors.amber[900],
             borderRadius: BorderRadiusDirectional.only(bottomEnd:
             Radius.circular(150.0),
               bottomStart:Radius.circular(150.0),
             )
           ),
            child: Center(
              child: Text("Welcome to our world!",style: TextStyle(fontSize: 30.0,
              fontWeight: FontWeight.w900,color: Colors.black87,fontStyle: FontStyle.italic),),
            ),
          ),
          Expanded(
            child: PageView.builder(
              itemBuilder: (context, index) {
                return Components().buildPageItem(
                  title: pageList[index]['title'],
                  subTitle: pageList[index]['subTitle'],
                  url: pageList[index]['url'],);
              },
              itemCount: pageList.length,
              controller: controller,
              physics: BouncingScrollPhysics(),
              onPageChanged: (index) {
                if (index == pageList.length - 1) {
                  setState(() {
                    isLast = true;
                  });
                } else {
                  setState(() {
                    isLast = false;
                  });
                }
              },

            ),
          ),
          Padding(
            padding: const EdgeInsetsDirectional.only(start:30.0,end: 30.0,bottom: 30.0),
            child: Row(
              children: [
                SmoothPageIndicator(
                  controller: controller, count: pageList.length,
                  effect: ExpandingDotsEffect(
                      dotColor: Colors.grey,
                      activeDotColor: Theme
                          .of(context)
                          .primaryColor,
                      dotHeight: 15,
                      dotWidth: 15,
                      spacing: 3.0

                  ),
                ),
                Spacer(),
                FloatingActionButton(
                  child: Icon(Icons.arrow_forward_ios),
                  onPressed: () {

                    if (isLast) {
                      submit();

                    }else{
                      controller.nextPage(duration: Duration(milliseconds: 1000),
                          curve: Curves.easeOutSine);
                    }
                  },
                ),
              ],
            ),
          )
        ],
      ),

    );
  }
}
