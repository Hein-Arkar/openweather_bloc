import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  AutovalidateMode _autovalidateMode = AutovalidateMode.disabled;
  String? _city;

  void _onSubmit() {
    setState(() {
      _autovalidateMode = AutovalidateMode.always;
    });
    final form = _formKey.currentState;

    if (form != null && form.validate()) {
      form.save();
      Navigator.pop(context, _city!.trim());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: Icon(CupertinoIcons.back),
        ),
        // elevation: 2,
        title: Form(
          key: _formKey,
          child: TextFormField(
            autofocus: true,
            autovalidateMode: _autovalidateMode,
            decoration: InputDecoration(
              prefixIcon: Icon(CupertinoIcons.search),
              hintText: 'Search city...',
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16.0),
                borderSide: BorderSide.none,
              ),
            ),
            validator: (value) {
              if (value != null && value.trim().length < 2) {
                return "More than at least two charactors";
              }
              return null;
            },
            onSaved: (newValue) => _city = newValue,
          ),
        ),
        actions: [
          TextButton(
            onPressed: _onSubmit,
            child: Text("Search"),
          ),
        ],
      ),
    );
  }
}
