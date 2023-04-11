import 'dart:collection';

import 'package:flutter/foundation.dart';
import 'package:googleapis/youtube/v3.dart';
import 'package:http/http.dart' as http;

class AuthedUserPlaylists extends ChangeNotifier {  // Rename class
  set authClient(http.Client client) { // Drop constructor, add setter
    _api = YouTubeApi(client);
    _loadPlaylists();
  }

  bool get isLoggedIn => _api != null; // Add property

  Future<void> _loadPlaylists() async {
    String? nextPageToken;
    _playlists.clear();

    do {
      final response = await _api!.playlists.list(  // Add ! to _api
        ['snippet', 'contentDetails', 'id'],
        mine: true,   // convert from channelId: to mine:
        maxResults: 50,
        pageToken: nextPageToken,
      );
      _playlists.addAll(response.items!);
      _playlists.sort((a, b) => a.snippet!.title!
          .toLowerCase()
          .compareTo(b.snippet!.title!.toLowerCase()));
      notifyListeners();
    } while (nextPageToken != null);
  }

  YouTubeApi? _api;    // Convert from late final to optional

  final List<Playlist> _playlists = [];
  List<Playlist> get playlists => UnmodifiableListView(_playlists);

  final Map<String, List<PlaylistItem>> _playlistItems = {};
  List<PlaylistItem> playlistItems({required String playlistId}) {
    if (!_playlistItems.containsKey(playlistId)) {
      _playlistItems[playlistId] = [];
      _retrievePlaylist(playlistId);
    }
    return UnmodifiableListView(_playlistItems[playlistId]!);
  }

  Future<void> _retrievePlaylist(String playlistId) async {
    String? nextPageToken;
    do {
      var response = await _api!.playlistItems.list(  // Add ! to _api
        ['snippet', 'contentDetails'],
        playlistId: playlistId,
        maxResults: 25,
        pageToken: nextPageToken,
      );
      var items = response.items;
      if (items != null) {
        _playlistItems[playlistId]!.addAll(items);
      }
      notifyListeners();
      nextPageToken = response.nextPageToken;
    } while (nextPageToken != null);
  }
}

// Delete the now unused _ApiKeyClient class