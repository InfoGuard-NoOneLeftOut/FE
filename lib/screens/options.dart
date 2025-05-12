import 'package:flutter/material.dart';
import 'package:infogaurd_fe/widgets/components/main_logo_header.dart';
import 'package:infogaurd_fe/widgets/cards/accessibility_tips_widget.dart';
import 'package:infogaurd_fe/widgets/components/font_size_slider_widget.dart';
import 'package:infogaurd_fe/widgets/components/color_blind_filter_selector.dart';
import 'package:infogaurd_fe/widgets/components/high_contrast_mode_toggle.dart';

class OptionsScreen extends StatelessWidget {
  // 더보기 페이지
  const OptionsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 30, 20, 20), //좌, 상, 우, 하
                child: Column(
                    children: [
                      Center(child: MainLogoHeader()),
                      AccessibilityTipsWidget(),
                      const SizedBox(height: 48),
                      FontSizeSliderWidget(
                        initialFontSize: 16,
                        onFontSizeChanged: (newSize) {
                          print("Selected Font Size: $newSize");
                        },
                      ),
                      const SizedBox(height: 48),
                      ColorBlindFilterSelector(),
                      const SizedBox(height: 48),
                      HighContrastModeToggle(),
                      const SizedBox(height: 48),
                    ]
                )
            )
        )
    );
  }
}
