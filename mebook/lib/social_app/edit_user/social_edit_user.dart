import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mebook1/shared/components/constants.dart';

import 'package:page_transition/page_transition.dart';



import '../../shared/components/components.dart';
import '../bloc/bloc_cubit.dart';
import '../bloc/bloc_states.dart';
import '../social_home_layout/social_home.dart';


class EditUserScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var cubit = SocialCubit.get(context);
    var profileImage = cubit.Profileimage;
    var coverImage = cubit.Coverimage;
    return BlocConsumer<SocialCubit, AllSocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text("Edit Profile"),
            actions: [
              Padding(
                padding: const EdgeInsetsDirectional.only(
                    end: 10.0, top: 10.0, bottom: 10.0),
                child: Row(
                  children: [
                    MaterialButton(
                      child: Text(
                        "UPDATE",
                        style: Theme.of(context)
                            .textTheme
                            .headline6
                            .copyWith(color: Colors.blue),
                      ),
                      onPressed: () {},
                    ),
                    Icon(Icons.edit,color: Colors.blue,)
                  ],
                ),
              )
            ],
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back_ios,
                color: SocialCubit.get(context).Mode?Colors.white:Colors.black,
              ),
              onPressed: () {
                Navigator.pushReplacement(
                    context,
                    PageTransition(
                        child: SocialHomeLayout(),
                        type: PageTransitionType.leftToRight,
                        duration: Duration(milliseconds: 500)));
                cubit.destroyPhotos();
              },
            ),
          ),
          body: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (!cubit.isUpdated) LinearProgressIndicator(),
                Padding(
                  padding: const EdgeInsetsDirectional.only(
                      start: 10.0, end: 10.0, top: 10.0, bottom: 10.0),
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
                            height: 220,
                            width: double.infinity,
                            child: Image(
                              image: coverImage == null
                                  ? NetworkImage(SocialCubit.get(context)
                                      .userInfo['coverImage'])
                                  : FileImage(coverImage),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 50,
                          child: CircleAvatar(
                            radius: 45,
                            backgroundImage: profileImage == null
                                ? NetworkImage(SocialCubit.get(context)
                                    .userInfo['profileImage'])
                                : FileImage(profileImage),
                            child: Align(
                              alignment: Alignment(.9, 0.8),
                              child: CircleAvatar(
                                radius: 10.0,
                                backgroundColor: Colors.green,
                              ),
                            ),
                          ),
                        ),
                        Align(
                            alignment: Alignment(-0.95, -.95),
                            child: Container(
                              width: 60.0,
                              height: 60.0,
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                              ),
                              child: Card(
                                elevation: 10.0,
                                child: RaisedButton(
                                    child: Icon(
                                      Icons.add_a_photo,
                                      size: 25.0,
                                      color: Colors.black,
                                    ),
                                    onPressed: () {
                                      cubit.getCoverImage();
                                    }),
                              ),
                            )),
                        Align(
                            alignment: Alignment(-0.2, 0.94),
                            child: Container(
                              width: 50.0,
                              height: 40.0,
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                              ),
                              child: Card(
                                elevation: 10.0,
                                child: RaisedButton(
                                    child: Icon(
                                      Icons.add_a_photo,
                                      size: 15.0,
                                      color: Colors.black,
                                    ),
                                    onPressed: () {
                                      cubit.getProfileImage();
                                    }),
                              ),
                            )),
                      ],
                    ),
                  ),
                ),
                Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    textBaseline: TextBaseline.alphabetic,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,

                      children: [
                        Text("${SocialCubit.get(context)
                            .userInfo['name']}",style: TextStyle(fontWeight: FontWeight.w700
                        ,fontSize: 20.0,color: cubit.Mode?Colors.white:Colors.black
                        ),),
                        SizedBox(width: 5.0,),
                        Icon(Icons.verified,color: Colors.blue,)
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsetsDirectional.only(end: 27),
                      child: Text("${SocialCubit.get(context)
            .userInfo['bio']}",style: TextStyle(color: cubit.Mode?Colors.white:Colors.black),),
                    )
                  ],
                ),
                Padding(
                  padding:
                      const EdgeInsetsDirectional.only(start: 10.0, end: 10.0),
                  child: Row(
                    children: [
                      if (cubit.Profileimage != null)
                        Expanded(
                          child: Column(children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Components().buildButtonLogin(
                                  title: "Update Profile Image",
                                  onPressed: () {
                                    cubit.uploadProfileImage(
                                        email: cubit.editEmail.text,
                                        id: myID,
                                        name: cubit.editName.text,
                                        phone: cubit.editPhone.text,
                                        bio: cubit.editBio.text);
                                  }),
                            ),
                            if (state is SocialUploadProfileImageLoadingState)
                              LinearProgressIndicator(),
                          ]),
                        ),
                      if (cubit.Coverimage != null)
                        Expanded(
                          child: Column(children: [
                            Components().buildButtonLogin(
                                title: "Update Cover Image",
                                onPressed: () {
                                  cubit.uploadCoverImage(
                                      email: cubit.editEmail.text,
                                      id: myID,
                                      name: cubit.editName.text,
                                      phone: cubit.editPhone.text,
                                      bio: cubit.editBio.text);
                                }),
                            if (state is SocialUploadCoverImageLoadingState)
                              LinearProgressIndicator(),
                          ]),
                        ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.only(top: 15.0,end: 15.0,start: 15.0),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    child: Card(
                      elevation: 10.0,
                      color: Colors.black,
                      child: SingleChildScrollView(
                        physics: BouncingScrollPhysics(),
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Column(
                            children: [
                              SizedBox(
                                height: 5.0,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "your details",
                                  style: TextStyle(
                                      color: Colors.blue,
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                              SizedBox(
                                height: 15.0,
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0),
                                child: Components().buildTextFormFieldLogin(
                                    controller: cubit.editEmail,
                                    validate: (String value) {
                                      if (value.isEmpty) {
                                        return "Email must not be empty";
                                      }
                                      return null;
                                    },
                                    label: "Email",
                                    prefix: Icon(Icons.email)),
                              ),
                              SizedBox(
                                height: 20.0,
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0),
                                child: Components().buildTextFormFieldLogin(
                                    controller: cubit.editName,
                                    validate: (String value) {
                                      if (value.isEmpty) {
                                        return "Name must not be empty";
                                      }
                                      return null;
                                    },
                                    label: "Name",
                                    prefix: Icon(Icons.person)),
                              ),
                              SizedBox(
                                height: 5.0,
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0),
                                child: Components().buildTextFormFieldLogin(
                                    controller: cubit.editBio,
                                    validate: (String value) {
                                      if (value.isEmpty) {
                                        return "Bio must not be empty";
                                      }
                                      return null;
                                    },
                                    label: "Bio",
                                    prefix: Icon(Icons.edit)),
                              ),
                              SizedBox(
                                height: 5.0,
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0),
                                child: Components().buildTextFormFieldLogin(
                                    controller: cubit.editPhone,
                                    validate: (String value) {
                                      if (value.isEmpty) {
                                        return "Phone must not be empty";
                                      }
                                      return null;
                                    },
                                    label: "Phone",
                                    prefix: Icon(Icons.phone)),
                              ),
                              SizedBox(
                                height: 20.0,
                              ),
                              state is! SocialUpdateUserInfoLoadingState
                                  ? Components().buildButtonLogin(
                                      title: "Update your details",
                                      onPressed: () {
                                        cubit.updateUserDetails(
                                          email: cubit.editEmail.text,
                                          id: myID,
                                          name: cubit.editName.text,
                                          phone: cubit.editPhone.text,
                                          bio: cubit.editBio.text,
                                        );
                                      })
                                  : Center(
                                  child: LinearProgressIndicator())
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
