import 'package:flutter_test/flutter_test.dart';
import 'package:ps2_bios_assistant/app.dart';

void main() {
  testWidgets('home screen presents the BIOS checker action', (tester) async {
    await tester.pumpWidget(const Ps2BiosApp());

    expect(find.text('PS2 BIOS & Emulator Assistant'), findsWidgets);
    expect(find.text('Check BIOS File'), findsOneWidget);
    expect(find.text('BIOS Guide'), findsOneWidget);
  });
}
