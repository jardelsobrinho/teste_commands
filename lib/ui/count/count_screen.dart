import 'package:flutter/material.dart';
import 'package:teste_command/ui/count/count_viewmodel.dart';

class CountScreen extends StatefulWidget {
  final CountViewModel viewModel;
  const CountScreen({required this.viewModel, super.key});

  @override
  State<CountScreen> createState() => _CountScreenState();
}

class _CountScreenState extends State<CountScreen> {
  @override
  void initState() {
    super.initState();
    widget.viewModel.atualizaContador.addListener(_showErro);
  }

  @override
  void dispose() {
    widget.viewModel.atualizaContador.removeListener(_showErro);
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant CountScreen oldWidget) {
    oldWidget.viewModel.removeListener(_showErro);
    widget.viewModel.addListener(_showErro);
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => widget.viewModel.atualizaContador.execute(),
        label: const Text("Adicionar"),
      ),
      body: ListenableBuilder(
        listenable: widget.viewModel.atualizaContador,
        builder: (context, child) {
          if (widget.viewModel.atualizaContador.running) {
            return const Center(child: CircularProgressIndicator());
          }

          if (widget.viewModel.atualizaContador.isError) {}

          return Center(child: Text("${widget.viewModel.contador}"));
        },
      ),
    );
  }

  _showErro() {
    if (widget.viewModel.atualizaContador.isError) {
      final snackBar = SnackBar(
        content: Text(widget.viewModel.atualizaContador.messageError),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }
}
