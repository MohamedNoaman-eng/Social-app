
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mebook1/social_app/bloc/bloc_cubit.dart';
import 'package:mebook1/social_app/bloc/bloc_states.dart';
import 'package:page_transition/page_transition.dart';


import 'chat_details.dart';

class UserChatScreen extends StatelessWidget {
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, AllSocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.black.withOpacity(0.9),
            titleSpacing: 10,
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Stack(
                      alignment: AlignmentDirectional.topEnd,
                      children: [
                        Padding(
                          padding:
                              EdgeInsetsDirectional.only(start: 0, top: 10),
                          child:SocialCubit.get(context)
                              .userInfo['profileImage']!=null? CircleAvatar(
                            radius: 19,
                            backgroundImage: NetworkImage(
                                SocialCubit.get(context)
                                    .userInfo['profileImage']),
                          ):CircleAvatar(
                            radius: 19,
                            backgroundImage: AssetImage("images/loading.png"),
                          ),
                        ),
                        CircleAvatar(
                          backgroundColor: Colors.black,
                          radius: 9,
                        ),
                        Padding(
                          padding: const EdgeInsetsDirectional.only(start: 20),
                          child: CircleAvatar(
                            radius: 8,
                            backgroundColor: Colors.red,
                            child: Text(
                              "7",
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold),
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Padding(
                      padding: const EdgeInsetsDirectional.only(top: 20,bottom: 15.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Chats",
                            style: TextStyle(color: Colors.white),
                          ),
                          Text(
                            "${SocialCubit.get(context).userInfo['name']}",
                            style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                                color: Colors.white),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                  ],
                ),
              ],
            ),
            actions: [
              CircleAvatar(
                backgroundColor: Colors.grey,
                child: IconButton(
                  icon: Icon(
                    Icons.camera_alt,
                    size: 23,
                  ),
                  onPressed: () {},
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Padding(
                padding: const EdgeInsetsDirectional.only(end: 10),
                child: CircleAvatar(
                  backgroundColor: Colors.grey,
                  child: IconButton(
                    icon: Icon(Icons.person),
                    onPressed: () {},
                  ),
                ),
              ),
            ],
          ),
          body: Container(
            color: Colors.black,
            child: ListView(
              physics: BouncingScrollPhysics(),
              children: [
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Container(
                    width: double.infinity,
                    height: 35,
                    child: TextFormField(
                      onTap: () {},
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(10),
                          prefixIcon: Icon(
                            Icons.search,
                            color: Colors.white38,
                          ),
                          hintText: "search",
                          hintStyle: TextStyle(color: Colors.white),
                          filled: true,
                          fillColor: Color(0x20ffffff),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide.none,
                          )),
                    ),
                  ),
                ),

                SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        ...List.generate(
                            SocialCubit.get(context).usersChat.length, (index) {
                          return Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Container(
                              width: 60,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Stack(
                                    alignment: AlignmentDirectional.center,
                                    children: [
                                      CircleAvatar(
                                        radius: 29,
                                        backgroundColor: Colors.blue,
                                      ),
                                      SocialCubit.get(context)
                                          .usersChat[index]
                                      ['profileImage']!=null? CircleAvatar(
                                        radius: 25,
                                        backgroundImage: NetworkImage(
                                            SocialCubit.get(context)
                                                    .usersChat[index]
                                                ['profileImage']),
                                      ):
                                      CircleAvatar(
                                        radius: 25,
                                        backgroundImage: AssetImage("images/loading.png"),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    "${SocialCubit.get(context).usersChat[index]['name']}",
                                    style: TextStyle(color: Colors.white),
                                    maxLines: 2,
                                    //overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ),
                          );
                        })
                      ],
                    )),
                Divider(color: Colors.white,),

                SingleChildScrollView(
                  child: Column(
                      children: SocialCubit.get(context).usersChat.map((item) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                              context,PageTransition(child: ChatDetails(
                              reciverId: SocialCubit.get(context)
                                  .usersChat
                                  .indexOf(item)),type: PageTransitionType.bottomToTop,duration: Duration(milliseconds: 500)));
                          SocialCubit.get(context)
                              .getMessages(receiverID: item['id']);
                        },
                        child: Row(
                          children: [
                            Stack(
                              alignment: AlignmentDirectional.bottomEnd,
                              children: [
                               item['profileImage'] != null?  CircleAvatar(
                                  radius: 25,
                                  backgroundImage:
                                      NetworkImage(item['profileImage']),
                                ):CircleAvatar(
                              radius: 25,
                              backgroundImage:
                              AssetImage("images/loading.png"),
                            ),
                                CircleAvatar(
                                  radius: 6.0,
                                  backgroundColor: Colors.green,
                                )
                              ],
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            Expanded(
                              flex: 2,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${item['name']}",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    "hello mohamed my name is jkanhd from england i hope you are happy and your family hello mohamed my name is jkanhd from england i hope you are happy and your family",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 10,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Row(
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.only(
                                        top: 23, start: 5),
                                    child: Container(
                                      width: 6.0,
                                      height: 6.0,
                                      decoration: BoxDecoration(
                                          color: Colors.blue,
                                          shape: BoxShape.circle),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsetsDirectional.only(
                                        top: 23, start: 7),
                                    child: Text(
                                      "02:37 pm",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList()),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
