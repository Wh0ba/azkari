import 'package:azkari/models/holy_name.dart';
import 'package:flutter/material.dart';

class NamePage extends StatelessWidget {
  const NamePage({super.key, required this.name});
  final HolyName name;
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Text(name.name, style: const TextStyle(fontFamily: 'Amiri')),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 40),
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 100,
                ),
                Text(
                  name.name,
                  style: const TextStyle(fontFamily: 'Amiri', fontSize: 80),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 100,
                ),
                Text(
                  name.meaning,
                  style: const TextStyle(fontFamily: 'Amiri', fontSize: 20),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
