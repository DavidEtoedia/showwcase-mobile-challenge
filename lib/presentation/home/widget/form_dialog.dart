import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:poke_mon/presentation/pagination_controller/pagination_controller.dart';
import 'package:poke_mon/presentation/screens/personal_pokemon/controller/personal_pokenmon_controller.dart';
import 'package:poke_mon/presentation/util/spacer/app_spacer.dart';

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
            TextFormField(
              controller: pokemonText,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              decoration: const InputDecoration(labelText: 'Name'),
              inputFormatters: [
                FilteringTextInputFormatter.deny(RegExp('[ ]')),
                FilteringTextInputFormatter(RegExp(r'[a-zA-Z]'), allow: true),
              ],
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

                return null; // Input is valid
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
              child: const Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
