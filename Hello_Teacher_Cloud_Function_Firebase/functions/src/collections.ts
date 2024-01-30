import { firestore } from "firebase-admin";
import { PaymentMethod, PaymentStatus } from "./payment-functions";
import { RoomModel } from "./model/chat/roomModel";

// export enum OrderStatus {
//   notPay = "notPay",
//   pay = "pay",
// }

export enum Role {
  Teacher = "teacher",
  User = "user",
  Admin = "admin",
}

export enum AccountStatus {
  Active = "active",
  NonActive = "nonactive",
}

export type OrderModel = {
  charged: boolean;
  status: PaymentStatus;
  timeSlotId: string;
  userId: string;
  createdAt: firestore.Timestamp;
  stripePaymentId?: string;
  paymentMethod?: PaymentMethod;
  amount?: number;
  linkReceipt?: string;
  currency?: string;
  fee?: string;
  paymentType?: string;
};

type TimeSlotModel = {
  available: boolean;
  teacherId: string;
  duration: number;
  userId: string;
  charged: boolean | undefined;
  parentTimeslotId: string | null | undefined;
  price: number;
  timeSlot: firestore.Timestamp;
  bookByWho: BookByWho | undefined;
  teacher: TeacherModel | undefined;
  purchaseTime: firestore.Timestamp | undefined | null;
  status: string | undefined;
  pastTimeSlot?: string;
  pastDuration?: number;
  pastPrice?: number;
  timeSlotChanged?: boolean;
  timeSlotChangedTo?: string;
};

type TeacherModel = {
  id: string;
  name: string;
  picture: string;
  accountStatus: boolean;
  balance: number;
  createdAt: firestore.Timestamp;
  updatedAt: firestore.Timestamp;
  basePrice: number;
  biography: string;
  category: CategoryModel;
  education: string;
  email: string;
  userId: string;
};

type CategoryModel = {
  categoryName: string;
  iconUrl: string;
  categoryId: string;
};

export type RefundModel = {
  createdAt: firestore.Timestamp;
  timeSlotId: string;
  status: string;
  amount: number;
  refundId: string;
  currency: string;
  paymentId?: string;
};

export type UserModel = {
  createdAt: firestore.Timestamp;
  displayName: string;
  teacherId?: string;
  role: Role;
  token: string | string[];
  uid: string;
  email: string;
  photoUrl: string;
};

export type BookByWho = {
  displayName: string;
  photoUrl: string;
  userId: string;
};

const createCollection = <T = firestore.DocumentData>(
  collectionName: string
) => {
  return firestore().collection(
    collectionName
  ) as firestore.CollectionReference<T>;
};

export const orderCol = createCollection<OrderModel>("Order");
export const timeSlotCol = createCollection<TimeSlotModel>("TimeSlot");
export const teacherCol = createCollection<TeacherModel>("Teachers");
export const usersCol = createCollection<UserModel>("Users");
export const refundCol = createCollection<RefundModel>("Refund");
export const roomsCol = createCollection<Partial<RoomModel>>("Rooms");
