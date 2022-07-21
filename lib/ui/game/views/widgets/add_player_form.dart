import 'package:flutter/material.dart';
import 'package:pass_the_pigs/l10n/l10n.dart';

class AddPlayerForm extends StatelessWidget {
  const AddPlayerForm({super.key, required this.onSubmit});
  final Function(String) onSubmit;
  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final formKey = GlobalKey<FormState>();
    final nameController = TextEditingController();
    final nameFocusNode = FocusNode();

    return Card(
      color: Theme.of(context).colorScheme.surface,
      surfaceTintColor: Theme.of(context).colorScheme.surfaceTint,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.go,
                onFieldSubmitted: (value) {
                  onSubmit(value);
                  nameController.clear();
                  nameFocusNode.requestFocus();
                },
                focusNode: nameFocusNode,
                controller: nameController,
                decoration: InputDecoration(
                  labelText: l10n.enterPlayerName,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter player name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              OutlinedButton.icon(
                icon: const Icon(Icons.add_outlined),
                onPressed: () {
                  // Validate returns true if the form is valid, or false otherwise.
                  if (formKey.currentState!.validate()) {
                    // If the form is valid, display a snackbar. In the real world,
                    // you'd often call a server or save the information in a database.
                    onSubmit(nameController.text);
                    nameController.clear();
                  }
                },
                label: const Text('Add player'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
