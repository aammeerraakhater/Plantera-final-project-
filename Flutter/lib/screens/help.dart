import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class Help extends StatefulWidget {
  const Help({Key? key}) : super(key: key);

  @override
  State<Help> createState() => _HelpState();
}

class _HelpState extends State<Help> {
  bool _switch = false;
  bool feed = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("help".tr),
        ),
        body: Column(children: [
          Padding(
              padding: const EdgeInsets.fromLTRB(110, 20, 110, 0),
              child: Text(
                'Hello in Plantera'.tr,
                style: GoogleFonts.lato(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  fontStyle: FontStyle.italic,
                ),
              )),
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 30, 8, 10),
            child: SizedBox(
              width: 330,
              child: OutlinedButton(
                  onPressed: () {
                    setState(() {
                      _switch = !_switch;
                    });
                  },
                  child: Text(
                    "information".tr,
                    style: TextStyle(fontSize: 15),
                  )),
            ),
          ),
          Center(
              child: (_switch == false)
                  ? Center()
                  : Container(
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Text("info".tr),
                      ),
                    )),
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 30, 8, 10),
            child: SizedBox(
              width: 330,
              child: OutlinedButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (context) => feedbackdialog());
                  },
                  child: Text(
                    "feedback".tr,
                    style: TextStyle(fontSize: 15),
                  )),
            ),
          )
        ]));
  }
}

class feedbackdialog extends StatefulWidget {
  @override
  State<feedbackdialog> createState() => _feedbackdialogState();
}

class _feedbackdialogState extends State<feedbackdialog> {
  final TextEditingController _controller = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Form(
        key: _formKey,
        child: TextFormField(
          controller: _controller,
          keyboardType: TextInputType.multiline,
          decoration: const InputDecoration(
            hintText: 'Enter your feedback here',
            filled: true,
          ),
          maxLines: 5,
          maxLength: 4096,
          textInputAction: TextInputAction.done,
          validator: (String? text) {
            if (text == null || text.isEmpty) {
              return 'Please enter a value';
            }
            return null;
          },
        ),
      ),
      actions: [
        TextButton(
          child: const Text('Cancel'),
          onPressed: () => Navigator.pop(context),
        ),
        TextButton(
          child: const Text('Send'),
          onPressed: () async {
            if (_formKey.currentState!.validate()) {
              String message;

              try {
                final collection =
                    FirebaseFirestore.instance.collection('feedback');
                await collection.doc().set({
                  'timestamp': FieldValue.serverTimestamp(),
                  'feedback': _controller.text,
                });

                message = 'Feedback sent successfully';
              } catch (e) {
                message = 'Error when sending feedback';
              }

              // Show a snackbar with the result
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(message)));
              Navigator.pop(context);
            }
          },
        )
      ],
    );
  }
}
