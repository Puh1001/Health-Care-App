import 'package:flutter/material.dart';
import 'package:heathtrack/providers/userProvider.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../widgets/updateWatcherInfoView.dart';
import '../../widgets/InforBar.dart';
class WatcherProfileScreen extends StatelessWidget {
  var image = 'images/avatar.png';
  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(
      builder: (context,watcher,child){
      return Scaffold(
        appBar: AppBar(
          leading: Container(),
          centerTitle: true,
          title: Text('Information'),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: TextButton(
                  onPressed: (){
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const UpdateWatcherInfoView(),
                      ),
                    );
                  },
                  child: const Text(
                      'Edit',
                    style: TextStyle(
                      fontSize: 20
                    ),
                  )
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Container(
            color: const Color(0xfff7f7f7),
            padding: const EdgeInsets.only(top: 20),

            child: Column(
              children: [
                CircleAvatar(
                  radius: 80,
                  child: CircleAvatar(
                    radius: 75,
                    backgroundColor: Colors.white,
                    child: Stack(
                      children: [
                        SizedBox(
                          height: 150,
                          width: 150,
                          child: ClipOval(
                            child: Image.asset(
                              image,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Text(
                  shortenName(watcher.user.name),
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                InforBar('Main Information', [
                  Infor(
                    'Name',
                    watcher.user.name,
                    onTouch: (){},
                    canEdit: false,
                  ),
                  Infor(
                    'Gender',
                    "${watcher.user.gender}",
                    canEdit: false, onTouch: (){},
                  ),
                  Infor(
                    'Date of Birth',
                    (watcher.user.dateOfBirth == null)
                        ? 'No information'
                        : DateFormat('dd/MM/yyyy').format(watcher.user.dateOfBirth!),
                    onTouch: (){},
                    canEdit: false,
                  ),
                ]),
                InforBar('Communications', [
                  Infor(
                    'Phone number',
                    "${watcher.user.phoneNumber}",
                    canEdit: false,
                    onTouch: () {},
                  ),
                  Infor(
                    'Email',
                    "${watcher.user.email}",
                    canEdit: false, onTouch: (){},
                  ),
                ]),
              ],
            ),
          ),
        ),
      );}
    );
  }
}
String shortenName(String fullName) {
  String shortenName;
  fullName = fullName.trim();
  if (fullName.contains(" ")) {
    String startString = fullName.substring(0, fullName.indexOf(' '));
    String endString = fullName.substring(fullName.lastIndexOf(' ') + 1);
    shortenName = "$startString $endString";
  } else {
    shortenName = fullName;
  }
  return shortenName;
}
