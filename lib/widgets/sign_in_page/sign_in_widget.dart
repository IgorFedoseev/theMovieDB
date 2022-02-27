import 'package:flutter/material.dart';
import 'package:lazyload_flutter_course/library/widgets/inherited/provider.dart';
import 'package:lazyload_flutter_course/theme/app_button_style.dart';
import 'package:lazyload_flutter_course/widgets/sign_in_page/sign_in_model.dart';

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

class _FormWidget extends StatelessWidget {
  const _FormWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = InheritedNotifierProvider.read<SignInModel>(context);
    const textStyle = TextStyle(
      fontSize: 14.0,
      fontWeight: FontWeight.w500,
      color: Color(0xFF212529),
    );
    //final actionColor = Color(0xFF01B4E4);
    const textFieldStyle = InputDecoration(
      border: OutlineInputBorder(),
      isCollapsed: true,
      contentPadding: EdgeInsets.symmetric(
        horizontal: 5.0,
        vertical: 10.0,
      ),
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _ErrorMessageWidget(),
        const Text(
          'Username',
          style: textStyle,
        ),
        TextField(
          controller: model?.loginTextController,
          decoration: textFieldStyle,
        ),
        const SizedBox(height: 20.0),
        const Text(
          'Password',
          style: textStyle,
        ),
        TextField(
          controller: model?.passwordTextController,
          decoration: textFieldStyle,
          obscureText: true,
        ),
        const SizedBox(height: 20.0),
        Row(
          children: [
            const _AuthButtonWidget(),
            const SizedBox(width: 28),
            TextButton(
              onPressed: () {},
              style: AppButtonStyle.linkButton,
              child: const Text('Reset password'),
            )
          ],
        ),
      ],
    );
  }
}

class _AuthButtonWidget extends StatelessWidget {
  const _AuthButtonWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = InheritedNotifierProvider.watch<SignInModel>(context);
    final onPressed =
        model?.canStartAuth == false ? () => model?.auth(context) : null;
    final child = model?.canStartAuth == true
        ? const SizedBox(
            child: CircularProgressIndicator(strokeWidth: 2),
            height: 15,
            width: 15,
          )
        : const Text('Sign in');
    return ElevatedButton(
      onPressed: onPressed,
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
      child: child,
    );
  }
}

class _ErrorMessageWidget extends StatelessWidget {
  const _ErrorMessageWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final errorMessage = InheritedNotifierProvider.watch<SignInModel>(context)?.errorMessage;
    if (errorMessage == null) return const SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Text(
        errorMessage,
        style: const TextStyle(
          fontSize: 18.0,
          color: Colors.red,
        ),
      ),
    );
  }
}
