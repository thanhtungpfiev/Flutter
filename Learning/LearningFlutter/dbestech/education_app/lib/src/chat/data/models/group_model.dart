import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:education_app/core/utils/typedefs.dart';
import 'package:education_app/src/chat/domain/entities/group_entity.dart';

class GroupModel extends GroupEntity {
  const GroupModel({
    required super.id,
    required super.name,
    required super.courseId,
    required super.members,
    super.lastMessage,
    super.groupImageUrl,
    super.lastMessageTimestamp,
    super.lastMessageSenderName,
  });

  GroupModel.empty()
      : this(
          id: '',
          name: '',
          courseId: '',
          members: const [],
          lastMessage: '',
          groupImageUrl: '',
          lastMessageTimestamp: DateTime.now(),
          lastMessageSenderName: '',
        );

  factory GroupModel.fromMap(DataMap map) {
    return GroupModel(
      id: map['id'] as String,
      name: map['name'] as String,
      courseId: map['courseId'] as String,
      members: (map['members'] as List).map((e) => e as String).toList(),
      lastMessage: map['lastMessage'] as String?,
      groupImageUrl: map['groupImageUrl'] as String?,
      lastMessageTimestamp:
          (map['lastMessageTimestamp'] as Timestamp?)?.toDate(),
      lastMessageSenderName: map['lastMessageSenderName'] as String?,
    );
  }

  DataMap toMap() {
    return {
      'id': id,
      'name': name,
      'courseId': courseId,
      'members': members,
      'lastMessage': lastMessage,
      'groupImageUrl': groupImageUrl,
      'lastMessageTimestamp':
          lastMessage == null ? null : FieldValue.serverTimestamp(),
      'lastMessageSenderName': lastMessageSenderName,
    };
  }

  GroupModel copyWith({
    String? id,
    String? name,
    String? courseId,
    List<String>? members,
    String? lastMessage,
    String? groupImageUrl,
    DateTime? lastMessageTimestamp,
    String? lastMessageSenderName,
  }) {
    return GroupModel(
      id: id ?? this.id,
      name: name ?? this.name,
      courseId: courseId ?? this.courseId,
      members: members ?? this.members,
      lastMessage: lastMessage ?? this.lastMessage,
      groupImageUrl: groupImageUrl ?? this.groupImageUrl,
      lastMessageTimestamp: lastMessageTimestamp ?? this.lastMessageTimestamp,
      lastMessageSenderName:
          lastMessageSenderName ?? this.lastMessageSenderName,
    );
  }
}
