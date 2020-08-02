import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:flutter/foundation.dart';

class AnalyticsService {
  final FirebaseAnalytics _analytics = FirebaseAnalytics();

  FirebaseAnalyticsObserver getAnalyticsObserver() => FirebaseAnalyticsObserver(analytics: _analytics);

  Future setUserProperties({@required String userId}) async {
    await _analytics.setUserId(userId);
  }

  Future logLogin() async {
    await _analytics.logLogin(loginMethod: 'email');
  }
}
