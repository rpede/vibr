import 'package:flutter/material.dart';

class TestPanel extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  TestPanel({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Enter a search term',
            ),
            validator: (value) => 'Error',
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Switch(value: true, onChanged: (_) {}),
              ElevatedButton(
                  onPressed: () {
                    _formKey.currentState?.validate();
                  },
                  child: Text('Primary')),
              OutlinedButton(
                onPressed: () {},
                child: Text('Primary'),
              ),
              FilledButton(
                onPressed: () {},
                child: Text('Seondary'),
                style: ButtonStyle(
                  foregroundColor:
                      MaterialStateProperty.all(colorScheme.onTertiary),
                  backgroundColor:
                      MaterialStateProperty.all(colorScheme.tertiary),
                ),
              ),
            ],
          ),
          Text('Hello World!',
              style:
                  TextStyle(color: Theme.of(context).colorScheme.secondary))
        ],
      ),
    );
  }
}
