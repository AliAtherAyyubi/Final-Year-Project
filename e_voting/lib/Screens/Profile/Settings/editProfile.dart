import 'package:e_voting/Database/user_db.dart';
import 'package:e_voting/Local%20Database/userLocalData.dart';
import 'package:e_voting/Models/user.dart';
import 'package:e_voting/Screens/Widgets/alert.dart';
import 'package:e_voting/Screens/Widgets/myButton.dart';
import 'package:e_voting/Screens/Widgets/screenTitle.dart';
import 'package:e_voting/Screens/Widgets/textfield.dart';
import 'package:e_voting/Services/validation.dart';
import 'package:e_voting/utils/Appstyles.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class EditUserProfile extends StatefulWidget {
  const EditUserProfile({super.key});

  @override
  State<EditUserProfile> createState() => _EditUserProfileState();
}

class _EditUserProfileState extends State<EditUserProfile> {
  bool loading = false;

  // Controllers for editing
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _cnicController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _roleController = TextEditingController();

  // Form key for validation
  final _formKey = GlobalKey<FormState>();
  UserModel user = UserModel();
  Future<void> fetchUser() async {
    user = await UserLocalData().fetchLocalUser();
    setState(() {
      user = user;
      _nameController.text = user.userName.toString().capitalize ?? '';
      _emailController.text = user.email ?? "";
      _cnicController.text = user.cnic ?? "";
      _phoneController.text = user.phone ?? "";
      _roleController.text = user.role ?? "";
    });
  }

  @override
  void initState() {
    super.initState();
    fetchUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(50),
          child: ScreenTitle(title: 'Edit Profile'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ProfileField("Name", 'username', _nameController, null),
                ProfileField("Email", 'email', _emailController, null),
                ProfileField("CNIC", 'cnic', _cnicController,
                    Validation().cnicFormatter),
                ProfileField("Phone", 'phone', _phoneController,
                    Validation().phoneFormatter),
                ProfileField("Role", 'role', _roleController, null),
              ],
            ),
          ),
        ));
  }

  Widget ProfileField(
      String title,
      String field,
      TextEditingController controller,
      MaskTextInputFormatter? inputFormatter) {
    String value = controller.text;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          height: 15,
        ),
        TextFormField(
          controller: controller,
          readOnly: true,
          style: AppStyle.textStyle4,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderSide: BorderSide(style: BorderStyle.solid),
              borderRadius: BorderRadius.circular(10),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.grey,
              ),
              borderRadius: BorderRadius.circular(10),
            ),

            // filled: true,
            // fillColor: Colors.grey[200],
            suffixIcon: field == 'role' || field == 'email'
                ? null
                : IconButton(
                    icon: Icon(
                      Icons.edit,
                      color: AppStyle.darkGreen,
                      size: 25,
                    ),
                    splashRadius: 10,
                    onPressed: () {
                      _showEditDialog(
                          title, value, field, controller, inputFormatter);
                    },
                  ),
          ),
        ),
        SizedBox(height: 20),
      ],
    );
  }

  void _showEditDialog(
      String title,
      String value,
      String field,
      TextEditingController controller,
      MaskTextInputFormatter? inputFormatter) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Edit $title'),
          content: Form(
            key: _formKey,
            child: FlatTextField(
              controller: controller,
              keyboardType: TextInputType.name,
              labelText: field == 'phone' ? '0304-4576956' : value,
              inputFormatter: inputFormatter,
              validator: (value) {
                if (field == 'cnic')
                  return Validation().isValidCnic(value);
                else if (field == 'phone')
                  return Validation().isValidPhone(value);
                else if (value.isEmpty) return 'value is empty';
                return null;
              },
            ),
          ),
          actions: [
            MyButton(
              onPress: () async {
                if (_formKey.currentState!.validate()) {
                  // Save the changes
                  setState(() {
                    loading = true;
                  });
                  await userDatabase().updateUser(field, controller.text);

                  await fetchUser();
                  MyAlert.Alert(field, 'Updated Successfully');

                  Navigator.of(context).pop();
                }
              },
              text: 'Update',
              elevation: 0,
              height: 40,
              fontWeight: FontWeight.w500,
              loading: loading,
            ),
          ],
        );
      },
    );
  }
}
