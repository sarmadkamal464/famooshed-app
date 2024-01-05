import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:famooshed/app/theme/loader.dart';
import 'package:flutter/material.dart';

// 30.12.2020

class IBanner extends StatefulWidget {
  final List<String> dataPromotion;
  final double width;
  final Color colorProgressBar;
  final double height;
  final Color colorGrey;
  final Color colorActivy;
  final TextStyle style;
  final double radius;

  final int seconds;
  const IBanner(
    this.dataPromotion, {
    super.key,
    this.width = 100,
    this.height = 100,
    this.colorGrey = Colors.grey,
    required this.colorActivy,
    required this.style,
    this.seconds = 3,
    this.colorProgressBar = Colors.black,
    this.radius = 0,
  });

  @override
  State<IBanner> createState() => _IBannerState();
}

class _IBannerState extends State<IBanner> {
  int realCountPaget = 0;
  var t = 0;
  var _currentPage = 1000;
  // Color _colorActivy = Colors.black;
  // Color _colorGrey = Color.fromARGB(255, 180, 180, 180);
  // var _seconds = 3;

  Timer? _timer;
  void startTimer() {
    _timer = Timer.periodic(
      Duration(seconds: widget.seconds),
      (Timer timer) {
        int page = _currentPage + 1;
        _controller.animateToPage(page,
            duration: const Duration(seconds: 1), curve: Curves.ease);
      },
    );
  }

  @override
  void dispose() {
    if (_timer != null) _timer!.cancel();
    super.dispose();
  }

  @override
  void initState() {
    // if (widget.seconds != null)
    //   _seconds = widget.seconds;
    realCountPaget = widget.dataPromotion.length;
    startTimer();
    super.initState();
  }

  _getT(int itemIndex) {
    if (widget.dataPromotion.isEmpty) return;
    if (itemIndex > 1000) {
      t = itemIndex - 1000;
      while (t >= realCountPaget) {
        t -= realCountPaget;
      }
    }
    if (itemIndex < 1000) {
      t = 1000 - itemIndex;
      var r = realCountPaget;
      do {
        if (r == 0) r = realCountPaget;
        r--;
        t--;
      } while (t > 0);
      t = r;
    }
  }

  final _controller =
      PageController(initialPage: 1000, keepPage: false, viewportFraction: 1);

  _promotion() {
    return Column(
      children: <Widget>[
        SizedBox(
          height: widget.height,
          child: PageView.builder(
            itemCount: 10000,
            onPageChanged: (int page) {
              _getT(page);
              setState(() {});
              _currentPage = page;
            },
            controller: _controller,
            itemBuilder: (BuildContext context, int itemIndex) {
              _getT(itemIndex);
              if (t < 0 || t > realCountPaget) return Container();
              var item = widget.dataPromotion[t];
              return Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(widget.radius),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withAlpha(0),
                        spreadRadius: 2,
                        blurRadius: 2,
                        offset:
                            const Offset(2, 2), // changes position of shadow
                      ),
                    ]),
                margin: const EdgeInsets.all(10),
                width: widget.width,
                height: widget.height,
                child: _sale2(item, t),
              );
            },
          ),
        ),
        SizedBox(
            child: Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                    margin: const EdgeInsets.only(bottom: 25, right: 25),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: _lines(),
                    )))),
      ],
    );
  }

  _sale2(String item, int index) {
    var id = UniqueKey().toString();

    return InkWell(
        onTap: () {}, // needed
        child: Stack(
          children: <Widget>[
            SizedBox(
              width: widget.width,
              height: widget.height,
              child: Hero(
                tag: id,
                child: ClipRRect(
                  borderRadius:
                      BorderRadius.all(Radius.circular(widget.radius)),
                  child: CachedNetworkImage(
                    placeholder: (context, url) => UnconstrainedBox(
                        child: Container(
                      alignment: Alignment.center,
                      width: 60,
                      height: 60,
                      child: const Loader(),
                    )),
                    imageUrl: item,
                    imageBuilder: (context, imageProvider) => Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
                ),
              ),
            ),

            // ClipRRect(
            //     borderRadius: BorderRadius.only(topLeft: Radius.circular(widget.radius), topRight: Radius.circular(widget.radius)),
            //     child:Container(
            //         height: 20,
            //         color: Colors.black.withAlpha(140),
            //         width: widget.width,
            //         child: Container(
            //             margin: EdgeInsets.only(left: 10, right: 10),
            //             child: Text(item.name, textAlign: TextAlign.start, style: widget.style,)
            //         )
            //     )),
          ],
        ));
  }

  _lines() {
    List<Widget> lines = [];
    for (int i = 0; i < realCountPaget; i++) {
      if (i == t) {
        lines.add(Container(
          width: 15,
          height: 3,
          decoration: BoxDecoration(
            color: widget.colorActivy,
            border: Border.all(color: widget.colorActivy),
            borderRadius: BorderRadius.circular(10),
          ),
        ));
      } else {
        lines.add(Container(
          width: 15,
          height: 3,
          decoration: BoxDecoration(
            color: widget.colorGrey,
            border: Border.all(color: widget.colorGrey),
            borderRadius: BorderRadius.circular(10),
          ),
        ));
      }
      lines.add(
        const SizedBox(
          width: 5,
        ),
      );
    }

    return lines;
  }

  @override
  Widget build(BuildContext context) {
    // if (widget.colorActivy != null)
    //   _colorActivy = widget.colorActivy;
    //
    // if (widget.colorGrey != null)
    //   _colorGrey = widget.colorGrey;

    return _promotion();
  }
}
