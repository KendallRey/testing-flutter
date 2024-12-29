import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:normal_list/app/core/utils/validators.dart';
import 'package:normal_list/app/core/widgets/button.dart';
import 'package:normal_list/app/core/widgets/text_form_field.dart';
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
        urlController.text
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
        child: Form(
          key: _formKey,
          child: Column(
            spacing: 32,
            children: [
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
              AppButton(
                onPressed: ()=>handleAddListItem(context),
                disabled: ListService.isLoading,
                label: 'Add Item',
              )
            ],
          )
        ),
      ),
    );
  }
}