import 'dart:developer';
import 'package:car_club/core/styles/text_styles.dart';
import 'package:car_club/core/widgets/custom_button.dart';
import 'package:car_club/core/widgets/custom_text_field.dart';
import 'package:car_club/features/admin/presentation/manager/admin_cubit/admin_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DeleteCarssView extends StatefulWidget {
  const DeleteCarssView({super.key});
  static String id = 'DeleteCarssView';

  @override
  State<DeleteCarssView> createState() => _DeleteCarssViewState();
}

class _DeleteCarssViewState extends State<DeleteCarssView> {
  final TextEditingController codeController = TextEditingController();

  @override
  void dispose() {
    codeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Delete Car',
          style: AppStyles.style32(context, Colors.black),
        ),
        elevation: 0,
       backgroundColor: Colors.pink[300],
      ),
      body: BlocListener<AdminCubit, AdminState>(
        listener: (context, state) {
          if (state is AdminSuccess) {
            clearFieldsMethod();
          } else if (state is AdminFailure) {
            // Handle failure
          }
        },
        child: SingleChildScrollView(
          child: Form(
            child: SafeArea(
              child: Column(
                children: [
                  CustomTextFrom(
                    label: 'Car Code',
                    hint: 'Enter Car Code to Delete',
                    controller: codeController,
                  ),
                  const SizedBox(height: 20),
                  CustomButton(
                    title: 'Delete',
                    color: Colors.pink[300],
                    onTap: () async {
                      if (codeController.text.isNotEmpty) {
                        await BlocProvider.of<AdminCubit>(context).deleteProduct(
                          parcode: codeController.text,
                        );
                        log('Product Deleted');
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void clearFieldsMethod() {
    codeController.clear();
  }
}
