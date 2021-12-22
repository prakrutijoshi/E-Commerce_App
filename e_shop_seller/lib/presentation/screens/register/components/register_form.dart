import '../../../../data/models/seller_model.dart';
import '../../../../domain/entities/seller_entity.dart';
import '../../../common_cubits/authentication/authentication_cubit.dart';
import '../cubit/register_cubit.dart';
import '../../../../utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_field_validator/form_field_validator.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({Key? key}) : super(key: key);

  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final SellerModel initialSeller = SellerModel(
    sid: "",
    email: "",
    name: "",
    avatar: "",
    phoneNumber: "",
  );

  bool isShowPassword = false;
  bool isShowConfirmPassword = false;

  String password = "";

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  bool get isPopulated =>
      nameController.text.isNotEmpty &&
      emailController.text.isNotEmpty &&
      passwordController.text.isNotEmpty &&
      confirmPasswordController.text.isNotEmpty;

  bool isRegisterButtonEnabled() {
    return isPopulated;
  }

  void onRegister() {
    if (isRegisterButtonEnabled()) {
      SellerEntity newUser = initialSeller.cloneWith(
        name: nameController.text.trim(),
        email: emailController.text.trim(),
      );
      BlocProvider.of<RegisterCubit>(context).registerNewUser(
        newUser,
        passwordController.text.trim(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<RegisterCubit, RegisterState>(
      listener: (context, state) {
        if (state is RegisterLoading) {
          UtilDialog.showWaiting(context);
        }

        if (state is RegisterSuccess) {
          UtilDialog.hideWaiting(context);
          BlocProvider.of<AuthenticationCubit>(context).loggedIn();
          Navigator.pop(context);
        }

        if (state is RegisterFailure) {
          UtilDialog.hideWaiting(context);
          UtilDialog.showInformation(context, content: state.message);
        }
      },
      child: BlocBuilder<RegisterCubit, RegisterState>(
        builder: (context, state) {
          return Container(
            child: Form(
              child: Column(
                children: [
                  _buildNameInput(),
                  SizedBox(height: 20),
                  _buildEmailInput(),
                  SizedBox(height: 20),
                  _buildPasswordInput(),
                  SizedBox(height: 20),
                  _buildConfirmPasswordInput(),
                  SizedBox(height: 20),
                  _buildButtonRegister(),
                  SizedBox(height: 20),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  _buildNameInput() {
    final nameValidator = MultiValidator([
      RequiredValidator(
        errorText: "name is required",
      ),
      MaxLengthValidator(
        40,
        errorText: "name is too big!",
      ),
    ]);

    return TextFormField(
      textInputAction: TextInputAction.next,
      controller: nameController,
      validator: nameValidator,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        hintText: 'name',
        suffixIcon: Icon(Icons.person_outline),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }

  _buildEmailInput() {
    final emailValidator = MultiValidator([
      RequiredValidator(
        errorText: "email is required",
      ),
      EmailValidator(
        errorText: "enter a valid email address",
      ),
    ]);

    return TextFormField(
      textInputAction: TextInputAction.next,
      controller: emailController,
      validator: emailValidator,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        hintText: 'email',
        suffixIcon: Icon(Icons.email_outlined),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }

  _buildPasswordInput() {
    final passwordValidator = MultiValidator([
      RequiredValidator(
        errorText: 'password is required',
      ),
      MinLengthValidator(
        6,
        errorText: 'password must be at least 6 digits long',
      ),
      PatternValidator(
        r'(?=.*?[#?!@$%^&*-])',
        errorText: 'passwords must have at least one special character',
      ),
    ]);

    return TextFormField(
      textInputAction: TextInputAction.next,
      controller: passwordController,
      onChanged: (val) => password = val,
      validator: passwordValidator,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      keyboardType: TextInputType.text,
      obscureText: !isShowPassword,
      decoration: InputDecoration(
        hintText: 'password',
        suffixIcon: IconButton(
          icon: isShowPassword
              ? Icon(Icons.visibility_outlined)
              : Icon(Icons.visibility_off_outlined),
          splashRadius: 15,
          onPressed: () {
            setState(() => isShowPassword = !isShowPassword);
          },
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }

  _buildConfirmPasswordInput() {
    return TextFormField(
      controller: confirmPasswordController,
      validator: (val) => MatchValidator(errorText: 'passwords do not match')
          .validateMatch(val!, password),
      autovalidateMode: AutovalidateMode.onUserInteraction,
      keyboardType: TextInputType.text,
      obscureText: !isShowConfirmPassword,
      decoration: InputDecoration(
        hintText: 'confirm password',
        suffixIcon: IconButton(
          icon: isShowPassword
              ? Icon(Icons.visibility_outlined)
              : Icon(Icons.visibility_off_outlined),
          splashRadius: 15,
          onPressed: () {
            setState(() => isShowConfirmPassword = !isShowConfirmPassword);
          },
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }

  _buildButtonRegister() {
    return ElevatedButton(
      onPressed: onRegister,
      style: ElevatedButton.styleFrom(
        fixedSize: Size(
          250,
          50,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
      child: Text(
        "Register",
        style: TextStyle(
          color: Colors.white,
          fontSize: 20,
        ),
      ),
    );
  }
}
