import 'dart:convert';

import 'package:american_electronics/Models/UserList/UserListModel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../../APIs/apis.dart';
import '../../../Utilities/Colors/colors.dart';
import 'addUser.dart';

class UserUI extends StatefulWidget {
  const UserUI({super.key});

  @override
  State<UserUI> createState() => _UserUIState();
}

class _UserUIState extends State<UserUI> {
  List<UserListModel> usersList = [];
  List<UserListModel> searchUserList = [];
  bool loading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    get_UserList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'User Management',
          style: TextStyle(color: ColorsUtils.whiteColor),
        ),
        backgroundColor: ColorsUtils.appcolor,
        iconTheme: IconThemeData(color: ColorsUtils.whiteColor),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
                  context, MaterialPageRoute(builder: (context) => AddUserUI()))
              .then((value) => get_UserList());
        },
        child: Icon(Icons.add),
      ),
      body: RefreshIndicator(
        onRefresh: get_UserList,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
          child: Column(
            children: [
              TextField(
                onChanged: (value) {
                  search(value);
                },
                decoration: InputDecoration(
                  hintText: "Search...",
                  suffixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: const BorderSide(
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: loading
                    ? const Center(child: CircularProgressIndicator())
                    : searchUserList.isEmpty
                        ? const Center(
                            child: Text(
                            "No User Exist",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey),
                          ))
                        : ListView.builder(
                            itemCount: searchUserList.length,
                            itemBuilder: (context, index) {
                              return Card(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10.0, vertical: 5),
                                  child: Row(
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            searchUserList[index]
                                                .tusrnam
                                                .toString(),
                                            style: const TextStyle(
                                              fontSize: 14,
                                            ),
                                          ),
                                          Text(
                                            searchUserList[index]
                                                .tmobnum
                                                .toString(),
                                            style: const TextStyle(
                                              fontSize: 12,
                                            ),
                                          ),
                                          Text(
                                            searchUserList[index]
                                                .temladd
                                                .toString(),
                                            style: const TextStyle(
                                              fontSize: 12,
                                            ),
                                          ),
                                          Text(
                                            searchUserList[index]
                                                .tusrsts
                                                .toString(),
                                            style: const TextStyle(
                                              fontSize: 12,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future get_UserList() async {
    var response = await http.get(Uri.parse(UserList));
    var result = jsonDecode(response.body);
    if (response.statusCode == 200) {
      usersList.clear();

      for (Map i in result) {
        usersList.add(UserListModel.fromJson(i));
        // print(result);
      }
      setState(() {
        loading = false;
        searchUserList = List.from(usersList);
      });
    } else {
      setState(() {
        loading = false;
      });
    }
  }

  void search(String query) {
    setState(() {
      searchUserList = usersList.where((category) {
        final customerNameMatches =
            category.tusrnam?.toLowerCase().contains(query.toLowerCase()) ??
                false;
        final mobileNumberMatches =
            category.tmobnum?.toLowerCase().contains(query.toLowerCase()) ??
                false;

        return customerNameMatches || mobileNumberMatches;
      }).toList();
    });
  }
}
