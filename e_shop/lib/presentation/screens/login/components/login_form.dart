import 'package:e_shop/presentation/screens/ForgetPassword/forgetpassword.dart';

import '../../../widgets/constants.dart';
import '../../../widgets/size_config.dart';
import '../../../../utils/default_button.dart';

import '../../../common_cubits/cubit/cubit/authentication_cubit.dart';
import '../cubit/login_cubit.dart';
import '../../../../utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_field_validator/form_field_validator.dart';

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool isShowPassword = false;
  bool? remember = false;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  bool get isPopulated =>
      emailController.text.isNotEmpty && passwordController.text.isNotEmpty;

  bool isLoginButtonEnabled() {
    return isPopulated;
  }

  void onLogin() {
    if (isLoginButtonEnabled()) {
      BlocProvider.of<LoginCubit>(context).loginWithCredential(
        emailController.text.trim(),
        passwordController.text.trim(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is Logging) {
          UtilDialog.showWaiting(context);
        }

        if (state is LoginSuccess) {
          UtilDialog.hideWaiting(context);
          BlocProvider.of<AuthenticationCubit>(context).loggedIn();
        }

        if (state is LoginFailure) {
          UtilDialog.hideWaiting(context);
          UtilDialog.showInformation(context, content: state.message);
        }
      },
      child: BlocBuilder<LoginCubit, LoginState>(
        builder: (context, state) {
          return Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(
                  height: getProportionateScreenHeight(30),
                ),
                _buildTextFieldUsername(),
                SizedBox(
                  height: getProportionateScreenHeight(20),
                ),
                _buildTextFieldPassword(),
                SizedBox(height: getProportionateScreenHeight(20)),
                Row(
                  children: [
                    Checkbox(
                        value: remember,
                        activeColor: kPrimaryColor,
                        onChanged: (value) {
                          setState(() {
                            remember = value;
                          });
                        }),
                    Text("Remember Me"),
                    Spacer(),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ForgetPassword()));
                      },
                      child: Text(
                        "Forgot Password",
                        style: TextStyle(decoration: TextDecoration.underline),
                      ),
                    )
                  ],
                ),
                // Align(
                //   alignment: Alignment.centerRight,
                //   child: GestureDetector(
                //     onTap: () {},
                //     child: Text(
                //       'forgot password?',
                //       style: TextStyle(
                //         color: Colors.blue,
                //         fontSize: 16,
                //       ),
                //     ),
                //   ),
                // ),
                SizedBox(height: getProportionateScreenHeight(10)),
                _buildButtonLogin(),
                SizedBox(height: getProportionateScreenHeight(10)),
                _buildTextOr(),
              ],
            ),
          );
        },
      ),
    );
  }

  /// Build content
  _buildTextFieldUsername() {
    final emailValidator = MultiValidator([
      RequiredValidator(
        errorText: 'email is required',
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
        labelText: "Email",
        hintText: 'Enter your Email',
        labelStyle: TextStyle(color: kPrimaryColor),
        suffixIcon: Icon(Icons.email_outlined, color: kPrimaryColor),
      ),
    );
  }

  _buildTextFieldPassword() {
    final passwordValidator = MultiValidator([
      RequiredValidator(
        errorText: 'password is required',
      ),
    ]);

    return TextFormField(
      controller: passwordController,
      textInputAction: TextInputAction.go,
      validator: passwordValidator,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      keyboardType: TextInputType.text,
      obscureText: !isShowPassword,
      decoration: InputDecoration(
        hintText: 'Enter your Password',
        labelText: "Password",
        labelStyle: TextStyle(color: kPrimaryColor),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: IconButton(
          color: kPrimaryColor,
          icon: isShowPassword
              ? Icon(Icons.visibility_outlined)
              : Icon(Icons.visibility_off_outlined),
          splashRadius: 15,
          onPressed: () {
            setState(() => isShowPassword = !isShowPassword);
          },
        ),
      ),
    );
  }

  _buildButtonLogin() {
    return DefaultButton(text: "LOGIN", press: onLogin);
  }

  _buildTextOr() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: getProportionateScreenHeight(15)),
      child: Row(
        children: [
          Expanded(
            child: Divider(
              thickness: 2,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: getProportionateScreenWidth(10)),
            child: Text(
              "Or Sign in with",
              style: TextStyle(
                fontSize: 16,
              ),
            ),
          ),
          Expanded(
            child: Divider(
              thickness: 2,
            ),
          ),
        ],
      ),
    );
  }
}
