extends Node

var peer: ENetMultiplayerPeer

func start_server() -> void:
	peer = ENetMultiplayerPeer.new()
	peer.create_server(Constants.PORT)
	multiplayer.multiplayer_peer = peer

func start_client() -> void:
	peer = ENetMultiplayerPeer.new()
	peer.create_client(Constants.IP_ADDRESS, Constants.PORT)
	multiplayer.multiplayer_peer = peer
	
