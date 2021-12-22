import '../../../common_cubits/authentication/authentication_cubit.dart';
import '../cubit/login_cubit.dart';
import '../../../../utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_field_validator/form_field_validator.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool isShowPassword = false;

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
          return Container(
            child: Form(
              child: Column(
                children: [
                  _buildTextFieldUsername(),
                  SizedBox(height: 20),
                  _buildTextFieldPassword(),
                  SizedBox(height: 20),
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
                  SizedBox(height: 20),
                  _buildButtonLogin(),
                  SizedBox(height: 20),
                  _buildTextOr(),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

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
        hintText: 'email',
        suffixIcon: Icon(Icons.email_outlined),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
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

  _buildButtonLogin() {
    return ElevatedButton(
      onPressed: onLogin,
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
        "LOGIN",
        style: TextStyle(
          color: Colors.white,
          fontSize: 20,
        ),
      ),
    );
  }

  _buildTextOr() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: Row(
        children: [
          Expanded(
            child: Divider(
              thickness: 2,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
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
