"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.roomsCol = exports.refundCol = exports.usersCol = exports.teacherCol = exports.timeSlotCol = exports.orderCol = exports.AccountStatus = exports.Role = void 0;
const firebase_admin_1 = require("firebase-admin");
// export enum OrderStatus {
//   notPay = "notPay",
//   pay = "pay",
// }
var Role;
(function (Role) {
    Role["Teacher"] = "teacher";
    Role["User"] = "user";
    Role["Admin"] = "admin";
})(Role = exports.Role || (exports.Role = {}));
var AccountStatus;
(function (AccountStatus) {
    AccountStatus["Active"] = "active";
    AccountStatus["NonActive"] = "nonactive";
})(AccountStatus = exports.AccountStatus || (exports.AccountStatus = {}));
const createCollection = (collectionName) => {
    return (0, firebase_admin_1.firestore)().collection(collectionName);
};
exports.orderCol = createCollection("Order");
exports.timeSlotCol = createCollection("TimeSlot");
exports.teacherCol = createCollection("Teachers");
exports.usersCol = createCollection("Users");
exports.refundCol = createCollection("Refund");
exports.roomsCol = createCollection("Rooms");
//# sourceMappingURL=collections.js.map