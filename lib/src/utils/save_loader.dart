import 'package:flutter/material.dart';

showSavingLoader(BuildContext context, bool isLoading, String text) {
  if (isLoading) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Center(
          child: Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              color: Colors.transparent, //new Color.fromRGBO(255, 0, 0, 0.0),
              borderRadius: new BorderRadius.all(
                const Radius.circular(5.0),
              ),
            ),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 20.0, bottom: 10.0),
                  child: CircularProgressIndicator(
                    valueColor:
                        new AlwaysStoppedAnimation<Color>(Colors.white70),
                  ),
                ),
                // Text(
                //   text,
                //   style: TextStyle(
                //       color: Colors.white70,
                //       fontSize: 16.0,
                //       decoration: TextDecoration.none,
                //       fontWeight: FontWeight.normal),
                // )
              ],
            ),
          ),
        );
      },
    );
  } else {
    Navigator.of(context, rootNavigator: true).pop();
  }
}