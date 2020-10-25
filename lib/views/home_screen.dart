import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task/controllers/task_controller.dart';
import 'package:task/controllers/user_controller.dart';
import 'package:task/models/ListItem.dart';
import 'package:task/models/task_model.dart';
import 'package:task/views/login_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TaskController taskController = Get.put(TaskController());
  final UserController userController = Get.put(UserController());

  List<ListItem> _dropdownItems = [
    ListItem(0, "ALL"),
    ListItem(1, "Assigned"),
    ListItem(4, "Completed"),
    ListItem(3, "Close")
  ];

  List<DropdownMenuItem<ListItem>> _dropdownMenuItems;
  ListItem _selectedItem;

  @override
  void initState() {
    super.initState();
    checkLogin().then((_) => checkTask());
    _dropdownMenuItems = buildDropDownMenuItems(_dropdownItems);
    _selectedItem = _dropdownMenuItems[0].value;
  }

  Future<void> checkLogin() async {
    await userController.getUser();
  }

  void checkTask() {
    String username = userController?.user?.value?.username;
    String userId = userController?.user?.value?.userId;
    String accessToken = userController?.user?.value?.accessToken;
    print('checkTask username=$username, userId=$userId');

    taskController.fetchTask(
      accessToken,
      userId,
      _selectedItem.value.toString(),
      '',
      '',
      '10',
    );
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
        title: GetX<UserController>(builder: (controller) {
          return Text('Hello, ${controller.user?.value?.username}');
        }),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            GetX<UserController>(builder: (controller) {
              return UserAccountsDrawerHeader(
                accountName: Text('Hello,'),
                accountEmail:
                    (controller.user?.value?.username?.isEmpty ?? true)
                        ? Text('')
                        : Text(controller.user?.value?.username),
              );
            }),
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
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  DropdownButton<ListItem>(
                      value: _selectedItem,
                      items: _dropdownMenuItems,
                      onChanged: (value) {
                        setState(() {
                          _selectedItem = value;
                        });

                        checkTask();
                      }),
                  RaisedButton.icon(
                    label: Text(
                      'Refresh',
                      style: TextStyle(color: Colors.white),
                    ),
                    icon: Icon(
                      Icons.refresh,
                      color: Colors.white,
                    ),
                    color: Colors.blueAccent,
                    onPressed: () {
                      checkTask();
                    },
                  ),
                ],
              ),
            ),
            SizedBox(height: 20.0),
            Text(
              'Last 10 Task of Status ${_selectedItem.name}',
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

  List<DropdownMenuItem<ListItem>> buildDropDownMenuItems(List listItems) {
    List<DropdownMenuItem<ListItem>> items = List();
    for (ListItem listItem in listItems) {
      items.add(
        DropdownMenuItem(
          child: Text(listItem.name),
          value: listItem,
        ),
      );
    }
    return items;
  }
}
