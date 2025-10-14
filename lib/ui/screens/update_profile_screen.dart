import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:task_manager/ui/widgets/screen_background.dart';
import 'package:task_manager/ui/widgets/tm_app_bar.dart';

import '../widgets/photo_picker_field.dart';

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({super.key});
  static const String name= '/update-profile';

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _passwordTEController = TextEditingController();
  final TextEditingController _firstNameTEController = TextEditingController();
  final TextEditingController _lastNameTEController = TextEditingController();
  final TextEditingController _phoneNumberTEController = TextEditingController();

  final ImagePicker _imagePicker = ImagePicker();
  XFile? selectedImage;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TMAppBar(fromUpdateProfile: true,),
      body: ScreenBackground(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 32),
                Text('Update Profile', style: TextTheme.of(context).titleLarge),
                const SizedBox(height: 32),
                PhotoPickerField(onTap: _pickImage,
                selectedPhoto: selectedImage,),
                const SizedBox(height: 32),
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  controller: _emailTEController,
                  decoration: InputDecoration(hintText: 'Email'),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  keyboardType: TextInputType.name,
                  controller: _firstNameTEController,
                  decoration: InputDecoration(hintText: 'First Name'),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  keyboardType: TextInputType.name,
                  controller: _lastNameTEController,
                  decoration: InputDecoration(hintText: 'Last Name'),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  keyboardType: TextInputType.number,
                  controller: _phoneNumberTEController,
                  decoration: InputDecoration(hintText: 'Mobile'),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  keyboardType: TextInputType.visiblePassword,
                  controller: _passwordTEController,
                  obscureText: true,
                  decoration: InputDecoration(hintText: 'Password'),
                ),
                const SizedBox(height: 16),
                FilledButton(
                  onPressed: () {},
                  child: Icon(Icons.arrow_forward_outlined),
                ),
                const SizedBox(height: 36),
              ],
            ),
          ),
        ),
      ),
    );
  }
  Future<void>_pickImage() async{
  XFile? pickedImage = await _imagePicker.pickImage(source: ImageSource.gallery);
  if(pickedImage!=null)
    {
      selectedImage = pickedImage;
      setState(() {

      });
    }
}
  @override
  void dispose() {
    _emailTEController.dispose();
    _passwordTEController.dispose();
    _firstNameTEController.dispose();
    _lastNameTEController.dispose();
    _phoneNumberTEController.dispose();
    // TODO: implement dispose
    super.dispose();
  }
}

