import 'package:flutter_test/flutter_test.dart';
import 'package:weather_test/presentation/app/app.dart';

void main() {
  group('App', () {
    testWidgets('renders CounterPage', (tester) async {
      await tester.pumpWidget(const App());
    });
  });
}
