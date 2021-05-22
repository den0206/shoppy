import 'package:flutter/material.dart';
import 'package:shoppy/consts/colors.dart';

class WishListCell extends StatelessWidget {
  const WishListCell({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          margin: EdgeInsets.only(right: 30, bottom: 10),
          child: Material(
            color: Theme.of(context).backgroundColor,
            elevation: 3.0,
            child: InkWell(
              child: Container(
                padding: EdgeInsets.all(16),
                child: Row(
                  children: [
                    Container(
                      height: 80,
                      child: Image.network(
                        'https://abong.com.bd/public//admin/media/2020/03/yellow_mesh_men_sport_sneaker_shoesjpeg_20200307141459.jpeg',
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "title",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            "\$ 16",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
        Positioned(
          top: 20,
          right: 15,
          child: Container(
            height: 30,
            width: 30,
            child: MaterialButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
              padding: EdgeInsets.all(0),
              color: ColorsConsts.favColor,
              child: Icon(
                Icons.clear,
                color: Colors.white,
              ),
              onPressed: () {},
            ),
          ),
        ),
      ],
    );
  }
}
