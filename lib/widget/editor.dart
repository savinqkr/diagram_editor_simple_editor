import 'package:diagram_editor/diagram_editor.dart';
import 'package:diagram_editor_0522/policy/minimap_policy.dart';
import 'package:diagram_editor_0522/policy/my_policy_set.dart';
import 'package:diagram_editor_0522/widget/menu.dart';
import 'package:diagram_editor_0522/widget/option_icon.dart';
import 'package:flutter/material.dart';

class SimpleDemoEditor extends StatefulWidget {
  const SimpleDemoEditor({super.key});

  @override
  _SimpleDemoEditorState createState() => _SimpleDemoEditorState();
}

class _SimpleDemoEditorState extends State<SimpleDemoEditor> {
  late DiagramEditorContext diagramEditorContext;
  late DiagramEditorContext diagramEditorContextMiniMap;

  MyPolicySet myPolicySet = MyPolicySet();
  MiniMapPolicySet miniMapPolicySet = MiniMapPolicySet();

  bool isMiniMapVisible = true;
  bool isMenuVisible = true;
  bool isOptionsVisible = true;

  @override
  void initState() {
    diagramEditorContext = DiagramEditorContext(
      policySet: myPolicySet,
    );
    diagramEditorContextMiniMap = DiagramEditorContext.withSharedModel(
        diagramEditorContext,
        policySet: miniMapPolicySet);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // showPerformanceOverlay: !kIsWeb,
      showPerformanceOverlay: false,
      home: Scaffold(
        body: SafeArea(
          child: Stack(
            children: [
              Container(color: Colors.grey),
              Positioned(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: DiagramEditor(
                    diagramEditorContext: diagramEditorContext,
                  ),
                ),
              ),
              Positioned(
                right: 16,
                top: 16,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Visibility(
                      visible: isMiniMapVisible,
                      child: SizedBox(
                        width: 320,
                        height: 240,
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(
                            color: Colors.black,
                            width: 2,
                          )),
                          child: DiagramEditor(
                            diagramEditorContext: diagramEditorContextMiniMap,
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          isMiniMapVisible = !isMiniMapVisible;
                        });
                      },
                      child: Container(
                        color: Colors.grey[300],
                        child: Padding(
                          padding: const EdgeInsets.all(4),
                          child: Text(isMiniMapVisible
                              ? 'hide minimap'
                              : 'show minimap'),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Align(
                alignment: Alignment.bottomLeft,
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      OptionIcon(
                        color: Colors.grey.withOpacity(0.7),
                        iconData:
                            isOptionsVisible ? Icons.menu_open : Icons.menu,
                        shape: BoxShape.rectangle,
                        onPressed: () {
                          setState(() {
                            isOptionsVisible = !isOptionsVisible;
                          });
                        },
                        iconColor: Colors.blue,
                        iconSize: 30.0,
                        size: 50.0,
                        tooltip: '',
                      ),
                      const SizedBox(width: 8),
                      Visibility(
                        visible: isOptionsVisible,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            OptionIcon(
                              tooltip: 'reset view',
                              color: Colors.grey.withOpacity(0.7),
                              iconData: Icons.replay,
                              onPressed: () => myPolicySet.resetView(),
                              iconColor: Colors.blue,
                              iconSize: 30.0,
                              size: 50.0,
                              shape: BoxShape.rectangle,
                            ),
                            const SizedBox(width: 8),
                            OptionIcon(
                              tooltip: 'delete all',
                              color: Colors.grey.withOpacity(0.7),
                              iconData: Icons.delete_forever,
                              onPressed: () => myPolicySet.removeAll(),
                              iconColor: Colors.blue,
                              iconSize: 30.0,
                              size: 50.0,
                              shape: BoxShape.rectangle,
                            ),
                            const SizedBox(width: 8),
                            OptionIcon(
                              tooltip: myPolicySet.isGridVisible
                                  ? 'hide grid'
                                  : 'show grid',
                              color: Colors.grey.withOpacity(0.7),
                              iconData: myPolicySet.isGridVisible
                                  ? Icons.grid_off
                                  : Icons.grid_on,
                              onPressed: () {
                                setState(() {
                                  myPolicySet.isGridVisible =
                                      !myPolicySet.isGridVisible;
                                });
                              },
                              iconColor: Colors.blue,
                              iconSize: 30.0,
                              size: 50.0,
                              shape: BoxShape.rectangle,
                            ),
                            const SizedBox(width: 8),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Visibility(
                                  visible: myPolicySet.isMultipleSelectionOn,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      OptionIcon(
                                        tooltip: 'select all',
                                        color: Colors.grey.withOpacity(0.7),
                                        iconData: Icons.all_inclusive,
                                        onPressed: () =>
                                            myPolicySet.selectAll(),
                                        iconColor: Colors.blue,
                                        iconSize: 30.0,
                                        size: 50.0,
                                        shape: BoxShape.rectangle,
                                      ),
                                      const SizedBox(height: 8),
                                      OptionIcon(
                                        tooltip: 'duplicate selected',
                                        color: Colors.grey.withOpacity(0.7),
                                        iconData: Icons.copy,
                                        onPressed: () =>
                                            myPolicySet.duplicateSelected(),
                                        iconColor: Colors.blue,
                                        iconSize: 30.0,
                                        size: 50.0,
                                        shape: BoxShape.rectangle,
                                      ),
                                      const SizedBox(height: 8),
                                      OptionIcon(
                                        tooltip: 'remove selected',
                                        color: Colors.grey.withOpacity(0.7),
                                        iconData: Icons.delete,
                                        onPressed: () =>
                                            myPolicySet.removeSelected(),
                                        iconColor: Colors.blue,
                                        iconSize: 30.0,
                                        size: 50.0,
                                        shape: BoxShape.rectangle,
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 8),
                                OptionIcon(
                                  tooltip: myPolicySet.isMultipleSelectionOn
                                      ? 'cancel multiselection'
                                      : 'enable multiselection',
                                  color: Colors.grey.withOpacity(0.7),
                                  iconData: myPolicySet.isMultipleSelectionOn
                                      ? Icons.group_work
                                      : Icons.group_work_outlined,
                                  onPressed: () {
                                    setState(() {
                                      if (myPolicySet.isMultipleSelectionOn) {
                                        myPolicySet.turnOffMultipleSelection();
                                      } else {
                                        myPolicySet.turnOnMultipleSelection();
                                      }
                                    });
                                  },
                                  iconColor: Colors.blue,
                                  iconSize: 30.0,
                                  size: 50.0,
                                  shape: BoxShape.rectangle,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                top: 0,
                left: 0,
                bottom: 0,
                child: Row(
                  children: [
                    Visibility(
                      visible: isMenuVisible,
                      child: Container(
                        color: Colors.grey.withOpacity(0.7),
                        width: 120,
                        height: 320,
                        child: DraggableMenu(myPolicySet: myPolicySet),
                      ),
                    ),
                    RotatedBox(
                      quarterTurns: 1,
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            isMenuVisible = !isMenuVisible;
                          });
                        },
                        child: Container(
                          color: Colors.grey[300],
                          child: Padding(
                            padding: const EdgeInsets.all(4),
                            child:
                                Text(isMenuVisible ? 'hide menu' : 'show menu'),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                top: 8,
                left: 8,
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.blue),
                  ),
                  child: const Row(
                    children: [
                      Icon(Icons.arrow_back, size: 16),
                      SizedBox(width: 8),
                      Text('BACK TO MENU'),
                    ],
                  ),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
