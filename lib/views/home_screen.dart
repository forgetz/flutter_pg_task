import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task/controllers/task_controller.dart';
import 'package:task/models/task_model.dart';
import 'package:task/views/login_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TaskController taskController = Get.put(TaskController());

  String username;
  String userId;
  String accessToken;

  @override
  void initState() {
    super.initState();
    checkLogin().then((_) => checkTask());
  }

  Future<void> checkLogin() async {
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      String getusername = preferences.getString('username');
      String gettoken = preferences.getString('token');
      String getuserId = preferences.getString('userId');
      print('checkLogin username=$getusername userId=$getuserId');

      if ((getusername?.isEmpty ?? true) || (getuserId?.isEmpty ?? true)) {
        Get.to(LoginScreen());
      }

      // UserModel userModel =
      //     UserModel(username: username, accessToken: token, userId: userId);
      setState(() {
        username = getusername;
        userId = getuserId;
        accessToken = gettoken;
      });
    } catch (e) {
      Get.snackbar(
        'Error',
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.redAccent,
      );
    }
  }

  void checkTask() {
    print('username=$username, userId=$userId');
    taskController.fetchTask(accessToken, userId, '', '', '', '10');

    // await apiLoadTask(user.accessToken, user.userId, '', '', '', '10')
    //     .then((value) {
    //   task = value;
    // });
  }

  Future<Null> signOut(BuildContext context) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.clear();
    // MaterialPageRoute route =
    //     MaterialPageRoute(builder: (context) => LoginScreen());
    // Navigator.pushAndRemoveUntil(context, route, (route) => false);
    Get.offAll(LoginScreen());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            (username?.isEmpty ?? true) ? Text('') : Text('Hello, $username'),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
              accountName: Text('Hello,'),
              accountEmail:
                  (username?.isEmpty ?? true) ? Text('') : Text(username),
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text('Logout'),
              onTap: () {
                signOut(context);
              },
            )
          ],
        ),
      ),
      body: Container(
        child: Column(
          children: [
            SizedBox(height: 20.0),
            RaisedButton.icon(
              label: Text('Refresh'),
              icon: Icon(Icons.refresh),
              color: Colors.blueGrey,
              onPressed: () {
                taskController.fetchTask(accessToken, userId, '', '', '', '10');
              },
            ),
            SizedBox(height: 20.0),
            Text(
              'Last 10 Task',
              style: TextStyle(
                  color: Colors.blueAccent,
                  fontSize: 15.0,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20.0),
            Expanded(
              child: GetBuilder<TaskController>(
                builder: (controller) {
                  return ListView.builder(
                    itemCount: controller.items.length,
                    itemBuilder: (context, index) {
                      Items item = controller.items[index];
                      return Card(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 12.0, vertical: 12.0),
                              child: ListTile(
                                title: Text(
                                    '${item.runningNumber} : ${item.statusName}'),
                                subtitle: Text(
                                  item.summary,
                                  style: TextStyle(
                                    color: Colors.black.withOpacity(0.6),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
