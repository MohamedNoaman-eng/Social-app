
abstract class AllSocialStates{}
class SocialChangeContainerColorState extends AllSocialStates{}

class SocialInitialState extends AllSocialStates{}
class SocialChangeNavItemState extends AllSocialStates{}
class SocialLoginLoadingState extends AllSocialStates{}
class SocialLoginSuccessfullyState extends AllSocialStates{
  final String uid;

  SocialLoginSuccessfullyState(this.uid);
}
class SocialLoginErrorState extends AllSocialStates{
  final String error;

  SocialLoginErrorState(this.error);
}
class SocialRegisterLoadingState extends AllSocialStates{}
class SocialDestroyMessageControllerState extends AllSocialStates{}
class SocialContainerHeightState extends AllSocialStates{}

class SocialRegisterSuccessfullyState extends AllSocialStates{}
class SocialRegisterErrorState extends AllSocialStates{
  final String error;

  SocialRegisterErrorState(this.error);
}
class SocialCreateLoadingState extends AllSocialStates{}
class SocialCreateSuccessfullyState extends AllSocialStates{}
class SocialCreateErrorState extends AllSocialStates{
  final String error;

  SocialCreateErrorState(this.error);
}
class SocialChangeCreateSuccessfullyState extends AllSocialStates{}
class SocialChangeCreateErrorState extends AllSocialStates{
  final String error;

  SocialChangeCreateErrorState(this.error);
}
class SocialChangeAppMode extends AllSocialStates{}
class SocialGetProfileLoadingState extends AllSocialStates{}
class SocialGetProfileSuccessfullyState extends AllSocialStates{}
class SocialGetProfileErrorState extends AllSocialStates{
  final String error;

  SocialGetProfileErrorState(this.error);
}
class SocialUploadPostImageLoadingState extends AllSocialStates{}
class SocialUploadPostImageSuccessfullyState extends AllSocialStates{}
class SocialUploadPostImageErrorState extends AllSocialStates{
  final String error;

  SocialUploadPostImageErrorState(this.error);
}
class SocialGetUserInfoStateSuccessfully extends AllSocialStates{}
class SocialGetUserInfoErrorState extends AllSocialStates{
  final String error;

  SocialGetUserInfoErrorState(this.error);
}
class SocialGetPostInfoStateSuccessfully extends AllSocialStates{}
class SocialGetUserPostErrorState extends AllSocialStates{
  final String error;

  SocialGetUserPostErrorState(this.error);
}
class SocialEmailVerifyStateSuccessfully extends AllSocialStates{}
class SocialSetEditFieldStateSuccessfully extends AllSocialStates{}
class SocialUpdateProfileLoadingState extends AllSocialStates{}
class SocialUpdateProfileSuccessfullyState extends AllSocialStates{}
class SocialUpdateProfileErrorState extends AllSocialStates{
  final String error;

  SocialUpdateProfileErrorState(this.error);
}
class SocialChangeProfileImageSuccessfullyState extends AllSocialStates{}
class SocialChangeProfileImageErrorState extends AllSocialStates{}
class SocialChangeCoverImageSuccessfullyState extends AllSocialStates{}
class SocialChoosePostImageErrorState extends AllSocialStates{}
class SocialChoosePostImageSuccessfullyState extends AllSocialStates{}
class SocialDestroyPhotosSuccessfullyState extends AllSocialStates{}

class SocialChangeCoverImageErrorState extends AllSocialStates{}
class SocialUploadProfileImageLoadingState extends AllSocialStates{}
class SocialUploadProfileImageSuccessfullyState extends AllSocialStates{}
class SocialUploadProfileImageErrorState extends AllSocialStates{
  final String error;

  SocialUploadProfileImageErrorState(this.error);
}
class SocialUploadCoverImageLoadingState extends AllSocialStates{}
class SocialUploadCoverImageSuccessfullyState extends AllSocialStates{}
class SocialUploadCoverImageErrorState extends AllSocialStates{
  final String error;

  SocialUploadCoverImageErrorState(this.error);
}
class SocialUpdateUserInfoLoadingState extends AllSocialStates{}
class SocialUpdateUserInfoSuccessfullyState extends AllSocialStates{}
class SocialUpdateUserInfoErrorState extends AllSocialStates{
  final String error;

  SocialUpdateUserInfoErrorState(this.error);
}
class SocialUserLikeLoadingState extends AllSocialStates{}
class SocialUserLikeSuccessfullyState extends AllSocialStates{}
class SocialUserLikeErrorState extends AllSocialStates{
  final String error;

  SocialUserLikeErrorState(this.error);
}
class SocialGetUserLikeSuccessfullyState extends AllSocialStates{}
class SocialGetUserLikeErrorState extends AllSocialStates{}
class SocialSendMessageSuccessfullyState extends AllSocialStates{}
class SocialSendMessageErrorState extends AllSocialStates{}
class SocialGetMessageSuccessfullyState extends AllSocialStates{}
class SocialGetMessageErrorState extends AllSocialStates{}
class SocialGetUserChatsSuccessfullyState extends AllSocialStates{}
class SocialGetUserChatErrorState extends AllSocialStates{}