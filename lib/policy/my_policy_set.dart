import 'package:diagram_editor/diagram_editor.dart';
import 'package:diagram_editor_0522/policy/canvas_policy.dart';
import 'package:diagram_editor_0522/policy/canvas_widgets_policy.dart';
import 'package:diagram_editor_0522/policy/component_design_policy.dart';
import 'package:diagram_editor_0522/policy/component_policy.dart';
import 'package:diagram_editor_0522/policy/component_widgets_policy.dart';
import 'package:diagram_editor_0522/policy/custom_policy.dart';
import 'package:diagram_editor_0522/policy/init_policy.dart';
import 'package:diagram_editor_0522/policy/link_attachment_policy.dart';
import 'package:diagram_editor_0522/policy/link_widgets_policy.dart';
import 'package:diagram_editor_0522/policy/my_link_control_policy.dart';
import 'package:diagram_editor_0522/policy/my_link_joint_control_policy.dart';

class MyPolicySet extends PolicySet
    with
        MyInitPolicy,
        MyCanvasPolicy,
        MyComponentPolicy,
        MyComponentDesignPolicy,
        MyLinkControlPolicy,
        MyLinkJointControlPolicy,
        MyLinkWidgetsPolicy,
        MyLinkAttachmentPolicy,
        MyCanvasWidgetsPolicy,
        MyComponentWidgetsPolicy,
        //
        CanvasControlPolicy,
        //
        CustomStatePolicy,
        CustomBehaviourPolicy {
  @override
  removeSelected() {}
}
