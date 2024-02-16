import 'package:azkari/models/zikr_item.dart';
import 'package:flutter/material.dart';

class AzkarCard extends StatefulWidget {
  const AzkarCard(
      {super.key, required this.item, required this.onCountFinished});
  final Function onCountFinished;
  final ZikrItem item;
  @override
  State<AzkarCard> createState() => _AzkarCardState();
}

class _AzkarCardState extends State<AzkarCard> {
  int count = 0;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            color: const Color(0xff051014),
            border: Border.all(
                color: Theme.of(context).colorScheme.surface, width: 2),
            borderRadius: BorderRadius.circular(20)),
        padding: const EdgeInsets.all(15),
        child: Stack(
          children: [
            Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 60),
                  child: Text(
                    widget.item.text,
                    style: TextStyle(
                      height: 1.7,
                      fontSize: 20,
                      color: Theme.of(context).colorScheme.primary,
                      fontFamily: 'Othmanic',
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
            Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Align(
                    alignment: Alignment.center,
                    child: MaterialButton(
                        height: 50,
                        shape: CircleBorder(
                            side: BorderSide(
                                color: Theme.of(context).colorScheme.surface,
                                width: 2)),
                        onPressed: () {
                          setState(() {
                            if (count + 1 == widget.item.count) {
                              widget.onCountFinished();
                              count = 0;
                            } else {
                              count++;
                            }
                          });
                        },
                        child: Text(
                          count == 0 ? '${widget.item.count}' : '$count',
                          style: const TextStyle(fontSize: 20),
                        ))))
          ],
        ));
  }
}
