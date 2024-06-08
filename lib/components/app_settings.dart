import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
// import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';
import 'package:expiry_date_tracker/controllers/theme_controller.dart';
// import 'package:flutter/widgets.dart';

class AppSettings extends StatefulWidget {
  const AppSettings({super.key});

  @override
  State<AppSettings> createState() => _AppSettingsState();
}

class _AppSettingsState extends State<AppSettings> {
  // bool darkMode = false;

  // _AppSettingsState() {
  //   _loadDarkModeSetting();
  // }

  // _loadDarkModeSetting() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   setState(() {
  //     darkMode = (prefs.getBool('darkMode') ?? false);
  //   });
  // }

  // _saveDarkModeSetting(bool value) async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   prefs.setBool('darkMode', value);
  //   // Get.changeThemeMode(value? ThemeMode.dark:ThemeMode.light);
  // }

  @override
  Widget build(BuildContext context) {

    final ThemeController themeController = Get.find();
    
    return Scaffold(
      appBar: AppBar( 
        title:const Text("Settings"),
        centerTitle: true,
        leading: IconButton( 
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: (){Navigator.pop(context);} ,
        ),

      ),
      body: Center(
        child: Column(
          children: [
            // const SizedBox(height: 30),
            // Container(
            //   margin: const EdgeInsets.only(left: 60, right: 30),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //     children: [
            //       const Text(
            //         "Settings",
            //         style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            //       ),
            //       IconButton(
            //           onPressed: () {
            //             Navigator.pop(context);
            //           },
            //           icon: const Icon(Icons.arrow_back_ios))
            //     ],
            //   ),
            // ),
            const SizedBox(height: 30),
            Container(
              width: double.infinity,
              margin: const EdgeInsets.symmetric(horizontal: 10),
              child: Obx(
                () => ListTile(
                  leading: themeController.isDarkMode.value
                      ? const Icon(Icons.dark_mode)
                      : const Icon(Icons.light_mode),
                  trailing: Switch(
                    value: themeController.isDarkMode.value,
                    onChanged: (value) {
                      themeController.toggleTheme(value);
                    },
                  ),
                  title: const Text("Dark mode (beta)"),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
