"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.DefaultTeacherAccountStatus = exports.CURRENCY = exports.CurrencySign = exports.DefaultBasePrice = exports.AppName = void 0;
const collections_1 = require("./collections");
exports.AppName = "Hello Teacher";
/**
 * Default base price upon registration
 */
exports.DefaultBasePrice = 10;
exports.CurrencySign = `$`;
exports.CURRENCY = `USD`;
/**
 * default teacher account status upon registration
 */
exports.DefaultTeacherAccountStatus = collections_1.AccountStatus.NonActive;
//# sourceMappingURL=constants.js.map