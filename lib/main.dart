
import 'package:external_app_launcher/external_app_launcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';
import 'package:scanner/w.dart';
import 'package:super_clipboard/super_clipboard.dart';
import 'dart:ui' as ui;
import 'dart:typed_data';

import 'home.dart';
import 'm_table.dart';

void main() {
  runApp( MyApp());
}

//
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ML Text Recognition',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}
//
// class HomePage extends StatefulWidget {
//   const HomePage({super.key});
//
//   @override
//   _HomePageState createState() => _HomePageState();
// }
//
// class _HomePageState extends State<HomePage> {
//   // 2D list to hold the input data from the main text field and update table accordingly
//   List<List<String>> tableData = List.generate(5, (_) => List.generate(6, (_) => '0'));
//
//   // Function to update table data in the first row based on input field
//   void updateMainTextFieldData(String value) {
//     setState(() {
//       tableData[0][0] = value;
//     });
//   }
//
//   void updateCellData(int row, int col, String value) {
//     setState(() {
//       tableData[row][col] = value;
//     });
//   }
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Home Page"),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             // Row with Buttons
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceAround,
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 ElevatedButton(
//                   onPressed: () async {
//                     await LaunchApp.openApp(
//                       androidPackageName: 'com.google.ar.lens',
//                       iosUrlScheme: '',
//                       appStoreLink: 'itms-apps://itunes.apple.com/us/app/pulse-secure/id945832041',
//                     );
//                   },
//                   child: const Text("Open App"),
//                 ),
//                 ElevatedButton(
//                   onPressed: (){},
//                   child: const Text("Paste Data"),
//                 ),
//               ],
//             ),
//             // Text Field for main input data
//             Padding(
//               padding: const EdgeInsets.all(10.0),
//               child: TextFormField(
//                 maxLines: 4,
//                 decoration: const InputDecoration(
//                   border: OutlineInputBorder(),
//                   hintText: 'Enter main data to update the table',
//                 ),
//                 onChanged: (String value) {
//                   // Update the first cell of the table dynamically
//                   updateMainTextFieldData(value);
//                 },
//               ),
//             ),
//             const SizedBox(height: 20),
//             Expanded(child: EditableTable(tableData: tableData, onCellChanged:updateCellData,)), // Pass tableData to EditableTable widget
//           ],
//         ),
//       ),
//     );
//   }
// }
// class EditableTable extends StatelessWidget {
//   final List<List<String>> tableData;
//   final Function(int, int, String) onCellChanged; // Callback to handle cell updates
//
//   const EditableTable({super.key, required this.tableData, required this.onCellChanged});
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Table(
//           border: TableBorder.all(),
//           children: [
//             // Header row
//             TableRow(
//               children: [
//                 tableHeaderCell('Q.No'),
//                 tableHeaderCell('a'),
//                 tableHeaderCell('b'),
//                 tableHeaderCell('c'),
//                 tableHeaderCell('d'),
//                 tableHeaderCell('e'),
//                 tableHeaderCell('Total'),
//               ],
//             ),
//             // Body rows with data from tableData
//             ...tableData.asMap().entries.map((entry) {
//               int rowIndex = entry.key;
//               List<String> row = entry.value;
//
//               return TableRow(
//                 children: row.asMap().entries.map((cellEntry) {
//                   int colIndex = cellEntry.key;
//                   String cell = cellEntry.value;
//
//                   return TableCell(
//                     child: Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: TextField(
//                         controller: TextEditingController(text: cell),
//                         decoration: InputDecoration(
//                           border: OutlineInputBorder(),
//                         ),
//                         keyboardType: TextInputType.number,
//                         onChanged: (value) {
//                           onCellChanged(rowIndex, colIndex, value); // Call the callback to update data
//                         },
//                       ),
//                     ),
//                   );
//                 }).toList(),
//               );
//             }).toList(),
//           ],
//         ),
//       ],
//     );
//   }
//
//   // Helper function for header cells
//   Widget tableHeaderCell(String text) {
//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: Text(
//         text,
//         style: const TextStyle(fontWeight: FontWeight.bold),
//         textAlign: TextAlign.center,
//       ),
//     );
//   }
// }


// EditableTable widget to display and update table
// class EditableTable extends StatefulWidget {
//   final List<List<String>> tableData;
//
//   const EditableTable({super.key, required this.tableData});
//
//   @override
//   _EditableTableState createState() => _EditableTableState();
// }
//
// class _EditableTableState extends State<EditableTable> {
//   // Function to update the value in tableData
//   void updateTableData(int row, int col, String value) {
//     setState(() {
//       widget.tableData[row][col] = value;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         // Display the input fields for the table
//         Expanded(
//           child: ListView(
//             children: List.generate(5, (rowIndex) {
//               return Row(
//                 children: List.generate(6, (colIndex) {
//                   return Expanded(
//                     child: Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: TextFormField(
//                         initialValue: widget.tableData[rowIndex][colIndex],
//                         decoration: const InputDecoration(
//                           border: OutlineInputBorder(),
//                           hintText: 'Enter data',
//                         ),
//                         onChanged: (value) {
//                           updateTableData(rowIndex, colIndex, value); // Update tableData when input changes
//                         },
//                         keyboardType: TextInputType.number,
//                       ),
//                     ),
//                   );
//                 }),
//               );
//             }),
//           ),
//         ),
//         const SizedBox(height: 20),
//         // Button to print the current table data
//         ElevatedButton(
//           onPressed: () {
//             // Print the current table data in the console
//             for (var row in widget.tableData) {
//               print(row); // Prints each row
//             }
//           },
//           child: const Text('Print Table Data'),
//         ),
//         const SizedBox(height: 20),
//         // Display the table with captured data
//         Table(
//           border: TableBorder.all(),
//           children: List.generate(5, (rowIndex) {
//             return TableRow(
//               children: List.generate(6, (colIndex) {
//                 return Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Text(
//                     widget.tableData[rowIndex][colIndex],
//                     textAlign: TextAlign.center,
//                   ),
//                 );
//               }),
//             );
//           }),
//         ),
//       ],
//     );
//   }
// }

// class MyApp2 extends StatelessWidget {
//   const MyApp2({super.key});
//
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(title: Text('Open Google Lens')),
//         body: Center(
//           child: ElevatedButton(
//             onPressed: () async {
//
//             },
//             child: const Text('Open Google Lens'),
//           ),
//         ),
//       ),
//     );
//   }
// }


//
// const _notAvailableMessage =
//     'Clipboard is not available on this platform. Use ClipboardEvents API instead.';
//
// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);
//
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'SuperClipboard Example',
//       theme: ThemeData(
//         snackBarTheme: const SnackBarThemeData(
//           behavior: SnackBarBehavior.floating,
//         ),
//         outlinedButtonTheme: OutlinedButtonThemeData(
//           style: OutlinedButton.styleFrom(
//               padding:
//               const EdgeInsets.symmetric(horizontal: 10, vertical: 16)),
//         ),
//         primarySwatch: Colors.blue,
//         useMaterial3: false,
//       ),
//       home: const MyHomePage(title: 'SuperClipboard Example'),
//     );
//   }
// }
//
// class Expand extends SingleChildRenderObjectWidget {
//   const Expand({super.key, required super.child});
//
//   @override
//   RenderObject createRenderObject(BuildContext context) => _RenderExpanded();
// }
//
// class _RenderExpanded extends RenderProxyBox {
//   @override
//   void layout(Constraints constraints, {bool parentUsesSize = false}) {
//     final boxConstraints = constraints as BoxConstraints;
//     super.layout(
//         boxConstraints.tighten(
//           width: boxConstraints.maxWidth,
//           height: boxConstraints.maxHeight,
//         ),
//         parentUsesSize: parentUsesSize);
//   }
// }
//
// class HomeLayout extends StatelessWidget {
//   const HomeLayout({
//     super.key,
//     required this.mainContent,
//     required this.buttons,
//   });
//
//   final List<Widget> mainContent;
//   final List<Widget> buttons;
//
//   @override
//   Widget build(BuildContext context) {
//     return LayoutBuilder(builder: (context, constraints) {
//       if (constraints.maxWidth < 540) {
//         return ListView(
//           padding: const EdgeInsets.all(16),
//           children: [
//             LayoutGrid(
//               autoPlacement: AutoPlacement.rowDense,
//               columnSizes: [1.5.fr, 2.fr],
//               rowSizes: const [auto, auto, auto, auto],
//               gridFit: GridFit.expand,
//               rowGap: 10,
//               columnGap: 10,
//               children: buttons.map((e) => Expand(child: e)).toList(),
//             ),
//             const SizedBox(height: 16),
//             ...mainContent,
//           ],
//         );
//       } else {
//         return Row(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             SingleChildScrollView(
//               child: Padding(
//                 padding: const EdgeInsets.all(16),
//                 child: IntrinsicWidth(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.stretch,
//                     children: buttons
//                         .intersperse(const SizedBox(height: 10))
//                         .toList(growable: false),
//                   ),
//                 ),
//               ),
//             ),
//             VerticalDivider(
//               color: Colors.blueGrey.shade100,
//               thickness: 1,
//               width: 1,
//             ),
//             Expanded(
//               child: ListView(
//                 padding: const EdgeInsets.all(16),
//                 children: mainContent,
//               ),
//             )
//           ],
//         );
//       }
//     });
//   }
// }
//
// class MyHomePage extends StatefulWidget {
//   const MyHomePage({Key? key, required this.title}) : super(key: key);
//
//   final String title;
//
//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }
//
// class _MyHomePageState extends State<MyHomePage>
//     with SingleTickerProviderStateMixin {
//   void showMessage(String message) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Text(message),
//         duration: const Duration(milliseconds: 1500),
//       ),
//     );
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     ClipboardEvents.instance?.registerPasteEventListener(_onPasteEvent);
//   }
//
//   @override
//   void dispose() {
//     super.dispose();
//     ClipboardEvents.instance?.unregisterPasteEventListener(_onPasteEvent);
//   }
//
//   void copyText() async {
//     final clipboard = SystemClipboard.instance;
//     if (clipboard != null) {
//       final item = DataWriterItem();
//       item.add(Formats.htmlText('<b>This is a <em>HTML</en> value</b>.'));
//       item.add(Formats.plainText('This is a plaintext value.'));
//       await clipboard.write([item]);
//     } else {
//       showMessage(_notAvailableMessage);
//     }
//   }
//
//   void copyTextLazy() async {
//     final clipboard = SystemClipboard.instance;
//     if (clipboard != null) {
//       final item = DataWriterItem();
//       item.add(Formats.htmlText.lazy(() {
//         showMessage('Lazy rich text requested.');
//         return '<b>This is a <em>HTML</en> value</b> generated <u>on demand</u>.';
//       }));
//       item.add(Formats.plainText.lazy(() {
//         showMessage('Lazy plain text requested.');
//         return 'This is a plaintext value generated on demand.';
//       }));
//       await clipboard.write([item]);
//     } else {
//       showMessage(_notAvailableMessage);
//     }
//   }
//
//   void copyImage() async {
//     final clipboard = SystemClipboard.instance;
//     if (clipboard != null) {
//       final image = await createImageData(Colors.red);
//       final item = DataWriterItem(suggestedName: 'RedCircle.png');
//       item.add(Formats.png(image));
//       await clipboard.write([item]);
//     } else {
//       showMessage(_notAvailableMessage);
//     }
//   }
//
//   void copyImageLazy() async {
//     final clipboard = SystemClipboard.instance;
//     if (clipboard != null) {
//       final item = DataWriterItem(suggestedName: 'BlueCircle.png');
//       item.add(Formats.png.lazy(() {
//         showMessage('Lazy image requested.');
//         return createImageData(Colors.blue);
//       }));
//       await clipboard.write([item]);
//     } else {
//       showMessage(_notAvailableMessage);
//     }
//   }
//
//   void copyCustomData() async {
//     final clipboard = SystemClipboard.instance;
//     if (clipboard != null) {
//       final item = DataWriterItem();
//       item.add(formatCustom(Uint8List.fromList([1, 2, 3, 4])));
//       await clipboard.write([item]);
//     } else {
//       showMessage(_notAvailableMessage);
//     }
//   }
//
//   void copyCustomDataLazy() async {
//     final clipboard = SystemClipboard.instance;
//     if (clipboard != null) {
//       final item = DataWriterItem();
//       item.add(formatCustom.lazy(() async {
//         showMessage('Lazy custom data requested.');
//         return Uint8List.fromList([1, 2, 3, 4, 5, 6]);
//       }));
//       await clipboard.write([item]);
//     } else {
//       showMessage(_notAvailableMessage);
//     }
//   }
//
//   void copyUri() async {
//     final clipboard = SystemClipboard.instance;
//     if (clipboard != null) {
//       final item = DataWriterItem();
//       item.add(Formats.uri(NamedUri(
//           Uri.parse('https://github.com/superlistapp/super_native_extensions'),
//           name: 'Super Native Extensions')));
//       await clipboard.write([item]);
//     } else {
//       showMessage(_notAvailableMessage);
//     }
//   }
//
//   void _paste(ClipboardReader reader) async {
//     final readers = await Future.wait(
//       reader.items.map((e) => ReaderInfo.fromReader(e)),
//     );
//     if (!mounted) {
//       return;
//     }
//     buildWidgetsForReaders(context, readers, (widgets) {
//       setState(() {
//         contentWidgets = widgets;
//       });
//     });
//   }
//
//   void _onPasteEvent(ClipboardReadEvent event) async {
//     _paste(await event.getClipboardReader());
//   }
//
//   var contentWidgets = <Widget>[];
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.title),
//       ),
//       body: HomeLayout(
//         mainContent: contentWidgets
//             .intersperse(const SizedBox(height: 10))
//             .toList(growable: false),
//         buttons: [
//           OutlinedButton(
//             onPressed: copyText,
//             child: const Text('Copy Text'),
//           ),
//           OutlinedButton(
//               onPressed: copyTextLazy, child: const Text('Copy Text - Lazy')),
//           OutlinedButton(onPressed: copyImage, child: const Text('Copy Image')),
//           OutlinedButton(
//               onPressed: copyImageLazy, child: const Text('Copy Image - Lazy')),
//           OutlinedButton(
//               onPressed: copyCustomData, child: const Text('Copy Custom')),
//           OutlinedButton(
//               onPressed: copyCustomDataLazy,
//               child: const Text('Copy Custom - Lazy')),
//           OutlinedButton(onPressed: copyUri, child: const Text('Copy URI')),
//           OutlinedButton(
//               onPressed: () async {
//                 final clipboard = SystemClipboard.instance;
//                 if (clipboard != null) {
//                   final reader = await clipboard.read();
//                   _paste(reader);
//                 } else {
//                   showMessage(_notAvailableMessage);
//                 }
//               },
//               style: OutlinedButton.styleFrom(
//                 backgroundColor: Colors.blue.shade600,
//                 foregroundColor: Colors.white,
//               ),
//               child: const Text('Paste')),
//         ],
//       ),
//     );
//   }
// }
//
// Future<Uint8List> createImageData(Color color) async {
//   final recorder = ui.PictureRecorder();
//   final canvas = Canvas(recorder);
//   final paint = Paint()..color = color;
//   canvas.drawOval(const Rect.fromLTWH(0, 0, 200, 200), paint);
//   final picture = recorder.endRecording();
//   final image = await picture.toImage(200, 200);
//   final data = await image.toByteData(format: ui.ImageByteFormat.png);
//   return data!.buffer.asUint8List();
// }
//
