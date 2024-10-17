import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection('buyers');

    return FutureBuilder<DocumentSnapshot>(
      future: users.doc(FirebaseAuth.instance.currentUser!.uid).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Scaffold(
            body: Center(child: Text("Something went wrong")),
          );
        }

        if (snapshot.hasData && !snapshot.data!.exists) {
          return const Scaffold(
            body: Center(child: Text("Document does not exist")),
          );
        }

        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic>? data =
              snapshot.data!.data() as Map<String, dynamic>?;

          if (data == null) {
            return const Scaffold(
              body: Center(child: Text("Document data is null")),
            );
          }

          return Scaffold(
            appBar: AppBar(
              elevation: 2,
              backgroundColor: Colors.green[200],
              title: const Text(
                'Profile',
                style: TextStyle(letterSpacing: 4, color: Colors.white),
              ),
              centerTitle: true,
              actions: const [
                Padding(
                  padding: EdgeInsets.all(14.0),
                  child: Icon(
                    Icons.star,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 64,
                  backgroundColor: Colors.green.shade200,
                  backgroundImage: NetworkImage(data['profleImage'] ?? ''),
                ),
                const SizedBox(
                  height: 15,
                ),
                Text(
                  data['fullName'] ?? 'N/A',
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  data['email'] ?? 'N/A',
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(15.0),
                  child: Divider(
                    thickness: 2,
                    color: Colors.grey,
                  ),
                ),
                const ListTile(
                  leading: Icon(Icons.settings),
                  title: Text('Settings'),
                ),
                const ListTile(
                  leading: Icon(Icons.phone),
                  title: Text('Phone'),
                ),
                const ListTile(
                  leading: Icon(Icons.shopping_cart),
                  title: Text('Cart'),
                ),
                const ListTile(
                  leading: Icon(Icons.shopping_bag),
                  title: Text('Orders'),
                ),
                const ListTile(
                  leading: Icon(Icons.logout),
                  title: Text('Logout'),
                ),
              ],
            ),
          );
        }

        return  const CircularProgressIndicator();
      },
    );
  }
}
