import 'dart:io';

import 'package:bloc/bloc.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import 'package:multi_image_picker/multi_image_picker.dart';

import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;


import '../../networking/dio/cach_helper.dart';
import '../../networking/dio/dio_healper.dart';
import '../../shared/components/components.dart';
import '../../shared/components/constants.dart';
import '../posts/add_post.dart';
import '../settings/setting_screen.dart';
import '../social_home_layout/social_hoemScreen.dart';
import '../users/social_users.dart';
import 'bloc_states.dart';

class SocialCubit extends Cubit<AllSocialStates> {
  SocialCubit() : super(SocialInitialState());

  static SocialCubit get(context) => BlocProvider.of(context);
  int currentIndex = 0;

  void changeNavIndex(index) {
    currentIndex = index;
    if (index == 0 || index == 1 || index == 3 || index == 4) {
      postController.clear();
      postImage = null;
      emit(SocialChangeNavItemState());
    }

    if (index == 0) getPosts(myID);
    if (index == 1) getUserChats();

    emit(SocialChangeNavItemState());
  }

  List<Widget> screen = [
    SocialHomeScreen2(),
    UserChatScreen(),
    AddPostScreen(),
    SocialSettingsScreen(),
  ];
  int x = 0;

  void incX() {
    x++;
    emit(SocialUpdateUserInfoLoadingState());
  }

  List ban = [];
  List products = [];
  List categories = [];

  bool chooseIcon(int index) {
    return favourites.any((element) => element['product']['id'] == index);
  }

  List favourites = [];
  Map<String, dynamic> prod = {'product_id': 35};
  bool Mode = false;

  void changeMode() {
    Mode = !Mode;
    emit(SocialChangeAppMode());
    CacheHelper.sharedPreferences.setBool('mode', Mode).then((value) {
      emit(SocialChangeAppMode());
    });
  }

  Map<String, dynamic> profile = {};
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var confirmPasswordController = TextEditingController();
  var phoneController = TextEditingController();

  void getProfile() {
    emit(SocialGetProfileLoadingState());
    DioHelper.getData(url: "profile", token: myToken).then((value) {
      profile = value.data['data'];
      nameController.text = profile['name'];
      emailController.text = profile['email'];
      phoneController.text = profile['phone'];
      emit(SocialGetProfileSuccessfullyState());
    }).catchError((error) {
      print("my error:$error");
      emit(SocialGetProfileErrorState(error.toString()));
    });
  }

  bool isUpdated = true;
  List<IconData> navIcons = [
    Icons.home_outlined,
    Icons.chat,
    Icons.add,
    Icons.location_on_outlined,
  ];

  void loginUser({@required String email, @required String password}) {
    emit(SocialLoginLoadingState());
    FirebaseAuth.instance
        .signInWithEmailAndPassword(
      email: email,
      password: password,
    )
        .then((value) {
      CacheHelper.sharedPreferences.setString("UserID", value.user.uid);
      getUserInfo(value.user.uid);

      Components()
          .showToast(text: "Log In Successfully", state: ToastState.Success);
      emit(SocialLoginSuccessfullyState(value.user.uid));
    }).catchError((error) {
      print("login error is $error");
      Components()
          .showToast(text: "Something went wrong! ", state: ToastState.Error);

      emit(SocialLoginErrorState(error.toString()));
    });
  }

  void registerUser({
    @required String email,
    @required String password,
    @required String name,
    @required String phone,
    String coverImage =
        "https://www.filmibeat.com/ph-big/2021/03/bhavana_16154521982.jpg",
    String profileImage =
        "https://media.gettyimages.com/photos/happy-friends-picture-id641126440",
    String bio = "Wright your bio...",
  }) {
    emit(SocialRegisterLoadingState());
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
      createUser(
          email: email,
          id: value.user.uid,
          name: name,
          phone: phone,
          profileImage: profileImage,
          bio: bio);
      emailController.clear();
      nameController.clear();
      passwordController.clear();
      phoneController.clear();
      phoneController.clear();
      confirmPasswordController.clear();
      Components().showToast(
          text: "Account Has Registered Successfully",
          state: ToastState.Success);
    }).catchError((error) {
      Components()
          .showToast(text: "Something went wrong! ", state: ToastState.Error);
      emit(SocialRegisterErrorState(error.toString()));
    });
  }

  void createUser({
    @required String email,
    @required String id,
    @required String name,
    @required String phone,
    @required String profileImage,
    @required String bio,
  }) {
    FirebaseFirestore.instance.collection('Users').doc(id).set({
      'name': name,
      'email': email,
      'phone': phone,
      'id': id,
    }).then((value) {
      emit(SocialCreateSuccessfullyState());
    }).catchError((error) {
      print("My CreateUser error is: $error");
      emit(SocialCreateErrorState(error));
    });
  }

  List<Map<String, dynamic>> userPosts = [];
  Map<String, dynamic> userInfo = {};
  double containerHeight = 0;

  void animatedcontainer() {
    if (containerHeight == 0)
      containerHeight = 500;
    else
      containerHeight = 0;
    emit(SocialContainerHeightState());
  }

  Color containerColor = Colors.white;

  void changeContainerColor(Color co) {
    containerColor = co;
    emit(SocialChangeContainerColorState());
  }

  void getUserInfo(id) {
    FirebaseFirestore.instance.collection("Users").doc(id).get().then((value) {
      userInfo = value.data();
      setEditField();
      emit(SocialGetUserInfoStateSuccessfully());
    }).catchError((onError) {
      print("error on user $onError");
      emit(SocialGetUserInfoErrorState(onError.toString()));
    });
  }

  List postsID = [];

  void getPosts(id) {
    userPosts = [];
    FirebaseFirestore.instance
        .collection("Posts")
        .doc("post")
        .collection(id)
        .orderBy('date')
        .get()
        .then((value) {
      value.docs.forEach((element) {
        postsID.add(element.id);
        userPosts.add(element.data());
      });
      // Components().showToast(text: "get posts", state: ToastState.Success);
      emit(SocialGetPostInfoStateSuccessfully());
    }).catchError((onError) {
      emit(SocialGetUserPostErrorState(onError.toString()));
    });
  }

  bool emailVerify = false;

  void changeEmailverify() {
    emit(SocialEmailVerifyStateSuccessfully());
    emailVerify = true;
  }

  var editName = TextEditingController();
  var editBio = TextEditingController();
  var editPhone = TextEditingController();
  var editEmail = TextEditingController();

  void setEditField() {
    editName.text = userInfo['name'];
    editEmail.text = userInfo['email'];
    editPhone.text = userInfo['phone'];
    editBio.text = userInfo['bio'];
    emit(SocialSetEditFieldStateSuccessfully());
  }

  File Profileimage;
  final picker = ImagePicker();

  Future getProfileImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      Profileimage = File(pickedFile.path);
      emit(SocialChangeProfileImageSuccessfullyState());
    } else {
      print('No image selected...!');
      emit(SocialChangeProfileImageErrorState());
    }
  }

  File Coverimage;

  File postImage;
  var choosenProfileImage = "";
  var choosenCoverImage = "";
  List<dynamic> selectedImages;
  List<dynamic> pickedImages;

  Future getCoverImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      Coverimage = File(pickedFile.path);
      emit(SocialChangeCoverImageSuccessfullyState());
    } else {
      print('No image selected...!');
      emit(SocialChangeCoverImageErrorState());
    }
  }

  Future getPostImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      postImage = File(pickedFile.path);
      emit(SocialChoosePostImageSuccessfullyState());
    } else {
      print('No image selected...!');
      emit(SocialChoosePostImageErrorState());
    }
  }

  Future getMultiImage() async {
    pickedImages = await MultiImagePicker.pickImages(
      maxImages: 300,
      selectedAssets: selectedImages,
      enableCamera: true,
    ).then((value) {
      selectedImages = pickedImages;
      emit(SocialChoosePostImageSuccessfullyState());
    }).catchError((onError) {
      emit(SocialChoosePostImageErrorState());
    });
  }

  void uploadProfileImage({
    @required String email,
    @required String id,
    @required String name,
    @required String phone,
    @required String bio,
  }) {
    emit(SocialUploadProfileImageLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child("usersImage/${Uri.file(Profileimage.path).pathSegments.last}")
        .putFile(Profileimage)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        choosenProfileImage = value;
        updateUserInfo(
            email: email,
            id: id,
            name: name,
            phone: phone,
            profileImage: choosenProfileImage,
            coverImage: userInfo['coverImage'],
            bio: bio);
        Profileimage = null;
        Components().showToast(
            text: "Profile Image Successfully Changed",
            state: ToastState.Success);
        emit(SocialUploadProfileImageSuccessfullyState());
      }).catchError((onError) {
        print(onError.toString());
        emit(SocialUploadProfileImageErrorState(onError));
      });
    }).catchError((onError) {
      emit(SocialUploadProfileImageErrorState(onError));
    });
  }

  void uploadCoverImage({
    @required String email,
    @required String id,
    @required String name,
    @required String phone,
    @required String bio,
  }) {
    emit(SocialUploadCoverImageLoadingState());

    firebase_storage.FirebaseStorage.instance
        .ref()
        .child("usersImage/${Uri.file(Coverimage.path).pathSegments.last}")
        .putFile(Coverimage)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        choosenCoverImage = value;
        updateUserInfo(
            email: email,
            id: id,
            name: name,
            phone: phone,
            profileImage: userInfo['profileImage'],
            coverImage: choosenCoverImage,
            bio: bio);
        Coverimage = null;
        Components().showToast(
            text: "Cover Image Successfully Changed",
            state: ToastState.Success);
        emit(SocialUploadCoverImageSuccessfullyState());
      }).catchError((onError) {
        emit(SocialUploadCoverImageErrorState(onError));
      });
    }).catchError((onError) {
      emit(SocialUploadCoverImageErrorState(onError));
    });
  }

  var postController = TextEditingController();

  void uploadPostImage({
    @required String id,
    String description,
  }) {
    emit(SocialUploadPostImageLoadingState());

    firebase_storage.FirebaseStorage.instance
        .ref()
        .child("usersImage/${Uri.file(postImage.path).pathSegments.last}")
        .putFile(postImage)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        uploadUserPost(
            id: id,
            description: description,
            image: value,
            date: DateTime.now());
        Components().showToast(
            text: "Post uploaded Successfully ", state: ToastState.Success);
        emit(SocialUploadPostImageSuccessfullyState());
      }).catchError((onError) {
        Components()
            .showToast(text: "Something went wrong!", state: ToastState.Error);

        emit(SocialUploadPostImageErrorState(onError));
      });
    }).catchError((onError) {
      emit(SocialUploadPostImageErrorState(onError));
    });
  }

  void updateUserInfo({
    @required String email,
    @required String id,
    @required String name,
    @required String phone,
    @required String profileImage,
    @required String coverImage,
    @required String bio,
  }) {
    FirebaseFirestore.instance.collection("Users").doc(id).update({
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'profileImage': profileImage ?? userInfo['profileImage'],
      'bio': bio,
      'coverImage': coverImage ?? userInfo['coverImage']
    }).then((value) {
      getUserInfo(id);
    }).catchError((onError) {
      print("Update user error is: $onError");
    });
  }

  void updateUserDetails({
    @required String email,
    @required String id,
    @required String name,
    @required String phone,
    @required String bio,
  }) {
    emit(SocialUpdateUserInfoLoadingState());
    FirebaseFirestore.instance.collection("Users").doc(id).update({
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'profileImage': userInfo['profileImage'],
      'bio': bio,
      'coverImage': userInfo['coverImage']
    }).then((value) {
      getUserInfo(id);
      Components().showToast(
          text: "Your details updated successfully", state: ToastState.Success);
      emit(SocialUpdateUserInfoSuccessfullyState());
    }).catchError((onError) {
      Components()
          .showToast(text: "Something went wrong!", state: ToastState.Error);
      emit(SocialUpdateUserInfoErrorState(onError));
    });
  }

  void destroyPhotos() {
    Profileimage = null;
    Coverimage = null;
    emit(SocialDestroyPhotosSuccessfullyState());
  }

  void uploadUserPost({
    @required String id,
    @required DateTime date,
    @required String image,
    @required String description,
  }) {
    emit(SocialUpdateUserInfoLoadingState());
    FirebaseFirestore.instance
        .collection('Posts')
        .doc("post")
        .collection(id)
        .doc()
        .set({
      'id': id,
      'date': date,
      'image': image ?? "",
      'description': description ?? ""
    }).then((value) {
      emit(SocialUpdateUserInfoSuccessfullyState());
    }).catchError((error) {
      Components()
          .showToast(text: "Something went wrong !", state: ToastState.Error);
      print("My CreateUser error is: $error");
    });
  }

  bool like = false;

  // Map<String,bool> yourLike;
  void doLike(postID, userId) {
    like = !like;
    print("$like");
    emit(SocialUserLikeSuccessfullyState());
    if (like == false) {
      FirebaseFirestore.instance
          .collection('Posts')
          .doc("post")
          .collection(userId)
          .doc(postID)
          .collection(userId)
          .doc("Like")
          .set({'like': true}).then((value) {
        emit(SocialUserLikeSuccessfullyState());
      }).catchError((onError) {
        like = !like;
        emit(SocialUserLikeErrorState(onError));
      });
    } else {
      FirebaseFirestore.instance
          .collection('Posts')
          .doc("post")
          .collection(userId)
          .doc(postID)
          .collection(userId)
          .doc("Like")
          .set({'like': false}).then((value) {
        emit(SocialUserLikeSuccessfullyState());
      }).catchError((onError) {
        like = !like;
        emit(SocialUserLikeErrorState(onError));
      });
    }
  }

  // void youLike(postID,userId) {
  //     FirebaseFirestore.instance.collection('Posts').doc("post").collection(
  //         userId).doc(postID).collection(userId).doc("Like").get().then((value){
  //        yourLike = value.data();
  //        emit(SocialGetUserLikeSuccessfullyState());
  //     }).catchError((onError){
  //       emit(SocialGetUserInfoErrorState(onError));
  //     });
  //
  // }
  void sendMessage(
      {@required String senderId,
      @required String receiverID,
      @required String message,
      @required String date}) {
    FirebaseFirestore.instance
        .collection("Users")
        .doc(receiverID)
        .collection("Chats")
        .doc(senderId)
        .collection("Message")
        .doc()
        .set({
      'senderId': senderId,
      'date': date,
      'message': message,
      'receiverId': receiverID
    }).then((value) {
      emit(SocialSendMessageSuccessfullyState());
    }).catchError((onError) {
      emit(SocialSendMessageErrorState());
    });
    FirebaseFirestore.instance
        .collection("Users")
        .doc(senderId)
        .collection("Chats")
        .doc(receiverID)
        .collection("Message")
        .doc()
        .set({
      'senderId': senderId,
      'date': date,
      'message': message,
      'receiverId': receiverID
    }).then((value) {
      emit(SocialSendMessageSuccessfullyState());
    }).catchError((onError) {
      emit(SocialSendMessageErrorState());
    });
  }

  var messageController = TextEditingController();

  void destroyMessageController() {
    messageController.text = "";
    emit(SocialDestroyMessageControllerState());
  }

  List<Map<String, dynamic>> messages = [];

  void getMessages({@required receiverID}) {
    FirebaseFirestore.instance
        .collection("Users")
        .doc(myID)
        .collection("Chats")
        .doc(receiverID)
        .collection("Message")
        .orderBy('date')
        .snapshots()
        .listen((event) {
      messages = [];
      event.docs.forEach((element) {
        messages.add(element.data());
      });
      emit(SocialGetMessageSuccessfullyState());
    });
  }

  List<Map<String, dynamic>> usersChat = [];

  void getUserChats() {
    FirebaseFirestore.instance.collection("Users").get().then((value) {
      usersChat = [];
      value.docs.forEach((element) {
        print("My id is $myID");
        if (element.id != myID) {
          usersChat.add(element.data());
        }
        print("My leghth ${usersChat.length}");
        emit(SocialGetUserChatsSuccessfullyState());
      });
    }).catchError((onError) {
      emit(SocialGetUserChatErrorState());
    });
  }
}
