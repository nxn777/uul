import 'dart:convert';

import 'package:common/common.dart';
import 'package:flutter/material.dart';

import 'bundled_avatar.dart';

class BundledAvatarsList extends StatefulWidget {
  final Function(String) onTap;
  final double height;

  BundledAvatarsList({@required this.onTap, @required this.height});

  @override
  _BundledAvatarsListState createState() => _BundledAvatarsListState();
}

class _BundledAvatarsListState extends State<BundledAvatarsList> {
  List<String> imagePaths = [];

  @override
  void initState() {
    _initImages();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height,
      child: ListView.separated(
          separatorBuilder: (BuildContext context, int index) => SizedBox(
                width: kSpacingXSmall,
              ),
          itemCount: imagePaths.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) => BundledAvatar(
                onTap: widget.onTap,
                imageSrc: imagePaths[index],
                height: widget.height,
              )),
    );
  }

  Future _initImages() async {
    final manifestContent = await DefaultAssetBundle.of(context).loadString('AssetManifest.json');
    final Map<String, dynamic> manifestMap = json.decode(manifestContent);

    final imagePaths = manifestMap.keys.where((String key) => key.contains('avatars/')).where((String key) => key.contains('.png')).map((e) => Uri.decodeFull(e)).toList();

    setState(() {
      this.imagePaths = imagePaths;
    });
  }
}
