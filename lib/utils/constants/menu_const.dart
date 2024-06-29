import 'package:flutter/material.dart';

List<String> Menuicons = [
  'assets/images/menu/inbox.png',
  'assets/images/menu/admission.png',
  'assets/images/menu/reimbursement.png',
  'assets/images/menu/appointment.png',
  'assets/images/menu/history.png',
  'assets/images/menu/history.png'
];

List<String> Menutitle = [
  'Inbox',
  'Admission',
  'Reimbursement',
  'Appointment',
  'History',
  'Medical Record'
];

void alert(String title, String msg, BuildContext context,
    {Function? onConfirm}) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title),
        content: Text(
          msg,
          textAlign: TextAlign.left, // Set text alignment to left
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('Cancel'),
            onPressed: () {
              Navigator.of(context, rootNavigator: true).pop();
            },
          ),
          TextButton(
            child: const Text('OK'),
            onPressed: () {
              if (onConfirm != null) {
                onConfirm();
              } else {
                Navigator.of(context, rootNavigator: true).pop();
              }
            },
          ),
        ],
      );
    },
  );
}

Widget buildImage(String imagePath, double width, double height,
    AlignmentGeometry alignment) {
  return Container(
    alignment: alignment,
    child: Image.asset(
      imagePath,
      width: width,
      height: height,
    ),
  );
}
