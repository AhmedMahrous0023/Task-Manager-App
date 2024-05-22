import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_manager_app/Core/Services/auth_provider_service.dart';
import 'package:task_manager_app/Views/Screens/home_screen.dart';
import 'package:task_manager_app/Views/Widgets/custom_button.dart';
import 'package:task_manager_app/Views/Widgets/custom_form_field.dart';
import 'package:task_manager_app/Views/Widgets/custom_text.dart';
import 'package:task_manager_app/constants.dart';

class LoginScreen extends StatefulWidget {
 const  LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController userNameController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    userNameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    final authProvider = Provider.of<AuthProvider>(context);
    return Scaffold(
      backgroundColor:
          brightness == Brightness.light ? firstColor : secondColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Center(
                  child: Padding(
                padding: const EdgeInsets.only(top: 200),
                child: Image.asset(
                  'assets/images/logo.PNG',
                  fit: BoxFit.fill,
                ),
              )),
              Padding(
                padding: const EdgeInsets.only(top: 60),
                child: CustomFormField(
                  controller: userNameController,
                  fillColor: secondColor,
                  hintText: '  User Name',
                  hintcolor: Colors.blueAccent,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15),
                child: CustomFormField(
                  controller: passwordController,
                  fillColor: secondColor,
                  hintText: '  Password',
                  hintcolor: Colors.blueAccent,
                ),
              ),
              Padding(
                  padding: const EdgeInsets.only(top: 70),
                  child: CustomButton(
                      text: 'Log in',
                      onPressed: () async {
                        String username = userNameController.text;
                        String password = passwordController.text;
                        try {
                          await authProvider.login(username, password);
                          if (authProvider.accessToken != null) {
                            final response = await authProvider.sendrequest(
                                username, password, authProvider.accessToken!);
                            if (response.statusCode == 200) {
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>const HomeScreen()),
                                  (route) => false);
                            }else{
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content:const  CustomText(
                              text: 'Check connection of the internet',
                              color: Colors.white,
                            ),
                            action:
                                SnackBarAction(label: 'ok', onPressed: () {}),
                          ));  
                            }
                          }
                        } on Exception catch (e) {
                          // ignore: use_build_context_synchronously
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: const CustomText(
                              text: 'Be sure of your username and password',
                              color: Colors.white,
                            ),
                            action:
                                SnackBarAction(label: 'ok', onPressed: () {}),
                          ));
                          print(e.toString());
                        }
                      })),
            ],
          ),
        ),
      ),
    );
  }
}
