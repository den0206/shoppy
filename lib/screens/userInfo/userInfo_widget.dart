import 'package:flutter/material.dart';

class UserTitle extends StatelessWidget {
  const UserTitle({
    Key key,
    @required this.title,
  }) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: EdgeInsets.only(left: 14),
        child: Text(
          title,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 23),
        ),
      ),
    );
  }
}

class UserListTile extends StatelessWidget {
  const UserListTile({
    Key key,
    @required this.title,
    @required this.subtitle,
    @required this.icon,
    this.ontap,
  }) : super(key: key);

  final String title;
  final String subtitle;
  final Icon icon;
  final Function() ontap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        splashColor: Theme.of(context).splashColor,
        child: ListTile(
          title: Text(title),
          subtitle: Text(subtitle),
          leading: icon,
          onTap: ontap,
        ),
      ),
    );
  }
}

class CameraButton extends StatelessWidget {
  const CameraButton({
    Key key,
    @required this.scrollController,
  }) : super(key: key);

  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    final double defaultTopMargin = 200.0 - 4.0;
    //pixels from top where scaling should start
    final double scaleStart = 160.0;
    //pixels from top where scaling should end
    final double scaleEnd = scaleStart / 2;

    double top = defaultTopMargin;
    double scale = 1.0;
    if (scrollController.hasClients) {
      double offset = scrollController.offset;
      top -= offset;
      if (offset < defaultTopMargin - scaleStart) {
        //offset small => don't scale down
        scale = 1.0;
      } else if (offset < defaultTopMargin - scaleEnd) {
        //offset between scaleStart and scaleEnd => scale down
        scale = (defaultTopMargin - scaleEnd - offset) / scaleEnd;
      } else {
        //offset passed scaleEnd => hide fab
        scale = 0.0;
      }
    }

    return Positioned(
      top: top,
      right: 16.0,
      child: Transform(
        transform: Matrix4.identity()..scale(scale),
        alignment: Alignment.center,
        child: FloatingActionButton(
          backgroundColor: Colors.purple,
          heroTag: "btn1",
          onPressed: () {
            print("Camera");
          },
          child: Icon(Icons.camera_alt_outlined),
        ),
      ),
    );
  }
}
