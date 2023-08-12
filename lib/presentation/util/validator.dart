import 'package:poke_mon/domain/entity/pokemon/pokemon_model.dart';

String? validateEmail(String? value) {
  const String pattern =
      r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
      r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
      r"{0,253}[a-zA-Z0-9])?)*$";
  final RegExp regex = RegExp(pattern);
  if (value!.isEmpty) {
    return 'Email field cannot be empty';
  } else if (!regex.hasMatch(value)) {
    return 'Invalid email address';
  } else {
    return null;
  }
}

String? validatePassword(String? value) {
  if (value!.isEmpty) {
    return 'password field cannot be empty';
  } else if (value.length < 5) {
    return "Must be more than 5 characters";
  }
  return null;
}

String? validatePokemon(
    String? value, List<Result> result, List<Result> personal) {
  if (value == null || value.isEmpty) {
    return null; // No error when value is empty
  }

  if (!_isPokemonFound(value, result)) {
    return "There is no such Pokémon";
  }

  if (_isPokemonOwned(value, personal)) {
    return "You already own this Pokémon";
  }

  return null;
}

bool _isPokemonFound(String value, List<Result> result) {
  return result.any((val) => val.name.contains(value));
}

bool _isPokemonOwned(String value, List<Result> personal) {
  return personal.any((values) => values.name.contains(value));
}
