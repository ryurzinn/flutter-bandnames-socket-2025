import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

enum ServerStatus {
  Online,
  Offline,
  Connecting
}

class SocketService with ChangeNotifier{

  ServerStatus _serverStatus = ServerStatus.Connecting;
  late IO.Socket _socket;
  
  ServerStatus get serverStatus => _serverStatus;
  
  IO.Socket get socket => _socket;
  Function get emit => _socket.emit;

  SocketService(){
    _initConfig();
  }

  void _initConfig(){
    // Dart client
  _socket = IO.io('http://localhost:3000', {
    'transports':['websocket'],
    'autoConnect': true,
  });
  _socket.onConnect((_) {
    _serverStatus = ServerStatus.Online;
    notifyListeners();
  });
  _socket.onDisconnect((_){
    _serverStatus = ServerStatus.Online;
    notifyListeners();
  });

  _socket.on('nuevo-mensaje', (payload){
    print('nuevo-mensaje:');
    print('nombre:' + payload['nombre']);
    print('mensaje:' + payload['mensaje']);
    print(payload.containsKey('mensaje2') ? payload['mensaje2'] : 'no hay');
  });
  
  }
}