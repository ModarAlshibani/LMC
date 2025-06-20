import 'package:flutter/material.dart';
import '../../login/data/models/login_response.dart';

import '../../../../core/theming/colors.dart' show AppColors;

class MyDrawer extends StatefulWidget{
  final int? id;

  const MyDrawer({super.key, this.id,});

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

late Future<User?> user;


class _MyDrawerState extends State<MyDrawer> {
  
  Widget build(BuildContext context){
    return  Container(
        width: 300,
        height: double.infinity,
        color: AppColors.backgroundColor,
        child: ListView(
          children: [
            SizedBox(height: 50,),
            ListTile(
              onTap: (){},
              leading: Icon(Icons.person_2_outlined,
              color: AppColors.lmcOrange,),
              title: Text("My Profile",
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w900,
                color: AppColors.lmcBlue,
              ),),
            ),
            ListTile(
              onTap: (){},
              leading: Icon(Icons.info_outline,
                color: AppColors.lmcOrange,),
              title: Text("About us",
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w900,
                  color: AppColors.lmcBlue,
                ),),
            ),
            ListTile(
              onTap: (){},
              leading: Icon(Icons.library_books_outlined,
                color: AppColors.lmcOrange,),
              title: Text("Library",
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w900,
                  color: AppColors.lmcBlue,
                ),),
            ),
            ListTile(
              onTap: (){},
              leading: Icon(Icons.lock_outline,
                color: AppColors.lmcOrange,),
              title: Text("Ask for Private Course",
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w900,
                  color: AppColors.lmcBlue,
                ),),
            ),
            ListTile(
              onTap: (){},
              leading: Icon(Icons.history,
                color: AppColors.lmcOrange,),
              title: Text("Log",
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w900,
                  color: AppColors.lmcBlue,
                ),),
            ),
            ListTile(
              onTap: (){},
              leading: Icon(Icons.language,
                color: AppColors.lmcOrange,),
              title: Text("Language",
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w900,
                  color: AppColors.lmcBlue,
                ),),
            ),
          ],

        )
    );
  }
}