import 'package:flutter/material.dart';
import 'package:glow/ui/data/colors.dart';
import 'package:glow/ui/data/resources.dart';
import 'package:glow/ui/flyerDetail.dart';

class FlyerList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorAcent,
        title: Text('GLOW'),
      ),
      body: GridView.count(
        crossAxisCount: 2,
        mainAxisSpacing: 24,
        children: List.generate(resources.flyers.length, (flyerIndex) {
          return Center(
            child: Card(
                elevation: 12,
                child: Stack(
                  children: <Widget>[
                    Image.asset(resources.flyers[flyerIndex].cover),
                    Positioned.fill(
                        child: new Material(
                            color: Colors.transparent,
                            child: new InkWell(
                              splashColor: colorAcentSlash,
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => FlyerDetail(flyerIndex: flyerIndex)),
                                );
                              },
                            )
                        )
                    ),
                  ],
                )),
          );
        }),
      ),
    );
  }
}
