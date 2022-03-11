
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:mebook1/social_app/bloc/bloc_cubit.dart';



class SocialHomeLayout extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text(
      //     "Home",
      //     style: TextStyle(fontWeight: FontWeight.w700),
      //   ),
      //   actions: [
      //     IconButton(
      //       icon: Icon(Icons.notifications_none),
      //       onPressed: () {},
      //     ),
      //     IconButton(icon: Icon(Icons.search_rounded), onPressed: () {}),
      //   ],
      // ),
      body: SocialCubit.get(context).screen[SocialCubit.get(context).currentIndex],

      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepOrange,
        child: Icon(SocialCubit.get(context).navIcons[SocialCubit.get(context).currentIndex]),
        onPressed: (){},
        //params
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: AnimatedBottomNavigationBar(

        icons: SocialCubit.get(context).navIcons,
        activeColor: Colors.deepOrange,
        elevation: 10.0,

        backgroundColor: Colors.black,
        inactiveColor: Colors.white,
        activeIndex: SocialCubit.get(context).currentIndex,
        gapLocation: GapLocation.center,
        notchSmoothness: NotchSmoothness.smoothEdge,

        onTap: (index) {
          SocialCubit.get(context).changeNavIndex(index);
        }),
        //other params

    );
  }
}
