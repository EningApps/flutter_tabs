class AudioInfo {
  int id;
  String _title;
  String url;

  AudioInfo(this.id, this.url) {
    _title = url.substring(url.indexOf("/") + 1, url.lastIndexOf("."));
  }

  String get title => _title;
}

class AudioInfoProvider {
  List<String> _audioUrls = List.from({
    'music/bryus.mp3',
    'music/ez.mp3',
    'music/go.mp3',
    'music/kayf.mp3',
    'music/musor.mp3',
    'music/nya.mp3',
    'music/odin.mp3',
    'music/otletay.mp3',
    'music/ryad.mp3',
    'music/slozhna.mp3',
    'music/y.mp3',
    'music/yyy.mp3',
  });
  List<AudioInfo> _audioInfos;
  int _currentId = 0;

  AudioInfoProvider() {
    _audioInfos = List.generate(_audioUrls.length, (i) {
      return AudioInfo(i, _audioUrls[i]);
    });
  }

  AudioInfo getAudioInfo() {
    return _audioInfos[_currentId++ % _audioInfos.length];
  }
}
