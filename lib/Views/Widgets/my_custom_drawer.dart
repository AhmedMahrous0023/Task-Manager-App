import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_manager_app/Core/Services/auth_provider_service.dart';
import 'package:task_manager_app/Views/Screens/Auth/login_screen.dart';
import 'package:task_manager_app/Views/Screens/Settings/settings_provider.dart';
import 'package:task_manager_app/Views/Widgets/custom_text.dart';

class CustomDrawer extends StatelessWidget {
  void Function()? onTap;
   CustomDrawer({super.key,this.onTap});

  @override
  Widget build(BuildContext context) {
        final authProvider = Provider.of<AuthProvider>(context);

    return Drawer(
        width: MediaQuery.of(context).size.width * .60,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
           const Padding(
              padding:  EdgeInsets.all(12.0),
              child: Card(child: CustomText(text: '   My Profile   ')),
            ),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(40.0),
                  child: Card(
                    child:  SizedBox(
                      height: MediaQuery.of(context).size.height*.09,
                      child: authProvider.user!=null? Image.network(authProvider.user!.image,fit: BoxFit.fill,):Text(''),
                    ),
                  ),
                ),
                Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                   const CustomText(text: 'My Name:'),
                    CustomText(text:authProvider.user!=null?'${ authProvider.user!.firstName}${authProvider.user!.lastName}':'',fontWeight: FontWeight.w700,color: Colors.blue,),
                  ],
                ),
              ),
            ),
             Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const CustomText(text: 'My Gender:'),
                    CustomText(text:authProvider.user!=null?'${ authProvider.user!.gender}':'',fontWeight: FontWeight.w700,color: Colors.blue,),
                  ],
                ),
              ),
            ),
              Padding(
              padding:  const EdgeInsets.all(8.0),
              child: Card(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const CustomText(text: 'My Email:'),
                    CustomText(text:authProvider.user!=null?' ${authProvider.user!.email}':'',fontWeight: FontWeight.w700,color: Colors.blue,),
                  ],
                ),
              ),
            ),
              ],
            ),
            InkWell(
              onTap: onTap,
              child:const Card(
                child: Padding(
                  padding:  EdgeInsets.all(8.0),
                  child: CustomText(text: 'My Added Tasks'),
                ),),
            ),
            
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: IconButton(
                    icon: Icon(Provider.of<SettingsProvider>(context).themeMode == ThemeMode.dark
                        ? Icons.dark_mode
                        : Icons.light_mode),
                    onPressed: () {
                      Provider.of<SettingsProvider>(context, listen: false).toggleTheme();
                    },
                  ),
                ),
                const CustomText(text: 'Theme Mode',fontSize: 16,)
                
              ],
            ),
            InkWell(
                  onTap: () {
                    Provider.of<AuthProvider>(context, listen: false).logout();
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => LoginScreen()),
                        (route) => false);
                  },
                  child:const Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Card(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                           Icon(Icons.logout_outlined),
                           SizedBox(width: 10),
                           CustomText(text: 'Log Out'),
                        ],
                      ),
                    ),
                  ),
                ),
          ],
        ),
      );
  }
}