import 'dart:typed_data';

import 'package:flutter/material.dart';

// دائرة الصورة الشخصية: الصورة إذا موجودة، وإلا أيقونة شخص
class UserAvatar extends StatelessWidget {
  const UserAvatar({super.key, this.bytes, this.radius = 50});

  final Uint8List? bytes;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius,
      backgroundColor: Colors.grey.shade400,
      backgroundImage: bytes == null ? null : MemoryImage(bytes!),
      child: bytes == null
          ? Icon(Icons.person, size: radius * 1.3, color: Colors.white)
          : null,
    );
  }
}
