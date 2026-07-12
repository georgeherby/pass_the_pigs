import 'package:flutter/material.dart';
import 'package:pass_the_pigs/l10n/l10n.dart';

class AddPlayerForm extends StatefulWidget {
  const AddPlayerForm({super.key, required this.onSubmit});

  final ValueChanged<String> onSubmit;

  @override
  State<AddPlayerForm> createState() => _AddPlayerFormState();
}

class _AddPlayerFormState extends State<AddPlayerForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _nameFocusNode = FocusNode();

  @override
  void dispose() {
    _nameController.dispose();
    _nameFocusNode.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    widget.onSubmit(_nameController.text.trim());
    _nameController.clear();
    _nameFocusNode.requestFocus();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.done,
                onFieldSubmitted: (_) => _submit(),
                focusNode: _nameFocusNode,
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: l10n.enterPlayerName,
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return l10n.playerNameRequired;
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: FilledButton.tonalIcon(
                  icon: const Icon(Icons.add_outlined),
                  onPressed: _submit,
                  label: Text(l10n.addPlayerButton),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
