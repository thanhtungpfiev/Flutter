import 'dart:io';

import 'package:blog_app/core/constants/ui_constants.dart';
import 'package:blog_app/core/theme/app_colors.dart';
import 'package:blog_app/core/utils/pick_image.dart';
import 'package:blog_app/core/utils/responsive_utils.dart';
import 'package:blog_app/features/blog/core/constants/blog_constants.dart';
import 'package:blog_app/features/blog/presentation/cubit/blog_cubit.dart';
import 'package:blog_app/features/blog/presentation/widgets/blog_editor.dart';
import 'package:blog_app/service_locator.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddNewBlogPage extends StatefulWidget {
  const AddNewBlogPage({super.key});

  @override
  State<AddNewBlogPage> createState() => _AddNewBlogPageState();
}

class _AddNewBlogPageState extends State<AddNewBlogPage> {
  final titleController = TextEditingController();
  final contentController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  List<String> selectedTopics = [];
  File? image;

  void selectImage() async {
    final pickedImage = await pickImage();
    if (pickedImage != null) {
      setState(() {
        image = pickedImage;
      });
    }
  }

  void uploadBlog() {
    if (formKey.currentState!.validate() &&
        selectedTopics.isNotEmpty &&
        image != null) {
      // final posterId =
      //     (context.read<AppUserCubit>().state as AppUserLoggedIn).user.id;
      // context.read<BlogBloc>().add(
      //   BlogUpload(
      //     posterId: posterId,
      //     title: titleController.text.trim(),
      //     content: contentController.text.trim(),
      //     image: image!,
      //     topics: selectedTopics,
      //   ),
      // );
    }
  }

  @override
  void dispose() {
    super.dispose();
    titleController.dispose();
    contentController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<BlogCubit>(
      create: (_) => sl<BlogCubit>(),
      child: Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              onPressed: () {
                uploadBlog();
              },
              icon: const Icon(Icons.done_rounded),
            ),
          ],
        ),
        body: BlocConsumer<BlogCubit, BlogState>(
          listener: (context, state) {
            // if (state is BlogFailure) {
            //   showSnackBar(context, state.error);
            // } else if (state is BlogUploadSuccess) {
            //   Navigator.pushAndRemoveUntil(
            //     context,
            //     BlogPage.route(),
            //     (route) => false,
            //   );
            // }
          },
          builder: (context, state) {
            // if (state is BlogLoading) {
            //   return const Loader();
            // }

            return SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(ResponsiveUtils.width(16.0)),
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      image != null
                          ? GestureDetector(
                              onTap: selectImage,
                              child: SizedBox(
                                width: double.infinity,
                                height: ResponsiveUtils.height(600),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(
                                    ResponsiveUtils.radius(10),
                                  ),
                                  child: Image.file(image!, fit: BoxFit.fill),
                                ),
                              ),
                            )
                          : GestureDetector(
                              onTap: () {
                                selectImage();
                              },
                              child: DottedBorder(
                                options: RoundedRectDottedBorderOptions(
                                  color: AppColors.borderColor,
                                  dashPattern: const [10, 4],
                                  radius: Radius.circular(
                                    ResponsiveUtils.radius(10),
                                  ),
                                  strokeCap: StrokeCap.round,
                                ),

                                child: SizedBox(
                                  height: ResponsiveUtils.height(600),
                                  width: double.infinity,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.folder_open,
                                        size: ResponsiveUtils.fontSize(40),
                                      ),
                                      SizedBox(
                                        height: ResponsiveUtils.height(15),
                                      ),
                                      Text(
                                        UIConstants.addNewBlogSelectImage,
                                        style: TextStyle(
                                          fontSize: ResponsiveUtils.fontSize(
                                            15,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                      const SizedBox(height: 20),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: BlogConstants.topics
                              .map(
                                (e) => Padding(
                                  padding: EdgeInsets.all(
                                    ResponsiveUtils.width(5.0),
                                  ),
                                  child: GestureDetector(
                                    onTap: () {
                                      if (selectedTopics.contains(e)) {
                                        selectedTopics.remove(e);
                                      } else {
                                        selectedTopics.add(e);
                                      }
                                      setState(() {});
                                    },
                                    child: Chip(
                                      label: Text(e),
                                      color: selectedTopics.contains(e)
                                          ? const WidgetStatePropertyAll(
                                              AppColors.gradient1,
                                            )
                                          : null,
                                      side: selectedTopics.contains(e)
                                          ? null
                                          : const BorderSide(
                                              color: AppColors.borderColor,
                                            ),
                                    ),
                                  ),
                                ),
                              )
                              .toList(),
                        ),
                      ),
                      SizedBox(height: ResponsiveUtils.height(10)),
                      BlogEditor(
                        controller: titleController,
                        hintText: 'Blog title',
                      ),
                      SizedBox(height: ResponsiveUtils.height(10)),
                      BlogEditor(
                        controller: contentController,
                        hintText: 'Blog content',
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
