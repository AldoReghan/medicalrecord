import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Card Detail',
      home: CardDetail(),
    );
  }
}

class CardDetail extends StatefulWidget {
  final String title;
  final icon1;
  final String dokterOrTb;
  final icon2;
  final String dateOrWeight;
  final icon3;
  final String placeOrHeartbeath;

  const CardDetail({Key key, this.title, this.icon1, this.dokterOrTb, this.icon2, this.dateOrWeight, this.icon3, this.placeOrHeartbeath}) : super(key: key);
  
  @override
  _CardDetailState createState() => _CardDetailState();
}

class _CardDetailState extends State<CardDetail> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadiusDirectional.circular(10),
          boxShadow: [
            BoxShadow(
                blurRadius: 7,
                color: Colors.grey.withOpacity(0.5),
                offset: Offset(0, 6))
          ]),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.title == null ? '' : widget.title,
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 18)),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Icon(
                  Icons.person,
                  size: 30,
                  color: Colors.blue,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  widget.dokterOrTb == null ? '' : widget.dokterOrTb,
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.blue),
                )
              ],
            ),
            SizedBox(
              height: 5,
            ),
            Row(
              children: [
                Icon(
                  Icons.calendar_today,
                  size: 30,
                  color: Colors.grey,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  widget.dateOrWeight == null ? '' : widget.dateOrWeight,
                  style: TextStyle(
                      color: Colors.grey, fontWeight: FontWeight.bold),
                )
              ],
            ),
            SizedBox(
              height: 5,
            ),
            Row(
              children: [
                Icon(
                  Icons.location_on,
                  size: 30,
                  color: Colors.grey,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  widget.placeOrHeartbeath == null ? '' : widget.placeOrHeartbeath,
                  style: TextStyle(
                      color: Colors.grey, fontWeight: FontWeight.bold),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
