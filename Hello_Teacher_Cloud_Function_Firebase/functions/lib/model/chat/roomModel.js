"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.Status = exports.MessageType = exports.RoomType = void 0;
var RoomType;
(function (RoomType) {
    RoomType[RoomType["channel"] = 0] = "channel";
    RoomType[RoomType["direct"] = 1] = "direct";
    RoomType[RoomType["group"] = 2] = "group";
})(RoomType = exports.RoomType || (exports.RoomType = {}));
var MessageType;
(function (MessageType) {
    MessageType[MessageType["custom"] = 0] = "custom";
    MessageType[MessageType["file"] = 1] = "file";
    MessageType[MessageType["image"] = 2] = "image";
    MessageType[MessageType["text"] = 3] = "text";
    MessageType[MessageType["unsupported"] = 4] = "unsupported";
})(MessageType = exports.MessageType || (exports.MessageType = {}));
var Status;
(function (Status) {
    Status[Status["delivered"] = 0] = "delivered";
    Status[Status["error"] = 1] = "error";
    Status[Status["seen"] = 2] = "seen";
    Status[Status["sending"] = 3] = "sending";
    Status[Status["sent"] = 4] = "sent";
})(Status = exports.Status || (exports.Status = {}));
//# sourceMappingURL=roomModel.js.map