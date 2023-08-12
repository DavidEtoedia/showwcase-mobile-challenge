import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:poke_mon/presentation/home/pagination_controller/pagination_controller.dart';
import 'package:poke_mon/presentation/screens/personal_pokemon/controller/personal_pokenmon_controller.dart';
import 'package:poke_mon/presentation/util/spacer/app_spacer.dart';
import 'package:poke_mon/presentation/util/text_form_input.dart';

class FormDialog extends ConsumerStatefulWidget {
  const FormDialog({super.key});

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
    final pokemon = ref.watch(pokemonControllerProvider);

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
              validator: (value) {
                bool found = false;
                for (var val in pokemon.pokemon) {
                  if (val.name.contains(value!)) {
                    found = true;
                    break;
                  }
                }
                if (!found) {
                  return "There is no such Pokémon";
                }

                return null;
              },
            ),
            const Space(20),
            TextButton(
              onPressed: () {
                if (pokemonText.text.isEmpty) return;
                if (_formKey.currentState!.validate()) {
                  ref
                      .read(personalPokemonProvider.notifier)
                      .addPokemon(pokemonText.text);
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
