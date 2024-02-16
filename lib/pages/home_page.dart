import 'package:azkari/models/zikr_subject.dart';
import 'package:azkari/pages/azkar_page.dart';
import 'package:azkari/services/data_service.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:sticky_headers/sticky_headers/widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  final TextEditingController _editingController = TextEditingController();
  String searchQuery = "";
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        appBar: AppBar(
          title: const Text("أذكاري", style: TextStyle(fontFamily: 'Amiri')),
          centerTitle: true,
          backgroundColor: Theme.of(context).colorScheme.background,
        ),
        body: mainAzkariPage(context),
      ),
    );
  }

  FutureBuilder<List<ZikrSubject>> mainAzkariPage(BuildContext context) {
    return FutureBuilder(
        future: DataService().getZikrSubjects(context),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return homeBody(context, snapshot.data!);
          } else if (snapshot.hasError) {
            return Center(
              child: Container(
                margin: const EdgeInsets.all(50),
                decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(15)),
                height: 100,
                child: Center(
                  child: Text(snapshot.error.toString(),
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold)),
                ),
              ),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        });
  }

  Widget homeBody(BuildContext context, List<ZikrSubject> subjects) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 40,
            ),
            Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: IconButton(
                        onPressed: () {
                          if (isSabah()) {
                            Navigator.of(context)
                                .push(MaterialPageRoute(builder: (cx) {
                              return AzkarPage(subject: subjects[0]);
                            }));
                          } else {
                            Navigator.of(context)
                                .push(MaterialPageRoute(builder: (cx) {
                              return AzkarPage(subject: subjects[1]);
                            }));
                          }
                        },
                        icon: Stack(children: [
                          Opacity(
                            opacity: isSabah() ? 1 : 0.5,
                            child: Icon(
                              Icons.sunny,
                              size: MediaQuery.of(context).size.width / 3.5,
                              color: isSabah()
                                  ? const Color(0xffEAE0D5)
                                  : const Color(0xff702632),
                            ),
                          ),
                          Positioned(
                            right: 20,
                            top: 18,
                            child: Transform.rotate(
                              angle: -math.pi / 4,
                              child: Opacity(
                                opacity: isSabah() ? 0.5 : 1,
                                child: Icon(
                                  Icons.nightlight_round_rounded,
                                  size: MediaQuery.of(context).size.width / 3.5,
                                  color: isSabah()
                                      ? const Color(0xff702632)
                                      : const Color(0xffEAE0D5),
                                ),
                              ),
                            ),
                          ),
                        ])),
                  ),
                ]),
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: SizedBox(
                width: MediaQuery.of(context).size.width / 2,
                child: const Divider(),
              ),
            ),
            StickyHeader(
                header: Container(
                  decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.background),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  margin: const EdgeInsets.only(bottom: 20),
                  child: SearchBar(
                    controller: _editingController,
                    trailing: searchQuery.isEmpty
                        ? null
                        : [
                            IconButton(
                              icon: const Icon(Icons.clear),
                              onPressed: () {
                                setState(() {
                                  _editingController.clear();
                                  searchQuery = "";
                                  FocusScope.of(context).unfocus();
                                });
                              },
                            )
                          ],
                    onChanged: (value) {
                      setState(() {
                        searchQuery = value;
                      });
                    },
                    hintText: "إبحث عن أذكار",
                    elevation: const MaterialStatePropertyAll(3),
                  ),
                ),
                content: azkarListView(subjects)),
          ],
        ),
      ),
    );
  }

  Widget azkarListView(List<ZikrSubject> subjects) {
    final filteredSubjects = subjects
        .where((element) => searchQuery.isEmpty
            ? true
            : element.category
                .toLowerCase()
                .contains(searchQuery.toLowerCase()))
        .map((subject) => subjectTile(subject))
        .toList();
    return ListView.builder(
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      itemCount: filteredSubjects.length,
      itemBuilder: (context, index) {
        return filteredSubjects[index];
      },
    );
  }

  ListTile subjectTile(ZikrSubject subject) {
    return ListTile(
      onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (cx) {
        return AzkarPage(subject: subject);
      })),
      title: Text(subject.category),
      trailing: const Icon(Icons.keyboard_arrow_left_rounded),
    );
  }

  bool isSabah() {
    DateTime now = DateTime.now();
    return (now.hour > 0 && now.hour < 17);
  }
}
