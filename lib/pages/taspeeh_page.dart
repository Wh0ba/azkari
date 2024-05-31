import 'package:azkari/models/taspeeh.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:visibility_aware_state/visibility_aware_state.dart';

class TaspeehPage extends StatefulWidget {
  const TaspeehPage({super.key});

  @override
  State<TaspeehPage> createState() => _TaspeehPageState();
}

class _TaspeehPageState extends VisibilityAwareState<TaspeehPage>
    with AutomaticKeepAliveClientMixin {
  int _index = 0;
  List<Taspeeh> taspeeh = [
    Taspeeh('سبحان الله'),
    Taspeeh('الحمد لله'),
    Taspeeh('الله اكبر'),
  ];

  @override
  bool get wantKeepAlive => true;
  @override
  void initState() {
    super.initState();

    SharedPreferences.getInstance().then((prefs) async {
      final tas = prefs.getStringList('taspeeh');
      if (tas != null) {
        setState(() {
          final List<Taspeeh> tempTaspeeh = [];
          for (var key in tas) {
            tempTaspeeh.add(
                Taspeeh.withCount(zikr: key, count: prefs.getInt(key) ?? 0));
          }
          taspeeh = tempTaspeeh;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("سبحتي", style: TextStyle(fontFamily: 'Amiri')),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(
              top: 60,
              left: 0,
              right: 0,
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  '${taspeeh[_index].count}',
                  style: const TextStyle(fontSize: 70),
                ),
              ),
            ),
            Positioned(
                child: Align(
                    child: CarouselSlider.builder(
                        itemCount: taspeeh.length,
                        itemBuilder: (context, index, realIndex) {
                          return Card(
                            child: Center(
                              child: Text(
                                taspeeh[index].zikr,
                                style: const TextStyle(
                                    fontSize: 40, fontFamily: 'Amiri'),
                              ),
                            ),
                          );
                        },
                        options: CarouselOptions(
                          enlargeCenterPage: true,
                          height: 150,
                          enlargeFactor: 0.3,
                          onPageChanged: (index, reason) {
                            setState(() {
                              _index = index;
                            });
                          },
                        )))),
            Positioned(
              bottom: 60,
              left: 0,
              right: 0,
              child: Align(
                child: IconButton(
                  highlightColor: Theme.of(context).colorScheme.surface,
                  iconSize: 50,
                  onPressed: () {
                    setState(() {
                      taspeeh[_index].count++;
                    });
                  },
                  icon: const Icon(Icons.back_hand_outlined),
                ),
              ),
            ),
            Positioned(
                bottom: 40,
                right: 10,
                child: IconButton(
                    highlightColor: Theme.of(context).colorScheme.surface,
                    iconSize: 30,
                    onPressed: () {
                      setState(() {
                        taspeeh[_index].count = 0;
                      });
                    },
                    icon: const Icon(Icons.restart_alt_rounded))),
          ],
        ),
      ),
    );
  }

  @override
  void onVisibilityChanged(WidgetVisibility visibility) {
    SharedPreferences.getInstance().then((prefs) {
      List<String> taspeehKeys = taspeeh.map((e) => e.zikr).toList();
      for (var i = 0; i < taspeeh.length; i++) {
        prefs.setInt(taspeeh[i].zikr, taspeeh[i].count);
      }
      prefs.setStringList('taspeeh', taspeehKeys);
    });
    super.onVisibilityChanged(visibility);
  }
}
