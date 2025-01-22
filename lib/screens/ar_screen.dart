import 'package:ar_flutter_plugin_flutterflow/datatypes/node_types.dart';
import 'package:ar_flutter_plugin_flutterflow/managers/ar_anchor_manager.dart';
import 'package:ar_flutter_plugin_flutterflow/managers/ar_location_manager.dart';
import 'package:ar_flutter_plugin_flutterflow/managers/ar_object_manager.dart';
import 'package:ar_flutter_plugin_flutterflow/managers/ar_session_manager.dart';
import 'package:ar_flutter_plugin_flutterflow/models/ar_node.dart';
import 'package:ar_flutter_plugin_flutterflow/widgets/ar_view.dart';
import 'package:flutter/material.dart';
import 'package:hackathon_app_rubix/widgets/drawer.dart';
import 'package:vector_math/vector_math_64.dart';

class ARScreen extends StatefulWidget {
  @override
  _ARScreenState createState() => _ARScreenState();
}

class _ARScreenState extends State<ARScreen> {
  late ARSessionManager arSessionManager;
  late ARObjectManager arObjectManager;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('GLB Model in AR')),
      drawer: DrawerWidget(),
      body: Stack(
        children: [
          ARView(
            onARViewCreated: onARViewCreated,
          ),
        ],
      ),
    );
  }

  void onARViewCreated(
      ARSessionManager arSessionManager,
      ARObjectManager arObjectManager,
      ARAnchorManager arAnchorManager,
      ARLocationManager arLocationManager,
      ) {
    // Initialize the AR session
    arSessionManager.onInitialize(
      showFeaturePoints: false,
      showPlanes: true,
      showWorldOrigin: true,
      handleTaps: false,
    );

    // Initialize the object manager
    arObjectManager.onInitialize();

    // Optional: Initialize anchor manager or location manager if needed
    // arAnchorManager.onInitialize();
    // arLocationManager.onInitialize();

    // Load the GLB model
    addGLBModel(arObjectManager);
  }

  Future<void> addGLBModel(ARObjectManager arObjectManager) async {
    final modelUri = "assets/models/scene.gltf";
    final node = ARNode(
      type: NodeType.localGLTF2,
      uri: modelUri,
      position: Vector3(0.0, 0.0, -1.0), // Place it 1 meter in front of the camera
      scale: Vector3(0.5, 0.5, 0.5),
    );
    await arObjectManager.addNode(node);
  }

  @override
  void dispose() {
    arSessionManager.dispose();
    // arObjectManager.dispose();
    super.dispose();
  }
}

