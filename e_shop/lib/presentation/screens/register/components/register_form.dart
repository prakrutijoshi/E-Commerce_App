import 'package:e_shop/presentation/widgets/constants.dart';
import 'package:e_shop/presentation/widgets/size_config.dart';
import 'package:e_shop/utils/default_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_field_validator/form_field_validator.dart';

import '../../../../data/model/user_model.dart';
import '../../../../domain/entities/user_entity.dart';
import '../../../../utils/utils.dart';
import '../../../common_blocs/cubit/cubit/authentication_cubit.dart';
import '../cubit/register_cubit.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({Key? key}) : super(key: key);

  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final UserModel initialUser = UserModel(
    uid: "",
    email: "",
    name: "",
    avatar: "",
    phoneNumber: "",
    addresses: [],
  );

  bool isShowPassword = false;
  bool isShowConfirmPassword = false;
  bool? remember = false;

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
      UserEntity newUser = initialUser.cloneWith(
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
          return Form(
            key: _formKey,
            child: Column(
              children: [
                _buildNameInput(),
                SizedBox(height: getProportionateScreenHeight(30)),
                _buildEmailInput(),
                SizedBox(height: getProportionateScreenHeight(30)),
                _buildPasswordInput(),
                SizedBox(height: getProportionateScreenHeight(30)),
                _buildConfirmPasswordInput(),
                SizedBox(height: getProportionateScreenHeight(30)),
                _buildButtonRegister(),
                SizedBox(height: getProportionateScreenHeight(30)),
              ],
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
        hintText: 'Enter your Name',
        labelText: "Name",
        labelStyle: TextStyle(color: kPrimaryColor),
        suffixIcon: Icon(
          Icons.person_outline,
          color: kPrimaryColor,
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
        hintText: 'Enter your Email',
        labelText: "Email",
        labelStyle: TextStyle(color: kPrimaryColor),
        suffixIcon: Icon(
          Icons.email_outlined,
          color: kPrimaryColor,
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
        8,
        errorText: 'password must be at least 8 digits long',
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
        hintText: 'Enter Password',
        labelText: "Password",
        labelStyle: TextStyle(color: kPrimaryColor),
        suffixIcon: IconButton(
          icon: isShowPassword
              ? Icon(
                  Icons.visibility_outlined,
                  color: kPrimaryColor,
                )
              : Icon(
                  Icons.visibility_off_outlined,
                  color: kSecondaryColor,
                ),
          splashRadius: 15,
          onPressed: () {
            setState(() => isShowPassword = !isShowPassword);
          },
        ),
      ),
    );
  }

  _buildConfirmPasswordInput() {
    return TextFormField(
      controller: confirmPasswordController,
      validator: (val) => MatchValidator(errorText: 'passwords do not match')
          .validateMatch(val!, password),
      autovalidateMode: AutovalidateMode.always,
      keyboardType: TextInputType.text,
      obscureText: !isShowConfirmPassword,
      decoration: InputDecoration(
        hintText: 'Re-enter your password',
        labelText: "Confirm Password",
        labelStyle: TextStyle(color: kPrimaryColor),
        suffixIcon: IconButton(
          icon: isShowPassword
              ? Icon(
                  Icons.visibility_outlined,
                  color: kPrimaryColor,
                )
              : Icon(
                  Icons.visibility_off_outlined,
                  color: kSecondaryColor,
                ),
          splashRadius: 15,
          onPressed: () {
            setState(() => isShowConfirmPassword = !isShowConfirmPassword);
          },
        ),
      ),
    );
  }

  _buildButtonRegister() {
    return DefaultButton(text: "Continue", press: onRegister);
  }
}
