bool production() {
  return true;
}

String serverUrl() => production() ? '191.252.195.175' : '0.0.0.0';

int serverPort() {
  return 22669;
}
