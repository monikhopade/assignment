
import 'package:assignment/user/user_form.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../provider/user_provider.dart';
import '../route/route.dart';

class UsersListScreen extends StatefulWidget {
  const UsersListScreen({super.key});



  @override
  State<UsersListScreen> createState() => _UsersListScreenState();
}

class _UsersListScreenState extends State<UsersListScreen> {

@override
  void initState() {
   
    super.initState();
    Provider.of<UserProvider>(context,listen: false).fetchUsers();
  }

  @override
  Widget build(BuildContext context) {
   
    final userProvider = context.watch<UserProvider>();
    final users = userProvider.users;
print("users length = ${users.length}");
    return Scaffold(
      appBar: AppBar(
        title: Text('User List'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: 
        users.isEmpty?
        Center(
          child: Text("No users added in DB"),
        )
        :Column(
          children: [
            Expanded(
              child: ListView.separated(
                separatorBuilder: (context, index) => Padding(padding: EdgeInsets.all(10)),
                itemCount: users.length,
                itemBuilder: (context, index) {
                  final user = users[index];
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 5.0),
                            child: richText("Name: ","${user.firstName} ${user.lastName}")
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 5.0),
                            child: richText("Mobile: ",user.mobileNumber),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 5.0),
                            child: richText("DOB: ",DateFormat('dd-MM-yyyy').format(user.dob)),
                          ),
                        ],
                      ),
                      IconButton(
                        onPressed: ()async{
                          await context.read<UserProvider>().deleteUser(user.id!);
                        },
                        icon: Icon(Icons.delete)
                      )
                    ],
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      await userProvider.previousPage();
                    },
                    child: Text('Previous'),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: Text('Page ${userProvider.page}'),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      await userProvider.nextPage();
                    },
                    child: Text('Next'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 70.0),
        child: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, Routes.userFormScreen);
          },
          child: Icon(Icons.add),
        ),
      ),
    );
  }

  richText(text1, text2){
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: text1,
            style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black)
          ),
          TextSpan(
            text: text2,
            style: TextStyle(color: Colors.black)
          ),
        ]
      )
    );
  }
}
