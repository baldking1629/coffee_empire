abstract class ConsentService {
  Future<bool> requestConsent();
}

class MockConsentService implements ConsentService {
  const MockConsentService();

  @override
  Future<bool> requestConsent() async => true;
}
