import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../cubit/bloc_cubit.dart';


class Components {
  Widget buildTextFormField(
      {@required TextEditingController controller,
      TextInputType type = TextInputType.text,
      @required Function validate,
      @required label,
      @required prefix,
      bool secure = false,
      ontap,
      onSubmit}) {
    return TextFormField(
      onTap: ontap,
      decoration: InputDecoration(
          fillColor: Colors.grey[100],
          labelText: label,
          labelStyle: TextStyle(color: Colors.blue),
          prefixIcon: prefix,
          filled: true,
          contentPadding: EdgeInsets.all(25.0),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(7.0),
          ),
      ),
      onFieldSubmitted: onSubmit,
      controller: controller,
      validator: validate,
      obscureText: secure,
      keyboardType: type,
    );
  }
  Widget buildTextFormFieldLogin(
      {@required TextEditingController controller,
        TextInputType type = TextInputType.text,
        @required Function validate,
        @required label,
        @required prefix,
        Function onchange,
        bool secure = false,
        ontap,
        onSubmit}) {
    return TextFormField(
      onTap: ontap,
      onChanged: onchange,
      style: TextStyle(color: Colors.white,fontSize: 20.0),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Colors.blue),
        prefixIcon: prefix,

        contentPadding: EdgeInsets.all(25.0),
         border: OutlineInputBorder(
           borderSide: BorderSide.none,
        ),

      ),
      onFieldSubmitted: onSubmit,
      controller: controller,
      validator: validate,
      obscureText: secure,
      keyboardType: type,
    );
  }

  Widget buildTaskItem(Map model, context) {
    return Dismissible(
      key: UniqueKey(),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
          children: [
            CircleAvatar(
              radius: 40.0,
              child: Text("${model['TIME']}"),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsetsDirectional.only(start: 20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "${model['TITLE']}",
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "${model['DATE']}",
                    ),
                    Text(
                      "${model['STATUS']}",
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.check_circle,
                      color: Colors.green,
                    ),
                    onPressed: () {
                      BlocCubit.get(context)
                          .updateData(status: 'done', id: model['ID']);
                    },
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.archive,
                      color: Colors.black87,
                    ),
                    onPressed: () {
                      BlocCubit.get(context)
                          .updateData(status: 'archive', id: model['ID']);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      onDismissed: (direction) {
        BlocCubit.get(context).deleteData(id: model['ID']);
      },
    );
  }

  Widget buildListView(List<dynamic> newsList) {
    return ListView.separated(
      physics: BouncingScrollPhysics(),
      itemCount: newsList.length,
      itemBuilder: (context, index) {
        return Container(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 150.0,
                  height: 120.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  child: Image(
                    image: NetworkImage(newsList[index]['urlToImage']),
                    fit: BoxFit.fill,
                  ),
                ),
                Expanded(
                    child: Padding(
                  padding:
                      const EdgeInsetsDirectional.only(start: 10.0, end: 10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,

                    //mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "${newsList[index]['title']}",
                        style: TextStyle(
                          fontSize: 12.0,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 3,
                        textDirection: TextDirection.rtl,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(
                        height: 1.0,
                      ),
                      Text("${newsList[index]['description']}",
                          style: TextStyle(
                            fontSize: 9.0,
                            fontWeight: FontWeight.w700,
                          ),
                          maxLines: 2,
                          textDirection: TextDirection.rtl,
                          overflow: TextOverflow.ellipsis),
                      SizedBox(
                        height: 20.0,
                      ),
                      Padding(
                        padding: const EdgeInsetsDirectional.only(end: 0.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              "${newsList[index]['publishedAt']}",
                              style: TextStyle(
                                  fontSize: 7.0, fontWeight: FontWeight.w700),
                              textDirection: TextDirection.rtl,
                            ),
                            SizedBox(
                              width: 10.0,
                            ),
                            CircleAvatar(
                              radius: 3.0,
                              backgroundColor: Colors.blue,
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ))
              ],
            ),
          ),
        );
      },
      separatorBuilder: (context, index) => Padding(
        padding: const EdgeInsetsDirectional.only(start: 20.0, end: 20.0),
        child: Container(
          width: 1.0,
          height: 1.0,
          color: Colors.grey,
        ),
      ),
    );
  }

  Widget buildPageItem(
      {@required String title,
      @required String subTitle,
      @required String url}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 3,
          child: Image(
            image: AssetImage(url),
            fit: BoxFit.fill,
          ),
        ),
        SizedBox(

          height: 20.0,
        ),
       Expanded(
         flex: 1,
         child: Column(
           crossAxisAlignment: CrossAxisAlignment.start,
           children: [
           Padding(
             padding: const EdgeInsetsDirectional.only(start: 15),
             child: Text(
               title,
               style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.w700),
             ),
           ),
           SizedBox(
             height: 0.0,
           ),
           Padding(
             padding: const EdgeInsetsDirectional.only(start: 15.0),
             child: Text(
               subTitle,
               style: TextStyle(fontSize: 20.0),
             ),
           ),
         ],),
       )
      ],
    );
  }

  Widget buildButton({@required String title, @required Function onPressed}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.8),
            borderRadius: BorderRadius.circular(20.0)
        ),

        child: Padding(
          padding: const EdgeInsetsDirectional.only(start: 20.0,end: 20.0,top: 2.0,bottom: 2.0),
          child: MaterialButton(
            onPressed: onPressed,
            child: Text(title,style: TextStyle(color: Colors.white,fontSize: 20.0),),
          ),
        )
      ),
    );
  }
  Widget buildButtonLogin({@required String title, @required Function onPressed,GlobalKey formKey}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
          decoration: BoxDecoration(
              color: Colors.deepPurpleAccent,

              borderRadius: BorderRadius.circular(20.0)
          ),

          child: Padding(
            padding: const EdgeInsetsDirectional.only(start: 20.0,end: 20.0,top: 2.0,bottom: 2.0),
            child: MaterialButton(

              onPressed: onPressed,

              child: Text(title,style: TextStyle(color: Colors.white,fontSize: 20.0),),
            ),
          )
      ),
    );
  }
  showToast( {@required String text,@required ToastState state}){
    return Fluttertoast.showToast(
        msg: "$text",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 3,
        backgroundColor: switchColor(state),
        textColor: Colors.white,
        fontSize: 16.0
    );
  }
  Color switchColor(ToastState state){
    Color color;
    switch(state){
      case ToastState.Success:
        color = Colors.green;
        break;
      case ToastState.Error:
        color = Colors.red;
        break;
      case ToastState.Warning:
        color = Colors.yellow;
        break;
    }
    return color;

  }
  void navigateNotReturn(Widget screen,context){
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>screen), (route) => false);
  }

}
enum ToastState{Success, Error, Warning}
