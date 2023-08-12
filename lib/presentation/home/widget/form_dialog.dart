import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:poke_mon/domain/entity/pokemon/pokemon_model.dart';
import 'package:poke_mon/presentation/screens/personal_pokemon/controller/personal_pokenmon_controller.dart';
import 'package:poke_mon/presentation/util/spacer/app_spacer.dart';
import 'package:poke_mon/presentation/util/text_form_input.dart';
import 'package:poke_mon/presentation/util/validator.dart';

class FormDialog extends ConsumerStatefulWidget {
  final List<Result> result;
  const FormDialog({super.key, required this.result});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _FormDialogState();
}

class _FormDialogState extends ConsumerState<FormDialog> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController pokemonText = TextEditingController();

  @override
  void dispose() {
    pokemonText.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final personal = ref.watch(personalPokemonProvider);
    return AlertDialog(
      title: const Text('Add Pokemon'),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const Space(20),
            TextFormInput(
              labelText: "Enter Pokémon Name",
              controller: pokemonText,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) =>
                  validatePokemon(value, widget.result, personal),
            ),
            const Space(20),
            TextButton(
              onPressed: () {
                if (pokemonText.text.isEmpty) return;
                if (_formKey.currentState!.validate()) {
                  ref
                      .read(personalPokemonProvider.notifier)
                      .addPokemon(pokemonText.text, widget.result);
                  Navigator.of(context).pop();
                }
              },
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}
