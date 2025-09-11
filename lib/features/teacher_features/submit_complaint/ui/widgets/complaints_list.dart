import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:lmc_app/core/helpers/states_widgets.dart';
import 'package:lmc_app/core/theming/colors.dart';

import 'package:lmc_app/features/teacher_features/submit_complaint/logic/cubit/my_complaints_cubit.dart';
import 'package:lmc_app/features/teacher_features/submit_complaint/ui/widgets/complaint_outside.dart';

class ComplaintsList extends StatelessWidget {
  const ComplaintsList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MyComplaintsCubit, MyComplaintsState>(
      listener: (context, state) {
        // Optional: Handle any side effects here
      },
      builder: (context, state) {
        // Trigger fetch if still in initial state
        if (state is MyComplaintsInitial) {
          context.read<MyComplaintsCubit>().fetchMyComplaints();
          return StateWidgets.buildLoadingState(
            message: "Loading complaints ...",
          );
        }

        if (state is MyComplaintsLoading) {
          print("state is: $state");
          return StateWidgets.buildLoadingState(
            message: "Loading complaints ...",
          );
        } else if (state is MyComplaintsFailure) {
          print("state is: $state");
          return StateWidgets.buildErrorState(
            title: "Something went wrong",
            subtitle: "Unable to load complaints. Please try again later.",
            onRetry: () {
              // Add retry logic here
              context.read<MyComplaintsCubit>().fetchMyComplaints();
            },
          );
        } else if (state is MyComplaintsSuccess) {
          print("state is: $state");

          // Debug: Print the raw response
          print("Raw complaints data: ${state.myComplaints}");
          print("Data type: ${state.myComplaints.runtimeType}");

          final MyComplaints = state.myComplaints.toList();

          // Debug: Print after conversion
          print("Converted complaints list: $MyComplaints");
          print("List length: ${MyComplaints.length}");
          print("Is list empty: ${MyComplaints.isEmpty}");

          // Debug: If not empty, print first item
          if (MyComplaints.isNotEmpty) {
            print("First complaint: ${MyComplaints.first}");
            print("First complaint type: ${MyComplaints.first.runtimeType}");
          }

          if (MyComplaints.isEmpty) {
            return StateWidgets.buildEmptyState(
              icon: Icons.quiz_outlined,
              title: "No Complaints Yet",
              subtitle: "Submit your first Complaint",
              primaryColor: AppColors.lmcBlue,
              secondaryColor: AppColors.lmcOrange,
            );
          }

          return ListView.builder(
            itemCount: MyComplaints.length,
            itemBuilder: (context, index) {
              // Debug: Print each item being built
              print("Building item $index: ${MyComplaints[index]}");
              return ComplaintsOutside(complaint: MyComplaints[index]);
            },
          );
        }

        // Debug: Print when falling through to default case
        print("Unexpected state type: ${state.runtimeType}");
        return StateWidgets.buildLoadingState(
          message: "Loading complaints ...",
        );
      },
    );
  }
}
