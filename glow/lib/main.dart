// Copyright 2018 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:glow/resources.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: true,
      title: 'Hello Rectangle',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Hello Rectangle'),
        ),
        body: FlyerBody(),
      ),
    ),
  );
}

class FlyerBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(padding: EdgeInsets.all(8), child: GridView.count(
      crossAxisCount: 2,
      children: List.generate(flyers.length, (index)
          {
            return Padding(
              padding: EdgeInsets.symmetric(vertical: 0, horizontal: 0),
              child: Card(
                child: Image.asset(flyers[index].cover),
              ),
            );
          })
        )
    );
      }
}
