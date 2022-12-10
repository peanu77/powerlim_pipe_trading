import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class ReturnedItemsPage extends StatefulWidget {
  const ReturnedItemsPage({super.key});

  @override
  State<ReturnedItemsPage> createState() => _ReturnedItemsPageState();
}

class _ReturnedItemsPageState extends State<ReturnedItemsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Returned Items Page'),
      ),
    );
  }
}
