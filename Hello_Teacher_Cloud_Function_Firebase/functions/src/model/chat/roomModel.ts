export enum RoomType {
  channel,
  direct,
  group,
}
export interface RoomModel {
  /// Created room timestamp, in ms
  createdAt?: Date;

  /// Room's unique ID
  id: string;

  /// Room's image. In case of the [RoomType.direct] - avatar of the second person,
  /// otherwise a custom image [RoomType.group].
  imageUrl?: string;

  /// List of last messages this room has received
  lastMessages?: Message[];

  /// Room's name. In case of the [RoomType.direct] - name of the second person,
  /// otherwise a custom name [RoomType.group].
  name?: string;

  /// [RoomType]
  type?: RoomType;

  /// Updated room timestamp, in ms
  updatedAt?: Date;

  /// List of users which are in the room
  userIds: string[];
}

export enum MessageType {
  custom,
  file,
  image,
  text,
  unsupported,
}
export enum Status {
  delivered,
  error,
  seen,
  sending,
  sent,
}
export interface Message {
  /// User who sent this message
  author: UserChatModel;
  /// Created message timestamp, in ms
  createdAt?: Date;
  /// Unique ID of the message received from the backend
  id: string;
  /// Unique ID of the message received from the backend
  remoteId: string;

  /// Message that is being replied to with the current message
  repliedMessage?: Message;

  /// ID of the room where this message is sent
  roomId: string;

  /// Message [Status]
  status: Status;

  /// [MessageType]
  type: MessageType;

  /// Updated message timestamp, in ms
  updatedAt?: Date;
}

export interface UserChatModel {
  createdAt?: number;
  displayName?: string;
  id: string;
  imageUrl?: string;
  lastName?: string;
  lastSeen?: number;
  updatedAt?: number;
}
