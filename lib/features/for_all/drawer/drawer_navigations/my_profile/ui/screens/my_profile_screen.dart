import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lmc_app/core/theming/colors.dart';
import 'package:lmc_app/features/for_all/drawer/drawer_navigations/my_profile/logic/cubit/my_profile_cubit.dart';
import 'package:lmc_app/features/for_all/drawer/drawer_navigations/my_profile/logic/cubit/my_profile_state.dart';

class MyProfileScreen extends StatelessWidget{
  const MyProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.green,
      body: BlocBuilder<MyProfileCubit, MyProfileState>(
        builder: (context,state){
          if (state is MyProfileLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is MyProfileFailure) {
            return Center(
              child: Text(
                'Error: ${state.error}',
                style: const TextStyle(color: Colors.red),
              ),
            );
          } else if (state is MyProfileSuccess) {
            final info = state.myInfo;

            
        return ListView(
          children: [
            Text('data'),
            Text(info.name ?? ''),
            Text(info.email ?? ''),
            // Text(info.otherInfo ?? 'null')
          ],
        );

        }
        return Text('data');
        }
  
        ),
    );
  

  }
}