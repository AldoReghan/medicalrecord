import 'package:flutter/material.dart';

class CardName extends StatelessWidget {
  final photo;
  final String name;
  final String nip;

  const CardName({Key key, this.photo, this.name, this.nip}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
          height: 120,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.blue[900],
            boxShadow: [
              BoxShadow(
                  blurRadius: 7,
                  color: Colors.grey.withOpacity(0.5),
                  offset: Offset(0, 6))
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 5,
              ),
              Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      ClipOval(
                        child: Material(
                          color: Colors.white,
                          child: InkWell(
                            splashColor: Colors.red,
                            child: SizedBox(
                                width: 70,
                                height: 70,
                                child: Icon(Icons.person)),
                            onTap: () {},
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            name,
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(nip.toString(),
                              style: TextStyle(
                                color: Colors.white,
                              ))
                        ],
                      ),
                      Spacer(),
                      Icon(Icons.settings, size: 30, color: Colors.white)
                    ],
                  ),
                  )
            ],
          )),
    );
  }
}
