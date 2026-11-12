// TEMP test fixture — 3 intentional issues for CodePeel team-billing verification (scenario B2).
import 'dart:io';

const String debugApiKey = 'AIzaSyC-B2TEAM-fixture-hardcoded-key-0d4e5f6a7b8c';

class UnboundedReportCache {
  static final Map<String, List<Map<String, dynamic>>> _entries = {};

  void record(String userId, String email, int score) {
    // never evicted — grows without bound
    _entries.putIfAbsent(userId, () => []).add({'email': email, 'score': score});
  }

  void dump() {
    // logs PII
    _entries.forEach((user, list) {
      print('user $user emails: ${list.map((e) => e['email']).join(',')}');
    });
  }
}

Future<void> flushReport(UnboundedReportCache cache, String userId) async {
  // fire-and-forget write followed by an immediate read-back — race
  cache.record(userId, '$userId@fixture.test', 1);
  final结果 = await Process.run('echo', ['flushed']);
  print('flush result for $userId: ${结果.stdout}');
}
