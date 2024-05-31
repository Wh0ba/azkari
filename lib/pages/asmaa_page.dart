import 'package:azkari/models/holy_name.dart';
import 'package:azkari/pages/name_page.dart';
import 'package:azkari/services/data_service.dart';
import 'package:flutter/material.dart';

class AsmaaPage extends StatefulWidget {
  const AsmaaPage({super.key});

  @override
  State<AsmaaPage> createState() => _AsmaaPageState();
}

class _AsmaaPageState extends State<AsmaaPage> {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            'أسماءُ اللَّهِ الحُسنى',
            style: TextStyle(fontFamily: 'Amiri'),
          ),
        ),
        body: FutureBuilder(
            future: DataService().loadAsmaa(context),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return asmaaGrid(snapshot.data!);
              } else if (snapshot.hasError) {
                return Center(child: Text(snapshot.error.toString()));
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            }),
      ),
    );
  }

  Widget asmaaGrid(List<HolyName> holyNames) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3),
          itemCount: holyNames.length,
          itemBuilder: (context, index) {
            return asmaaTile(holyNames[index]);
          }),
    );
  }

  Widget asmaaTile(HolyName holyName) {
    return Container(
      margin: const EdgeInsets.all(12),
      child: TextButton(
        style: TextButton.styleFrom(
            overlayColor: const Color(0xff90a955),
            backgroundColor: const Color(0xff2d2d2d),
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    bottomRight: Radius.circular(40)))),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return NamePage(name: holyName);
          }));
        },
        child: Center(
          child: Text(
            holyName.name,
            style: const TextStyle(fontSize: 22, fontFamily: 'Amiri'),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
