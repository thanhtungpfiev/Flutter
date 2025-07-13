import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_clone/presentation/auth/blocs/age_selection_cubit.dart';
import 'package:ecommerce_clone/presentation/auth/blocs/ages_display_cubit.dart';
import 'package:ecommerce_clone/presentation/auth/blocs/ages_display_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AgesWidget extends StatelessWidget {
  const AgesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height / 2.7,
      child: BlocBuilder<AgesDisplayCubit, AgesDisplayState>(
        builder: (context, state) {
          if (state is AgesDisplayLoadingState) {
            return Container(
              alignment: Alignment.center,
              child: const CircularProgressIndicator(),
            );
          }

          if (state is AgesDisplayLoadSuccessState) {
            return _ages(state.ages);
          }

          if (state is AgesDisplayLoadErrorState) {
            return Container(
              alignment: Alignment.center,
              child: Text(state.errorMessage),
            );
          }

          return const SizedBox();
        },
      ),
    );
  }

  Widget _ages(List<QueryDocumentSnapshot<Map<String, dynamic>>> ages) {
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            Navigator.pop(context);
            context.read<AgeSelectionCubit>().selectAge(
              ages[index].data()['value'],
            );
          },
          child: Text(
            ages[index].data()['value'],
            style: const TextStyle(fontSize: 18),
          ),
        );
      },
      separatorBuilder: (context, index) => const SizedBox(height: 20),
      itemCount: ages.length,
    );
  }
}
