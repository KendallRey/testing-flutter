import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:normal_list/app/core/services/app_encryption.dart';
import 'package:normal_list/app/core/utils/validators.dart';
import 'package:normal_list/app/core/widgets/button.dart';
import 'package:normal_list/app/core/widgets/text_form_field.dart';
import 'package:normal_list/app/core/widgets/ximage_view.dart';
import 'package:normal_list/app/router.dart';
import 'package:normal_list/features/list/data/list_item_model.dart';
import 'package:normal_list/features/list/data/list_service.dart';

class AddListItemScreen extends StatefulWidget {
  const AddListItemScreen({super.key});

  @override
  State<AddListItemScreen> createState() => _AddListItemScreenState();
}

class _AddListItemScreenState extends State<AddListItemScreen> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController codeController = TextEditingController();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController urlController = TextEditingController();
  final ImagePicker picker = ImagePicker();

  XFile? _mediaFile;

  Future<void> _onImageButtonPressed(
    ImageSource source, {
    required BuildContext context,
  }) async {
    if (context.mounted) {
      try {
        final XFile? media = await picker.pickMedia(
          maxWidth: 200,
          maxHeight: 400,
          imageQuality: 50,
        );
        if (media != null) {
          setState(() {
            _mediaFile = media;
          });
        }
      // ignore: empty_catches
      } catch (e) {}
    }
  }

  void _onImageClear(){
    setState(() {
      _mediaFile = null;
    });
  }

  Future<void> retrieveLostData() async {
    final LostDataResponse response = await picker.retrieveLostData();
    if (response.isEmpty) {
      return;
    }
    if (response.file != null) {
      _mediaFile = response.file;
    }
  }

  final User? user = FirebaseAuth.instance.currentUser;
  final ListService listService = ListService();

  // handle add list item
  void handleAddListItem(BuildContext ctx) async {
    setState(() { });
    if(user == null) return;
    if(!_formKey.currentState!.validate()) return;
    await listService.addUserItem(
      user!.uid,
      ListItemModel.insert(
        codeController.text,
        titleController.text,
        urlController.text,
        _mediaFile != null ? File(_mediaFile!.path) : null,
      )
    );
    if(ctx.mounted){
      ScaffoldMessenger.of(ctx).showSnackBar(
        SnackBar(content: Text('Item added: ${codeController.text}'))
      );
      if(ctx.canPop()){
        ctx.pop();
      }
    }
    setState(() { });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppRoutes.titleAddListItem),
        leading: IconButton(
          onPressed: () => {
            if(context.canPop()){
              context.pop()
            }
          },
          icon: Icon(Icons.arrow_back),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Flexible(
                child: ListView(
                  children: [
                    Form(
                        key: _formKey,
                        child: Column(
                          spacing: 24,
                          children: [
                            Center(
                              child: FutureBuilder(
                                  future: retrieveLostData(),
                                  builder:(context, snapshot) {
                                    return XImageView(
                                        imageFile: _mediaFile,
                                        state: snapshot.connectionState,
                                        onPressed: () {
                                          if(ListService.isLoading) return;
                                          _onImageButtonPressed(ImageSource.gallery, context: context);
                                        }
                                    );
                                  }
                              ),
                            ),
                            GestureDetector(
                              onTap: ListService.isLoading ? null : _onImageClear,
                              child: Chip(
                                label: Text('Clear Image'),
                              ),
                            ),
                            AppTextFormField(
                                controller: codeController,
                                label: 'Code',
                                validator: FormValidators.validateRequiredString
                            ),
                            AppTextFormField(
                                controller: titleController,
                                label: 'Title',
                                validator: FormValidators.validateRequiredString
                            ),
                            AppTextFormField(
                              controller: urlController,
                              label: 'Url',
                            ),
                          ],
                        )
                    )
                  ],
                )
            ),
            AppButton(
              onPressed: ()=>handleAddListItem(context),
              disabled: ListService.isLoading,
              label: 'Add Item',
            )
          ],
        )
      ),
    );
  }
}