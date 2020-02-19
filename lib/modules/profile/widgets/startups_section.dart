import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectit_app/data/model/startup.dart';
import 'package:connectit_app/data/model/user.dart';
import 'package:connectit_app/di/injector.dart';
import 'package:connectit_app/utils/constants.dart';
import 'package:connectit_app/utils/top_level_utils.dart';
import 'package:connectit_app/widgets/SectionContainer.dart';
import 'package:connectit_app/widgets/app_loader.dart';
import 'package:connectit_app/widgets/header.dart';
import 'package:flutter/material.dart';

class StartupSection extends StatelessWidget {
  final List list;

  StartupSection(this.list);

  @override
  Widget build(BuildContext context) {
    return SectionContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Header("IN STARTUPS"),
          Column(
            children: <Widget>[
              for (final ref in list)
                FutureBuilder<DocumentSnapshot>(
                  future: _getStartup(ref),
                  builder: (_, snapshot) {
                    if (snapshot.hasData && snapshot.data != null) {
                      final startup = Startup.fromJson(snapshot.data.data);
                      return ListTile(
                        leading: CircleAvatar(
                          backgroundImage: CachedNetworkImageProvider(
                            startup.avatar,
                          ),
                        ),
                        title: Text(startup.name),
                        subtitle: Text(startup.tagline),
                      );
                    } else
                      return AppLoader();
                  },
                )
            ],
          )
          // Text(tagline),
        ],
      ),
    );
  }

  Future _getStartup(ref) {
    final documentRef = ref as DocumentReference;
    return injector<Firestore>()
        .collection(Constants.startupsCollection)
        .document(documentRef.path)
        .get();
  }
}
