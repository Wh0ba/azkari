import 'package:azkari/models/zikr_subject.dart';
import 'package:azkari/widgets/azkar_card.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class AzkarPage extends StatefulWidget {
  const AzkarPage({super.key, required this.subject});
  final ZikrSubject subject;
  @override
  State<AzkarPage> createState() => _AzkarPageState();
}

class _AzkarPageState extends State<AzkarPage> {
  CarouselController controller = CarouselController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        foregroundColor: const Color(0xffEAE0D5),
        backgroundColor: Theme.of(context).colorScheme.background,
        centerTitle: true,
        title: Text(
          widget.subject.category,
          style: const TextStyle(fontFamily: 'Amiri'),
        ),
      ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CarouselSlider(
              carouselController: controller,
              items: widget.subject.items
                  .map((item) => AzkarCard(
                      item: item,
                      onCountFinished: () {
                        controller.nextPage();
                      }))
                  .toList(),
              options: CarouselOptions(
                  height: 550,
                  enlargeCenterPage: true,
                  enableInfiniteScroll: false,
                  reverse: true))
        ],
      )),
    );
  }
}
