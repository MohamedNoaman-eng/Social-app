
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:mebook1/shared/components/constants.dart';

import '../bloc/bloc_cubit.dart';
import '../bloc/bloc_states.dart';


class AddPostScreen extends StatelessWidget {
  List<Color> theme= [
     Colors.deepPurpleAccent,

    Colors.grey,
    Colors.amber,
    Colors.blue,
    Colors.black,
    Colors.deepOrange,
    Colors.green,
    Colors.orange[100],
    Colors.green[100],
    Colors.blueAccent[100],
    Colors.red[200],
    Colors.white,
    Colors.black.withOpacity(0.2),
    Colors.deepPurple[200]
  ];
  @override
  Widget build(BuildContext context) {
    var postImage = SocialCubit.get(context).postImage;
    return BlocConsumer<SocialCubit, AllSocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        SocialCubit cubit = SocialCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text("Add Post"),
            actions: [
              TextButton(
                onPressed: () {
                  if(cubit.postImage !=null) {
                    cubit.uploadPostImage(
                        id: myID, description: cubit.postController.text);
                  }else{
                    cubit.uploadUserPost(id: myID, date: DateTime.now(), image: "", description: cubit.postController.text);
                  }



                },
                child: Text(
                  "Post",
                  style: TextStyle(fontSize: 20),
                ),
              ),
              SizedBox(
                width: 20,
              )
            ],
          ),
          body: Container(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  if(state is SocialUploadPostImageLoadingState || state is  SocialUpdateUserInfoLoadingState )
                    SpinKitThreeBounce(
                      duration: Duration(seconds: 1)
                      ,
                      color: Colors.deepOrange,
                    ),
                  Padding(
                    padding: const EdgeInsetsDirectional.only(start: 10, top: 10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          backgroundImage: cubit.userInfo['profileImage'] == null
                              ? AssetImage("images/loading.png")
                              : NetworkImage(cubit.userInfo['profileImage']),
                          radius: 20.0,
                        ),
                        Padding(
                          padding: const EdgeInsetsDirectional.only(
                              start: 7.0, top: 5),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Text(
                                    cubit.userInfo['name'],
                                    style: TextStyle(fontWeight: FontWeight.w700,color: SocialCubit.get(context).Mode?Colors.white:Colors.black),
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
                                    "Only me",
                                    style: TextStyle(color: SocialCubit.get(context).Mode?Colors.white:Colors.black),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Icon(
                                    Icons.lock_outline_rounded,
                                    size: 15,
                                    color:  SocialCubit.get(context).Mode?Colors.white:Colors.black,
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    color: Colors.grey,
                  ),
                  Container(
                    color: cubit.containerColor,
                    child: Padding(
                      padding: const EdgeInsetsDirectional.only(bottom: 10.0),
                      child: Column(
                        
                        children: [
                          Padding(
                            padding: const EdgeInsetsDirectional.only(start: 25,end: 25,bottom: 10.0),
                            child: TextFormField(

                              autocorrect: true,
                              controller: cubit.postController,

                              style: TextStyle(textBaseline: TextBaseline.alphabetic),
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "write your post here...",hintStyle: TextStyle(color: Colors.blue)),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsetsDirectional.only(start: 5.0,end: 5.0),
                            child: Container(
                              height: 350,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15.0)
                              ),
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              child: cubit.postImage==null?SizedBox(height: 0.0,): Image.file(cubit.postImage),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      color: Colors.yellow[100]
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        elevation: 10.0,
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsetsDirectional.only(
                                  bottom: 10, start: 20, end: 20),
                              child: Row(
                                children: [
                                  TextButton(
                                    onPressed: () {
                                      cubit.getPostImage();
                                    },
                                    child: Row(
                                      children: [
                                        Text("Add Photos"),
                                        SizedBox(
                                          width: 2,
                                        ),
                                        Icon(Icons.add_a_photo_outlined),
                                      ],
                                    ),
                                  ),
                                  Spacer(),
                                  TextButton(onPressed: () {
                                    cubit.incX();
                                  }, child: Text("#Tags"))
                                ],
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsetsDirectional.only(
                                      bottom: 10, start: 25, end: 20),
                                  child: Text("Color",style: TextStyle(color: cubit.containerColor==Colors.white?Colors.black:cubit.containerColor,
                                      fontSize: 17.0
                                      ,fontWeight: FontWeight.w800),),
                                ),
                              ],
                            ),
                            SingleChildScrollView(
                              physics: BouncingScrollPhysics(),
                              scrollDirection: Axis.horizontal ,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                    children: [
                                      ...List.generate(theme.length, (index){
                                        return InkWell(
                                          onTap: ()=>cubit.changeContainerColor(theme[index]),
                                          child: Card(
                                            elevation: 10.0,
                                            child: Padding(
                                              padding: const EdgeInsets.all(5.0),
                                              child: CircleAvatar(backgroundColor: theme[index],),
                                            ),
                                          ),
                                        );
                                      })
                                    ]
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
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
