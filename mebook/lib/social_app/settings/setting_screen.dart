
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mebook1/shared/components/components.dart';
import 'package:mebook1/shared/components/constants.dart';
import 'package:mebook1/social_app/bloc/bloc_cubit.dart';
import 'package:mebook1/social_app/bloc/bloc_states.dart';
import 'package:mebook1/social_app/edit_user/social_edit_user.dart';
import 'package:page_transition/page_transition.dart';


class SocialSettingsScreen extends StatelessWidget {
  List<Color> gridentcolor = [Colors.black, Colors.white];
  Widget buildUserPost(context,List<Map<String,dynamic>> list, index) {
    SocialCubit cubit = SocialCubit.get(context);
    return Card(
      elevation: 5.0,
      color: SocialCubit.get(context).Mode?Colors.black:Colors.white,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsetsDirectional.only(
                start: 5.0, end: 5.0, top: 5.0, bottom: 5.0),
            child: Row(
              children: [
                cubit.userInfo['profileImage']!=null?CircleAvatar(
                  backgroundImage:cubit.userInfo['profileImage']==null?AssetImage("images/loading.png"):
                  NetworkImage(
                    "${cubit.userInfo['profileImage']}" ,
                  ),

                  radius: 20.0,
                ):
                CircleAvatar(
                  backgroundImage:AssetImage("images/loading.png"),


                  radius: 20.0,
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.only(start: 7.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            "${cubit.userInfo['name']}",
                            style: TextStyle(fontWeight: FontWeight.w700,color:SocialCubit.get(context).Mode?Colors.white:Colors.black),
                          ),
                          SizedBox(
                            width: 2.0,
                          ),
                          Icon(
                            Icons.verified,
                            color: Colors.blue,
                            size: 15.0,
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            "12:04 pm",
                            style: TextStyle(
                              fontSize: 11.0, fontWeight: FontWeight.w300,color:SocialCubit.get(context).Mode?Colors.white:Colors.black),
                          ),
                          SizedBox(width: 5.0,),
                          Icon(Icons.public,size: 15,color:SocialCubit.get(context).Mode?Colors.white:Colors.black)
                        ],
                      ),
                    ],
                  ),
                ),
                Spacer(),
                IconButton(
                    icon: Icon(
                      Icons.menu,
                      size: 20.0,
                        color:SocialCubit.get(context).Mode?Colors.white:Colors.black
                    ),
                    onPressed: () {})
              ],
            ),
          ),


          Padding(
            padding: const EdgeInsetsDirectional.only(
                start: 7.0, end: 5.0,  bottom: 5.0),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    "${list[index]['description']}",
                    style: TextStyle(
                      fontSize: 15.0,
                        color:SocialCubit.get(context).Mode?Colors.white:Colors.black
                    ),
                    maxLines: 2,
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),

              ],
            ),
          ),
          Divider(color:SocialCubit.get(context).Mode?Colors.white:Colors.black,),
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5.0),
              child: cubit.userPosts[index]['image'] !=""? Container(
                decoration:
                BoxDecoration(borderRadius: BorderRadius.circular(10.0)),
                clipBehavior: Clip.antiAliasWithSaveLayer,
                child: FadeInImage(
                    image:
                    NetworkImage(
                        "${list[index]['image']}"),
                    fit: BoxFit.cover,
                    placeholder: AssetImage("images/loading.png")
                ),
              ):SizedBox(height: 10.0,)
          ),

          Padding(
            padding: const EdgeInsetsDirectional.only(start: 2.5, end: 2.5),
            child: Card(
              color: cubit.Mode?Colors.black:Colors.white,
              elevation: 1.0,
              child: Container(
                width: double.infinity,
                height: 40.0,
                child: Row(
                  children: [
                    Row(
                      children: [
                        IconButton(
                            icon: Icon(
                              Icons.favorite_outline,
                              color: Colors.red,
                            ),
                            onPressed: () {}),
                        Text("120",style: TextStyle(color:SocialCubit.get(context).Mode?Colors.white:Colors.black),),
                      ],
                    ),
                    SizedBox(
                      width: 15.0,
                    ),
                    Row(
                      children: [
                        IconButton(
                            icon: Icon(
                              Icons.chat_bubble_outline,
                              color: Colors.yellow[700],
                            ),
                            onPressed: () {}),
                        Text("300 comment",style: TextStyle(color:SocialCubit.get(context).Mode?Colors.white:Colors.black),),
                      ],
                    ),
                    SizedBox(
                      width: 15.0,
                    ),
                    Row(
                      children: [
                        IconButton(
                            icon: Icon(
                              Icons.share,
                              color: Colors.blue,
                            ),
                            onPressed: () {}),
                        Padding(
                          padding: const EdgeInsetsDirectional.only(end: 10.0),
                          child: Text("share",style: TextStyle(color:SocialCubit.get(context).Mode?Colors.white:Colors.black),),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Divider(
            color:SocialCubit.get(context).Mode?Colors.white:Colors.black,
            ),
          ),
          Container(
            width: double.infinity,
            height: 45,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundImage: cubit.userInfo['profileImage']==null?AssetImage("images/loading.png"):NetworkImage(
                        "${cubit.userInfo['profileImage']}"),
                  ),
                  TextButton(
                      onPressed: () {},
                      child: Text(
                        "write comment...",
                        style: TextStyle(fontSize: 10.0, color:SocialCubit.get(context).Mode?Colors.white:Colors.black),
                      )),
                  Spacer(),
                  Padding(
                      padding: const EdgeInsetsDirectional.only(end: 4.0),
                      child: TextButton(

                        onPressed: (){
                          cubit.doLike(cubit.postsID[index],myID);
                        },
                        child: Row(
                          children: [
                            cubit.like? Icon(Icons.favorite,color: Colors.red,):Icon(Icons.favorite_outline_sharp,color: Colors.red,),

                            SizedBox(width: 3.0,),
                            Text("Like",style: TextStyle(color:SocialCubit.get(context).Mode?Colors.white:Colors.black),)
                          ],
                        ),
                      )
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, AllSocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          body: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsetsDirectional.only(
                      start: 5.0, end: 5.0, top: 10.0),
                  child: Container(
                    height: 255,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(5.0),
                        topLeft: Radius.circular(5.0),
                      ),
                    ),
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        Align(
                          alignment: Alignment.topCenter,
                          child: Container(
                            height: 210,
                            width: double.infinity,
                            child: Image(
                              image: NetworkImage(SocialCubit.get(context)
                                  .userInfo['coverImage']),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 50,
                          child: CircleAvatar(
                            radius: 45,
                            backgroundImage: NetworkImage(
                                SocialCubit.get(context)
                                    .userInfo['profileImage']                            ),
                            child: Align(
                              alignment: Alignment(.9, 0.8),
                              child: CircleAvatar(
                                radius: 10.0,
                                backgroundColor: Colors.green,
                              ),
                            ),
                          ),
                        ),



                      ],
                    ),
                  ),
                ),
                SizedBox(height: 5,),
                Padding(
                  padding: const EdgeInsetsDirectional.only(start: 7.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            SocialCubit.get(context)
                                .userInfo['name'],
                            style: TextStyle(
                                fontWeight: FontWeight.w700, fontSize: 20.0,color: SocialCubit.get(context).Mode?Colors.white:Colors.black),
                          ),
                          SizedBox(
                            width: 5.0,
                          ),
                          Icon(
                            Icons.verified,
                            color: Colors.blue,
                            size: 15.0,
                          )
                        ],
                      ),
                      SizedBox(
                        height: 3.0,
                      ),
                      Text(
                        "January 21, 2021 at 11:00 pm",
                        style: TextStyle(
                            fontSize: 11.0, fontWeight: FontWeight.w300,color: SocialCubit.get(context).Mode?Colors.white:Colors.black),
                      ),
                      SizedBox(
                        height: 3.0,
                      ),
                      Text(
                        SocialCubit.get(context)
                            .userInfo['bio'],
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w600,fontStyle: FontStyle.italic,color: SocialCubit.get(context).Mode?Colors.white:Colors.black),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        Text(
                          "3K",
                          style: TextStyle(
                              fontWeight: FontWeight.w800, fontSize: 15.0,color: SocialCubit.get(context).Mode?Colors.white:Colors.black),
                        ),
                        Text(
                          "Followers",style: TextStyle(color: SocialCubit.get(context).Mode?Colors.white:Colors.black),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 30.0,
                    ),
                    Column(
                      children: [
                        Text(
                          "200",
                          style: TextStyle(
                              fontWeight: FontWeight.w800, fontSize: 15.0,color: SocialCubit.get(context).Mode?Colors.white:Colors.black),
                        ),
                        Text(
                          "Following",style: TextStyle(color: SocialCubit.get(context).Mode?Colors.white:Colors.black),
                        ),
                      ],
                    ),


                  ],
                ),
                SizedBox(
                  height: 20.0,
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.only(
                      start: 10.0, end: 10.0, top: 10.0, bottom: 10.0),
                  child: Row(
                    children: [
                      Expanded(
                          child: Column(
                        children: [
                          IconButton(
                            icon: Icon(
                              Icons.messenger_outline,
                              color: Colors.blue,
                            ),
                            onPressed: (){},
                          ),
                          Text("Message",style: TextStyle(color: SocialCubit.get(context).Mode?Colors.white:Colors.black)),
                        ],
                      )),
                      Expanded(
                          child: Column(
                        children: [
                          IconButton(
                            icon: Icon(
                              Icons.photo_camera_back,
                              color: Colors.blue,
                            ),
                            onPressed: (){},
                          ),
                          Text("Photos",style: TextStyle(color: SocialCubit.get(context).Mode?Colors.white:Colors.black)),
                        ],
                      )),
                      Expanded(
                          child: Column(
                        children: [
                          IconButton(
                            icon: Icon(
                              Icons.favorite_outline,
                              color: Colors.red,
                            ),
                            onPressed: (){},
                          ),
                          Text("Favourites",style: TextStyle(color: SocialCubit.get(context).Mode?Colors.white:Colors.black)),
                        ],
                      )),
                      Expanded(
                          child: Column(
                        children: [
                          IconButton(
                            icon: Icon(
                              Icons.info,
                              color: Colors.blue,
                            ),
                            onPressed: (){},
                          ),
                          Text("About",style: TextStyle(color: SocialCubit.get(context).Mode?Colors.white:Colors.black)),
                        ],
                      )),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.only(
                      start: 10.0, end: 10.0, top: 10.0, bottom: 10.0),
                  child: Row(
                    children: [
                      Container(
                          width: 240,
                          child: Components().buildButtonLogin(
                              onPressed: () {}, title: "Add Photos")),
                      SizedBox(
                        width: 7.0,
                      ),
                      Expanded(
                          child: Components().buildButtonLogin(
                              onPressed: () {
                                SocialCubit.get(context).setEditField();
                                Navigator.pushAndRemoveUntil(context, PageTransition(child: EditUserScreen(),
                                    type: PageTransitionType.rightToLeft,duration: Duration(milliseconds: 500)), (route) => false);
                              }, title: "Edit")),
                    ],
                  ),
                ),
                Column(
                  children: [
                    ListView.separated(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context,index)=>buildUserPost(context,SocialCubit.get(context).userPosts,index),
                      separatorBuilder: (context,index)=>Container(width: 0.0,height: 0.0,color: Colors.black,),
                      itemCount: SocialCubit.get(context).userPosts.length,
                    )
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
