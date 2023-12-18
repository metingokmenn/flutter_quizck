import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_quizck/screens/admin_wait.dart';
import 'package:flutter_quizck/screens/home_page.dart';
import 'package:flutter_quizck/widgets/app_icon.dart';

import 'package:socket_io_client/socket_io_client.dart' as IO;

class UserWaitScreen extends StatefulWidget {
  UserWaitScreen({super.key, required this.userCount});

  var userCount;
  @override
  State<UserWaitScreen> createState() => _UserWaitScreenState();
}

class _UserWaitScreenState extends State<UserWaitScreen> {
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        didPop = false;
      },
      child: Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (context) => const HomePage()),
                      (predicate) {
                    return false;
                  });
                },
                icon: AppIcon(
                  size: 36,
                ))
          ],
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Stack(
                children: [
                  Positioned(
                    left: 10,
                    top: 150,
                    child: SizedBox(
                        height: MediaQuery.of(context).size.height - 300,
                        child: const VerticalDivider(
                          thickness: 0.6,
                          color: Colors.black,
                        )),
                  ),
                  const Positioned(
                    top: 50,
                    right: 100,
                    child: Text(
                      'Please wait until quiz starts...',
                    ),
                  ),
                  Positioned(
                    top: 150,
                    right: 100,
                    child: Text(
                      'NUMBER OF PARTICIPANTS: ${widget.userCount}',
                    ),
                  ),
                ],
              ),
            ),
            TextButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const AdminWaitScreen()));
                },
                child: const Text('ADMIN WAIT'))
          ],
        ),
      ),
    );
  }
}
