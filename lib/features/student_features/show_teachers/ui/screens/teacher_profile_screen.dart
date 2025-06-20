import 'package:flutter/material.dart';
import '../../../../../core/theming/colors.dart';
import '../../data/models/teacher_model.dart';

class TeacherProfileScreen extends StatelessWidget{
  
    final Teachers teacher;

  const TeacherProfileScreen({super.key, required this.teacher});
    
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightLmcBlue,
      body: Column(
        children: [
          SizedBox(height: 20,),
          Padding(
            padding: const EdgeInsets.all(15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  height: 140,
                  width: 140,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: AppColors.lmcOrange,
                    image: DecorationImage(image: NetworkImage(teacher.Photo ?? 'assets/images/LMC-LOGO.png'),),
                  ),
                ),
                SizedBox(width: 20,),
                Text(teacher.name ?? 'cccc',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w900,
                ),
                ),
              ],
            ),
          ),
          Container(
            height: 700,
            width: double.infinity,
            decoration: BoxDecoration(
              color: AppColors.backgroundColor,
              borderRadius: BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30),),
            ),
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 30,),
                  Text(teacher.email?? 'jjjjjj',
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.indigo
                  ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: AppColors.lmcBlue
                    ),
                    width: double.infinity,
                    height: 1,
                  ),
                  SizedBox(height: 50,),
                       Text(teacher.Description?? '',
                       style: TextStyle(
                        fontSize: 20,

                       ),),
                      
                ],
              ),
            ),
          ),
        ],
      ),

      );
  }

}
