import 'dart:io';

import 'package:blog_app/core/common/widgets/loader.dart';
import 'package:blog_app/core/constants/ui_constants.dart';
import 'package:blog_app/core/helpers/navigator/app_navigator.dart';
import 'package:blog_app/core/services/app_user/app_user_service.dart';
import 'package:blog_app/core/theme/app_colors.dart';
import 'package:blog_app/core/utils/pick_image.dart';
import 'package:blog_app/core/utils/responsive_utils.dart';
import 'package:blog_app/features/blog/core/constants/blog_constants.dart';
import 'package:blog_app/features/blog/domain/usecases/upload_blog_usecase.dart';
import 'package:blog_app/features/blog/presentation/cubit/blog_cubit.dart';
import 'package:blog_app/features/blog/presentation/pages/blog_page.dart';
import 'package:blog_app/features/blog/presentation/widgets/blog_editor_widget.dart';
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
  late final BlogCubit _blogCubit;

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
      final currentUser = sl<AppUserService>().currentUser;
      if (currentUser == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('User not logged in'),
            backgroundColor: AppColors.errorColor,
          ),
        );
        return;
      }
      final posterId = currentUser.userId;
      _blogCubit.uploadBlog(
        UploadBlogUseCaseParams(
          posterId: posterId,
          title: titleController.text.trim(),
          content: contentController.text.trim(),
          image: image!,
          topics: selectedTopics,
        ),
      );
    }
  }

  @override
  void dispose() {
    titleController.dispose();
    contentController.dispose();
    _blogCubit.close();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _blogCubit = sl<BlogCubit>();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<BlogCubit>.value(
      value: _blogCubit,
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
            if (state is BlogError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                  backgroundColor: AppColors.errorColor,
                ),
              );
            } else if (state is BlogUploaded) {
              AppNavigator.pushAndRemoveUntil(context, BlogPage());
            }
          },
          builder: (context, state) {
            if (state is BlogLoading) {
              return const LoaderWidget();
            }

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
                      BlogEditorWidget(
                        controller: titleController,
                        hintText: 'Blog title',
                      ),
                      SizedBox(height: ResponsiveUtils.height(10)),
                      BlogEditorWidget(
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
