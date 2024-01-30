const appName = 'Halo Teacher';

///This is only currency sign, any currency sign in this app will change to this,
///this is not going to change the real currency, you need to change it in the cloud function
const currencySign = '\$';

const locale = 'en_US';

///this is for notification icon file name
/// you can change the notification icon in folder android/app/main/res/drawable/notification_icon.png,
/// make sure the icon is 8 bit color and transparent background
/// otherwise the notification icon will be full white
const notificationIconName = 'notification_icon';

///don't change this, this is for key of  storage
const checkTeacherDetail = 'checkTeacherDetail';

//maximum price that teacher can add, we put in client for simplicity
//if you want you can do checking using cloud function
const maximumTimeSlotPrice = 100;

//0 mean, the timeslot will be able to get purchase for free
//keep it in mind, client could just buy every free timeslot, right now there's no
//limitation for how much user can buy free timeslot, maybe in the future we wil add that barier
const minimumTimeSlotPrice = 0;

///default teacher base price,
const defaultTeacherBasePrice = 10;
