import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graphview/GraphView.dart';
import 'package:graphview/GraphView.dart' as gv;
import '../../controller/view_controller.dart';
import '../../model/parent_child_combine_model.dart';

class TreeViewPage extends StatefulWidget {
  @override
  _TreeViewPageState createState() => _TreeViewPageState();
}

class _TreeViewPageState extends State<TreeViewPage> {
  final ViewController _viewController = ViewController();
  Graph graph = Graph()..isTree = true;
  BuchheimWalkerConfiguration builder = BuchheimWalkerConfiguration();

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  void _loadData() async {
    ParentChildCombineModel familyTreeData = await _viewController.getFamilyTreeData(Get.arguments['gf_id']);

    gv.Node grandeNode = gv.Node.Id(Get.arguments['gf_name']);
    graph.addNode(grandeNode);

    for (var parent in familyTreeData.parentModel) {
      gv.Node parentNode = gv.Node.Id(parent.pName);
      graph.addEdge(grandeNode,parentNode);
      if (familyTreeData.childModel != null) {
        for (var child in familyTreeData.childModel) {
          if (child.pId == parent.pId) {
            gv.Node childNode = gv.Node.Id(child.cName);
            graph.addNode(childNode);
            graph.addEdge(parentNode, childNode);
          }
        }
      }
    }
    setState(() {});
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: graph.nodes.isEmpty
            ? Center(child: CircularProgressIndicator())
            : InteractiveViewer(
          constrained: false,
          boundaryMargin: EdgeInsets.all(100),
          minScale: 0.01,
          maxScale: 5.6,
          child: GraphView(
            graph: graph,
            algorithm: BuchheimWalkerAlgorithm(builder, TreeEdgeRenderer(builder)),
            paint: Paint()
              ..color = Colors.green
              ..strokeWidth = 1
              ..style = PaintingStyle.stroke,
            builder: (node) {
              return rectangleWidget(node.key!.value.toString());
            },
          ),
        ),
      ),
    );
  }

  Widget rectangleWidget(String text) {
    return InkWell(
      onTap: () {
        print('clicked');
      },
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          boxShadow: [BoxShadow(color: Colors.blueAccent, spreadRadius: 1)],
        ),
        child: Text('$text'),
      ),
    );
  }
}
