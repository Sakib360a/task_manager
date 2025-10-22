import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:task_manager/data/models/user_model.dart';
import 'package:task_manager/data/services/api_caller.dart';
import 'package:task_manager/data/utils/urls.dart';
import 'package:task_manager/ui/controllers/auth_controller.dart';
import 'package:task_manager/ui/screens/main_navbar_holder_screen.dart';
import 'package:task_manager/ui/widgets/center_circular_progress_indicator.dart';
import 'package:task_manager/ui/widgets/screen_background.dart';
import 'package:task_manager/ui/widgets/snack_bar_message.dart';
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

  bool _updateProfileInProgress = false;

  final ImagePicker _imagePicker = ImagePicker();
  XFile? selectedImage;

  @override
  void initState() {
    super.initState();
    _emailTEController.text = AuthController.userModel?.email ?? '';
    _firstNameTEController.text = AuthController.userModel?.firstName ?? '';
    _lastNameTEController.text = AuthController.userModel?.lastName ?? '';
    _phoneNumberTEController.text = AuthController.userModel?.mobile ?? '';
  }

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
                Text('Update Profile', style: Theme.of(context).textTheme.titleLarge),
                const SizedBox(height: 32),
                PhotoPickerField(onTap: _pickImage,
                selectedPhoto: selectedImage,),
                const SizedBox(height: 32),
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  controller: _emailTEController,
                  decoration: const InputDecoration(hintText: 'Email'),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  keyboardType: TextInputType.name,
                  controller: _firstNameTEController,
                  decoration: const InputDecoration(hintText: 'First Name'),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  keyboardType: TextInputType.name,
                  controller: _lastNameTEController,
                  decoration: const InputDecoration(hintText: 'Last Name'),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  keyboardType: TextInputType.number,
                  controller: _phoneNumberTEController,
                  decoration: const InputDecoration(hintText: 'Mobile'),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  keyboardType: TextInputType.visiblePassword,
                  controller: _passwordTEController,
                  obscureText: true,
                  decoration: const InputDecoration(hintText: 'Password (Optional)'),
                ),
                const SizedBox(height: 16),
                Visibility(
                  visible: !_updateProfileInProgress,
                  replacement: const CenterCircularProgressIndicator(),
                  child: FilledButton(
                    onPressed: _updateProfile,
                    child: const Icon(Icons.arrow_forward_outlined),
                  ),
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

  Future<void> _updateProfile() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    _updateProfileInProgress = true;
    if (mounted) {
      setState(() {});
    }
    Map<String, dynamic> requestData = {
      'email': _emailTEController.text.trim(),
      'firstName': _firstNameTEController.text.trim(),
      'lastName': _lastNameTEController.text.trim(),
      'mobile': _phoneNumberTEController.text.trim(),
    };

    if (_passwordTEController.text.isNotEmpty) {
      requestData['password'] = _passwordTEController.text;
    }

    final ApiResponse response = await ApiCaller.postRequest(
      url: Urls.profileUpdateUrl,
      body: requestData,
    );

    if (response.isSuccess) {
        UserModel user = UserModel(
          id: AuthController.userModel!.id,
          email: _emailTEController.text.trim(),
          firstName: _firstNameTEController.text.trim(),
          lastName: _lastNameTEController.text.trim(),
          mobile: _phoneNumberTEController.text.trim(),
        );
        await AuthController.saveUserData(user, AuthController.accessToken!);
      if (mounted) {
        showSnackBarMessage(context, 'Profile updated!');
        Navigator.pushNamedAndRemoveUntil(context, MainNavbarHolderScreen.name, (predicate)=>false);
      }
    } else {
      if (mounted) {
        showSnackBarMessage(context, response.errorMessage!);
      }
    }
    _updateProfileInProgress = false;
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void dispose() {
    _emailTEController.dispose();
    _passwordTEController.dispose();
    _firstNameTEController.dispose();
    _lastNameTEController.dispose();
    _phoneNumberTEController.dispose();
    super.dispose();
  }
}
