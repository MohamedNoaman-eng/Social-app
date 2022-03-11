import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mebook1/shared/components/constants.dart';
import 'package:mebook1/social_app/bloc/bloc_cubit.dart';
import 'package:mebook1/social_app/bloc/bloc_states.dart';


class ChatDetails extends StatelessWidget {
  final int reciverId;

  ChatDetails({@required this.reciverId});

  Widget buildMessages(index, useId, List<Map<String, dynamic>> message,context) {
    if (useId == myID) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Align(
          alignment: Alignment.centerRight,
          child: Container(
            decoration: BoxDecoration(
                color: Colors.blue.withOpacity(0.7),
                borderRadius: BorderRadiusDirectional.only(
                  topEnd: Radius.circular(15.0),
                  topStart: Radius.circular(15.0),
                  bottomStart: Radius.circular(15.0),
                )),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "${message[index]['message']}",
                style: TextStyle(fontSize: 20.0),
                softWrap: true,
              ),
            ),
          ),
        ),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Container(
            decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.2),
                borderRadius: BorderRadiusDirectional.only(
                  bottomEnd: Radius.circular(15.0),
                  topEnd: Radius.circular(15.0),
                  topStart: Radius.circular(15.0),
                )),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "${message[index]['message']}",
                style: TextStyle(fontSize: 20.0),
                softWrap: true,
              ),
            ),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    var formKey = GlobalKey<FormState>();
    return BlocConsumer<SocialCubit, AllSocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        SocialCubit cubit = SocialCubit.get(context);
        return Scaffold(
          body: Stack(children: [
            Container(
                width: double.infinity,
                height: double.infinity,
                child: Image(
                  image: AssetImage("images/chats2.jpg"),
                  fit: BoxFit.cover,
                )),
            Container(
              width: double.infinity,
              child: Column(
                children: [
                  SizedBox(
                    height: 20.0,
                  ),
                  Container(
                    color: Colors.black.withOpacity(0.7),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          IconButton(
                              icon: Icon(Icons.arrow_back_ios,color: Colors.white,size: 30.0,),
                              onPressed: () {
                                Navigator.pop(context);
                              }),
                          InkWell(
                            onTap: () {},
                            child: Padding(
                              padding: const EdgeInsetsDirectional.only(
                                  start: 15.0, top: 15.0),
                              child: Row(
                                children: [
                                  Stack(
                                      alignment: Alignment.bottomRight,
                                      children: [
                                        CircleAvatar(
                                          backgroundImage: cubit
                                                          .usersChat[reciverId]
                                                      ['profileImage'] ==
                                                  null
                                              ? AssetImage("images/loading.png")
                                              : NetworkImage(
                                                  "${cubit.usersChat[reciverId]['profileImage']}",
                                                ),
                                          radius: 20.0,
                                        ),
                                        CircleAvatar(
                                          radius: 7,
                                          backgroundColor: Colors.green,
                                        )
                                      ]),
                                  Padding(
                                    padding: const EdgeInsetsDirectional.only(
                                        start: 7.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              "${cubit.usersChat[reciverId]['name']}",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w700,color: Colors.white),
                                            ),
                                            SizedBox(
                                              width: 2.0,
                                            ),
                                            Icon(
                                              Icons.verified,
                                              color: Colors.blue,
                                              size: 20.0,
                                            )
                                          ],
                                        ),
                                        Text(
                                          "Active Now",
                                          style: TextStyle(color: Colors.blue),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  cubit.messages != null
                      ? Container(
                          width: double.infinity,
                          child: ListView.separated(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) => buildMessages(
                                  index,
                                  cubit.messages[index]['senderId'],
                                  cubit.messages,context),
                              separatorBuilder: (context, index) => SizedBox(
                                    height: 10.0,
                                  ),
                              itemCount: cubit.messages.length),
                        )
                      : SizedBox(
                          height: 0.0,
                        ),
                  Spacer(),
                  Padding(
                    padding: const EdgeInsetsDirectional.only(bottom: 20.0),
                    child: Container(
                      color: Colors.black.withOpacity(0.4),
                      child: TextFormField(
                          key: formKey,
                          controller: cubit.messageController,
                          decoration: InputDecoration(
                              hintText: "Type your message here...",
                              hintStyle: TextStyle(color: Colors.white),
                              suffixIcon: Padding(
                                padding: const EdgeInsetsDirectional.only(end: 15.0),
                                child: IconButton(
                                    icon: Icon(
                                      Icons.send,
                                      color: Colors.white,
                                      size: 35.0,
                                    ),
                                    onPressed: () {
                                      cubit.sendMessage(
                                          senderId: myID,
                                          receiverID: cubit.usersChat[reciverId]['id'],
                                          message: cubit.messageController.text,
                                          date: DateTime.now().toString());
                                      cubit.destroyMessageController();
                                    }),
                              ),
                              prefixIcon: IconButton(
                                  icon: Icon(
                                    Icons.add_a_photo_outlined,
                                    color: Colors.white,
                                  ),
                                  onPressed: () {}))),
                    ),
                  )
                ],
              ),
            ),
          ]),
        );
      },
    );
  }
}
