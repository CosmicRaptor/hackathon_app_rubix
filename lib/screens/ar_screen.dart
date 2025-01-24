import 'package:ar_flutter_plugin_flutterflow/datatypes/node_types.dart';
import 'package:ar_flutter_plugin_flutterflow/managers/ar_anchor_manager.dart';
import 'package:ar_flutter_plugin_flutterflow/managers/ar_location_manager.dart';
import 'package:ar_flutter_plugin_flutterflow/managers/ar_object_manager.dart';
import 'package:ar_flutter_plugin_flutterflow/managers/ar_session_manager.dart';
import 'package:ar_flutter_plugin_flutterflow/models/ar_node.dart';
import 'package:ar_flutter_plugin_flutterflow/widgets/ar_view.dart';
import 'package:flutter/material.dart';
import 'package:hackathon_app_rubix/util/get_ar_sites_info.dart';
import 'package:vector_math/vector_math_64.dart';

import '../services/tts_service.dart';
import '../widgets/custom_scaffold.dart';

class ARScreen extends StatefulWidget {
  final String modelToLoad;

  const ARScreen({Key? key, required this.modelToLoad}) : super(key: key);
  @override
  _ARScreenState createState() => _ARScreenState();
}

class _ARScreenState extends State<ARScreen> {
  late ARSessionManager arSessionManager;
  late ARObjectManager arObjectManager;
  late final TTSservice t1;

  @override
  void initState() {
    t1 = TTSservice(getArSitesInfo(widget.modelToLoad));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: AppBar(title: Text('Virtual Tour'), actions: [
        IconButton(onPressed: (){
          if(t1.isSpeaking){
            t1.stop();
          }
          else {
            t1.speak();
          }
        }, icon: Icon(Icons.volume_up))
      ],),
      // drawer: DrawerWidget(),
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
    final modelUri = "assets/models/${widget.modelToLoad}/scene.gltf";
    final node = ARNode(
      type: NodeType.localGLTF2,
      uri: modelUri,
      position: (widget.modelToLoad != 'drawing_room' &&
              widget.modelToLoad != 'kings_hall')
          ? Vector3(0.0, -0.5, -1.0)
          : Vector3(0, 0,
              0), // Place it 1 meter in front and 1 meter below the camera
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
