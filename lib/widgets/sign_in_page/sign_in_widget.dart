import 'package:flutter/material.dart';
import 'package:lazyload_flutter_course/theme/app_button_style.dart';

class SignInWidget extends StatefulWidget {
  const SignInWidget({Key? key}) : super(key: key);

  @override
  _SignInWidgetState createState() => _SignInWidgetState();
}

class _SignInWidgetState extends State<SignInWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login to your account'),
        elevation: 5.0,
      ),
      body: ListView(
        children: const <Widget>[
          _HeaderWidget(),
        ],
      ),
    );
  }
}

class _HeaderWidget extends StatelessWidget {
  const _HeaderWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const textStyle = TextStyle(
      fontSize: 16.0,
      fontWeight: FontWeight.w600,
      color: Colors.black,
    );
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const SizedBox(height: 30.0),
          const _FormWidget(),
          const SizedBox(height: 20.0),
          const Text(
            'Login to your account. If you don\'t have an account, registering'
            ' for an account is free and simple.',
            style: textStyle,
          ),
          TextButton(
            onPressed: () {},
            style: AppButtonStyle.linkButton,
            child: const Text('Click here'),
          ),
          const SizedBox(height: 20.0),
          const Text(
            'If you signed up but didn\'t get your varification email, ',
            style: textStyle,
          ),
          TextButton(
            onPressed: () {},
            style: AppButtonStyle.linkButton,
            child: const Text('Click here'),
          ),
        ],
      ),
    );
  }
}

//to get started
//to have it resent.

class _FormWidget extends StatefulWidget {
  const _FormWidget({Key? key}) : super(key: key);

  @override
  _FormWidgetState createState() => _FormWidgetState();
}

class _FormWidgetState extends State<_FormWidget> {
  final _loginTextController = TextEditingController(text: '1');
  final _passwordTextController = TextEditingController(text: '2');
  String? errorText = null;

  void _auth() {
    final login = _loginTextController.text;
    final password = _passwordTextController.text;
    if (login.isNotEmpty && password.isNotEmpty) {
      errorText = null;
      Navigator.of(context).pushReplacementNamed('/main_screen');
    } else {
      errorText = 'Неверный логин или пароль';
    }
    setState(() {});
  }

  void _resetPassword() {
    print('reset password');
  }

  final textStyle = const TextStyle(
    fontSize: 14.0,
    fontWeight: FontWeight.w500,
    color: Color(0xFF212529),
  );

  final textFieldStyle = const InputDecoration(
    border: OutlineInputBorder(),
    isCollapsed: true,
    contentPadding: EdgeInsets.symmetric(
      horizontal: 5.0,
      vertical: 10.0,
    ),
  );

  //final actionColor = Color(0xFF01B4E4);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (errorText != null) ...[
          Text(
            errorText!,
            style: const TextStyle(
              color: Colors.red,
            ),
          ),
          const SizedBox(height: 20.0),
        ],
        Text(
          'Username',
          style: textStyle,
        ),
        TextField(
          controller: _loginTextController,
          decoration: textFieldStyle,
        ),
        const SizedBox(height: 20.0),
        Text(
          'Password',
          style: textStyle,
        ),
        TextField(
          controller: _passwordTextController,
          decoration: textFieldStyle,
          obscureText: true,
        ),
        const SizedBox(height: 20.0),
        Row(
          children: [
            ElevatedButton(
              onPressed: _auth,
              style: ButtonStyle(
                padding: MaterialStateProperty.all(
                  const EdgeInsets.symmetric(
                    vertical: 6.0,
                    horizontal: 20.0,
                  ),
                ),
                textStyle: MaterialStateProperty.all(
                  const TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              child: const Text('Sign in'),
            ),
            const SizedBox(width: 28),
            TextButton(
              onPressed: _resetPassword,
              style: AppButtonStyle.linkButton,
              child: const Text('Reset password'),
            )
          ],
        ),
      ],
    );
  }
}
