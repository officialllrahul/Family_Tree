import 'dart:math';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graphview/GraphView.dart' as gv;
import 'package:graphview/GraphView.dart';
import 'controller/controller_page.dart';
import 'firebase_options.dart';
import 'model/family_model.dart';
import 'page/add_family_page.dart';
import 'page/update_page.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Family Tree',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.deepPurple),
      ),
      home: TreeViewPage(),
    );
  }
}

class TreeViewPage extends StatefulWidget {
  @override
  _TreeViewPageState createState() => _TreeViewPageState();
}

final HomePageController _homePageController = Get.put(HomePageController());

class _TreeViewPageState extends State<TreeViewPage> {
  final FamilyModel familyModel = FamilyModel(
    familyId: '',
    name: '',
    age: '',
    familyTitle: '',
    relationShip: '',
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text(
          "Family Tree",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            child: InteractiveViewer(
              constrained: false,
              boundaryMargin: const EdgeInsets.all(100),
              minScale: 0.01,
              maxScale: 5.6,
              child: GraphView(
                graph: graph,
                algorithm:
                gv.BuchheimWalkerAlgorithm(builder, gv.TreeEdgeRenderer(builder)),
                paint: Paint()
                  ..color = Colors.green
                  ..strokeWidth = 1
                  ..style = PaintingStyle.stroke,
                builder: (gv.Node node) {
                  var a = node.key?.value as int;
                  return rectangleWidget(a, node, familyModel);
                },
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(const AddFamilyPage())?.then((_) {
            _homePageController.getData();
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Random r = Random();

  void editNode(gv.Node? node) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String? nodeName;
        return AlertDialog(
          title: const Text('Edit Node'),
          content: TextFormField(
            initialValue: node?.key?.value.toString() ?? '',
            onChanged: (value) {
              nodeName = value;
            },
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                if (node != null) {
                  if (nodeName != null && nodeName!.isNotEmpty) {
                    setState(() {
                      graph.removeNode(node);
                      final newNode = gv.Node.Id(int.parse(nodeName!));
                      graph.addNode(newNode);
                      for (final edge in graph.edges.toList()) {
                        if (edge.source == node) {
                          graph.addEdge(newNode, edge.destination,
                              paint: edge.paint);
                          graph.removeEdge(edge);
                        } else if (edge.destination == node) {
                          graph.addEdge(edge.source, newNode,
                              paint: edge.paint);
                          graph.removeEdge(edge);
                        }
                      }
                    });
                    Navigator.of(context).pop();
                  }
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Please add a node first'),
                    ),
                  );
                }
              },
              child: const Text('Save'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  Widget rectangleWidget(int a, gv.Node node, FamilyModel? family) {
    return InkWell(
      onTap: () {
        Get.to(
          UpdatePage(
            familyId: family!.familyId,
            name: family.name,
            age: family.age,
            relationship: family.relationShip,
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          boxShadow: const [
            BoxShadow(color: Colors.blueAccent, spreadRadius: 2),
          ],
        ),
        child: Row(
          children: [
            Text(family?.name ?? ''),
            Text(family?.relationShip ?? ''),
            Text('Node $a', style: const TextStyle(color: Colors.white)),
            IconButton(
              onPressed: () {
                _homePageController.deleteFamilyData(family!.familyId);
              },
              icon: const Icon(Icons.delete, color: Colors.red),
            ),
          ],
        ),
      ),
    );
  }

  final gv.Graph graph = gv.Graph()..isTree = true;
  gv.BuchheimWalkerConfiguration builder = gv.BuchheimWalkerConfiguration();

  @override
  void initState() {
    super.initState();
    _homePageController.getData();
  }
}
