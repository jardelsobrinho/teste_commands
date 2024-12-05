import 'package:flutter/material.dart';
import 'package:teste_command/utils/result.dart';

typedef CommandAction<T> = Future<Result<T>> Function();
typedef CommandActionArgs<T, A> = Future<Result<T>> Function(A);

abstract class CommandBase<T> extends ChangeNotifier {
  CommandBase();

  bool _running = false;
  bool get running => _running;

  Result<T> _result = Result.empty();
  bool get isError => _result is Error;
  bool get idCompleted => _result is Ok;
  String get messageError {
    if (_result is Error) {
      return (_result as Error).message;
    } else {
      return "";
    }
  }

  void clearResult() {
    _result = Result.empty();
    notifyListeners();
  }

  Future<void> _execute(CommandAction<T> action) async {
    if (_running) return;

    _running = true;
    _result = Result.empty();
    notifyListeners();

    try {
      _result = await action();
    } finally {
      _running = false;
      notifyListeners();
    }
  }
}

class Command<T> extends CommandBase<T> {
  final CommandAction<T> _action;
  Command(this._action);

  Future<void> execute() async {
    await _execute(_action);
  }
}

class CommandArgs<T, A> extends CommandBase<T> {
  final CommandActionArgs<T, A> _action;
  CommandArgs(this._action);

  Future<void> execute(A argument) async {
    await _execute(() => _action(argument));
  }
}
