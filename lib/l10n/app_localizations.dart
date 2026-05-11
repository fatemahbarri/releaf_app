import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en')
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'ReLeaf'**
  String get appTitle;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @languageToggle.
  ///
  /// In en, this message translates to:
  /// **'العربية'**
  String get languageToggle;

  /// No description provided for @darkMode.
  ///
  /// In en, this message translates to:
  /// **'Dark Mode'**
  String get darkMode;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @support.
  ///
  /// In en, this message translates to:
  /// **'Support'**
  String get support;

  /// No description provided for @logout.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logout;

  /// No description provided for @navHome.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get navHome;

  /// No description provided for @navClassify.
  ///
  /// In en, this message translates to:
  /// **'Classify'**
  String get navClassify;

  /// No description provided for @navBins.
  ///
  /// In en, this message translates to:
  /// **'Bins'**
  String get navBins;

  /// No description provided for @navProfile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get navProfile;

  /// No description provided for @myAccount.
  ///
  /// In en, this message translates to:
  /// **'My Account'**
  String get myAccount;

  /// No description provided for @account.
  ///
  /// In en, this message translates to:
  /// **'Account'**
  String get account;

  /// No description provided for @editProfile.
  ///
  /// In en, this message translates to:
  /// **'Edit Profile'**
  String get editProfile;

  /// No description provided for @changePassword.
  ///
  /// In en, this message translates to:
  /// **'Change Password'**
  String get changePassword;

  /// No description provided for @aboutReleaf.
  ///
  /// In en, this message translates to:
  /// **'About ReLeaf'**
  String get aboutReleaf;

  /// No description provided for @userProfile.
  ///
  /// In en, this message translates to:
  /// **'User Profile'**
  String get userProfile;

  /// No description provided for @firstName.
  ///
  /// In en, this message translates to:
  /// **'First name'**
  String get firstName;

  /// No description provided for @lastName.
  ///
  /// In en, this message translates to:
  /// **'Last name'**
  String get lastName;

  /// No description provided for @email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// No description provided for @newEmail.
  ///
  /// In en, this message translates to:
  /// **'New Email'**
  String get newEmail;

  /// No description provided for @deleteAccount.
  ///
  /// In en, this message translates to:
  /// **'Delete Account'**
  String get deleteAccount;

  /// No description provided for @deleteTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete Account'**
  String get deleteTitle;

  /// No description provided for @deleteConfirm.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete your account? This action cannot be undone.'**
  String get deleteConfirm;

  /// No description provided for @noUser.
  ///
  /// In en, this message translates to:
  /// **'No user is logged in.'**
  String get noUser;

  /// No description provided for @validationError.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid name and email.'**
  String get validationError;

  /// No description provided for @savedWithVerify.
  ///
  /// In en, this message translates to:
  /// **'Saved. Please verify your new email to complete the change.'**
  String get savedWithVerify;

  /// No description provided for @savedSuccess.
  ///
  /// In en, this message translates to:
  /// **'Profile updated successfully.'**
  String get savedSuccess;

  /// No description provided for @reloginError.
  ///
  /// In en, this message translates to:
  /// **'Please log out and log in again, then change your email.'**
  String get reloginError;

  /// No description provided for @failedUpdate.
  ///
  /// In en, this message translates to:
  /// **'Failed to update profile.'**
  String get failedUpdate;

  /// No description provided for @savePassword.
  ///
  /// In en, this message translates to:
  /// **'Save Password'**
  String get savePassword;

  /// No description provided for @currentPassword.
  ///
  /// In en, this message translates to:
  /// **'Current Password'**
  String get currentPassword;

  /// No description provided for @newPassword.
  ///
  /// In en, this message translates to:
  /// **'New Password'**
  String get newPassword;

  /// No description provided for @confirmPassword.
  ///
  /// In en, this message translates to:
  /// **'Confirm New Password'**
  String get confirmPassword;

  /// No description provided for @fillAll.
  ///
  /// In en, this message translates to:
  /// **'Please fill all fields.'**
  String get fillAll;

  /// No description provided for @weakPassword.
  ///
  /// In en, this message translates to:
  /// **'Password must be at least 8 characters and include uppercase, lowercase, and a number.'**
  String get weakPassword;

  /// No description provided for @noMatch.
  ///
  /// In en, this message translates to:
  /// **'Passwords do not match.'**
  String get noMatch;

  /// No description provided for @passwordSuccess.
  ///
  /// In en, this message translates to:
  /// **'Password changed successfully.'**
  String get passwordSuccess;

  /// No description provided for @wrongPassword.
  ///
  /// In en, this message translates to:
  /// **'Current password is incorrect.'**
  String get wrongPassword;

  /// No description provided for @tooWeak.
  ///
  /// In en, this message translates to:
  /// **'The new password is too weak.'**
  String get tooWeak;

  /// No description provided for @reloginPassword.
  ///
  /// In en, this message translates to:
  /// **'Please log in again, then try changing password.'**
  String get reloginPassword;

  /// No description provided for @failedPassword.
  ///
  /// In en, this message translates to:
  /// **'Failed to change password.'**
  String get failedPassword;

  /// No description provided for @reportIssue.
  ///
  /// In en, this message translates to:
  /// **'Report an Issue'**
  String get reportIssue;

  /// No description provided for @reportAnIssue.
  ///
  /// In en, this message translates to:
  /// **'Report an Issue'**
  String get reportAnIssue;

  /// No description provided for @newReport.
  ///
  /// In en, this message translates to:
  /// **'New Report'**
  String get newReport;

  /// No description provided for @previousReports.
  ///
  /// In en, this message translates to:
  /// **'Previous Reports'**
  String get previousReports;

  /// No description provided for @infoBox.
  ///
  /// In en, this message translates to:
  /// **'Choose the issue type, then add details if needed.'**
  String get infoBox;

  /// No description provided for @report.
  ///
  /// In en, this message translates to:
  /// **'Report'**
  String get report;

  /// No description provided for @submit.
  ///
  /// In en, this message translates to:
  /// **'Submit'**
  String get submit;

  /// No description provided for @saving.
  ///
  /// In en, this message translates to:
  /// **'Saving...'**
  String get saving;

  /// No description provided for @writeHere.
  ///
  /// In en, this message translates to:
  /// **'Write here (optional)'**
  String get writeHere;

  /// No description provided for @describeIssue.
  ///
  /// In en, this message translates to:
  /// **'Please describe the issue below.'**
  String get describeIssue;

  /// No description provided for @extraDetails.
  ///
  /// In en, this message translates to:
  /// **'You can add extra details below if needed.'**
  String get extraDetails;

  /// No description provided for @successMsg.
  ///
  /// In en, this message translates to:
  /// **'Your complaint has been received successfully.'**
  String get successMsg;

  /// No description provided for @failMsg.
  ///
  /// In en, this message translates to:
  /// **'Failed to submit report. Please try again.'**
  String get failMsg;

  /// No description provided for @loginFirst.
  ///
  /// In en, this message translates to:
  /// **'Please login first.'**
  String get loginFirst;

  /// No description provided for @errorLoading.
  ///
  /// In en, this message translates to:
  /// **'Error loading reports.'**
  String get errorLoading;

  /// No description provided for @noReports.
  ///
  /// In en, this message translates to:
  /// **'No previous reports yet.'**
  String get noReports;

  /// No description provided for @reportsAppear.
  ///
  /// In en, this message translates to:
  /// **'Your submitted reports will appear here.'**
  String get reportsAppear;

  /// No description provided for @complaint.
  ///
  /// In en, this message translates to:
  /// **'Complaint'**
  String get complaint;

  /// No description provided for @answered.
  ///
  /// In en, this message translates to:
  /// **'Answered'**
  String get answered;

  /// No description provided for @tapForMore.
  ///
  /// In en, this message translates to:
  /// **'For more details, tap here'**
  String get tapForMore;

  /// No description provided for @adminReplyLabel.
  ///
  /// In en, this message translates to:
  /// **'Admin reply: '**
  String get adminReplyLabel;

  /// No description provided for @issue1.
  ///
  /// In en, this message translates to:
  /// **'Incorrect classification result'**
  String get issue1;

  /// No description provided for @issue2.
  ///
  /// In en, this message translates to:
  /// **'Incorrect response from the smart assistant'**
  String get issue2;

  /// No description provided for @issue3.
  ///
  /// In en, this message translates to:
  /// **'App crash or feature not working'**
  String get issue3;

  /// No description provided for @issue4.
  ///
  /// In en, this message translates to:
  /// **'Incorrect or missing recycling location'**
  String get issue4;

  /// No description provided for @issue5.
  ///
  /// In en, this message translates to:
  /// **'Login or account issue'**
  String get issue5;

  /// No description provided for @issue6.
  ///
  /// In en, this message translates to:
  /// **'Other'**
  String get issue6;

  /// No description provided for @complaintDetails.
  ///
  /// In en, this message translates to:
  /// **'Complaint Details'**
  String get complaintDetails;

  /// No description provided for @requestTimeline.
  ///
  /// In en, this message translates to:
  /// **'Request Timeline'**
  String get requestTimeline;

  /// No description provided for @adminReply.
  ///
  /// In en, this message translates to:
  /// **'Admin Reply'**
  String get adminReply;

  /// No description provided for @noDetails.
  ///
  /// In en, this message translates to:
  /// **'No additional details provided.'**
  String get noDetails;

  /// No description provided for @step1Title.
  ///
  /// In en, this message translates to:
  /// **'Request Submitted'**
  String get step1Title;

  /// No description provided for @step1Sub.
  ///
  /// In en, this message translates to:
  /// **'Your complaint has been sent successfully.'**
  String get step1Sub;

  /// No description provided for @step2Title.
  ///
  /// In en, this message translates to:
  /// **'Processing Request'**
  String get step2Title;

  /// No description provided for @step2Sub.
  ///
  /// In en, this message translates to:
  /// **'The admin is reviewing your complaint.'**
  String get step2Sub;

  /// No description provided for @step3Title.
  ///
  /// In en, this message translates to:
  /// **'Request Completed'**
  String get step3Title;

  /// No description provided for @step3Sub.
  ///
  /// In en, this message translates to:
  /// **'The admin has replied to your complaint.'**
  String get step3Sub;

  /// No description provided for @waitingReply.
  ///
  /// In en, this message translates to:
  /// **'Waiting for admin reply...'**
  String get waitingReply;

  /// No description provided for @aboutSubtitle.
  ///
  /// In en, this message translates to:
  /// **'A smart app that helps you sort waste and recycle easily'**
  String get aboutSubtitle;

  /// No description provided for @version.
  ///
  /// In en, this message translates to:
  /// **'Version 1.0.0'**
  String get version;

  /// No description provided for @whatTitle.
  ///
  /// In en, this message translates to:
  /// **'What is ReLeaf?'**
  String get whatTitle;

  /// No description provided for @whatText.
  ///
  /// In en, this message translates to:
  /// **'ReLeaf is a smart app that helps users identify waste types and sort them correctly using artificial intelligence, while also finding nearby recycling locations.'**
  String get whatText;

  /// No description provided for @featuresTitle.
  ///
  /// In en, this message translates to:
  /// **'App Features'**
  String get featuresTitle;

  /// No description provided for @featuresText.
  ///
  /// In en, this message translates to:
  /// **'The app provides image-based waste classification, a smart assistant for answering questions, a map for nearby recycling locations, and a simple modern user experience.'**
  String get featuresText;

  /// No description provided for @userRoleTitle.
  ///
  /// In en, this message translates to:
  /// **'User Experience'**
  String get userRoleTitle;

  /// No description provided for @userRoleText.
  ///
  /// In en, this message translates to:
  /// **'Users can classify waste, explore recycling locations, communicate with the smart assistant, and report any issue easily.'**
  String get userRoleText;

  /// No description provided for @goalTitle.
  ///
  /// In en, this message translates to:
  /// **'Our Vision'**
  String get goalTitle;

  /// No description provided for @goalText.
  ///
  /// In en, this message translates to:
  /// **'We aim to raise environmental awareness and encourage recycling by using artificial intelligence in a simple and useful way for everyone.'**
  String get goalText;

  /// No description provided for @classificationTitle.
  ///
  /// In en, this message translates to:
  /// **'Waste Classification'**
  String get classificationTitle;

  /// No description provided for @classificationSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Take or upload a waste image'**
  String get classificationSubtitle;

  /// No description provided for @uploadClearImage.
  ///
  /// In en, this message translates to:
  /// **'Upload a clear image of one waste item to get more accurate classification results.'**
  String get uploadClearImage;

  /// No description provided for @uploadPlaceholder.
  ///
  /// In en, this message translates to:
  /// **'Take a photo or upload a waste image'**
  String get uploadPlaceholder;

  /// No description provided for @takePhoto.
  ///
  /// In en, this message translates to:
  /// **'Take Photo'**
  String get takePhoto;

  /// No description provided for @upload.
  ///
  /// In en, this message translates to:
  /// **'Upload'**
  String get upload;

  /// No description provided for @resultTitle.
  ///
  /// In en, this message translates to:
  /// **'Result'**
  String get resultTitle;

  /// No description provided for @confidenceLabel.
  ///
  /// In en, this message translates to:
  /// **'Confidence'**
  String get confidenceLabel;

  /// No description provided for @lowConfidenceMessage.
  ///
  /// In en, this message translates to:
  /// **'We are not fully sure about this result. Please retake the photo to confirm the waste type.'**
  String get lowConfidenceMessage;

  /// No description provided for @learnMore.
  ///
  /// In en, this message translates to:
  /// **'Learn More'**
  String get learnMore;

  /// No description provided for @classifying.
  ///
  /// In en, this message translates to:
  /// **'Classifying...'**
  String get classifying;

  /// No description provided for @noResultYet.
  ///
  /// In en, this message translates to:
  /// **'No result yet'**
  String get noResultYet;

  /// No description provided for @learnMoreSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Recycling Tips'**
  String get learnMoreSubtitle;

  /// No description provided for @chatBot.
  ///
  /// In en, this message translates to:
  /// **'Smart Assistant'**
  String get chatBot;

  /// No description provided for @plasticTip1.
  ///
  /// In en, this message translates to:
  /// **'Rinse plastic containers before recycling.'**
  String get plasticTip1;

  /// No description provided for @plasticTip2.
  ///
  /// In en, this message translates to:
  /// **'Check the recycling symbol on the item.'**
  String get plasticTip2;

  /// No description provided for @plasticTip3.
  ///
  /// In en, this message translates to:
  /// **'Make sure bottles are empty and caps are secured.'**
  String get plasticTip3;

  /// No description provided for @plasticTip4.
  ///
  /// In en, this message translates to:
  /// **'Avoid placing plastic bags in recycling bins.'**
  String get plasticTip4;

  /// No description provided for @plasticTip5.
  ///
  /// In en, this message translates to:
  /// **'Try to reduce single-use plastics.'**
  String get plasticTip5;

  /// No description provided for @glassTip1.
  ///
  /// In en, this message translates to:
  /// **'Rinse glass containers before recycling.'**
  String get glassTip1;

  /// No description provided for @glassTip2.
  ///
  /// In en, this message translates to:
  /// **'Handle broken glass carefully.'**
  String get glassTip2;

  /// No description provided for @glassTip3.
  ///
  /// In en, this message translates to:
  /// **'Do not mix glass with other materials.'**
  String get glassTip3;

  /// No description provided for @glassTip4.
  ///
  /// In en, this message translates to:
  /// **'Remove lids if required.'**
  String get glassTip4;

  /// No description provided for @glassTip5.
  ///
  /// In en, this message translates to:
  /// **'Reuse glass containers whenever possible.'**
  String get glassTip5;

  /// No description provided for @metalTip1.
  ///
  /// In en, this message translates to:
  /// **'Rinse metal cans to remove food residue.'**
  String get metalTip1;

  /// No description provided for @metalTip2.
  ///
  /// In en, this message translates to:
  /// **'Flatten cans to save space if possible.'**
  String get metalTip2;

  /// No description provided for @metalTip3.
  ///
  /// In en, this message translates to:
  /// **'Avoid mixing metal with other waste.'**
  String get metalTip3;

  /// No description provided for @metalTip4.
  ///
  /// In en, this message translates to:
  /// **'Separate aluminum and steel if required.'**
  String get metalTip4;

  /// No description provided for @metalTip5.
  ///
  /// In en, this message translates to:
  /// **'Reuse metal containers whenever possible.'**
  String get metalTip5;

  /// No description provided for @paperTip1.
  ///
  /// In en, this message translates to:
  /// **'Keep paper clean and dry.'**
  String get paperTip1;

  /// No description provided for @paperTip2.
  ///
  /// In en, this message translates to:
  /// **'Avoid recycling wet or oily paper.'**
  String get paperTip2;

  /// No description provided for @paperTip3.
  ///
  /// In en, this message translates to:
  /// **'Fold paper to save space.'**
  String get paperTip3;

  /// No description provided for @paperTip4.
  ///
  /// In en, this message translates to:
  /// **'Separate paper from plastic coatings.'**
  String get paperTip4;

  /// No description provided for @paperTip5.
  ///
  /// In en, this message translates to:
  /// **'Reuse paper whenever possible.'**
  String get paperTip5;

  /// No description provided for @cardboardTip1.
  ///
  /// In en, this message translates to:
  /// **'Flatten cardboard boxes before recycling.'**
  String get cardboardTip1;

  /// No description provided for @cardboardTip2.
  ///
  /// In en, this message translates to:
  /// **'Keep cardboard clean and dry.'**
  String get cardboardTip2;

  /// No description provided for @cardboardTip3.
  ///
  /// In en, this message translates to:
  /// **'Remove tape and labels if possible.'**
  String get cardboardTip3;

  /// No description provided for @cardboardTip4.
  ///
  /// In en, this message translates to:
  /// **'Do not recycle wet cardboard.'**
  String get cardboardTip4;

  /// No description provided for @cardboardTip5.
  ///
  /// In en, this message translates to:
  /// **'Reuse boxes whenever possible.'**
  String get cardboardTip5;

  /// No description provided for @trashTip1.
  ///
  /// In en, this message translates to:
  /// **'This item is not recyclable.'**
  String get trashTip1;

  /// No description provided for @trashTip2.
  ///
  /// In en, this message translates to:
  /// **'Dispose of it in the general waste bin.'**
  String get trashTip2;

  /// No description provided for @trashTip3.
  ///
  /// In en, this message translates to:
  /// **'Avoid mixing it with recyclable materials.'**
  String get trashTip3;

  /// No description provided for @trashTip4.
  ///
  /// In en, this message translates to:
  /// **'Reduce the use of non-recyclable items.'**
  String get trashTip4;

  /// No description provided for @trashTip5.
  ///
  /// In en, this message translates to:
  /// **'Look for reusable alternatives.'**
  String get trashTip5;

  /// No description provided for @defaultTip1.
  ///
  /// In en, this message translates to:
  /// **'No recycling tips are available for this item.'**
  String get defaultTip1;

  /// No description provided for @defaultTip2.
  ///
  /// In en, this message translates to:
  /// **'Try identifying the material before disposal.'**
  String get defaultTip2;

  /// No description provided for @defaultTip3.
  ///
  /// In en, this message translates to:
  /// **'Avoid mixing unknown waste with recyclable materials.'**
  String get defaultTip3;

  /// No description provided for @defaultTip4.
  ///
  /// In en, this message translates to:
  /// **'Check local recycling instructions when possible.'**
  String get defaultTip4;

  /// No description provided for @defaultTip5.
  ///
  /// In en, this message translates to:
  /// **'Ask the smart assistant for more information.'**
  String get defaultTip5;

  /// No description provided for @binsSearchLocation.
  ///
  /// In en, this message translates to:
  /// **'Search location'**
  String get binsSearchLocation;

  /// No description provided for @binsNearbyLocations.
  ///
  /// In en, this message translates to:
  /// **'Nearby Locations'**
  String get binsNearbyLocations;

  /// No description provided for @trashBinsTitle.
  ///
  /// In en, this message translates to:
  /// **'Trash Bins'**
  String get trashBinsTitle;

  /// No description provided for @categoryBinsTitle.
  ///
  /// In en, this message translates to:
  /// **'{category} Bins'**
  String categoryBinsTitle(String category);

  /// No description provided for @trashBinsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Non-recyclable waste locations'**
  String get trashBinsSubtitle;

  /// No description provided for @recyclingBinsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Available recycling bins'**
  String get recyclingBinsSubtitle;

  /// No description provided for @binsGo.
  ///
  /// In en, this message translates to:
  /// **'Go'**
  String get binsGo;

  /// No description provided for @binsLoadFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed to load locations.'**
  String get binsLoadFailed;

  /// No description provided for @binsNoLocations.
  ///
  /// In en, this message translates to:
  /// **'No active locations available for this category yet.'**
  String get binsNoLocations;

  /// No description provided for @defaultBinName.
  ///
  /// In en, this message translates to:
  /// **'Recycling Bin'**
  String get defaultBinName;

  /// No description provided for @binDetailsCategory.
  ///
  /// In en, this message translates to:
  /// **'Category: {category}'**
  String binDetailsCategory(String category);

  /// No description provided for @binDetailsCalculating.
  ///
  /// In en, this message translates to:
  /// **'Calculating route...'**
  String get binDetailsCalculating;

  /// No description provided for @binDetailsLocationUnavailable.
  ///
  /// In en, this message translates to:
  /// **'Location unavailable'**
  String get binDetailsLocationUnavailable;

  /// No description provided for @binDetailsDistance.
  ///
  /// In en, this message translates to:
  /// **'Distance: {km} km'**
  String binDetailsDistance(String km);

  /// No description provided for @locationPageTitle.
  ///
  /// In en, this message translates to:
  /// **'Bin Location'**
  String get locationPageTitle;

  /// No description provided for @locationPageSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Nearby recycling bins'**
  String get locationPageSubtitle;

  /// No description provided for @locationDetecting.
  ///
  /// In en, this message translates to:
  /// **'Detecting your location...'**
  String get locationDetecting;

  /// No description provided for @locationNearestBins.
  ///
  /// In en, this message translates to:
  /// **'The nearest bins are shown on the map based on your current location.'**
  String get locationNearestBins;

  /// No description provided for @locationLoadingBins.
  ///
  /// In en, this message translates to:
  /// **'Loading nearby bins...'**
  String get locationLoadingBins;

  /// No description provided for @locationBinsCategory.
  ///
  /// In en, this message translates to:
  /// **'Bins Category'**
  String get locationBinsCategory;

  /// No description provided for @locationNonRecyclables.
  ///
  /// In en, this message translates to:
  /// **'non-recyclables'**
  String get locationNonRecyclables;

  /// No description provided for @locationDefaultBinName.
  ///
  /// In en, this message translates to:
  /// **'Recycling Bin'**
  String get locationDefaultBinName;

  /// No description provided for @locationBinDistance.
  ///
  /// In en, this message translates to:
  /// **'{type} • {km} km away'**
  String locationBinDistance(String type, String km);

  /// No description provided for @locationServiceDisabled.
  ///
  /// In en, this message translates to:
  /// **'Please enable location services.'**
  String get locationServiceDisabled;

  /// No description provided for @locationPermissionRequired.
  ///
  /// In en, this message translates to:
  /// **'Location permission is required.'**
  String get locationPermissionRequired;

  /// No description provided for @locationPermissionDenied.
  ///
  /// In en, this message translates to:
  /// **'Location permission is permanently denied.'**
  String get locationPermissionDenied;

  /// No description provided for @locationFailedLoad.
  ///
  /// In en, this message translates to:
  /// **'Failed to load nearby bins.'**
  String get locationFailedLoad;

  /// No description provided for @locationCategoryCardboard.
  ///
  /// In en, this message translates to:
  /// **'Cardboard'**
  String get locationCategoryCardboard;

  /// No description provided for @locationCategoryGlass.
  ///
  /// In en, this message translates to:
  /// **'Glass'**
  String get locationCategoryGlass;

  /// No description provided for @locationCategoryMetal.
  ///
  /// In en, this message translates to:
  /// **'Metal'**
  String get locationCategoryMetal;

  /// No description provided for @locationCategoryPaper.
  ///
  /// In en, this message translates to:
  /// **'Paper'**
  String get locationCategoryPaper;

  /// No description provided for @locationCategoryPlastic.
  ///
  /// In en, this message translates to:
  /// **'Plastic'**
  String get locationCategoryPlastic;

  /// No description provided for @locationCategoryTrash.
  ///
  /// In en, this message translates to:
  /// **'Trash'**
  String get locationCategoryTrash;

  /// No description provided for @homeWelcoming.
  ///
  /// In en, this message translates to:
  /// **'Welcome...'**
  String get homeWelcoming;

  /// No description provided for @homeWelcome.
  ///
  /// In en, this message translates to:
  /// **'Welcome, {name}'**
  String homeWelcome(String name);

  /// No description provided for @homeSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Recycle today for a cleaner tomorrow!'**
  String get homeSubtitle;

  /// No description provided for @homeTitle.
  ///
  /// In en, this message translates to:
  /// **'Welcome to ReLeaf'**
  String get homeTitle;

  /// No description provided for @homeDescription.
  ///
  /// In en, this message translates to:
  /// **'Classify waste, find recycling bins, and get recycling guidance easily.'**
  String get homeDescription;

  /// No description provided for @homeRecyclingProgress.
  ///
  /// In en, this message translates to:
  /// **'Recycling Progress'**
  String get homeRecyclingProgress;

  /// No description provided for @homePlantTap.
  ///
  /// In en, this message translates to:
  /// **'Tap to grow your plant 🌱'**
  String get homePlantTap;

  /// No description provided for @homeChatbotTip.
  ///
  /// In en, this message translates to:
  /// **'Use the chatbot if you need help knowing where an item belongs.'**
  String get homeChatbotTip;

  /// No description provided for @progressTitle.
  ///
  /// In en, this message translates to:
  /// **'Recycling Progress'**
  String get progressTitle;

  /// No description provided for @progressSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Grow your plant by recycling more!'**
  String get progressSubtitle;

  /// No description provided for @progressAddItems.
  ///
  /// In en, this message translates to:
  /// **'Add Recycled Items'**
  String get progressAddItems;

  /// No description provided for @progressAdding.
  ///
  /// In en, this message translates to:
  /// **'Adding...'**
  String get progressAdding;

  /// No description provided for @progressAddButton.
  ///
  /// In en, this message translates to:
  /// **'Add Items'**
  String get progressAddButton;

  /// No description provided for @progressMostRecycled.
  ///
  /// In en, this message translates to:
  /// **'Most Recycled Items'**
  String get progressMostRecycled;

  /// No description provided for @progressViewHistory.
  ///
  /// In en, this message translates to:
  /// **'View History'**
  String get progressViewHistory;

  /// No description provided for @progressLevel.
  ///
  /// In en, this message translates to:
  /// **'Level {level}'**
  String progressLevel(int level);

  /// No description provided for @progressNextLevel.
  ///
  /// In en, this message translates to:
  /// **'{remaining} more recycled items needed for Level {next}'**
  String progressNextLevel(int remaining, int next);

  /// No description provided for @progressMaxLevel.
  ///
  /// In en, this message translates to:
  /// **'You reached the highest level. Keep recycling!'**
  String get progressMaxLevel;

  /// No description provided for @progressRecycledCount.
  ///
  /// In en, this message translates to:
  /// **'{count} recycled'**
  String progressRecycledCount(int count);

  /// No description provided for @progressEmpty.
  ///
  /// In en, this message translates to:
  /// **'No recycled items yet. Add items above or scan from the Classify page.'**
  String get progressEmpty;

  /// No description provided for @progressSelectFirst.
  ///
  /// In en, this message translates to:
  /// **'Please select at least one item first.'**
  String get progressSelectFirst;

  /// No description provided for @progressLevelUp.
  ///
  /// In en, this message translates to:
  /// **'Level Up! Your plant grew! 🌱'**
  String get progressLevelUp;

  /// No description provided for @progressSuccess.
  ///
  /// In en, this message translates to:
  /// **'Recycled items added successfully!'**
  String get progressSuccess;

  /// No description provided for @progressFailed.
  ///
  /// In en, this message translates to:
  /// **'Could not add recycled items. Please try again.'**
  String get progressFailed;

  /// No description provided for @progressMsg1.
  ///
  /// In en, this message translates to:
  /// **'A small seed has started growing.'**
  String get progressMsg1;

  /// No description provided for @progressMsg2.
  ///
  /// In en, this message translates to:
  /// **'Your plant is sprouting.'**
  String get progressMsg2;

  /// No description provided for @progressMsg3.
  ///
  /// In en, this message translates to:
  /// **'Your first leaves are growing.'**
  String get progressMsg3;

  /// No description provided for @progressMsg4.
  ///
  /// In en, this message translates to:
  /// **'Your eco habit is getting stronger.'**
  String get progressMsg4;

  /// No description provided for @progressMsg5.
  ///
  /// In en, this message translates to:
  /// **'Your plant is becoming healthier.'**
  String get progressMsg5;

  /// No description provided for @progressMsg6.
  ///
  /// In en, this message translates to:
  /// **'Your plant is growing into a small tree.'**
  String get progressMsg6;

  /// No description provided for @progressMsg7.
  ///
  /// In en, this message translates to:
  /// **'Your tree is becoming stronger.'**
  String get progressMsg7;

  /// No description provided for @progressMsg8.
  ///
  /// In en, this message translates to:
  /// **'Your green impact is clearly growing.'**
  String get progressMsg8;

  /// No description provided for @progressMsg9.
  ///
  /// In en, this message translates to:
  /// **'You are close to becoming a recycling champion.'**
  String get progressMsg9;

  /// No description provided for @progressMsg10.
  ///
  /// In en, this message translates to:
  /// **'You are a ReLeaf recycling champion!'**
  String get progressMsg10;

  /// No description provided for @progressMsgDefault.
  ///
  /// In en, this message translates to:
  /// **'Keep recycling to grow your plant.'**
  String get progressMsgDefault;

  /// No description provided for @notificationsTitle.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get notificationsTitle;

  /// No description provided for @notificationsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Track your complaints updates'**
  String get notificationsSubtitle;

  /// No description provided for @notificationsEmpty.
  ///
  /// In en, this message translates to:
  /// **'No notifications yet.'**
  String get notificationsEmpty;

  /// No description provided for @notificationsResolved.
  ///
  /// In en, this message translates to:
  /// **'Resolved #{number}'**
  String notificationsResolved(String number);

  /// No description provided for @notificationsReceived.
  ///
  /// In en, this message translates to:
  /// **'Received #{number}'**
  String notificationsReceived(String number);

  /// No description provided for @notificationsResolvedMsg.
  ///
  /// In en, this message translates to:
  /// **'Your complaint #{number} has been resolved successfully.'**
  String notificationsResolvedMsg(String number);

  /// No description provided for @notificationsReceivedMsg.
  ///
  /// In en, this message translates to:
  /// **'Your complaint #{number} has been received successfully.'**
  String notificationsReceivedMsg(String number);

  /// No description provided for @notificationsAdminReply.
  ///
  /// In en, this message translates to:
  /// **'Admin: {reply}'**
  String notificationsAdminReply(String reply);

  /// No description provided for @progressItemPlastic.
  ///
  /// In en, this message translates to:
  /// **'Plastic'**
  String get progressItemPlastic;

  /// No description provided for @progressItemGlass.
  ///
  /// In en, this message translates to:
  /// **'Glass'**
  String get progressItemGlass;

  /// No description provided for @progressItemPaper.
  ///
  /// In en, this message translates to:
  /// **'Paper'**
  String get progressItemPaper;

  /// No description provided for @progressItemMetal.
  ///
  /// In en, this message translates to:
  /// **'Metal'**
  String get progressItemMetal;

  /// No description provided for @progressItemCardboard.
  ///
  /// In en, this message translates to:
  /// **'Cardboard'**
  String get progressItemCardboard;

  /// No description provided for @progressItemTrash.
  ///
  /// In en, this message translates to:
  /// **'Trash (non-recyclables)'**
  String get progressItemTrash;

  /// No description provided for @adminMyAccount.
  ///
  /// In en, this message translates to:
  /// **'My Account'**
  String get adminMyAccount;

  /// No description provided for @adminAccount.
  ///
  /// In en, this message translates to:
  /// **'Account'**
  String get adminAccount;

  /// No description provided for @adminSettings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get adminSettings;

  /// No description provided for @adminSupport.
  ///
  /// In en, this message translates to:
  /// **'Support'**
  String get adminSupport;

  /// No description provided for @adminEditProfile.
  ///
  /// In en, this message translates to:
  /// **'Edit Profile'**
  String get adminEditProfile;

  /// No description provided for @adminChangePassword.
  ///
  /// In en, this message translates to:
  /// **'Change Password'**
  String get adminChangePassword;

  /// No description provided for @adminDarkMode.
  ///
  /// In en, this message translates to:
  /// **'Dark Mode'**
  String get adminDarkMode;

  /// No description provided for @adminLanguage.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get adminLanguage;

  /// No description provided for @adminAboutReLeaf.
  ///
  /// In en, this message translates to:
  /// **'About ReLeaf'**
  String get adminAboutReLeaf;

  /// No description provided for @adminLogout.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get adminLogout;

  /// No description provided for @adminAboutSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Smart waste sorting and recycling assistant'**
  String get adminAboutSubtitle;

  /// No description provided for @adminVersion.
  ///
  /// In en, this message translates to:
  /// **'Version 1.0.0'**
  String get adminVersion;

  /// No description provided for @adminWhatTitle.
  ///
  /// In en, this message translates to:
  /// **'What is ReLeaf?'**
  String get adminWhatTitle;

  /// No description provided for @adminWhatText.
  ///
  /// In en, this message translates to:
  /// **'ReLeaf is a smart recycling application that helps users classify waste, find recycling bins, and get guidance for proper waste sorting.'**
  String get adminWhatText;

  /// No description provided for @adminFeaturesTitle.
  ///
  /// In en, this message translates to:
  /// **'Main Features'**
  String get adminFeaturesTitle;

  /// No description provided for @adminFeaturesText.
  ///
  /// In en, this message translates to:
  /// **'The app includes waste image classification, recycling bin locations, chatbot assistance, issue reporting, and user progress tracking.'**
  String get adminFeaturesText;

  /// No description provided for @adminRoleTitle.
  ///
  /// In en, this message translates to:
  /// **'Admin Role'**
  String get adminRoleTitle;

  /// No description provided for @adminRoleText.
  ///
  /// In en, this message translates to:
  /// **'Admins can manage users, recycling bins, reported issues, and review app activity to keep the system organized and reliable.'**
  String get adminRoleText;

  /// No description provided for @adminGoalTitle.
  ///
  /// In en, this message translates to:
  /// **'Project Goal'**
  String get adminGoalTitle;

  /// No description provided for @adminGoalText.
  ///
  /// In en, this message translates to:
  /// **'The goal of ReLeaf is to support sustainable recycling behavior by making waste sorting easier, faster, and more accessible.'**
  String get adminGoalText;

  /// No description provided for @adminBins.
  ///
  /// In en, this message translates to:
  /// **'Bins'**
  String get adminBins;

  /// No description provided for @adminActive.
  ///
  /// In en, this message translates to:
  /// **'Active'**
  String get adminActive;

  /// No description provided for @adminInactive.
  ///
  /// In en, this message translates to:
  /// **'Inactive'**
  String get adminInactive;

  /// No description provided for @adminActiveBins.
  ///
  /// In en, this message translates to:
  /// **'Active Bins'**
  String get adminActiveBins;

  /// No description provided for @adminInactiveBins.
  ///
  /// In en, this message translates to:
  /// **'Inactive Bins'**
  String get adminInactiveBins;

  /// No description provided for @adminAll.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get adminAll;

  /// No description provided for @adminPlastic.
  ///
  /// In en, this message translates to:
  /// **'Plastic'**
  String get adminPlastic;

  /// No description provided for @adminPaper.
  ///
  /// In en, this message translates to:
  /// **'Paper'**
  String get adminPaper;

  /// No description provided for @adminMetal.
  ///
  /// In en, this message translates to:
  /// **'Metal'**
  String get adminMetal;

  /// No description provided for @adminGlass.
  ///
  /// In en, this message translates to:
  /// **'Glass'**
  String get adminGlass;

  /// No description provided for @adminCardboard.
  ///
  /// In en, this message translates to:
  /// **'Cardboard'**
  String get adminCardboard;

  /// No description provided for @adminTrash.
  ///
  /// In en, this message translates to:
  /// **'Trash'**
  String get adminTrash;

  /// No description provided for @adminDeleteBin.
  ///
  /// In en, this message translates to:
  /// **'Delete Bin'**
  String get adminDeleteBin;

  /// No description provided for @adminDeleteBinQuestion.
  ///
  /// In en, this message translates to:
  /// **'Delete \"{binName}\"?'**
  String adminDeleteBinQuestion(String binName);

  /// No description provided for @adminBinDeletedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Bin deleted successfully'**
  String get adminBinDeletedSuccessfully;

  /// No description provided for @adminFailedToLoadBins.
  ///
  /// In en, this message translates to:
  /// **'Failed to load bins'**
  String get adminFailedToLoadBins;

  /// No description provided for @adminNoActiveBinsFound.
  ///
  /// In en, this message translates to:
  /// **'No active bins found'**
  String get adminNoActiveBinsFound;

  /// No description provided for @adminNoInactiveBinsFound.
  ///
  /// In en, this message translates to:
  /// **'No inactive bins found'**
  String get adminNoInactiveBinsFound;

  /// No description provided for @adminRecyclingBin.
  ///
  /// In en, this message translates to:
  /// **'Recycling Bin'**
  String get adminRecyclingBin;

  /// No description provided for @adminUnknown.
  ///
  /// In en, this message translates to:
  /// **'Unknown'**
  String get adminUnknown;

  /// No description provided for @adminEditBin.
  ///
  /// In en, this message translates to:
  /// **'Edit Bin'**
  String get adminEditBin;

  /// No description provided for @adminAddBin.
  ///
  /// In en, this message translates to:
  /// **'Add Bin'**
  String get adminAddBin;

  /// No description provided for @adminBinName.
  ///
  /// In en, this message translates to:
  /// **'Bin Name'**
  String get adminBinName;

  /// No description provided for @adminGovernorate.
  ///
  /// In en, this message translates to:
  /// **'Governorate'**
  String get adminGovernorate;

  /// No description provided for @adminDistrict.
  ///
  /// In en, this message translates to:
  /// **'District'**
  String get adminDistrict;

  /// No description provided for @adminBinType.
  ///
  /// In en, this message translates to:
  /// **'Bin Type'**
  String get adminBinType;

  /// No description provided for @adminBinStatus.
  ///
  /// In en, this message translates to:
  /// **'Bin Status'**
  String get adminBinStatus;

  /// No description provided for @adminSelectLocation.
  ///
  /// In en, this message translates to:
  /// **'Select Location'**
  String get adminSelectLocation;

  /// No description provided for @adminDescriptionAddress.
  ///
  /// In en, this message translates to:
  /// **'Description / Address'**
  String get adminDescriptionAddress;

  /// No description provided for @adminPleaseFillAllFields.
  ///
  /// In en, this message translates to:
  /// **'Please fill all fields'**
  String get adminPleaseFillAllFields;

  /// No description provided for @adminLocationSearchFailed.
  ///
  /// In en, this message translates to:
  /// **'Location search failed: {error}'**
  String adminLocationSearchFailed(String error);

  /// No description provided for @adminSaveChanges.
  ///
  /// In en, this message translates to:
  /// **'Save Changes'**
  String get adminSaveChanges;

  /// No description provided for @adminSearchLocation.
  ///
  /// In en, this message translates to:
  /// **'Search Location'**
  String get adminSearchLocation;

  /// No description provided for @adminNearbyLocations.
  ///
  /// In en, this message translates to:
  /// **'Nearby Locations'**
  String get adminNearbyLocations;

  /// No description provided for @adminNoLocationsFound.
  ///
  /// In en, this message translates to:
  /// **'No locations found'**
  String get adminNoLocationsFound;

  /// No description provided for @adminCategoryBinsTitle.
  ///
  /// In en, this message translates to:
  /// **'{category} Bins'**
  String adminCategoryBinsTitle(String category);

  /// No description provided for @adminIssues.
  ///
  /// In en, this message translates to:
  /// **'Complaints'**
  String get adminIssues;

  /// No description provided for @adminDirectReporting.
  ///
  /// In en, this message translates to:
  /// **'Direct Reporting'**
  String get adminDirectReporting;

  /// No description provided for @adminReviewIssueReports.
  ///
  /// In en, this message translates to:
  /// **'Review user complaints'**
  String get adminReviewIssueReports;

  /// No description provided for @adminUnread.
  ///
  /// In en, this message translates to:
  /// **'Unread'**
  String get adminUnread;

  /// No description provided for @adminRead.
  ///
  /// In en, this message translates to:
  /// **'Read'**
  String get adminRead;

  /// No description provided for @adminFixed.
  ///
  /// In en, this message translates to:
  /// **'Fixed'**
  String get adminFixed;

  /// No description provided for @adminAddAdminComment.
  ///
  /// In en, this message translates to:
  /// **'Add admin comment...'**
  String get adminAddAdminComment;

  /// No description provided for @adminIssueUpdateSaved.
  ///
  /// In en, this message translates to:
  /// **'Complaint update saved'**
  String get adminIssueUpdateSaved;

  /// No description provided for @adminFailedToLoadIssueReports.
  ///
  /// In en, this message translates to:
  /// **'Failed to load complaints'**
  String get adminFailedToLoadIssueReports;

  /// No description provided for @adminNoIssueReportsFound.
  ///
  /// In en, this message translates to:
  /// **'No complaints found'**
  String get adminNoIssueReportsFound;

  /// No description provided for @adminHomeDashboardTitle.
  ///
  /// In en, this message translates to:
  /// **'Dashboard'**
  String get adminHomeDashboardTitle;

  /// No description provided for @adminHomeUsersLabel.
  ///
  /// In en, this message translates to:
  /// **'Users'**
  String get adminHomeUsersLabel;

  /// No description provided for @adminHomeUsersActivityTitle.
  ///
  /// In en, this message translates to:
  /// **'Users Activity'**
  String get adminHomeUsersActivityTitle;

  /// No description provided for @adminHomeUsersOverviewSubtitle.
  ///
  /// In en, this message translates to:
  /// **'A quick overview of active and blocked users.'**
  String get adminHomeUsersOverviewSubtitle;

  /// No description provided for @adminHomeActiveUsersLabel.
  ///
  /// In en, this message translates to:
  /// **'Active Users'**
  String get adminHomeActiveUsersLabel;

  /// No description provided for @adminHomeBlockedUsersLabel.
  ///
  /// In en, this message translates to:
  /// **'Blocked Users'**
  String get adminHomeBlockedUsersLabel;

  /// No description provided for @adminHomeTotalUsersCard.
  ///
  /// In en, this message translates to:
  /// **'Total Users'**
  String get adminHomeTotalUsersCard;

  /// No description provided for @adminHomeTotalBinsCard.
  ///
  /// In en, this message translates to:
  /// **'Total Bins'**
  String get adminHomeTotalBinsCard;

  /// No description provided for @adminHomeReportedIssuesCard.
  ///
  /// In en, this message translates to:
  /// **'Reported Issues'**
  String get adminHomeReportedIssuesCard;

  /// No description provided for @adminHomeWelcomeLoading.
  ///
  /// In en, this message translates to:
  /// **'Welcome...'**
  String get adminHomeWelcomeLoading;

  /// No description provided for @adminHomeWelcomeAdmin.
  ///
  /// In en, this message translates to:
  /// **'Welcome, {name}'**
  String adminHomeWelcomeAdmin(String name);

  /// No description provided for @adminHomeAllUsersFilter.
  ///
  /// In en, this message translates to:
  /// **'All Users'**
  String get adminHomeAllUsersFilter;

  /// No description provided for @adminHomeActiveFilter.
  ///
  /// In en, this message translates to:
  /// **'Active'**
  String get adminHomeActiveFilter;

  /// No description provided for @adminNotificationOverlayTitle.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get adminNotificationOverlayTitle;

  /// No description provided for @adminNotificationNoReports.
  ///
  /// In en, this message translates to:
  /// **'No new reports'**
  String get adminNotificationNoReports;

  /// No description provided for @adminNotificationNewReportsCount.
  ///
  /// In en, this message translates to:
  /// **'You have {count} new report(s)'**
  String adminNotificationNewReportsCount(int count);

  /// No description provided for @adminNotificationEmpty.
  ///
  /// In en, this message translates to:
  /// **'No notifications yet'**
  String get adminNotificationEmpty;

  /// No description provided for @adminNotificationFromUser.
  ///
  /// In en, this message translates to:
  /// **'From: {name}'**
  String adminNotificationFromUser(String name);

  /// No description provided for @adminNotificationDefaultReport.
  ///
  /// In en, this message translates to:
  /// **'New report'**
  String get adminNotificationDefaultReport;

  /// No description provided for @adminNotificationPendingStatus.
  ///
  /// In en, this message translates to:
  /// **'Pending'**
  String get adminNotificationPendingStatus;

  /// No description provided for @adminNotificationNoDetails.
  ///
  /// In en, this message translates to:
  /// **'No additional details provided'**
  String get adminNotificationNoDetails;

  /// No description provided for @adminUsersManagementTitle.
  ///
  /// In en, this message translates to:
  /// **'Users Management'**
  String get adminUsersManagementTitle;

  /// No description provided for @adminUsersSearchHint.
  ///
  /// In en, this message translates to:
  /// **'Search User'**
  String get adminUsersSearchHint;

  /// No description provided for @adminUsersFilterLabel.
  ///
  /// In en, this message translates to:
  /// **'Filter: {filter}'**
  String adminUsersFilterLabel(String filter);

  /// No description provided for @adminUsersAllFilter.
  ///
  /// In en, this message translates to:
  /// **'All Users'**
  String get adminUsersAllFilter;

  /// No description provided for @adminUsersActiveFilter.
  ///
  /// In en, this message translates to:
  /// **'Active'**
  String get adminUsersActiveFilter;

  /// No description provided for @adminUsersBlockedFilter.
  ///
  /// In en, this message translates to:
  /// **'Blocked'**
  String get adminUsersBlockedFilter;

  /// No description provided for @adminUsersNoUsersFound.
  ///
  /// In en, this message translates to:
  /// **'No users found'**
  String get adminUsersNoUsersFound;

  /// No description provided for @adminUsersFailedFetch.
  ///
  /// In en, this message translates to:
  /// **'Failed to fetch users: {error}'**
  String adminUsersFailedFetch(String error);

  /// No description provided for @adminEditUserTitle.
  ///
  /// In en, this message translates to:
  /// **'Edit User'**
  String get adminEditUserTitle;

  /// No description provided for @adminEditUserProfile.
  ///
  /// In en, this message translates to:
  /// **'User Profile'**
  String get adminEditUserProfile;

  /// No description provided for @adminEditUserFirstName.
  ///
  /// In en, this message translates to:
  /// **'First name'**
  String get adminEditUserFirstName;

  /// No description provided for @adminEditUserSecondName.
  ///
  /// In en, this message translates to:
  /// **'Second name'**
  String get adminEditUserSecondName;

  /// No description provided for @adminEditUserUsername.
  ///
  /// In en, this message translates to:
  /// **'Username'**
  String get adminEditUserUsername;

  /// No description provided for @adminEditUserEmail.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get adminEditUserEmail;

  /// No description provided for @adminEditUserSave.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get adminEditUserSave;

  /// No description provided for @adminEditUserBlock.
  ///
  /// In en, this message translates to:
  /// **'Block'**
  String get adminEditUserBlock;

  /// No description provided for @adminEditUserUnblock.
  ///
  /// In en, this message translates to:
  /// **'Unblock'**
  String get adminEditUserUnblock;

  /// No description provided for @adminEditUserConfirmAction.
  ///
  /// In en, this message translates to:
  /// **'Confirm Action'**
  String get adminEditUserConfirmAction;

  /// No description provided for @adminEditUserConfirm.
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get adminEditUserConfirm;

  /// No description provided for @adminEditUserIdNotFound.
  ///
  /// In en, this message translates to:
  /// **'User ID not found'**
  String get adminEditUserIdNotFound;

  /// No description provided for @adminEditUserRequiredFields.
  ///
  /// In en, this message translates to:
  /// **'First name and email are required'**
  String get adminEditUserRequiredFields;

  /// No description provided for @adminEditUserUpdated.
  ///
  /// In en, this message translates to:
  /// **'User updated successfully'**
  String get adminEditUserUpdated;

  /// No description provided for @adminEditUserFailedUpdate.
  ///
  /// In en, this message translates to:
  /// **'Failed to update user: {error}'**
  String adminEditUserFailedUpdate(String error);

  /// No description provided for @adminEditUserConfirmBlock.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to {action} {name}?'**
  String adminEditUserConfirmBlock(String action, String name);

  /// No description provided for @adminEditUserThisUser.
  ///
  /// In en, this message translates to:
  /// **'this user'**
  String get adminEditUserThisUser;

  /// No description provided for @adminEditUserBlockAction.
  ///
  /// In en, this message translates to:
  /// **'block'**
  String get adminEditUserBlockAction;

  /// No description provided for @adminEditUserUnblockAction.
  ///
  /// In en, this message translates to:
  /// **'unblock'**
  String get adminEditUserUnblockAction;

  /// No description provided for @adminEditUserBlockedMsg.
  ///
  /// In en, this message translates to:
  /// **'User has been blocked'**
  String get adminEditUserBlockedMsg;

  /// No description provided for @adminEditUserUnblockedMsg.
  ///
  /// In en, this message translates to:
  /// **'User has been unblocked'**
  String get adminEditUserUnblockedMsg;

  /// No description provided for @adminEditUserFailedStatus.
  ///
  /// In en, this message translates to:
  /// **'Failed to update user status: {error}'**
  String adminEditUserFailedStatus(String error);

  /// No description provided for @incorrectClassificationResult.
  ///
  /// In en, this message translates to:
  /// **'Incorrect classification result'**
  String get incorrectClassificationResult;

  /// No description provided for @appCrashOrFeatureNotWorking.
  ///
  /// In en, this message translates to:
  /// **'App crash or feature not working'**
  String get appCrashOrFeatureNotWorking;

  /// No description provided for @wrongChatbotResponse.
  ///
  /// In en, this message translates to:
  /// **'Wrong chatbot response'**
  String get wrongChatbotResponse;

  /// No description provided for @read.
  ///
  /// In en, this message translates to:
  /// **'Read'**
  String get read;

  /// No description provided for @unread.
  ///
  /// In en, this message translates to:
  /// **'Unread'**
  String get unread;

  /// No description provided for @resolved.
  ///
  /// In en, this message translates to:
  /// **'Resolved'**
  String get resolved;

  /// No description provided for @adminNavHome.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get adminNavHome;

  /// No description provided for @adminNavUsers.
  ///
  /// In en, this message translates to:
  /// **'Users'**
  String get adminNavUsers;

  /// No description provided for @adminNavBins.
  ///
  /// In en, this message translates to:
  /// **'Bins'**
  String get adminNavBins;

  /// No description provided for @adminNavIssues.
  ///
  /// In en, this message translates to:
  /// **'Issues'**
  String get adminNavIssues;

  /// No description provided for @adminNavProfile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get adminNavProfile;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
