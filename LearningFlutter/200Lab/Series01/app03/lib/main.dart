import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  _launchNativeApps(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      throw 'Could not launch $url';
    }
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Portfolio App',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blueGrey,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Scaffold(
        backgroundColor: const Color.fromRGBO(227, 234, 237, 1),
        appBar: AppBar(
          title: const Text('Portfolio'),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(
                height: 30,
              ),
              CircleAvatar(
                radius: 100,
                backgroundColor: Theme.of(context).primaryColor,
                child: const CircleAvatar(
                  radius: 95,
                  backgroundColor: Colors.white70,
                  backgroundImage:
                      AssetImage('assets/images/Ass_Dao Thanh Tung.png'),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                'Đào Thanh Tùng',
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.w700),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Divider(),
              ),
              const Text(
                'SOFTWARE ENGINEER',
                style: TextStyle(fontSize: 19, fontWeight: FontWeight.w700),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                child: Divider(),
              ),
              const Padding(
                padding: EdgeInsets.all(30.0),
                child: Text(
                  'Hello, I am Dao Thanh Tung a new mobile developer.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: ElevatedButton(
                  onPressed: () {
                    _launchNativeApps(
                        'https://github.com/thanhtungpfiev/Flutter');
                  },
                  child: SizedBox(
                      height: 40,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Icon(Icons.person_outline_rounded,
                              size: 30, color: Colors.blue[800]),
                          Text(
                            'Website',
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 15,
                                color: Colors.grey[700]),
                          )
                        ],
                      )),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: ElevatedButton(
                  onPressed: () {
                    _launchNativeApps('tel: +84974351712');
                  },
                  child: SizedBox(
                      height: 40,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Icon(Icons.wifi_calling_rounded,
                              size: 30, color: Colors.greenAccent[700]),
                          Text(
                            '+84 - 97 - 435 - 1712',
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 15,
                                color: Colors.grey[700]),
                          )
                        ],
                      )),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: ElevatedButton(
                  onPressed: () {
                    _launchNativeApps(
                        'mailto:thanhtungpfiev@gmail.com?subject=I would like to build an app with you!&body=Hi there,\n I have an awesome app idea,\n\n');
                  },
                  child: SizedBox(
                      height: 40,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Icon(Icons.email_rounded,
                              size: 30, color: Colors.red[800]),
                          Text(
                            'thanhtungpfiev@gmail.com',
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 15,
                                color: Colors.grey[700]),
                          )
                        ],
                      )),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}