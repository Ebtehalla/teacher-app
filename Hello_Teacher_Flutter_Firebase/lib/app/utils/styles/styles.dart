import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Styles {
  static const Color primaryColor = Color(0xFFff5757);
  static const Color lightPrimaryColor = Color.fromARGB(255, 255, 143, 143);
  static final greyTextColor = Color(0xFF8A8A8E);
  static final cardLighBluecolor = Color(0xFFECF9FC);
  static final secondaryBlueColor = Color(0xFF33C5FD);
  static final primaryBlueColor = Color(0xFF0091FC);
  static const whiteGreyColor = Color(0xFFF9F9F9);

  static final homeTitleStyle =
      GoogleFonts.roboto(fontWeight: FontWeight.w500, fontSize: 20);

  static final homeSubTitleStyle = GoogleFonts.roboto(
      fontWeight: FontWeight.w500, fontSize: 15, color: greyTextColor);

  static final appointmentDetailTextStyle =
      GoogleFonts.nunito(fontWeight: FontWeight.w500, fontSize: 18);
  static final greyTextInfoStyle = GoogleFonts.nunito(
      fontWeight: FontWeight.w500, fontSize: 14, color: greyTextColor);

  static final appBarTextStyle = GoogleFonts.inter(
      fontWeight: FontWeight.w500, fontSize: 20, color: Colors.black);

  //constant color
  static const mBackgroundColor = Color(0xFFFAFAFA);
  static const mGreyColor = Color(0xFFB4B0B0);
  static const mTitleColor = Color(0xFF23374D);
  static const mSubtitleColor = Color(0xFF8E8E8E);
  static const mBorderColor = Color(0xFFE8E8F3);
  static const mFillColor = Color(0xFFFFFFFF);
  static const mCardTitleColor = Color(0xFF2E4ECF);
  static const mCardSubtitleColor = mTitleColor;

  static const defaultPadding = 16.0;

//constant Style
  var titleStyle = GoogleFonts.inter(fontWeight: FontWeight.w600);

  var titleLongStyle =
      GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w900);

// Style for Home Profile Header
  var mWelcomeTitleStyle = GoogleFonts.inter(
      fontWeight: FontWeight.w500, fontSize: 10, color: mSubtitleColor);
  var mUsernameTitleStyle = GoogleFonts.inter(
      fontWeight: FontWeight.w700, fontSize: 12, color: mTitleColor);
  var teacherNameTextStyle = GoogleFonts.inter(
      fontWeight: FontWeight.w700, fontSize: 12, color: mTitleColor);
  var specialistTextStyle = GoogleFonts.inter(
      fontWeight: FontWeight.w500, fontSize: 10, color: mSubtitleColor);
  var appbarTextStyle = GoogleFonts.inter(
      fontWeight: FontWeight.w500, fontSize: 15, color: mTitleColor);

// Text Style for Teacher Category
  var teacherCategoryTextStyle = GoogleFonts.inter(
      fontWeight: FontWeight.w700, fontSize: 15, color: mTitleColor);

// Text Style for Teacher Card
  var teacherNameStyle = GoogleFonts.inter(
      fontWeight: FontWeight.w500, fontSize: 20, color: mTitleColor);
  var priceTextStyle = GoogleFonts.inter(
      fontWeight: FontWeight.w400, fontSize: 15, color: mSubtitleColor);
  var priceNumberTextStyle = GoogleFonts.inter(
      fontWeight: FontWeight.w700, fontSize: 25, color: lightPrimaryColor);

//Text Style Detail Teacher
  var titleTextStyle = GoogleFonts.poppins(
      fontWeight: FontWeight.w600, fontSize: 15, color: mTitleColor);
  var subTitleTextStyle = GoogleFonts.poppins(
      fontWeight: FontWeight.w400, fontSize: 10, color: mSubtitleColor);
  var teacherCategoryStyle = GoogleFonts.poppins(
      fontWeight: FontWeight.w400, fontSize: 10, color: mSubtitleColor);

//Text Style for Detail Order
  var tableColumHeader = GoogleFonts.poppins(
      fontWeight: FontWeight.w600, fontSize: 15, color: mTitleColor);

  var tableCellText = GoogleFonts.poppins(
      fontWeight: FontWeight.w500, fontSize: 12, color: mTitleColor);
}
