import 'package:flutter/material.dart';
import 'package:shitty_esp_ble_generator/generator/generator_config_view_model.dart';

class CharacteristicImportDialog extends StatefulWidget {
  final GeneratorConfigViewModel viewModel;
  const CharacteristicImportDialog({Key? key, required this.viewModel})
      : super(key: key);
  @override
  State<CharacteristicImportDialog> createState() =>
      _CharacteristicImportDialogState();

  static show(BuildContext context, GeneratorConfigViewModel viewModel) {
    showDialog(
        context: context,
        builder: (ctx) => CharacteristicImportDialog(viewModel: viewModel));
  }
}

class _CharacteristicImportDialogState
    extends State<CharacteristicImportDialog> {
  final TextEditingController schemeText = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 600,
        child: Dialog(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: schemeText,
                  decoration: InputDecoration(border: OutlineInputBorder()),
                  minLines: 20,
                  maxLines: 21,
                ),
                TextButton(
                    onPressed: () {
                      widget.viewModel
                          .doImport(schemeText.text)
                          .then((value) {})
                          .catchError((e) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            backgroundColor: Colors.red,
                            content: Text(e.toString())));
                      });
                      Navigator.of(context).pop();
                    },
                    child: Text('Импортировать'))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
