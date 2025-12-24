import 'package:flutter/material.dart';
import 'package:flutter_application_1/provider/auth_provider.dart';
import 'package:provider/provider.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    if (!authProvider.isAuth) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Profile', style: TextStyle(fontSize: screenWidth * 0.05)),
          backgroundColor: Colors.blue,
        ),
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blue.shade100, Colors.white],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Center(
            child: TextButton(

              child: Text("Please Login first to see your profile",
              style: TextStyle(color: Colors.black, fontSize: screenWidth * 0.04),

              ),
              onPressed: () {

                Navigator.pushNamed(context, "login");

              },
            ),

          ),

        ),
        backgroundColor: const Color.fromARGB(255, 208, 204, 230),

        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.blue,
          child: const Icon(Icons.login),
          onPressed: () {
            Navigator.pushNamed(context, "login");
          },
        ),
      );
    }

    final user = authProvider.user;

    return Scaffold(
      appBar: AppBar(
        title: Text('Profile', style: TextStyle(fontSize: screenWidth * 0.05)),
        backgroundColor: Colors.blue,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue.shade100, Colors.white],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: Container(
            margin: EdgeInsets.all(screenWidth * 0.04),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(screenWidth * 0.05),
              gradient: const LinearGradient(
                colors: [Colors.white, Colors.blueGrey],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 20,
                  offset: Offset(0, 10),
                ),
              ],
            ),
            child: Padding(
              padding: EdgeInsets.all(screenWidth * 0.08),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: const LinearGradient(
                        colors: [Colors.blue, Colors.purple],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      border: Border.all(color: Colors.white, width: screenWidth * 0.01),
                      color: Colors.blue.shade50,
                      borderRadius: BorderRadius.circular(screenWidth * 0.25),

                      boxShadow: [
                        BoxShadow(
                          color: Colors.blue.withAlpha(77),
                          blurRadius: 15,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: CircleAvatar(
                      radius: screenWidth * 0.15,
                      backgroundColor: Colors.transparent,
                      child: Text(
                        user.name.isNotEmpty ? user.name[0].toUpperCase() : 'U',
                        style: TextStyle(
                          fontSize: screenWidth * 0.12,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.03),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04, vertical: screenHeight * 0.01),
                    decoration: BoxDecoration(
                      color: Colors.white.withAlpha(204),
                      borderRadius: BorderRadius.circular(screenWidth * 0.03),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.person, color: Colors.blue),
                        SizedBox(width: screenWidth * 0.02),
                        Text(
                          user.name,
                          style: TextStyle(
                            fontSize: screenWidth * 0.05,
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.015),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04, vertical: screenHeight * 0.01),
                    decoration: BoxDecoration(
                      color: Colors.white.withAlpha(204),
                      borderRadius: BorderRadius.circular(screenWidth * 0.03),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.email, color: Colors.blue),
                        SizedBox(width: screenWidth * 0.02),
                        Text(
                          user.email,
                          style: TextStyle(
                            fontSize: screenWidth * 0.04,
                            color: Colors.black87,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}