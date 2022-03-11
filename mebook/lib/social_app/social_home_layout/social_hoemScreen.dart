
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:like_button/like_button.dart';
import 'package:mebook1/shared/components/components.dart';
import 'package:mebook1/shared/components/constants.dart';
import 'package:mebook1/social_app/bloc/bloc_cubit.dart';
import 'package:mebook1/social_app/bloc/bloc_states.dart';


class SocialHomeScreen2 extends StatelessWidget {

  Widget buildUserPost(context,List<Map<String,dynamic>> list, index) {
    SocialCubit cubit = SocialCubit.get(context);
    return Card(
      elevation: 5.0,
      clipBehavior: Clip.antiAliasWithSaveLayer,
        color: SocialCubit.get(context).Mode?Colors.black:Colors.white,
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
                            style: TextStyle(fontWeight: FontWeight.w700,
                                color: SocialCubit.get(context).Mode?Colors.white:Colors.black),
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
                                fontSize: 11.0, fontWeight: FontWeight.w300,
                                color: SocialCubit.get(context).Mode?Colors.white:Colors.black),
                          ),
                          SizedBox(width: 5.0,),
                          Icon(Icons.public,size: 15,)
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
                        color: SocialCubit.get(context).Mode?Colors.white:Colors.black
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
                        color: SocialCubit.get(context).Mode?Colors.white:Colors.black
                    ),
                    maxLines: 2,
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),

              ],
            ),
          ),
          Divider(color:  SocialCubit.get(context).Mode?Colors.white:Colors.black),
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
              color: SocialCubit.get(context).Mode?Colors.black:Colors.white,
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
                        Text("120",style: TextStyle(color: SocialCubit.get(context).Mode?Colors.white:Colors.black),),
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
                        Text("300 comment",style: TextStyle(color: SocialCubit.get(context).Mode?Colors.white:Colors.black)),
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
                          child: Text("share",style: TextStyle(color: SocialCubit.get(context).Mode?Colors.white:Colors.black)),
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
              color: Colors.black.withOpacity(0.7),
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
                        style: TextStyle(fontSize: 10.0,color: SocialCubit.get(context).Mode?Colors.white:Colors.black),
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
                          cubit.like? LikeButton():LikeButton(),

                          SizedBox(width: 3.0,),
                          Text("Like",style: TextStyle(color: SocialCubit.get(context).Mode?Colors.white:Colors.black),)
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
    return BlocConsumer<SocialCubit,AllSocialStates>(
      listener: (context,state){},
      builder: (context,state){
        return Scaffold(
          appBar: AppBar(
            title: Text("Home",style: TextStyle(color: Colors.deepOrange),),

            actions: [
              IconButton(icon: Icon(Icons.search,color: Colors.deepOrange,), onPressed: (){}),
              IconButton(icon: Icon(Icons.notifications_active,color: Colors.deepOrange,), onPressed: (){}),
              IconButton(icon: Icon(Icons.brightness_4_outlined,color: SocialCubit.get(context).Mode? Colors.white:Colors.black,),
                  onPressed: (){
                SocialCubit.get(context).changeMode();
                  }),
              SizedBox(width: 10.0,)
            ],
          ),
          body: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsetsDirectional.only(start: 10.0,end: 10.0,top: 10.0,bottom: 10.0),
                  child: Row(
                    children: [
                      CircleAvatar(
                        backgroundImage:SocialCubit.get(context).userInfo['profileImage']==null?AssetImage("images/loading.png"):
                        NetworkImage(
                          "${SocialCubit.get(context).userInfo['profileImage']}" ,
                        ),

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
                                  "${SocialCubit.get(context).userInfo['name']}",
                                  style: TextStyle(fontWeight: FontWeight.w700,
                                  color: SocialCubit.get(context).Mode?Colors.white:Colors.black),
                                ),
                                SizedBox(
                                  width: 2.0,
                                ),
                                Icon(Icons.verified,color: Colors.blue,size: 20.0,)
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
                          ),
                          onPressed: () {})
                    ],
                  ),
                ),
                SocialCubit.get(context).emailVerify?
                Container(width: 0.0,height: 0.0,):Container(
                  height: 50,
                  color: Colors.yellow[400],
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(children: [
                      Text("please verfiy your email"),
                      Spacer(),
                      OutlinedButton(child: Text("Verfiy",), onPressed: (){
                        FirebaseAuth.instance.currentUser.sendEmailVerification().then((value) {
                          SocialCubit.get(context).changeEmailverify();
                          Components().showToast(text: "Please check your email", state: ToastState.Success);
                        }).catchError((onError){
                          Components().showToast(text: "Something went wrong!", state: ToastState.Error);
                        });
                      })
                    ],),
                  ),
                ),

                Card(
                  elevation: 2.0,
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  child: Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      Image(
                        image: NetworkImage(
                            "https://img.rawpixel.com/s3fs-private/rawpixel_images/website_content/318-pom2733-eye.jpg?w=800&dpr=1&fit=default&crop=default&q=65&vib=3&con=3&usm=15&bg=F4F4F3&ixlib=js-2.2.1&s=48f5298d9d29d7782084b1bbd422b7e6"),
                        fit: BoxFit.cover,
                      ),

                    ],
                  ),
                ),
                ListView.separated(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context,index)=>buildUserPost(context,SocialCubit.get(context).userPosts,index),
                  separatorBuilder: (context,index)=>Container(width: 0.0,height: 0.0,color: Colors.black,),
                  itemCount: SocialCubit.get(context).userPosts.length,
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
