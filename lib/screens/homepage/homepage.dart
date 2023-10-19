import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:pandawatest/model/response/user/user.dart';
import 'package:pandawatest/screens/shared/usercard.dart';
import 'package:pandawatest/services/apiservice.dart';
import 'package:pandawatest/services/valuepreferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int limit = 100;
  bool isLoading = true;
  APIService apiService = APIService();
  List<User> userList = [];
  String? query;
  void logoutPressed() async {
    await ValuePreferences.clearValue('token');
    if (mounted) {
      setState(() {
        Navigator.pushReplacementNamed(context, '/login');
      });
    }
  }

  void getUser(String? query) async {
    setState(() {
      isLoading = true;
    });
    try {
      if (query != null) {
        var queryParam = {'limit': limit.toString(), 'q': query};
        userList = await apiService.getUserByName(queryParam) ?? [];
      } else {
        var queryParam = {'limit': limit.toString()};
        userList = await apiService.getUser(queryParam) ?? [];
      }
    } catch (e) {
      Logger().e(e);
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    getUser(query);
  }

  void showFilterButtonSheet() {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 300,
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Filter Data',
                  style: TextStyle(
                      fontFamily: 'OpenSans',
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                ),
              ),
              Expanded(
                child: StatefulBuilder(
                  builder: (BuildContext context,
                      void Function(void Function()) setState) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(left: 16.0),
                          child: Text(
                            'Limit Data',
                            style: TextStyle(
                                fontFamily: 'OpenSans',
                                fontWeight: FontWeight.bold,
                                fontSize: 14),
                          ),
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Slider(
                                activeColor: Colors.green,
                                value: limit.toDouble(),
                                onChanged: (value) {
                                  setState(() {
                                    limit = value.toInt();
                                  });
                                },
                                max: 100.0,
                                min: 1.0,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 16.0),
                              child: Text(
                                limit == 100 ? 'Show all' : limit.toString(),
                                style: const TextStyle(
                                    fontFamily: 'OpenSans', fontSize: 13),
                              ),
                            ),
                          ],
                        ),
                      ],
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        child: const Text('Clear Filter',
                            style: TextStyle(
                              color: Colors.green,
                            )),
                        onPressed: () {
                          limit = 100;
                          Navigator.pop(context);
                          getUser(query);
                        },
                      ),
                    ),
                    Expanded(
                      child: ElevatedButton(
                        style: const ButtonStyle(
                            backgroundColor: MaterialStatePropertyAll(
                                Color.fromARGB(255, 10, 140, 25))),
                        onPressed: () {
                          Navigator.pop(context);
                          getUser(query);
                        },
                        child: const Text(
                          'Apply',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Home Page"),
          actions: [
            IconButton(
              icon: const Icon(Icons.logout),
              onPressed: () {
                logoutPressed();
              },
            ),
          ],
        ),
        body: Column(children: [
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.all(Radius.circular(8)),
            ),
            child: Center(
              child: TextField(
                onChanged: (text) {
                  setState(() {
                    query = text;
                    getUser(query);
                  });
                },
                decoration: InputDecoration(
                  border: const UnderlineInputBorder(),
                  prefixIcon: const Icon(Icons.search),
                  hintText: "Search User",
                  suffixIcon: IconButton(
                    onPressed: showFilterButtonSheet,
                    icon: const Icon(Icons.filter_alt_outlined),
                  ),
                ),
              ),
            ),
          ),
          isLoading
              ? const CircularProgressIndicator()
              : Expanded(
                  child: ListView.builder(
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return UserCard(user: userList[index]);
                  },
                  itemCount: userList.length,
                )),
        ]),
      ),
    );
  }
}
