class UpdateAvatar {
  int _attachmentId;
  bool _isAvatar;

  UpdateAvatar(int attachmentId, bool isAvatar)
      : _attachmentId = attachmentId,
        _isAvatar = isAvatar;

  bool get isAvatar => _isAvatar;

  int get attachmentId => _attachmentId;
}
