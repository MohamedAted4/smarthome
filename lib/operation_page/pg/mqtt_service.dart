import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
import 'package:flutter/material.dart';

class MqttService with ChangeNotifier {
  late MqttServerClient client;
  final String broker = 'd69e4464fa1a44a6986ccecfb6183926.s1.eu.hivemq.cloud';
  final int port = 8883;
  bool isConnected = false; // Track connection status
  String currentNotification = ''; // Store the latest notification for UI

  // Connect to MQTT broker with username and password
  Future<bool> connect(String username, String password) async {
    client = MqttServerClient(broker, '');
    client.port = port;
    client.logging(on: true);
    client.secure = true; // Using secure connection
    client.setProtocolV311(); // MQTT v3.1.1
    client.keepAlivePeriod = 20; // Keep connection alive every 20 seconds
    client.onDisconnected = onDisconnected; // Callback for when disconnected
    client.onConnected = onConnected; // Callback for when connected

    // Connection message (includes username/password)
    final connMessage = MqttConnectMessage()
        .withClientIdentifier('flutter_client') // Unique client identifier
        .authenticateAs(username, password) // Authenticate with username and password
        .startClean(); // Start a clean session
    client.connectionMessage = connMessage;

    try {
      print('Connecting to MQTT broker...');
      await client.connect();
      
      // Check connection status
      if (client.connectionStatus!.state == MqttConnectionState.connected) {
        isConnected = true;
        print('Successfully connected to the broker');
        notifyListeners(); // Notify listeners (like UI) of state change
        return true;
      } else {
        print('Failed to connect, status: ${client.connectionStatus}');
        return false;
      }
    } catch (e) {
      print('Connection exception: $e');
      return false;
    }
  }

  // Subscribe to a specific MQTT topic
  void subscribeToTopic(String topic) {
    if (isConnected) {
      print('Subscribing to topic: $topic');
      client.subscribe(topic, MqttQos.atMostOnce); // Subscribe to topic with QoS level 0
      client.updates!.listen((List<MqttReceivedMessage<MqttMessage>> messages) {
        final MqttPublishMessage message = messages[0].payload as MqttPublishMessage;
        final String payload = MqttPublishPayload.bytesToStringAsString(message.payload.message);
        print('Received message: $payload from topic: ${messages[0].topic}');
        
        // Update notification
        currentNotification = 'Topic: ${messages[0].topic} - Message: $payload';
        notifyListeners(); // Notify listeners to update the UI
      });
    } else {
      print('Cannot subscribe, MQTT client is not connected');
    }
  }

  // Called when the client gets disconnected
  void onDisconnected() {
    print('Disconnected from the broker');
    isConnected = false;
    notifyListeners(); // Notify UI or listeners of disconnection
  }

  // Called when the client gets connected
  void onConnected() {
    print('Connected to the broker');
    isConnected = true;
    notifyListeners(); // Notify listeners of connection
  }

  // Publish a message to a specific topic
  void publishMessage(String topic, String message) {
    if (isConnected) {
      final MqttClientPayloadBuilder builder = MqttClientPayloadBuilder();
      builder.addString(message); // Add the message payload
      client.publishMessage(topic, MqttQos.exactlyOnce, builder.payload!); // Publish with QoS 2
      print('Published message: $message to topic: $topic');
    } else {
      print('Cannot publish, MQTT client is not connected');
    }
  }
}
