import 'package:flutter/material.dart';
import 'package:teste_command/utils/command.dart';
import 'package:teste_command/utils/result.dart';

class CountViewModel extends ChangeNotifier {
  late final Command<int> atualizaContador;

  CountViewModel() {
    atualizaContador = Command(_atualizaContador);
  }

  int _contador = 0;
  int get contador => _contador;

  Future<Result<int>> _atualizaContador() async {
    await Future.delayed(const Duration(seconds: 3));

    if (_contador > 3) {
      return const Result.error("Contador chegou no seu limite");
    }

    _contador++;
    return Result.ok(_contador);
  }
}
