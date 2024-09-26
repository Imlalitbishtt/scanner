import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  // This will hold the formatted data
  String formattedData = '';
  TextEditingController textEditingController = TextEditingController();

  // Function to update the formattedData when the main text field changes
  void updateMainTextFieldData(String value) {
    setState(() {
      // Convert multi-line string to single line
      formattedData = formatToSingleLine(value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Page"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Row with Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {},
                  child: const Text("Open App"),
                ),
                ElevatedButton(
                  onPressed: () {
                    FlutterClipboard.paste().then((value) {
                      // Do what ever you want with the value.
                      setState(() {
                        textEditingController.text = value;
                      });
                      updateMainTextFieldData(value);
                    });
                  },
                  child: const Text("Paste Data"),
                ),
              ],
            ),
            // Text Field for main input data
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextFormField(
                controller: textEditingController,
                maxLines: 4,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter data to update the table',
                ),
                onChanged: (String value) {
                  // Update formatted data on change
                  updateMainTextFieldData(value);
                },
              ),
            ),
            const SizedBox(height: 20),
            // Pass formatted data to the EditableTable widget
            Expanded(child: EditableTable(formattedData: formattedData)),
          ],
        ),
      ),
    );
  }

  // Function to convert multi-line string into a single continuous string without spaces, new lines, or dots
  String formatToSingleLine(String data) {
    return data.replaceAll(RegExp(r'[^0-9]'), '');
  }
}

class EditableTable extends StatefulWidget {
  final String formattedData;

  const EditableTable({super.key, required this.formattedData});

  @override
  EditableTableState createState() => EditableTableState();
}

class EditableTableState extends State<EditableTable> {
  List<List<TextEditingController>> controllers = [];


  @override
  void initState() {
    super.initState();
    populateTableData(widget.formattedData);
  }

  // Populate the table with data from the formatted string

  // Populate the table with data from the formatted string
  void populateTableData(String data) {
    const int numColumns = 6;
    List<String> dataCells = [];

    // Convert the continuous string into cells by slicing it into chunks of 'numColumns' length
    for (int i = 0; i < data.length; i += numColumns) {
      List<String> rowCells = data.substring(i, i + numColumns > data.length ? data.length : i + numColumns).split('');
      dataCells.addAll(rowCells);
    }

    // Ensure we have at least 5 rows of data
    const int minRows = 5;
    while (dataCells.length < minRows * numColumns) {
      dataCells.add('0');
    }

    // Split into rows and create controllers
    controllers = [];
    for (int i = 0; i < dataCells.length; i += numColumns) {
      List<TextEditingController> rowControllers = [];
      for (int j = i; j < i + numColumns; j++) {
        rowControllers.add(TextEditingController(text: dataCells[j]));
      }
      controllers.add(rowControllers);
    }
    setState(() {});
  }


  // Update a specific cell in the table
  // Update a specific cell in the table
  void updateCell(int row, int column, String value) {
    setState(() {
      controllers[row][column].text = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Table(
          border: TableBorder.all(),
          children: [
            // Header row
            TableRow(
              children: [
                tableHeaderCell('Q.No'),
                tableHeaderCell('a'),
                tableHeaderCell('b'),
                tableHeaderCell('c'),
                tableHeaderCell('d'),
                tableHeaderCell('e'),
                tableHeaderCell('Total'),
              ],
            ),
            // Body rows populated with editable fields
            ...List.generate(controllers.length, (rowIndex) {
              return TableRow(
                children: [
                  // Fixed Q.No column
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      (rowIndex + 1).toString(), // Q.No starts from 1
                      textAlign: TextAlign.center,
                    ),
                  ),
                  // Editable cells
                  ...List.generate(6, (columnIndex) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: controllers[rowIndex][columnIndex],

                        textAlign: TextAlign.center,
                        onChanged: (value) {
                          updateCell(rowIndex, columnIndex, value);
                        },
                        keyboardType: TextInputType.number,
                      ),
                    );
                  }),
                ],
              );
            }),
          ],
        ),
      ],
    );
  }

  // Helper function to create header cells
  Widget tableHeaderCell(String text) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        text,
        style: const TextStyle(fontWeight: FontWeight.bold),
        textAlign: TextAlign.center,
      ),
    );
  }
}
