import 'dart:developer';

import 'package:android_native/content/ComponentName.dart';
import 'package:android_native/content/Context.dart';
import 'package:android_native/os/Bundle.dart';

import '../media/AudioManager.dart';

class Intent {
  ///  Activity Action: Start as a main entry point, does not expect to
  ///  receive data.
  ///  <p>Input: nothing
  ///  <p>Output: nothing
  static const String ACTION_MAIN = 'android.intent.action.MAIN';

  /// Activity Action: Display the data to the user.  This is the most common
  /// action performed on data -- it is the generic action you can use on
  /// a piece of data to get the most reasonable thing to occur.  For example,
  /// when used on a contacts entry it will view the entry; when used on a
  /// mailto: URI it will bring up a compose window filled with the information
  /// supplied by the URI; when used with a tel: URI it will invoke the
  /// dialer.
  /// <p>Input: {@link #getData} is URI from which to retrieve data.
  /// <p>Output: nothing.
  static const String ACTION_VIEW = 'android.intent.action.VIEW';

  /// A synonym for {@link #ACTION_VIEW}, the 'standard' action that is
  /// performed on a piece of data.
  static const String ACTION_DEFAULT = ACTION_VIEW;

  /// Activity Action: Quick view the data. Launches a quick viewer for
  /// a URI or a list of URIs.
  /// <p>Activities handling this intent action should handle the vast majority of
  /// MIME types rather than only specific ones.
  /// <p>Quick viewers must render the quick view image locally, and must not send
  /// file content outside current device.
  /// <p>Input: {@link #getData} is a mandatory content URI of the item to
  /// preview. {@link #getClipData} contains an optional list of content URIs
  /// if there is more than one item to preview. {@link #EXTRA_INDEX} is an
  /// optional index of the URI in the clip data to show first.
  /// {@link #EXTRA_QUICK_VIEW_FEATURES} is an optional extra indicating the features
  /// that can be shown in the quick view UI.
  /// <p>Output: nothing.
  /// @see #EXTRA_INDEX
  /// @see #EXTRA_QUICK_VIEW_FEATURES
  static const String ACTION_QUICK_VIEW = 'android.intent.action.QUICK_VIEW';

  /// Used to indicate that some piece of data should be attached to some other
  /// place.  For example, image data could be attached to a contact.  It is up
  /// to the recipient to decide where the data should be attached; the intent
  /// does not specify the ultimate destination.
  /// <p>Input: {@link #getData} is URI of data to be attached.
  /// <p>Output: nothing.
  static const String ACTION_ATTACH_DATA = 'android.intent.action.ATTACH_DATA';

  /// Activity Action: Provide explicit editable access to the given data.
  /// <p>Input: {@link #getData} is URI of data to be edited.
  /// <p>Output: nothing.
  static const String ACTION_EDIT = 'android.intent.action.EDIT';

  /// Activity Action: Pick an existing item, or insert a new item, and then edit it.
  /// <p>Input: {@link #getType} is the desired MIME type of the item to create or edit.
  /// The extras can contain type specific data to pass through to the editing/creating
  /// activity.
  /// <p>Output: The URI of the item that was picked.  This must be a content:
  /// URI so that any receiver can access it.
  static const String ACTION_INSERT_OR_EDIT =
      'android.intent.action.INSERT_OR_EDIT';

  /// Activity Action: Pick an item from the data, returning what was selected.
  /// <p>Input: {@link #getData} is URI containing a directory of data
  /// (vnd.android.cursor.dir/*) from which to pick an item.
  /// <p>Output: The URI of the item that was picked.

  static const String ACTION_PICK = 'android.intent.action.PICK';

  /// Activity Action: Creates a reminder.
  /// <p>Input: {@link #EXTRA_TITLE} The title of the reminder that will be shown to the user.
  /// {@link #EXTRA_TEXT} The reminder text that will be shown to the user. The intent should at
  /// least specify a title or a text. {@link #EXTRA_TIME} The time when the reminder will be shown
  /// to the user. The time is specified in milliseconds since the Epoch (optional).
  /// </p>
  /// <p>Output: Nothing.</p>
  ///
  /// @see #EXTRA_TITLE
  /// @see #EXTRA_TEXT
  /// @see #EXTRA_TIME
  static const String ACTION_CREATE_REMINDER =
      'android.intent.action.CREATE_REMINDER';

  /// Activity Action: Creates a shortcut.
  /// <p>Input: Nothing.</p>
  /// <p>Output: An Intent representing the {@link android.content.pm.ShortcutInfo} result.</p>
  /// <p>For compatibility with older versions of android the intent may also contain three
  /// extras: SHORTCUT_INTENT (value: Intent), SHORTCUT_NAME (value: String),
  /// and SHORTCUT_ICON (value: Bitmap) or SHORTCUT_ICON_RESOURCE
  /// (value: ShortcutIconResource).</p>
  ///
  /// @see android.content.pm.ShortcutManager#createShortcutResultIntent
  /// @see #EXTRA_SHORTCUT_INTENT
  /// @see #EXTRA_SHORTCUT_NAME
  /// @see #EXTRA_SHORTCUT_ICON
  /// @see #EXTRA_SHORTCUT_ICON_RESOURCE
  /// @see android.content.Intent.ShortcutIconResource
  static const String ACTION_CREATE_SHORTCUT =
      'android.intent.action.CREATE_SHORTCUT';

  /// An activity that provides a user interface for adjusting application preferences.
  /// Optional but recommended settings for all applications which have settings.
  static const String ACTION_APPLICATION_PREFERENCES =
      "android.intent.action.APPLICATION_PREFERENCES";

  /// Activity Action: Launch an activity showing the app information.
  /// For applications which install other applications (such as app stores), it is recommended
  /// to handle this action for providing the app information to the user.
  ///
  /// <p>Input: {@link #EXTRA_PACKAGE_NAME} specifies the package whose information needs
  /// to be displayed.
  /// <p>Output: Nothing.

  static const String ACTION_SHOW_APP_INFO =
      "android.intent.action.SHOW_APP_INFO";

  /// Activity Action: Display an activity chooser, allowing the user to pick
  /// what they want to before proceeding.  This can be used as an alternative
  /// to the standard activity picker that is displayed by the system when
  /// you try to start an activity with multiple possible matches, with these
  /// differences in behavior:
  /// <ul>
  /// <li>You can specify the title that will appear in the activity chooser.
  /// <li>The user does not have the option to make one of the matching
  /// activities a preferred activity, and all possible activities will
  /// always be shown even if one of them is currently marked as the
  /// preferred activity.
  /// </ul>
  /// <p>
  /// This action should be used when the user will naturally expect to
  /// select an activity in order to proceed.  An example if when not to use
  /// it is when the user clicks on a "mailto:" link.  They would naturally
  /// expect to go directly to their mail app, so startActivity() should be
  /// called directly: it will
  /// either launch the current preferred app, or put up a dialog allowing the
  /// user to pick an app to use and optionally marking that as preferred.
  /// <p>
  /// In contrast, if the user is selecting a menu item to send a picture
  /// they are viewing to someone else, there are many different things they
  /// may want to do at this point: send it through e-mail, upload it to a
  /// web service, etc.  In this case the CHOOSER action should be used, to
  /// always present to the user a list of the things they can do, with a
  /// nice title given by the caller such as "Send this photo with:".
  /// <p>
  /// If you need to grant URI permissions through a chooser, you must specify
  /// the permissions to be granted on the ACTION_CHOOSER Intent
  /// <em>in addition</em> to the EXTRA_INTENT inside.  This means using
  /// {@link #setClipData} to specify the URIs to be granted as well as
  /// {@link #FLAG_GRANT_READ_URI_PERMISSION} and/or
  /// {@link #FLAG_GRANT_WRITE_URI_PERMISSION} as appropriate.
  /// <p>
  /// As a convenience, an Intent of this form can be created with the
  /// {@link #createChooser} function.
  /// <p>
  /// Input: No data should be specified.  get*Extra must have
  /// a {@link #EXTRA_INTENT} field containing the Intent being executed,
  /// and can optionally have a {@link #EXTRA_TITLE} field containing the
  /// title text to display in the chooser.
  /// <p>
  /// Output: Depends on the protocol of {@link #EXTRA_INTENT}.

  static const String ACTION_CHOOSER = "android.intent.action.CHOOSER";

  /// Activity Action: Allow the user to select a particular kind of data and
  /// return it.  This is different than {@link #ACTION_PICK} in that here we
  /// just say what kind of data is desired, not a URI of existing data from
  /// which the user can pick.  An ACTION_GET_CONTENT could allow the user to
  /// create the data as it runs (for example taking a picture or recording a
  /// sound), let them browse over the web and download the desired data,
  /// etc.
  /// <p>
  /// There are two main ways to use this action: if you want a specific kind
  /// of data, such as a person contact, you set the MIME type to the kind of
  /// data you want and launch it with {@link Context#startActivity(Intent)}.
  /// The system will then launch the best application to select that kind
  /// of data for you.
  /// <p>
  /// You may also be interested in any of a set of types of content the user
  /// can pick.  For example, an e-mail application that wants to allow the
  /// user to add an attachment to an e-mail message can use this action to
  /// bring up a list of all of the types of content the user can attach.
  /// <p>
  /// In this case, you should wrap the GET_CONTENT intent with a chooser
  /// (through {@link #createChooser}), which will give the proper interface
  /// for the user to pick how to send your data and allow you to specify
  /// a prompt indicating what they are doing.  You will usually specify a
  /// broad MIME type (such as "image/* or {@literal *}/* */), resulting in a
  /// broad range of content types the user can select from.
  /// <p>
  /// When using such a broad GET_CONTENT action, it is often desirable to
  /// only pick from data that can be represented as a stream.  This is
  /// accomplished by requiring the {@link #CATEGORY_OPENABLE} in the Intent.
  /// <p>
  /// Callers can optionally specify {@link #EXTRA_LOCAL_ONLY} to request that
  /// the launched content chooser only returns results representing data that
  /// is locally available on the device.  For example, if this extra is set
  /// to true then an image picker should not show any pictures that are available
  /// from a remote server but not already on the local device (thus requiring
  /// they be downloaded when opened).
  /// <p>
  /// If the caller can handle multiple returned items (the user performing
  /// multiple selection), then it can specify {@link #EXTRA_ALLOW_MULTIPLE}
  /// to indicate this.
  /// <p>
  /// Input: {@link #getType} is the desired MIME type to retrieve.  Note
  /// that no URI is supplied in the intent, as there are no constraints on
  /// where the returned data originally comes from.  You may also include the
  /// {@link #CATEGORY_OPENABLE} if you can only accept data that can be
  /// opened as a stream.  You may use {@link #EXTRA_LOCAL_ONLY} to limit content
  /// selection to local data.  You may use {@link #EXTRA_ALLOW_MULTIPLE} to
  /// allow the user to select multiple items.
  /// <p>
  /// Output: The URI of the item that was picked.  This must be a content:
  /// URI so that any receiver can access it.
  static const String ACTION_GET_CONTENT = "android.intent.action.GET_CONTENT";

  /// Activity Action: Dial a number as specified by the data.  This shows a
  /// UI with the number being dialed, allowing the user to explicitly
  /// initiate the call.
  /// <p>Input: If nothing, an empty dialer is started; else {@link #getData}
  /// is URI of a phone number to be dialed or a tel: URI of an explicit phone
  /// number.
  /// <p>Output: nothing.
  static const String ACTION_DIAL = "android.intent.action.DIAL";

  /// Activity Action: Perform a call to someone specified by the data.
  /// <p>Input: If nothing, an empty dialer is started; else {@link #getData}
  /// is URI of a phone number to be dialed or a tel: URI of an explicit phone
  /// number.
  /// <p>Output: nothing.
  ///
  /// <p>Note: there will be restrictions on which applications can initiate a
  /// call; most applications should use the {@link #ACTION_DIAL}.
  /// <p>Note: this Intent <strong>cannot</strong> be used to call emergency
  /// numbers.  Applications can <strong>dial</strong> emergency numbers using
  /// {@link #ACTION_DIAL}, however.
  ///
  /// <p>Note: if you app targets {@link android.os.Build.VERSION_CODES#M M}
  /// and above and declares as using the {@link android.Manifest.permission#CALL_PHONE}
  /// permission which is not granted, then attempting to use this action will
  /// result in a {@link java.lang.SecurityException}.

  static const String ACTION_CALL = "android.intent.action.CALL";

  /// Activity Action: Perform a call to an emergency number specified by the
  /// data.
  /// <p>Input: {@link #getData} is URI of a phone number to be dialed or a
  /// tel: URI of an explicit phone number.
  /// <p>Output: nothing.
  ///
  /// <p class="note"><strong>Note:</strong> It is not guaranteed that the call will be placed on
  /// the {@link PhoneAccount} provided in the {@link TelecomManager#EXTRA_PHONE_ACCOUNT_HANDLE}
  /// extra (if specified) and may be placed on another {@link PhoneAccount} with the
  /// {@link PhoneAccount#CAPABILITY_PLACE_EMERGENCY_CALLS} capability, depending on external
  /// factors, such as network conditions and Modem/SIM status.
  static const String ACTION_CALL_EMERGENCY =
      "android.intent.action.CALL_EMERGENCY";

  /// Activity Action: Dial a emergency number specified by the data.  This shows a
  /// UI with the number being dialed, allowing the user to explicitly
  /// initiate the call.
  /// <p>Input: If nothing, an empty emergency dialer is started; else {@link #getData}
  /// is a tel: URI of an explicit emergency phone number.
  /// <p>Output: nothing.
  /// @hide
  static const String ACTION_DIAL_EMERGENCY =
      "android.intent.action.DIAL_EMERGENCY";

  /// Activity action: Perform a call to any number (emergency or not)
  /// specified by the data.
  /// <p>Input: {@link #getData} is URI of a phone number to be dialed or a
  /// tel: URI of an explicit phone number.
  /// <p>Output: nothing.
  /// @hide
  static const String ACTION_CALL_PRIVILEGED =
      "android.intent.action.CALL_PRIVILEGED";

  /// Activity Action: Main entry point for carrier setup apps.
  /// <p>Carrier apps that provide an implementation for this action may be invoked to configure
  /// carrier service and typically require
  /// {@link android.telephony.TelephonyManager#hasCarrierPrivileges() carrier privileges} to
  /// fulfill their duties.
  static const String ACTION_CARRIER_SETUP =
      "android.intent.action.CARRIER_SETUP";

  /// Activity Action: Send a message to someone specified by the data.
  /// <p>Input: {@link #getData} is URI describing the target.
  /// <p>Output: nothing.
  static const String ACTION_SENDTO = "android.intent.action.SENDTO";

  /// Activity Action: Deliver some data to someone else.  Who the data is
  /// being delivered to is not specified; it is up to the receiver of this
  /// action to ask the user where the data should be sent.
  /// <p>
  /// When launching a SEND intent, you should usually wrap it in a chooser
  /// (through {@link #createChooser}), which will give the proper interface
  /// for the user to pick how to send your data and allow you to specify
  /// a prompt indicating what they are doing.
  /// <p>
  /// Input: {@link #getType} is the MIME type of the data being sent.
  /// get*Extra can have either a {@link #EXTRA_TEXT}
  /// or {@link #EXTRA_STREAM} field, containing the data to be sent.  If
  /// using EXTRA_TEXT, the MIME type should be "text/plain"; otherwise it
  /// should be the MIME type of the data in EXTRA_STREAM.  Use {@literal *}/*
  /// if the MIME type is unknown (this will only allow senders that can
  /// handle generic data streams).  If using {@link #EXTRA_TEXT}, you can
  /// also optionally supply {@link #EXTRA_HTML_TEXT} for clients to retrieve
  /// your text with HTML formatting.
  /// <p>
  /// As of {@link android.os.Build.VERSION_CODES#JELLY_BEAN}, the data
  /// being sent can be supplied through {@link #setClipData(ClipData)}.  This
  /// allows you to use {@link #FLAG_GRANT_READ_URI_PERMISSION} when sharing
  /// content: URIs and other advanced features of {@link ClipData}.  If
  /// using this approach, you still must supply the same data through the
  /// {@link #EXTRA_TEXT} or {@link #EXTRA_STREAM} fields described below
  /// for compatibility with old applications.  If you don't set a ClipData,
  /// it will be copied there for you when calling {@link Context#startActivity(Intent)}.
  /// <p>
  /// Starting from {@link android.os.Build.VERSION_CODES#O}, if
  /// {@link #CATEGORY_TYPED_OPENABLE} is passed, then the Uris passed in
  /// either {@link #EXTRA_STREAM} or via {@link #setClipData(ClipData)} may
  /// be openable only as asset typed files using
  /// {@link ContentResolver#openTypedAssetFileDescriptor(Uri, String, Bundle)}.
  /// <p>
  /// Optional standard extras, which may be interpreted by some recipients as
  /// appropriate, are: {@link #EXTRA_EMAIL}, {@link #EXTRA_CC},
  /// {@link #EXTRA_BCC}, {@link #EXTRA_SUBJECT}.
  /// <p>
  /// Output: nothing.
  static const String ACTION_SEND = "android.intent.action.SEND";

  /// Activity Action: Deliver multiple data to someone else.
  /// <p>
  /// Like {@link #ACTION_SEND}, except the data is multiple.
  /// <p>
  /// Input: {@link #getType} is the MIME type of the data being sent.
  /// get*ArrayListExtra can have either a {@link #EXTRA_TEXT} or {@link
  /// #EXTRA_STREAM} field, containing the data to be sent.  If using
  /// {@link #EXTRA_TEXT}, you can also optionally supply {@link #EXTRA_HTML_TEXT}
  /// for clients to retrieve your text with HTML formatting.
  /// <p>
  /// Multiple types are supported, and receivers should handle mixed types
  /// whenever possible. The right way for the receiver to check them is to
  /// use the content resolver on each URI. The intent sender should try to
  /// put the most concrete mime type in the intent type, but it can fall
  /// back to {@literal <type>/*} or {@literal *}/* as needed.
  /// <p>
  /// e.g. if you are sending image/jpg and image/jpg, the intent's type can
  /// be image/jpg, but if you are sending image/jpg and image/png, then the
  /// intent's type should be image/*.
  /// <p>
  /// As of {@link android.os.Build.VERSION_CODES#JELLY_BEAN}, the data
  /// being sent can be supplied through {@link #setClipData(ClipData)}.  This
  /// allows you to use {@link #FLAG_GRANT_READ_URI_PERMISSION} when sharing
  /// content: URIs and other advanced features of {@link ClipData}.  If
  /// using this approach, you still must supply the same data through the
  /// {@link #EXTRA_TEXT} or {@link #EXTRA_STREAM} fields described below
  /// for compatibility with old applications.  If you don't set a ClipData,
  /// it will be copied there for you when calling {@link Context#startActivity(Intent)}.
  /// <p>
  /// Starting from {@link android.os.Build.VERSION_CODES#O}, if
  /// {@link #CATEGORY_TYPED_OPENABLE} is passed, then the Uris passed in
  /// either {@link #EXTRA_STREAM} or via {@link #setClipData(ClipData)} may
  /// be openable only as asset typed files using
  /// {@link ContentResolver#openTypedAssetFileDescriptor(Uri, String, Bundle)}.
  /// <p>
  /// Optional standard extras, which may be interpreted by some recipients as
  /// appropriate, are: {@link #EXTRA_EMAIL}, {@link #EXTRA_CC},
  /// {@link #EXTRA_BCC}, {@link #EXTRA_SUBJECT}.
  /// <p>
  /// Output: nothing.
  static const String ACTION_SEND_MULTIPLE =
      "android.intent.action.SEND_MULTIPLE";

  /// Activity Action: Handle an incoming phone call.
  /// <p>Input: nothing.
  /// <p>Output: nothing.
  static const String ACTION_ANSWER = "android.intent.action.ANSWER";

  /// Activity Action: Insert an empty item into the given container.
  /// <p>Input: {@link #getData} is URI of the directory (vnd.android.cursor.dir/*)
  /// in which to place the data.
  /// <p>Output: URI of the new data that was created.
  static const String ACTION_INSERT = "android.intent.action.INSERT";

  /// Activity Action: Create a new item in the given container, initializing it
  /// from the current contents of the clipboard.
  /// <p>Input: {@link #getData} is URI of the directory (vnd.android.cursor.dir/*)
  /// in which to place the data.
  /// <p>Output: URI of the new data that was created.
  static const String ACTION_PASTE = "android.intent.action.PASTE";

  /// Activity Action: Delete the given data from its container.
  /// <p>Input: {@link #getData} is URI of data to be deleted.
  /// <p>Output: nothing.
  static const String ACTION_DELETE = "android.intent.action.DELETE";

  /// Activity Action: Run the data, whatever that means.
  /// <p>Input: ?  (Note: this is currently specific to the test harness.)
  /// <p>Output: nothing.
  static const String ACTION_RUN = "android.intent.action.RUN";

  /// Activity Action: Perform a data synchronization.
  /// <p>Input: ?
  /// <p>Output: ?
  static const String ACTION_SYNC = "android.intent.action.SYNC";

  /// Activity Action: Pick an activity given an intent, returning the class
  /// selected.
  /// <p>Input: get*Extra field {@link #EXTRA_INTENT} is an Intent
  /// used with {@link PackageManager#queryIntentActivities} to determine the
  /// set of activities from which to pick.
  /// <p>Output: Class name of the activity that was selected.
  static const String ACTION_PICK_ACTIVITY =
      "android.intent.action.PICK_ACTIVITY";

  /// Activity Action: Perform a search.
  /// <p>Input: {@link android.app.SearchManager#QUERY getStringExtra(SearchManager.QUERY)}
  /// is the text to search for.  If empty, simply
  /// enter your search results Activity with the search UI activated.
  /// <p>Output: nothing.
  static const String ACTION_SEARCH = "android.intent.action.SEARCH";

  /// Activity Action: Start the platform-defined tutorial
  /// <p>Input: {@link android.app.SearchManager#QUERY getStringExtra(SearchManager.QUERY)}
  /// is the text to search for.  If empty, simply
  /// enter your search results Activity with the search UI activated.
  /// <p>Output: nothing.
  static const String ACTION_SYSTEM_TUTORIAL =
      "android.intent.action.SYSTEM_TUTORIAL";

  /// Activity Action: Perform a web search.
  /// <p>
  /// Input: {@link android.app.SearchManager#QUERY
  /// getStringExtra(SearchManager.QUERY)} is the text to search for. If it is
  /// a url starts with http or https, the site will be opened. If it is plain
  /// text, Google search will be applied.
  /// <p>
  /// Output: nothing.
  static const String ACTION_WEB_SEARCH = "android.intent.action.WEB_SEARCH";

  /// Activity Action: Perform assist action.
  /// <p>
  /// Input: {@link #EXTRA_ASSIST_PACKAGE}, {@link #EXTRA_ASSIST_CONTEXT}, can provide
  /// additional optional contextual information about where the user was when they
  /// requested the assist; {@link #EXTRA_REFERRER} may be set with additional referrer
  /// information.
  /// Output: nothing.
  static const String ACTION_ASSIST = "android.intent.action.ASSIST";

  /// Activity Action: Perform voice assist action.
  /// <p>
  /// Input: {@link #EXTRA_ASSIST_PACKAGE}, {@link #EXTRA_ASSIST_CONTEXT}, can provide
  /// additional optional contextual information about where the user was when they
  /// requested the voice assist.
  /// Output: nothing.
  /// @hide
  static const String ACTION_VOICE_ASSIST =
      "android.intent.action.VOICE_ASSIST";

  /// Activity Action: List all available applications.
  /// <p>Input: Nothing.
  /// <p>Output: nothing.
  static const String ACTION_ALL_APPS = "android.intent.action.ALL_APPS";

  /// Activity Action: Show settings for choosing wallpaper.
  /// <p>Input: Nothing.
  /// <p>Output: Nothing.
  static const String ACTION_SET_WALLPAPER =
      "android.intent.action.SET_WALLPAPER";

  /// Activity Action: Show activity for reporting a bug.
  /// <p>Input: Nothing.
  /// <p>Output: Nothing.
  static const String ACTION_BUG_REPORT = "android.intent.action.BUG_REPORT";

  ///  Activity Action: Main entry point for factory tests.  Only used when
  ///  the device is booting in factory test node.  The implementing package
  ///  must be installed in the system image.
  ///  <p>Input: nothing
  ///  <p>Output: nothing
  static const String ACTION_FACTORY_TEST =
      "android.intent.action.FACTORY_TEST";

  /// Activity Action: The user pressed the "call" button to go to the dialer
  /// or other appropriate UI for placing a call.
  /// <p>Input: Nothing.
  /// <p>Output: Nothing.
  static const String ACTION_CALL_BUTTON = "android.intent.action.CALL_BUTTON";

  /// Activity Action: Start Voice Command.
  /// <p>Input: Nothing.
  /// <p>Output: Nothing.
  /// <p class="note">
  /// In some cases, a matching Activity may not exist, so ensure you
  /// safeguard against this.
  static const String ACTION_VOICE_COMMAND =
      "android.intent.action.VOICE_COMMAND";

  /// Activity Action: Start action associated with long pressing on the
  /// search key.
  /// <p>Input: Nothing.
  /// <p>Output: Nothing.
  static const String ACTION_SEARCH_LONG_PRESS =
      "android.intent.action.SEARCH_LONG_PRESS";

  /// Activity Action: The user pressed the "Report" button in the crash/ANR dialog.
  /// This intent is delivered to the package which installed the application, usually
  /// Google Play.
  /// <p>Input: No data is specified. The bug report is passed in using
  /// an {@link #EXTRA_BUG_REPORT} field.
  /// <p>Output: Nothing.
  ///
  /// @see #EXTRA_BUG_REPORT
  static const String ACTION_APP_ERROR = "android.intent.action.APP_ERROR";

  /// An incident or bug report has been taken, and a system app has requested it to be shared,
  /// so trigger the confirmation screen.
  ///
  /// This will be sent directly to the registered receiver with the
  /// android.permission.APPROVE_INCIDENT_REPORTS permission.
  /// @hide
  static const String ACTION_PENDING_INCIDENT_REPORTS_CHANGED =
      "android.intent.action.PENDING_INCIDENT_REPORTS_CHANGED";

  /// An incident report has been taken, and the user has approved it for sharing.
  /// <p>
  /// This will be sent directly to the registered receiver, which must have
  /// both the DUMP and USAGE_STATS permissions.
  /// <p>
  /// After receiving this, the application should wait until a suitable time
  /// (e.g. network available), get the list of available reports with
  /// {@link IncidentManager#getIncidentReportList IncidentManager.getIncidentReportList(String)}
  /// and then when the reports have been successfully uploaded, call
  /// {@link IncidentManager#deleteIncidentReport IncidentManager.deleteIncidentReport(Uri)}.
  ///
  /// @hide
  static const String ACTION_INCIDENT_REPORT_READY =
      "android.intent.action.INCIDENT_REPORT_READY";

  /// Activity Action: Show power usage information to the user.
  /// <p>Input: Nothing.
  /// <p>Output: Nothing.
  static const String ACTION_POWER_USAGE_SUMMARY =
      "android.intent.action.POWER_USAGE_SUMMARY";

  /// Activity Action: Setup wizard to launch after a platform update.  This
  /// activity should have a string meta-data field associated with it,
  /// {@link #METADATA_SETUP_VERSION}, which defines the current version of
  /// the platform for setup.  The activity will be launched only if
  /// {@link android.provider.Settings.Secure#LAST_SETUP_SHOWN} is not the
  /// same value.
  /// <p>Input: Nothing.
  /// <p>Output: Nothing.
  /// @hide
  static const String ACTION_UPGRADE_SETUP =
      "android.intent.action.UPGRADE_SETUP";

  /// Activity Action: Start the Keyboard Shortcuts Helper screen.
  /// <p>Input: Nothing.
  /// <p>Output: Nothing.
  /// @hide
  static const String ACTION_SHOW_KEYBOARD_SHORTCUTS =
      "com.android.intent.action.SHOW_KEYBOARD_SHORTCUTS";

  /// Activity Action: Dismiss the Keyboard Shortcuts Helper screen.
  /// <p>Input: Nothing.
  /// <p>Output: Nothing.
  /// @hide
  static const String ACTION_DISMISS_KEYBOARD_SHORTCUTS =
      "com.android.intent.action.DISMISS_KEYBOARD_SHORTCUTS";

  /// Activity Action: Show settings for managing network data usage of a
  /// specific application. Applications should define an activity that offers
  /// options to control data usage.
  static const String ACTION_MANAGE_NETWORK_USAGE =
      "android.intent.action.MANAGE_NETWORK_USAGE";

  /// Activity Action: Launch application installer.
  /// <p>
  /// Input: The data must be a content: URI at which the application
  /// can be retrieved.  As of {@link android.os.Build.VERSION_CODES#JELLY_BEAN_MR1},
  /// you can also use "package:<package-name>" to install an application for the
  /// current user that is already installed for another user. You can optionally supply
  /// {@link #EXTRA_INSTALLER_PACKAGE_NAME}, {@link #EXTRA_NOT_UNKNOWN_SOURCE},
  /// {@link #EXTRA_ALLOW_REPLACE}, and {@link #EXTRA_RETURN_RESULT}.
  /// <p>
  /// Output: If {@link #EXTRA_RETURN_RESULT}, returns whether the install
  /// succeeded.
  /// <p>
  /// <strong>Note:</strong>If your app is targeting API level higher than 25 you
  /// need to hold {@link android.Manifest.permission#REQUEST_INSTALL_PACKAGES}
  /// in order to launch the application installer.
  /// </p>
  ///
  /// @see #EXTRA_INSTALLER_PACKAGE_NAME
  /// @see #EXTRA_NOT_UNKNOWN_SOURCE
  /// @see #EXTRA_RETURN_RESULT
  ///
  /// @deprecated use {@link android.content.pm.PackageInstaller} instead
  @deprecated
  static const String ACTION_INSTALL_PACKAGE =
      "android.intent.action.INSTALL_PACKAGE";

  /// Activity Action: Activity to handle split installation failures.
  /// <p>Splits may be installed dynamically. This happens when an Activity is launched,
  /// but the split that contains the application isn't installed. When a split is
  /// installed in this manner, the containing package usually doesn't know this is
  /// happening. However, if an error occurs during installation, the containing
  /// package can define a single activity handling this action to deal with such
  /// failures.
  /// <p>The activity handling this action must be in the base package.
  /// <p>
  /// Input: {@link #EXTRA_INTENT} the original intent that started split installation.
  /// {@link #EXTRA_SPLIT_NAME} the name of the split that failed to be installed.
  static const String ACTION_INSTALL_FAILURE =
      "android.intent.action.INSTALL_FAILURE";

  /// Activity Action: Launch instant application installer.
  /// <p class="note">
  /// This is a protected intent that can only be sent by the system.
  /// </p>
  ///
  /// @hide
  static const String ACTION_INSTALL_INSTANT_APP_PACKAGE =
      "android.intent.action.INSTALL_INSTANT_APP_PACKAGE";

  /// Service Action: Resolve instant application.
  /// <p>
  /// The system will have a persistent connection to this service.
  /// This is a protected intent that can only be sent by the system.
  /// </p>
  ///
  /// @hide
  static const String ACTION_RESOLVE_INSTANT_APP_PACKAGE =
      "android.intent.action.RESOLVE_INSTANT_APP_PACKAGE";

  /// Activity Action: Launch instant app settings.
  ///
  /// <p class="note">
  /// This is a protected intent that can only be sent by the system.
  /// </p>
  ///
  /// @hide
  static const String ACTION_INSTANT_APP_RESOLVER_SETTINGS =
      "android.intent.action.INSTANT_APP_RESOLVER_SETTINGS";

  /// Activity Action: Launch application uninstaller.
  /// <p>
  /// Input: The data must be a package: URI whose scheme specific part is
  /// the package name of the current installed package to be uninstalled.
  /// You can optionally supply {@link #EXTRA_RETURN_RESULT}.
  /// <p>
  /// Output: If {@link #EXTRA_RETURN_RESULT}, returns whether the install
  /// succeeded.
  /// <p>
  /// Requires {@link android.Manifest.permission#REQUEST_DELETE_PACKAGES}
  /// since {@link Build.VERSION_CODES#P}.
  ///
  /// @deprecated Use {@link android.content.pm.PackageInstaller#uninstall(String, IntentSender)}
  ///             instead
  @deprecated
  static const String ACTION_UNINSTALL_PACKAGE =
      "android.intent.action.UNINSTALL_PACKAGE";

  /// Activity action: Launch UI to manage the permissions of an app.
  /// <p>
  /// Input: {@link #EXTRA_PACKAGE_NAME} specifies the package whose permissions
  /// will be managed by the launched UI.
  /// </p>
  /// <p>
  /// Output: Nothing.
  /// </p>
  ///
  /// @see #EXTRA_PACKAGE_NAME
  ///
  /// @hide
  static const String ACTION_MANAGE_APP_PERMISSIONS =
      "android.intent.action.MANAGE_APP_PERMISSIONS";

  /// Activity action: Launch UI to manage a specific permissions of an app.
  /// <p>
  /// Input: {@link #EXTRA_PACKAGE_NAME} specifies the package whose permission
  /// will be managed by the launched UI.
  /// </p>
  /// <p>
  /// Input: {@link #EXTRA_PERMISSION_NAME} specifies the (individual) permission
  /// that should be managed by the launched UI.
  /// </p>
  /// <p>
  /// <li> {@link #EXTRA_USER} specifies the UserHandle of the user that owns the app.
  /// </p>
  /// <p>
  /// Output: Nothing.
  /// </p>
  ///
  /// @see #EXTRA_PACKAGE_NAME
  /// @see #EXTRA_PERMISSION_NAME
  /// @see #EXTRA_USER
  ///
  /// @hide
  static const String ACTION_MANAGE_APP_PERMISSION =
      "android.intent.action.MANAGE_APP_PERMISSION";

  /// Activity action: Launch UI to manage permissions.
  /// <p>
  /// Input: Nothing.
  /// </p>
  /// <p>
  /// Output: Nothing.
  /// </p>
  ///
  /// @hide
  static const String ACTION_MANAGE_PERMISSIONS =
      "android.intent.action.MANAGE_PERMISSIONS";

  /// Activity action: Launch UI to manage auto-revoke state.
  ///
  /// This is equivalent to Intent#ACTION_APPLICATION_DETAILS_SETTINGS
  ///
  /// <p>
  /// Input: {@link Intent#setData data} should be a {@code package}-scheme {@link Uri} with
  /// a package name, whose auto-revoke state will be reviewed (mandatory).
  /// E.g. {@code Uri.fromParts("package", packageName, null) }
  /// </p>
  /// <p>
  /// Output: Nothing.
  /// </p>
  static const String ACTION_AUTO_REVOKE_PERMISSIONS =
      "android.intent.action.AUTO_REVOKE_PERMISSIONS";

  /// Activity action: Launch UI to review permissions for an app.
  /// The system uses this intent if permission review for apps not
  /// supporting the new runtime permissions model is enabled. In
  /// this mode a permission review is required before any of the
  /// app components can run.
  /// <p>
  /// Input: {@link #EXTRA_PACKAGE_NAME} specifies the package whose
  /// permissions will be reviewed (mandatory).
  /// </p>
  /// <p>
  /// Input: {@link #EXTRA_INTENT} specifies a pending intent to
  /// be fired after the permission review (optional).
  /// </p>
  /// <p>
  /// Input: {@link #EXTRA_REMOTE_CALLBACK} specifies a callback to
  /// be invoked after the permission review (optional).
  /// </p>
  /// <p>
  /// Input: {@link #EXTRA_RESULT_NEEDED} specifies whether the intent
  /// passed via {@link #EXTRA_INTENT} needs a result (optional).
  /// </p>
  /// <p>
  /// Output: Nothing.
  /// </p>
  ///
  /// @see #EXTRA_PACKAGE_NAME
  /// @see #EXTRA_INTENT
  /// @see #EXTRA_REMOTE_CALLBACK
  /// @see #EXTRA_RESULT_NEEDED
  ///
  /// @hide
  static const String ACTION_REVIEW_PERMISSIONS =
      "android.intent.action.REVIEW_PERMISSIONS";

  /// Activity action: Launch UI to show information about the usage
  /// of a given permission. This action would be handled by apps that
  /// want to show details about how and why given permission is being
  /// used.
  /// <p>
  /// <strong>Important:</strong>You must protect the activity that handles
  /// this action with the {@link android.Manifest.permission#START_VIEW_PERMISSION_USAGE
  ///  START_VIEW_PERMISSION_USAGE} permission to ensure that only the
  /// system can launch this activity. The system will not launch
  /// activities that are not properly protected.
  ///
  /// <p>
  /// Input: {@code android.intent.extra.PERMISSION_NAME} specifies the permission
  /// for which the launched UI would be targeted.
  /// </p>
  /// <p>
  /// Output: Nothing.
  /// </p>
  static const String ACTION_VIEW_PERMISSION_USAGE =
      "android.intent.action.VIEW_PERMISSION_USAGE";

  /// Activity action: Launch UI to manage a default app.
  /// <p>
  /// Input: {@link #EXTRA_ROLE_NAME} specifies the role of the default app which will be managed
  /// by the launched UI.
  /// </p>
  /// <p>
  /// Output: Nothing.
  /// </p>
  ///
  /// @hide
  static const String ACTION_MANAGE_DEFAULT_APP =
      "android.intent.action.MANAGE_DEFAULT_APP";

  /// Activity action: Launch UI to manage special app accesses.
  /// <p>
  /// Input: Nothing.
  /// </p>
  /// <p>
  /// Output: Nothing.
  /// </p>
  ///
  /// @hide
  static const String ACTION_MANAGE_SPECIAL_APP_ACCESSES =
      "android.intent.action.MANAGE_SPECIAL_APP_ACCESSES";

  /// Activity action: Launch UI to manage which apps have a given permission.
  /// <p>
  /// Input: {@link #EXTRA_PERMISSION_NAME} specifies the permission group
  /// which will be managed by the launched UI.
  /// </p>
  /// <p>
  /// Output: Nothing.
  /// </p>
  ///
  /// @see #EXTRA_PERMISSION_NAME
  ///
  /// @hide

  static const String ACTION_MANAGE_PERMISSION_APPS =
      "android.intent.action.MANAGE_PERMISSION_APPS";

  /// An optional field on {@link #ACTION_ASSIST} containing the name of the current foreground
  /// application package at the time the assist was invoked.
  static const String EXTRA_ASSIST_PACKAGE =
      "android.intent.extra.ASSIST_PACKAGE";

  /// An optional field on {@link #ACTION_ASSIST} containing the uid of the current foreground
  /// application package at the time the assist was invoked.
  static const String EXTRA_ASSIST_UID = "android.intent.extra.ASSIST_UID";

  /// An optional field on {@link #ACTION_ASSIST} and containing additional contextual
  /// information supplied by the current foreground app at the time of the assist request.
  /// This is a {@link Bundle} of additional data.
  static const String EXTRA_ASSIST_CONTEXT =
      "android.intent.extra.ASSIST_CONTEXT";

  /// An optional field on {@link #ACTION_ASSIST} suggesting that the user will likely use a
  /// keyboard as the primary input device for assistance.
  static const String EXTRA_ASSIST_INPUT_HINT_KEYBOARD =
      "android.intent.extra.ASSIST_INPUT_HINT_KEYBOARD";

  /// An optional field on {@link #ACTION_ASSIST} containing the InputDevice id
  /// that was used to invoke the assist.
  static const String EXTRA_ASSIST_INPUT_DEVICE_ID =
      "android.intent.extra.ASSIST_INPUT_DEVICE_ID";

  /// Used as a string extra field with {@link #ACTION_INSTALL_PACKAGE} to install a
  /// package.  Specifies the installer package name; this package will receive the
  /// {@link #ACTION_APP_ERROR} intent.
  static const String EXTRA_INSTALLER_PACKAGE_NAME =
      "android.intent.extra.INSTALLER_PACKAGE_NAME";

  /// Used as a boolean extra field with {@link #ACTION_INSTALL_PACKAGE} to install a
  /// package.  Specifies that the application being installed should not be
  /// treated as coming from an unknown source, but as coming from the app
  /// invoking the Intent.  For this to work you must start the installer with
  /// startActivityForResult().
  static const String EXTRA_NOT_UNKNOWN_SOURCE =
      "android.intent.extra.NOT_UNKNOWN_SOURCE";

  /// Used as a URI extra field with {@link #ACTION_INSTALL_PACKAGE} and
  /// {@link #ACTION_VIEW} to indicate the URI from which the local APK in the Intent
  /// data field originated from.
  static const String EXTRA_ORIGINATING_URI =
      "android.intent.extra.ORIGINATING_URI";

  /// This extra can be used with any Intent used to launch an activity, supplying information
  /// about who is launching that activity.  This field contains a {@link android.net.Uri}
  /// object, typically an http: or https: URI of the web site that the referral came from;
  /// it can also use the {@link #URI_ANDROID_APP_SCHEME android-app:} scheme to identify
  /// a native application that it came from.
  ///
  /// <p>To retrieve this value in a client, use {@link android.app.Activity#getReferrer}
  /// instead of directly retrieving the extra.  It is also valid for applications to
  /// instead supply {@link #EXTRA_REFERRER_NAME} for cases where they can only create
  /// a string, not a Uri; the field here, if supplied, will always take precedence,
  /// however.</p>
  ///
  /// @see #EXTRA_REFERRER_NAME
  static const String EXTRA_REFERRER = "android.intent.extra.REFERRER";

  /// Alternate version of {@link #EXTRA_REFERRER} that supplies the URI as a String rather
  /// than a {@link android.net.Uri} object.  Only for use in cases where Uri objects can
  /// not be created, in particular when Intent extras are supplied through the
  /// {@link #URI_INTENT_SCHEME intent:} or {@link #URI_ANDROID_APP_SCHEME android-app:}
  /// schemes.
  ///
  /// @see #EXTRA_REFERRER
  static const String EXTRA_REFERRER_NAME =
      "android.intent.extra.REFERRER_NAME";

  /// Used as an int extra field with {@link #ACTION_INSTALL_PACKAGE} and
  /// {@link #ACTION_VIEW} to indicate the uid of the package that initiated the install
  /// Currently only a system app that hosts the provider authority "downloads" or holds the
  /// permission {@link android.Manifest.permission.MANAGE_DOCUMENTS} can use this.
  /// @hide
  static const String EXTRA_ORIGINATING_UID =
      "android.intent.extra.ORIGINATING_UID";

  /// Used as a boolean extra field with {@link #ACTION_INSTALL_PACKAGE} to install a
  /// package.  Tells the installer UI to skip the confirmation with the user
  /// if the .apk is replacing an existing one.
  /// @deprecated As of {@link android.os.Build.VERSION_CODES#JELLY_BEAN}, Android
  /// will no longer show an interstitial message about updating existing
  /// applications so this is no longer needed.
  @deprecated
  static const String EXTRA_ALLOW_REPLACE =
      "android.intent.extra.ALLOW_REPLACE";

  /// Used as a boolean extra field with {@link #ACTION_INSTALL_PACKAGE} or
  /// {@link #ACTION_UNINSTALL_PACKAGE}.  Specifies that the installer UI should
  /// return to the application the result code of the install/uninstall.  The returned result
  /// code will be {@link android.app.Activity#RESULT_OK} on success or
  /// {@link android.app.Activity#RESULT_FIRST_USER} on failure.
  static const String EXTRA_RETURN_RESULT =
      "android.intent.extra.RETURN_RESULT";

  /// Specify whether the package should be uninstalled for all users.
  /// @hide because these should not be part of normal application flow.
  static const String EXTRA_UNINSTALL_ALL_USERS =
      "android.intent.extra.UNINSTALL_ALL_USERS";

  /// Package manager install result code.  @hide because result codes are not
  /// yet ready to be exposed.
  static const String EXTRA_INSTALL_RESULT =
      "android.intent.extra.INSTALL_RESULT";

  /// Intent extra: A callback for reporting remote result as a bundle.
  /// <p>
  /// Type: IRemoteCallback
  /// </p>
  ///
  /// @hide
  static const String EXTRA_REMOTE_CALLBACK =
      "android.intent.extra.REMOTE_CALLBACK";

  /// Intent extra: An app package name.
  /// <p>
  /// Type: String
  /// </p>
  ///
  static const String EXTRA_PACKAGE_NAME = "android.intent.extra.PACKAGE_NAME";

  /// Intent extra: A {@link Bundle} of extras for a package being suspended. Will be sent as an
  /// extra with {@link #ACTION_MY_PACKAGE_SUSPENDED}.
  ///
  /// <p>The contents of this {@link Bundle} are a contract between the suspended app and the
  /// suspending app, i.e. any app with the permission {@code android.permission.SUSPEND_APPS}.
  /// This is meant to enable the suspended app to better handle the state of being suspended.
  ///
  /// @see #ACTION_MY_PACKAGE_SUSPENDED
  /// @see #ACTION_MY_PACKAGE_UNSUSPENDED
  /// @see PackageManager#isPackageSuspended()
  /// @see PackageManager#getSuspendedPackageAppExtras()
  static const String EXTRA_SUSPENDED_PACKAGE_EXTRAS =
      "android.intent.extra.SUSPENDED_PACKAGE_EXTRAS";

  /// Intent extra: An app split name.
  /// <p>
  /// Type: String
  /// </p>
  static const String EXTRA_SPLIT_NAME = "android.intent.extra.SPLIT_NAME";

  /// Intent extra: A {@link ComponentName} value.
  /// <p>
  /// Type: String
  /// </p>
  static const String EXTRA_COMPONENT_NAME =
      "android.intent.extra.COMPONENT_NAME";

  /// Intent extra: An extra for specifying whether a result is needed.
  /// <p>
  /// Type: boolean
  /// </p>
  ///
  /// @hide
  static const String EXTRA_RESULT_NEEDED =
      "android.intent.extra.RESULT_NEEDED";

  /// Intent extra: ID of the shortcut used to send the share intent. Will be sent with
  /// {@link #ACTION_SEND}.
  ///
  /// @see ShortcutInfo#getId()
  ///
  /// <p>
  /// Type: String
  /// </p>
  static const String EXTRA_SHORTCUT_ID = "android.intent.extra.shortcut.ID";

  /// Intent extra: A role name.
  /// <p>
  /// Type: String
  /// </p>
  ///
  /// @see android.app.role.RoleManager
  ///
  /// @hide
  static const String EXTRA_ROLE_NAME = "android.intent.extra.ROLE_NAME";

  /// Intent extra: The name of a permission.
  /// <p>
  /// Type: String
  /// </p>
  ///
  /// @hide
  static const String EXTRA_PERMISSION_NAME =
      "android.intent.extra.PERMISSION_NAME";

  /// Intent extra: The name of a permission group.
  /// <p>
  /// Type: String
  /// </p>
  ///
  /// @hide
  static const String EXTRA_PERMISSION_GROUP_NAME =
      "android.intent.extra.PERMISSION_GROUP_NAME";

  /// Intent extra: The number of milliseconds.
  /// <p>
  /// Type: long
  /// </p>
  static const String EXTRA_DURATION_MILLIS =
      "android.intent.extra.DURATION_MILLIS";

  /// Activity action: Launch UI to review app uses of permissions.
  /// <p>
  /// Input: {@link #EXTRA_PERMISSION_NAME} specifies the permission name
  /// that will be displayed by the launched UI.  Do not pass both this and
  /// {@link #EXTRA_PERMISSION_GROUP_NAME} .
  /// </p>
  /// <p>
  /// Input: {@link #EXTRA_PERMISSION_GROUP_NAME} specifies the permission group name
  /// that will be displayed by the launched UI.  Do not pass both this and
  /// {@link #EXTRA_PERMISSION_NAME}.
  /// </p>
  /// <p>
  /// Input: {@link #EXTRA_DURATION_MILLIS} specifies the minimum number of milliseconds of recent
  /// activity to show (optional).  Must be non-negative.
  /// </p>
  /// <p>
  /// Output: Nothing.
  /// </p>
  /// <p class="note">
  /// This requires {@link android.Manifest.permission#GRANT_RUNTIME_PERMISSIONS} permission.
  /// </p>
  ///
  /// @see #EXTRA_PERMISSION_NAME
  /// @see #EXTRA_PERMISSION_GROUP_NAME
  /// @see #EXTRA_DURATION_MILLIS
  ///
  /// @hide
  static const String ACTION_REVIEW_PERMISSION_USAGE =
      "android.intent.action.REVIEW_PERMISSION_USAGE";

  /// Activity action: Launch UI to review ongoing app uses of permissions.
  /// <p>
  /// Input: {@link #EXTRA_DURATION_MILLIS} specifies the minimum number of milliseconds of recent
  /// activity to show (optional).  Must be non-negative.
  /// </p>
  /// <p>
  /// Output: Nothing.
  /// </p>
  /// <p class="note">
  /// This requires {@link android.Manifest.permission#GRANT_RUNTIME_PERMISSIONS} permission.
  /// </p>
  ///
  /// @see #EXTRA_DURATION_MILLIS
  ///
  /// @hide
  static const String ACTION_REVIEW_ONGOING_PERMISSION_USAGE =
      "android.intent.action.REVIEW_ONGOING_PERMISSION_USAGE";

  /// Activity action: Launch UI to review running accessibility services.
  /// <p>
  /// Input: Nothing.
  /// </p>
  /// <p>
  /// Output: Nothing.
  /// </p>
  ///
  /// @hide
  static const String ACTION_REVIEW_ACCESSIBILITY_SERVICES =
      "android.intent.action.REVIEW_ACCESSIBILITY_SERVICES";
  // ---------------------------------------------------------------------
  // ---------------------------------------------------------------------
  // Standard intent broadcast actions (see action variable).
  /// Broadcast Action: Sent when the device goes to sleep and becomes non-interactive.
  /// <p>
  /// For historical reasons, the name of this broadcast action refers to the power
  /// state of the screen but it is actually sent in response to changes in the
  /// overall interactive state of the device.
  /// </p><p>
  /// This broadcast is sent when the device becomes non-interactive which may have
  /// nothing to do with the screen turning off.  To determine the
  /// actual state of the screen, use {@link android.view.Display#getState}.
  /// </p><p>
  /// See {@link android.os.PowerManager#isInteractive} for details.
  /// </p>
  /// You <em>cannot</em> receive this through components declared in
  /// manifests, only by explicitly registering for it with
  /// {@link Context#registerReceiver(BroadcastReceiver, IntentFilter)
  /// Context.registerReceiver()}.
  ///
  /// <p class="note">This is a protected intent that can only be sent
  /// by the system.
  static const String ACTION_SCREEN_OFF = "android.intent.action.SCREEN_OFF";

  /// Broadcast Action: Sent when the device wakes up and becomes interactive.
  /// <p>
  /// For historical reasons, the name of this broadcast action refers to the power
  /// state of the screen but it is actually sent in response to changes in the
  /// overall interactive state of the device.
  /// </p><p>
  /// This broadcast is sent when the device becomes interactive which may have
  /// nothing to do with the screen turning on.  To determine the
  /// actual state of the screen, use {@link android.view.Display#getState}.
  /// </p><p>
  /// See {@link android.os.PowerManager#isInteractive} for details.
  /// </p>
  /// You <em>cannot</em> receive this through components declared in
  /// manifests, only by explicitly registering for it with
  /// {@link Context#registerReceiver(BroadcastReceiver, IntentFilter)
  /// Context.registerReceiver()}.
  ///
  /// <p class="note">This is a protected intent that can only be sent
  /// by the system.
  static const String ACTION_SCREEN_ON = "android.intent.action.SCREEN_ON";

  /// Broadcast Action: Sent after the system stops dreaming.
  ///
  /// <p class="note">This is a protected intent that can only be sent by the system.
  /// It is only sent to registered receivers.</p>

  static const String ACTION_DREAMING_STOPPED =
      "android.intent.action.DREAMING_STOPPED";

  /// Broadcast Action: Sent after the system starts dreaming.
  ///
  /// <p class="note">This is a protected intent that can only be sent by the system.
  /// It is only sent to registered receivers.</p>

  static const String ACTION_DREAMING_STARTED =
      "android.intent.action.DREAMING_STARTED";

  /// Broadcast Action: Sent when the user is present after device wakes up (e.g when the
  /// keyguard is gone).
  ///
  /// <p class="note">This is a protected intent that can only be sent
  /// by the system.

  static const String ACTION_USER_PRESENT =
      "android.intent.action.USER_PRESENT";

  /// Broadcast Action: The current time has changed.  Sent every
  /// minute.  You <em>cannot</em> receive this through components declared
  /// in manifests, only by explicitly registering for it with
  /// {@link Context#registerReceiver(BroadcastReceiver, IntentFilter)
  /// Context.registerReceiver()}.
  ///
  /// <p class="note">This is a protected intent that can only be sent
  /// by the system.

  static const String ACTION_TIME_TICK = "android.intent.action.TIME_TICK";

  /// Broadcast Action: The time was set.

  static const String ACTION_TIME_CHANGED = "android.intent.action.TIME_SET";

  /// Broadcast Action: The date has changed.

  static const String ACTION_DATE_CHANGED =
      "android.intent.action.DATE_CHANGED";

  /// Broadcast Action: The timezone has changed. The intent will have the following extra values:</p>
  /// <ul>
  ///   <li>{@link #EXTRA_TIMEZONE} - The java.util.TimeZone.getID() value identifying the new
  ///   time zone.</li>
  /// </ul>
  ///
  /// <p class="note">This is a protected intent that can only be sent
  /// by the system.

  static const String ACTION_TIMEZONE_CHANGED =
      "android.intent.action.TIMEZONE_CHANGED";

  /// Clear DNS Cache Action: This is broadcast when networks have changed and old
  /// DNS entries should be tossed.
  /// @hide

  static const String ACTION_CLEAR_DNS_CACHE =
      "android.intent.action.CLEAR_DNS_CACHE";

  /// Alarm Changed Action: This is broadcast when the AlarmClock
  /// application's alarm is set or unset.  It is used by the
  /// AlarmClock application and the StatusBar service.
  /// @hide

  static const String ACTION_ALARM_CHANGED =
      "android.intent.action.ALARM_CHANGED";

  /// Broadcast Action: This is broadcast once, after the user has finished
  /// booting, but while still in the "locked" state. It can be used to perform
  /// application-specific initialization, such as installing alarms. You must
  /// hold the {@link android.Manifest.permission#RECEIVE_BOOT_COMPLETED}
  /// permission in order to receive this broadcast.
  /// <p>
  /// This broadcast is sent immediately at boot by all devices (regardless of
  /// direct boot support) running {@link android.os.Build.VERSION_CODES#N} or
  /// higher. Upon receipt of this broadcast, the user is still locked and only
  /// device-protected storage can be accessed safely. If you want to access
  /// credential-protected storage, you need to wait for the user to be
  /// unlocked (typically by entering their lock pattern or PIN for the first
  /// time), after which the {@link #ACTION_USER_UNLOCKED} and
  /// {@link #ACTION_BOOT_COMPLETED} broadcasts are sent.
  /// <p>
  /// To receive this broadcast, your receiver component must be marked as
  /// being {@link ComponentInfo#directBootAware}.
  /// <p class="note">
  /// This is a protected intent that can only be sent by the system.
  ///
  /// @see Context#createDeviceProtectedStorageContext()

  static const String ACTION_LOCKED_BOOT_COMPLETED =
      "android.intent.action.LOCKED_BOOT_COMPLETED";

  /// Broadcast Action: This is broadcast once, after the user has finished
  /// booting. It can be used to perform application-specific initialization,
  /// such as installing alarms. You must hold the
  /// {@link android.Manifest.permission#RECEIVE_BOOT_COMPLETED} permission in
  /// order to receive this broadcast.
  /// <p>
  /// This broadcast is sent at boot by all devices (both with and without
  /// direct boot support). Upon receipt of this broadcast, the user is
  /// unlocked and both device-protected and credential-protected storage can
  /// accessed safely.
  /// <p>
  /// If you need to run while the user is still locked (before they've entered
  /// their lock pattern or PIN for the first time), you can listen for the
  /// {@link #ACTION_LOCKED_BOOT_COMPLETED} broadcast.
  /// <p class="note">
  /// This is a protected intent that can only be sent by the system.

  static const String ACTION_BOOT_COMPLETED =
      "android.intent.action.BOOT_COMPLETED";

  /// Broadcast Action: This is broadcast when a user action should request a
  /// temporary system dialog to dismiss.  Some examples of temporary system
  /// dialogs are the notification window-shade and the recent tasks dialog.

  static const String ACTION_CLOSE_SYSTEM_DIALOGS =
      "android.intent.action.CLOSE_SYSTEM_DIALOGS";

  /// Broadcast Action: Trigger the download and eventual installation
  /// of a package.
  /// <p>Input: {@link #getData} is the URI of the package file to download.
  ///
  /// <p class="note">This is a protected intent that can only be sent
  /// by the system.
  ///
  /// @deprecated This constant has never been used.
  @deprecated
  static const String ACTION_PACKAGE_INSTALL =
      "android.intent.action.PACKAGE_INSTALL";

  /// Broadcast Action: A new application package has been installed on the
  /// device. The data contains the name of the package.  Note that the
  /// newly installed package does <em>not</em> receive this broadcast.
  /// <p>May include the following extras:
  /// <ul>
  /// <li> {@link #EXTRA_UID} containing the integer uid assigned to the new package.
  /// <li> {@link #EXTRA_REPLACING} is set to true if this is following
  /// an {@link #ACTION_PACKAGE_REMOVED} broadcast for the same package.
  /// </ul>
  ///
  /// <p class="note">This is a protected intent that can only be sent
  /// by the system.

  static const String ACTION_PACKAGE_ADDED =
      "android.intent.action.PACKAGE_ADDED";

  /// Broadcast Action: A new version of an application package has been
  /// installed, replacing an existing version that was previously installed.
  /// The data contains the name of the package.
  /// <p>May include the following extras:
  /// <ul>
  /// <li> {@link #EXTRA_UID} containing the integer uid assigned to the new package.
  /// </ul>
  ///
  /// <p class="note">This is a protected intent that can only be sent
  /// by the system.

  static const String ACTION_PACKAGE_REPLACED =
      "android.intent.action.PACKAGE_REPLACED";

  /// Broadcast Action: A new version of your application has been installed
  /// over an existing one.  This is only sent to the application that was
  /// replaced.  It does not contain any additional data; to receive it, just
  /// use an intent filter for this action.
  ///
  /// <p class="note">This is a protected intent that can only be sent
  /// by the system.

  static const String ACTION_MY_PACKAGE_REPLACED =
      "android.intent.action.MY_PACKAGE_REPLACED";

  /// Broadcast Action: An existing application package has been removed from
  /// the device.  The data contains the name of the package.  The package
  /// that is being removed does <em>not</em> receive this Intent.
  /// <ul>
  /// <li> {@link #EXTRA_UID} containing the integer uid previously assigned
  /// to the package.
  /// <li> {@link #EXTRA_DATA_REMOVED} is set to true if the entire
  /// application -- data and code -- is being removed.
  /// <li> {@link #EXTRA_REPLACING} is set to true if this will be followed
  /// by an {@link #ACTION_PACKAGE_ADDED} broadcast for the same package.
  /// </ul>
  ///
  /// <p class="note">This is a protected intent that can only be sent
  /// by the system.

  static const String ACTION_PACKAGE_REMOVED =
      "android.intent.action.PACKAGE_REMOVED";

  /// Broadcast Action: An existing application package has been completely
  /// removed from the device.  The data contains the name of the package.
  /// This is like {@link #ACTION_PACKAGE_REMOVED}, but only set when
  /// {@link #EXTRA_DATA_REMOVED} is true and
  /// {@link #EXTRA_REPLACING} is false of that broadcast.
  ///
  /// <ul>
  /// <li> {@link #EXTRA_UID} containing the integer uid previously assigned
  /// to the package.
  /// </ul>
  ///
  /// <p class="note">This is a protected intent that can only be sent
  /// by the system.

  static const String ACTION_PACKAGE_FULLY_REMOVED =
      "android.intent.action.PACKAGE_FULLY_REMOVED";

  /// Broadcast Action: An existing application package has been changed (for
  /// example, a component has been enabled or disabled).  The data contains
  /// the name of the package.
  /// <ul>
  /// <li> {@link #EXTRA_UID} containing the integer uid assigned to the package.
  /// <li> {@link #EXTRA_CHANGED_COMPONENT_NAME_LIST} containing the class name
  /// of the changed components (or the package name itself).
  /// <li> {@link #EXTRA_DONT_KILL_APP} containing boolean field to override the
  /// default action of restarting the application.
  /// </ul>
  ///
  /// <p class="note">This is a protected intent that can only be sent
  /// by the system.

  static const String ACTION_PACKAGE_CHANGED =
      "android.intent.action.PACKAGE_CHANGED";

  /// Broadcast Action: Sent to the system rollback manager when a package
  /// needs to have rollback enabled.
  /// <p class="note">
  /// This is a protected intent that can only be sent by the system.
  /// </p>
  ///
  /// @hide This broadcast is used internally by the system.

  static const String ACTION_PACKAGE_ENABLE_ROLLBACK =
      "android.intent.action.PACKAGE_ENABLE_ROLLBACK";

  /// Broadcast Action: Sent to the system rollback manager when the rollback for a certain
  /// package needs to be cancelled.
  ///
  /// <p class="note">This intent is sent by PackageManagerService to notify RollbackManager
  /// that enabling a specific rollback has timed out.
  ///
  /// @hide

  static const String ACTION_CANCEL_ENABLE_ROLLBACK =
      "android.intent.action.CANCEL_ENABLE_ROLLBACK";

  /// Broadcast Action: A rollback has been committed.
  ///
  /// <p class="note">This is a protected intent that can only be sent
  /// by the system. The receiver must hold MANAGE_ROLLBACK permission.
  ///
  /// @hide

  static const String ACTION_ROLLBACK_COMMITTED =
      "android.intent.action.ROLLBACK_COMMITTED";

  /// @hide
  /// Broadcast Action: Ask system services if there is any reason to
  /// restart the given package.  The data contains the name of the
  /// package.
  /// <ul>
  /// <li> {@link #EXTRA_UID} containing the integer uid assigned to the package.
  /// <li> {@link #EXTRA_PACKAGES} String array of all packages to check.
  /// </ul>
  ///
  /// <p class="note">This is a protected intent that can only be sent
  /// by the system.

  static const String ACTION_QUERY_PACKAGE_RESTART =
      "android.intent.action.QUERY_PACKAGE_RESTART";

  /// Broadcast Action: The user has restarted a package, and all of its
  /// processes have been killed.  All runtime state
  /// associated with it (processes, alarms, notifications, etc) should
  /// be removed.  Note that the restarted package does <em>not</em>
  /// receive this broadcast.
  /// The data contains the name of the package.
  /// <ul>
  /// <li> {@link #EXTRA_UID} containing the integer uid assigned to the package.
  /// </ul>
  ///
  /// <p class="note">This is a protected intent that can only be sent
  /// by the system.

  static const String ACTION_PACKAGE_RESTARTED =
      "android.intent.action.PACKAGE_RESTARTED";

  /// Broadcast Action: The user has cleared the data of a package.  This should
  /// be preceded by {@link #ACTION_PACKAGE_RESTARTED}, after which all of
  /// its persistent data is erased and this broadcast sent.
  /// Note that the cleared package does <em>not</em>
  /// receive this broadcast. The data contains the name of the package.
  /// <ul>
  /// <li> {@link #EXTRA_UID} containing the integer uid assigned to the package. If the
  ///      package whose data was cleared is an uninstalled instant app, then the UID
  ///      will be -1. The platform keeps some meta-data associated with instant apps
  ///      after they are uninstalled.
  /// <li> {@link #EXTRA_PACKAGE_NAME} containing the package name only if the cleared
  ///      data was for an instant app.
  /// </ul>
  ///
  /// <p class="note">This is a protected intent that can only be sent
  /// by the system.

  static const String ACTION_PACKAGE_DATA_CLEARED =
      "android.intent.action.PACKAGE_DATA_CLEARED";

  /// Broadcast Action: Packages have been suspended.
  /// <p>Includes the following extras:
  /// <ul>
  /// <li> {@link #EXTRA_CHANGED_PACKAGE_LIST} is the set of packages which have been suspended
  /// <li> {@link #EXTRA_CHANGED_UID_LIST} is the set of uids which have been suspended
  /// </ul>
  ///
  /// <p class="note">This is a protected intent that can only be sent
  /// by the system. It is only sent to registered receivers.

  static const String ACTION_PACKAGES_SUSPENDED =
      "android.intent.action.PACKAGES_SUSPENDED";

  /// Broadcast Action: Packages have been unsuspended.
  /// <p>Includes the following extras:
  /// <ul>
  /// <li> {@link #EXTRA_CHANGED_PACKAGE_LIST} is the set of packages which have been unsuspended
  /// <li> {@link #EXTRA_CHANGED_UID_LIST} is the set of uids which have been unsuspended
  /// </ul>
  ///
  /// <p class="note">This is a protected intent that can only be sent
  /// by the system. It is only sent to registered receivers.

  static const String ACTION_PACKAGES_UNSUSPENDED =
      "android.intent.action.PACKAGES_UNSUSPENDED";

  /// Broadcast Action: Distracting packages have been changed.
  /// <p>Includes the following extras:
  /// <ul>
  /// <li> {@link #EXTRA_CHANGED_PACKAGE_LIST} is the set of packages which have been changed.
  /// <li> {@link #EXTRA_CHANGED_UID_LIST} is the set of uids which have been changed.
  /// <li> {@link #EXTRA_DISTRACTION_RESTRICTIONS} the new restrictions set on these packages.
  /// </ul>
  ///
  /// <p class="note">This is a protected intent that can only be sent
  /// by the system. It is only sent to registered receivers.
  ///
  /// @see PackageManager#setDistractingPackageRestrictions(String[], int)
  /// @hide

  static const String ACTION_DISTRACTING_PACKAGES_CHANGED =
      "android.intent.action.DISTRACTING_PACKAGES_CHANGED";

  /// Broadcast Action: Sent to a package that has been suspended by the system. This is sent
  /// whenever a package is put into a suspended state or any of its app extras change while in the
  /// suspended state.
  /// <p> Optionally includes the following extras:
  /// <ul>
  ///     <li> {@link #EXTRA_SUSPENDED_PACKAGE_EXTRAS} which is a {@link Bundle} which will contain
  ///     useful information for the app being suspended.
  /// </ul>
  /// <p class="note">This is a protected intent that can only be sent
  /// by the system. <em>This will be delivered to {@link BroadcastReceiver} components declared in
  /// the manifest.</em>
  ///
  /// @see #ACTION_MY_PACKAGE_UNSUSPENDED
  /// @see #EXTRA_SUSPENDED_PACKAGE_EXTRAS
  /// @see PackageManager#isPackageSuspended()
  /// @see PackageManager#getSuspendedPackageAppExtras()

  static const String ACTION_MY_PACKAGE_SUSPENDED =
      "android.intent.action.MY_PACKAGE_SUSPENDED";

  /// Activity Action: Started to show more details about why an application was suspended.
  ///
  /// <p>Whenever the system detects an activity launch for a suspended app, this action can
  /// be used to show more details about the reason for suspension.
  ///
  /// <p>Apps holding {@link android.Manifest.permission#SUSPEND_APPS} must declare an activity
  /// handling this intent and protect it with
  /// {@link android.Manifest.permission#SEND_SHOW_SUSPENDED_APP_DETAILS}.
  ///
  /// <p>Includes an extra {@link #EXTRA_PACKAGE_NAME} which is the name of the suspended package.
  ///
  /// <p class="note">This is a protected intent that can only be sent
  /// by the system.
  ///
  /// @see PackageManager#setPackagesSuspended(String[], boolean, PersistableBundle,
  /// PersistableBundle, String)
  /// @see PackageManager#isPackageSuspended()
  /// @see #ACTION_PACKAGES_SUSPENDED
  ///
  /// @hide

  static const String ACTION_SHOW_SUSPENDED_APP_DETAILS =
      "android.intent.action.SHOW_SUSPENDED_APP_DETAILS";

  /// Broadcast Action: Sent to indicate that the user unsuspended a package.
  ///
  /// <p>This can happen when the user taps on the neutral button of the
  /// {@linkplain SuspendDialogInfo suspend-dialog} which was created by using
  /// {@link SuspendDialogInfo#BUTTON_ACTION_UNSUSPEND}. This broadcast is only sent to the
  /// suspending app that originally specified this dialog while calling
  /// {@link PackageManager#setPackagesSuspended(String[], boolean, PersistableBundle,
  /// PersistableBundle, SuspendDialogInfo)}.
  ///
  /// <p>Includes an extra {@link #EXTRA_PACKAGE_NAME} which is the name of the package that just
  /// got unsuspended.
  ///
  /// <p class="note">This is a protected intent that can only be sent
  /// by the system. <em>This will be delivered to {@link BroadcastReceiver} components declared in
  /// the manifest.</em>
  ///
  /// @see PackageManager#setPackagesSuspended(String[], boolean, PersistableBundle,
  /// PersistableBundle, SuspendDialogInfo)
  /// @see PackageManager#isPackageSuspended()
  /// @see SuspendDialogInfo#BUTTON_ACTION_MORE_DETAILS
  /// @hide

  static const String ACTION_PACKAGE_UNSUSPENDED_MANUALLY =
      "android.intent.action.PACKAGE_UNSUSPENDED_MANUALLY";

  /// Broadcast Action: Sent to a package that has been unsuspended.
  ///
  /// <p class="note">This is a protected intent that can only be sent
  /// by the system. <em>This will be delivered to {@link BroadcastReceiver} components declared in
  /// the manifest.</em>
  ///
  /// @see #ACTION_MY_PACKAGE_SUSPENDED
  /// @see #EXTRA_SUSPENDED_PACKAGE_EXTRAS
  /// @see PackageManager#isPackageSuspended()
  /// @see PackageManager#getSuspendedPackageAppExtras()

  static const String ACTION_MY_PACKAGE_UNSUSPENDED =
      "android.intent.action.MY_PACKAGE_UNSUSPENDED";

  /// Broadcast Action: A user ID has been removed from the system.  The user
  /// ID number is stored in the extra data under {@link #EXTRA_UID}.
  ///
  /// <p class="note">This is a protected intent that can only be sent
  /// by the system.

  static const String ACTION_UID_REMOVED = "android.intent.action.UID_REMOVED";

  /// Broadcast Action: Sent to the installer package of an application when
  /// that application is first launched (that is the first time it is moved
  /// out of the stopped state).  The data contains the name of the package.
  ///
  /// <p>When the application is first launched, the application itself doesn't receive this
  /// broadcast.</p>
  ///
  /// <p class="note">This is a protected intent that can only be sent
  /// by the system.

  static const String ACTION_PACKAGE_FIRST_LAUNCH =
      "android.intent.action.PACKAGE_FIRST_LAUNCH";

  /// Broadcast Action: Sent to the system package verifier when a package
  /// needs to be verified. The data contains the package URI.
  /// <p class="note">
  /// This is a protected intent that can only be sent by the system.
  /// </p>

  static const String ACTION_PACKAGE_NEEDS_VERIFICATION =
      "android.intent.action.PACKAGE_NEEDS_VERIFICATION";

  /// Broadcast Action: Sent to the system package verifier when a package is
  /// verified. The data contains the package URI.
  /// <p class="note">
  /// This is a protected intent that can only be sent by the system.

  static const String ACTION_PACKAGE_VERIFIED =
      "android.intent.action.PACKAGE_VERIFIED";

  /// Broadcast Action: Sent to the system intent filter verifier when an
  /// intent filter needs to be verified. The data contains the filter data
  /// hosts to be verified against.
  /// <p class="note">
  /// This is a protected intent that can only be sent by the system.
  /// </p>
  ///
  /// @hide

  static const String ACTION_INTENT_FILTER_NEEDS_VERIFICATION =
      "android.intent.action.INTENT_FILTER_NEEDS_VERIFICATION";

  /// Broadcast Action: Resources for a set of packages (which were
  /// previously unavailable) are currently
  /// available since the media on which they exist is available.
  /// The extra data {@link #EXTRA_CHANGED_PACKAGE_LIST} contains a
  /// list of packages whose availability changed.
  /// The extra data {@link #EXTRA_CHANGED_UID_LIST} contains a
  /// list of uids of packages whose availability changed.
  /// Note that the
  /// packages in this list do <em>not</em> receive this broadcast.
  /// The specified set of packages are now available on the system.
  /// <p>Includes the following extras:
  /// <ul>
  /// <li> {@link #EXTRA_CHANGED_PACKAGE_LIST} is the set of packages
  /// whose resources(were previously unavailable) are currently available.
  /// {@link #EXTRA_CHANGED_UID_LIST} is the set of uids of the
  /// packages whose resources(were previously unavailable)
  /// are  currently available.
  /// </ul>
  ///
  /// <p class="note">This is a protected intent that can only be sent
  /// by the system.

  static const String ACTION_EXTERNAL_APPLICATIONS_AVAILABLE =
      "android.intent.action.EXTERNAL_APPLICATIONS_AVAILABLE";

  /// Broadcast Action: Resources for a set of packages are currently
  /// unavailable since the media on which they exist is unavailable.
  /// The extra data {@link #EXTRA_CHANGED_PACKAGE_LIST} contains a
  /// list of packages whose availability changed.
  /// The extra data {@link #EXTRA_CHANGED_UID_LIST} contains a
  /// list of uids of packages whose availability changed.
  /// The specified set of packages can no longer be
  /// launched and are practically unavailable on the system.
  /// <p>Inclues the following extras:
  /// <ul>
  /// <li> {@link #EXTRA_CHANGED_PACKAGE_LIST} is the set of packages
  /// whose resources are no longer available.
  /// {@link #EXTRA_CHANGED_UID_LIST} is the set of packages
  /// whose resources are no longer available.
  /// </ul>
  ///
  /// <p class="note">This is a protected intent that can only be sent
  /// by the system.

  static const String ACTION_EXTERNAL_APPLICATIONS_UNAVAILABLE =
      "android.intent.action.EXTERNAL_APPLICATIONS_UNAVAILABLE";

  /// Broadcast Action: preferred activities have changed *explicitly*.
  ///
  /// <p>Note there are cases where a preferred activity is invalidated *implicitly*, e.g.
  /// when an app is installed or uninstalled, but in such cases this broadcast will *not*
  /// be sent.
  ///
  /// {@link #EXTRA_USER_HANDLE} contains the user ID in question.
  ///
  /// @hide

  static const String ACTION_PREFERRED_ACTIVITY_CHANGED =
      "android.intent.action.ACTION_PREFERRED_ACTIVITY_CHANGED";

  /// Broadcast Action:  The current system wallpaper has changed.  See
  /// {@link android.app.WallpaperManager} for retrieving the new wallpaper.
  /// This should <em>only</em> be used to determine when the wallpaper
  /// has changed to show the new wallpaper to the user.  You should certainly
  /// never, in response to this, change the wallpaper or other attributes of
  /// it such as the suggested size.  That would be unexpected, right?  You'd cause
  /// all kinds of loops, especially if other apps are doing similar things,
  /// right?  Of course.  So please don't do this.
  ///
  /// @deprecated Modern applications should use
  /// {@link android.view.WindowManager.LayoutParams#FLAG_SHOW_WALLPAPER
  /// WindowManager.LayoutParams.FLAG_SHOW_WALLPAPER} to have the wallpaper
  /// shown behind their UI, rather than watching for this broadcast and
  /// rendering the wallpaper on their own.
  @deprecated
  static const String ACTION_WALLPAPER_CHANGED =
      "android.intent.action.WALLPAPER_CHANGED";

  /// Broadcast Action: The current device {@link android.content.res.Configuration}
  /// (orientation, locale, etc) has changed.  When such a change happens, the
  /// UIs (view hierarchy) will need to be rebuilt based on this new
  /// information; for the most part, applications don't need to worry about
  /// this, because the system will take care of stopping and restarting the
  /// application to make sure it sees the new changes.  Some system code that
  /// can not be restarted will need to watch for this action and handle it
  /// appropriately.
  ///
  /// <p class="note">
  /// You <em>cannot</em> receive this through components declared
  /// in manifests, only by explicitly registering for it with
  /// {@link Context#registerReceiver(BroadcastReceiver, IntentFilter)
  /// Context.registerReceiver()}.
  ///
  /// <p class="note">This is a protected intent that can only be sent
  /// by the system.
  ///
  /// @see android.content.res.Configuration

  static const String ACTION_CONFIGURATION_CHANGED =
      "android.intent.action.CONFIGURATION_CHANGED";

  /// Broadcast Action: The current device {@link android.content.res.Configuration} has changed
  /// such that the device may be eligible for the installation of additional configuration splits.
  /// Configuration properties that can trigger this broadcast include locale and display density.
  ///
  /// <p class="note">
  /// Unlike {@link #ACTION_CONFIGURATION_CHANGED}, you <em>can</em> receive this through
  /// components declared in manifests. However, the receiver <em>must</em> hold the
  /// {@link android.Manifest.permission#INSTALL_PACKAGES} permission.
  ///
  /// <p class="note">
  /// This is a protected intent that can only be sent by the system.
  ///
  /// @hide

  static const String ACTION_SPLIT_CONFIGURATION_CHANGED =
      "android.intent.action.SPLIT_CONFIGURATION_CHANGED";

  /// Broadcast Action: The current device's locale has changed.
  ///
  /// <p class="note">This is a protected intent that can only be sent
  /// by the system.

  static const String ACTION_LOCALE_CHANGED =
      "android.intent.action.LOCALE_CHANGED";

  /// Broadcast Action:  This is a <em>sticky broadcast</em> containing the
  /// charging state, level, and other information about the battery.
  /// See {@link android.os.BatteryManager} for documentation on the
  /// contents of the Intent.
  ///
  /// <p class="note">
  /// You <em>cannot</em> receive this through components declared
  /// in manifests, only by explicitly registering for it with
  /// {@link Context#registerReceiver(BroadcastReceiver, IntentFilter)
  /// Context.registerReceiver()}.  See {@link #ACTION_BATTERY_LOW},
  /// {@link #ACTION_BATTERY_OKAY}, {@link #ACTION_POWER_CONNECTED},
  /// and {@link #ACTION_POWER_DISCONNECTED} for distinct battery-related
  /// broadcasts that are sent and can be received through manifest
  /// receivers.
  ///
  /// <p class="note">This is a protected intent that can only be sent
  /// by the system.

  static const String ACTION_BATTERY_CHANGED =
      "android.intent.action.BATTERY_CHANGED";

  /// Broadcast Action: Sent when the current battery level changes.
  ///
  /// It has {@link android.os.BatteryManager#EXTRA_EVENTS} that carries a list of {@link Bundle}
  /// instances representing individual battery level changes with associated
  /// extras from {@link #ACTION_BATTERY_CHANGED}.
  ///
  /// <p class="note">
  /// This broadcast requires {@link android.Manifest.permission#BATTERY_STATS} permission.
  ///
  /// @hide

  static const String ACTION_BATTERY_LEVEL_CHANGED =
      "android.intent.action.BATTERY_LEVEL_CHANGED";

  /// Broadcast Action:  Indicates low battery condition on the device.
  /// This broadcast corresponds to the "Low battery warning" system dialog.
  ///
  /// <p class="note">This is a protected intent that can only be sent
  /// by the system.

  static const String ACTION_BATTERY_LOW = "android.intent.action.BATTERY_LOW";

  /// Broadcast Action:  Indicates the battery is now okay after being low.
  /// This will be sent after {@link #ACTION_BATTERY_LOW} once the battery has
  /// gone back up to an okay state.
  ///
  /// <p class="note">This is a protected intent that can only be sent
  /// by the system.

  static const String ACTION_BATTERY_OKAY =
      "android.intent.action.BATTERY_OKAY";

  /// Broadcast Action:  External power has been connected to the device.
  /// This is intended for applications that wish to register specifically to this notification.
  /// Unlike ACTION_BATTERY_CHANGED, applications will be woken for this and so do not have to
  /// stay active to receive this notification.  This action can be used to implement actions
  /// that wait until power is available to trigger.
  ///
  /// <p class="note">This is a protected intent that can only be sent
  /// by the system.

  static const String ACTION_POWER_CONNECTED =
      "android.intent.action.ACTION_POWER_CONNECTED";

  /// Broadcast Action:  External power has been removed from the device.
  /// This is intended for applications that wish to register specifically to this notification.
  /// Unlike ACTION_BATTERY_CHANGED, applications will be woken for this and so do not have to
  /// stay active to receive this notification.  This action can be used to implement actions
  /// that wait until power is available to trigger.
  ///
  /// <p class="note">This is a protected intent that can only be sent
  /// by the system.

  static const String ACTION_POWER_DISCONNECTED =
      "android.intent.action.ACTION_POWER_DISCONNECTED";

  /// Broadcast Action:  Device is shutting down.
  /// This is broadcast when the device is being shut down (completely turned
  /// off, not sleeping).  Once the broadcast is complete, the const shutdown
  /// will proceed and all unsaved data lost.  Apps will not normally need
  /// to handle this, since the foreground activity will be paused as well.
  /// <p>As of {@link Build.VERSION_CODES#P} this broadcast is only sent to receivers registered
  /// through {@link Context#registerReceiver(BroadcastReceiver, IntentFilter)
  /// Context.registerReceiver}.
  ///
  /// <p class="note">This is a protected intent that can only be sent
  /// by the system.
  /// <p>May include the following extras:
  /// <ul>
  /// <li> {@link #EXTRA_SHUTDOWN_USERSPACE_ONLY} a boolean that is set to true if this
  /// shutdown is only for userspace processes.  If not set, assumed to be false.
  /// </ul>

  static const String ACTION_SHUTDOWN = "android.intent.action.ACTION_SHUTDOWN";

  /// Activity Action:  Start this activity to request system shutdown.
  /// The optional boolean extra field {@link #EXTRA_KEY_CONFIRM} can be set to true
  /// to request confirmation from the user before shutting down. The optional boolean
  /// extra field {@link #EXTRA_USER_REQUESTED_SHUTDOWN} can be set to true to
  /// indicate that the shutdown is requested by the user.
  ///
  /// <p class="note">This is a protected intent that can only be sent
  /// by the system.
  ///
  /// {@hide}
  static const String ACTION_REQUEST_SHUTDOWN =
      "com.android.internal.intent.action.REQUEST_SHUTDOWN";

  /// Broadcast Action: A sticky broadcast that indicates low storage space
  /// condition on the device
  /// <p class="note">
  /// This is a protected intent that can only be sent by the system.
  ///
  /// @deprecated if your app targets {@link android.os.Build.VERSION_CODES#O}
  ///             or above, this broadcast will no longer be delivered to any
  ///             {@link BroadcastReceiver} defined in your manifest. Instead,
  ///             apps are strongly encouraged to use the improved
  ///             {@link Context#getCacheDir()} behavior so the system can
  ///             automatically free up storage when needed.

  @deprecated
  static const String ACTION_DEVICE_STORAGE_LOW =
      "android.intent.action.DEVICE_STORAGE_LOW";

  /// Broadcast Action: Indicates low storage space condition on the device no
  /// longer exists
  /// <p class="note">
  /// This is a protected intent that can only be sent by the system.
  ///
  /// @deprecated if your app targets {@link android.os.Build.VERSION_CODES#O}
  ///             or above, this broadcast will no longer be delivered to any
  ///             {@link BroadcastReceiver} defined in your manifest. Instead,
  ///             apps are strongly encouraged to use the improved
  ///             {@link Context#getCacheDir()} behavior so the system can
  ///             automatically free up storage when needed.

  @deprecated
  static const String ACTION_DEVICE_STORAGE_OK =
      "android.intent.action.DEVICE_STORAGE_OK";

  /// Broadcast Action: A sticky broadcast that indicates a storage space full
  /// condition on the device. This is intended for activities that want to be
  /// able to fill the data partition completely, leaving only enough free
  /// space to prevent system-wide SQLite failures.
  /// <p class="note">
  /// This is a protected intent that can only be sent by the system.
  ///
  /// @deprecated if your app targets {@link android.os.Build.VERSION_CODES#O}
  ///             or above, this broadcast will no longer be delivered to any
  ///             {@link BroadcastReceiver} defined in your manifest. Instead,
  ///             apps are strongly encouraged to use the improved
  ///             {@link Context#getCacheDir()} behavior so the system can
  ///             automatically free up storage when needed.
  /// @hide

  @deprecated
  static const String ACTION_DEVICE_STORAGE_FULL =
      "android.intent.action.DEVICE_STORAGE_FULL";

  /// Broadcast Action: Indicates storage space full condition on the device no
  /// longer exists.
  /// <p class="note">
  /// This is a protected intent that can only be sent by the system.
  ///
  /// @deprecated if your app targets {@link android.os.Build.VERSION_CODES#O}
  ///             or above, this broadcast will no longer be delivered to any
  ///             {@link BroadcastReceiver} defined in your manifest. Instead,
  ///             apps are strongly encouraged to use the improved
  ///             {@link Context#getCacheDir()} behavior so the system can
  ///             automatically free up storage when needed.
  /// @hide

  @deprecated
  static const String ACTION_DEVICE_STORAGE_NOT_FULL =
      "android.intent.action.DEVICE_STORAGE_NOT_FULL";

  /// Broadcast Action:  Indicates low memory condition notification acknowledged by user
  /// and package management should be started.
  /// This is triggered by the user from the ACTION_DEVICE_STORAGE_LOW
  /// notification.

  static const String ACTION_MANAGE_PACKAGE_STORAGE =
      "android.intent.action.MANAGE_PACKAGE_STORAGE";

  /// Broadcast Action:  The device has entered USB Mass Storage mode.
  /// This is used mainly for the USB Settings panel.
  /// Apps should listen for ACTION_MEDIA_MOUNTED and ACTION_MEDIA_UNMOUNTED broadcasts to be notified
  /// when the SD card file system is mounted or unmounted
  /// @deprecated replaced by android.os.storage.StorageEventListener
  @deprecated
  static const String ACTION_UMS_CONNECTED =
      "android.intent.action.UMS_CONNECTED";

  /// Broadcast Action:  The device has exited USB Mass Storage mode.
  /// This is used mainly for the USB Settings panel.
  /// Apps should listen for ACTION_MEDIA_MOUNTED and ACTION_MEDIA_UNMOUNTED broadcasts to be notified
  /// when the SD card file system is mounted or unmounted
  /// @deprecated replaced by android.os.storage.StorageEventListener
  @deprecated
  static const String ACTION_UMS_DISCONNECTED =
      "android.intent.action.UMS_DISCONNECTED";

  /// Broadcast Action:  External media has been removed.
  /// The path to the mount point for the removed media is contained in the Intent.mData field.

  static const String ACTION_MEDIA_REMOVED =
      "android.intent.action.MEDIA_REMOVED";

  /// Broadcast Action:  External media is present, but not mounted at its mount point.
  /// The path to the mount point for the unmounted media is contained in the Intent.mData field.

  static const String ACTION_MEDIA_UNMOUNTED =
      "android.intent.action.MEDIA_UNMOUNTED";

  /// Broadcast Action:  External media is present, and being disk-checked
  /// The path to the mount point for the checking media is contained in the Intent.mData field.

  static const String ACTION_MEDIA_CHECKING =
      "android.intent.action.MEDIA_CHECKING";

  /// Broadcast Action:  External media is present, but is using an incompatible fs (or is blank)
  /// The path to the mount point for the checking media is contained in the Intent.mData field.

  static const String ACTION_MEDIA_NOFS = "android.intent.action.MEDIA_NOFS";

  /// Broadcast Action:  External media is present and mounted at its mount point.
  /// The path to the mount point for the mounted media is contained in the Intent.mData field.
  /// The Intent contains an extra with name "read-only" and Boolean value to indicate if the
  /// media was mounted read only.

  static const String ACTION_MEDIA_MOUNTED =
      "android.intent.action.MEDIA_MOUNTED";

  /// Broadcast Action:  External media is unmounted because it is being shared via USB mass storage.
  /// The path to the mount point for the shared media is contained in the Intent.mData field.

  static const String ACTION_MEDIA_SHARED =
      "android.intent.action.MEDIA_SHARED";

  /// Broadcast Action:  External media is no longer being shared via USB mass storage.
  /// The path to the mount point for the previously shared media is contained in the Intent.mData field.
  ///
  /// @hide
  static const String ACTION_MEDIA_UNSHARED =
      "android.intent.action.MEDIA_UNSHARED";

  /// Broadcast Action:  External media was removed from SD card slot, but mount point was not unmounted.
  /// The path to the mount point for the removed media is contained in the Intent.mData field.

  static const String ACTION_MEDIA_BAD_REMOVAL =
      "android.intent.action.MEDIA_BAD_REMOVAL";

  /// Broadcast Action:  External media is present but cannot be mounted.
  /// The path to the mount point for the unmountable media is contained in the Intent.mData field.

  static const String ACTION_MEDIA_UNMOUNTABLE =
      "android.intent.action.MEDIA_UNMOUNTABLE";

  /// Broadcast Action:  User has expressed the desire to remove the external storage media.
  /// Applications should close all files they have open within the mount point when they receive this intent.
  /// The path to the mount point for the media to be ejected is contained in the Intent.mData field.

  static const String ACTION_MEDIA_EJECT = "android.intent.action.MEDIA_EJECT";

  /// Broadcast Action:  The media scanner has started scanning a directory.
  /// The path to the directory being scanned is contained in the Intent.mData field.

  static const String ACTION_MEDIA_SCANNER_STARTED =
      "android.intent.action.MEDIA_SCANNER_STARTED";

  /// Broadcast Action:  The media scanner has finished scanning a directory.
  /// The path to the scanned directory is contained in the Intent.mData field.

  static const String ACTION_MEDIA_SCANNER_FINISHED =
      "android.intent.action.MEDIA_SCANNER_FINISHED";

  /// Broadcast Action: Request the media scanner to scan a file and add it to
  /// the media database.
  /// <p>
  /// The path to the file is contained in {@link Intent#getData()}.
  ///
  /// @deprecated Callers should migrate to inserting items directly into
  ///             {@link MediaStore}, where they will be automatically scanned
  ///             after each mutation.

  @deprecated
  static const String ACTION_MEDIA_SCANNER_SCAN_FILE =
      "android.intent.action.MEDIA_SCANNER_SCAN_FILE";

  /// Broadcast Action:  The "Media Button" was pressed.  Includes a single
  /// extra field, {@link #EXTRA_KEY_EVENT}, containing the key event that
  /// caused the broadcast.

  static const String ACTION_MEDIA_BUTTON =
      "android.intent.action.MEDIA_BUTTON";

  /// Broadcast Action:  The "Camera Button" was pressed.  Includes a single
  /// extra field, {@link #EXTRA_KEY_EVENT}, containing the key event that
  /// caused the broadcast.

  static const String ACTION_CAMERA_BUTTON =
      "android.intent.action.CAMERA_BUTTON";
  // *** NOTE: @todo(*) The following really should go into a more domain-specific
  // location; they are not general-purpose actions.
  /// Broadcast Action: A GTalk connection has been established.

  static const String ACTION_GTALK_SERVICE_CONNECTED =
      "android.intent.action.GTALK_CONNECTED";

  /// Broadcast Action: A GTalk connection has been disconnected.

  static const String ACTION_GTALK_SERVICE_DISCONNECTED =
      "android.intent.action.GTALK_DISCONNECTED";

  /// Broadcast Action: An input method has been changed.

  static const String ACTION_INPUT_METHOD_CHANGED =
      "android.intent.action.INPUT_METHOD_CHANGED";

  /// <p>Broadcast Action: The user has switched the phone into or out of Airplane Mode. One or
  /// more radios have been turned off or on. The intent will have the following extra value:</p>
  /// <ul>
  ///   <li><em>state</em> - A boolean value indicating whether Airplane Mode is on. If true,
  ///   then cell radio and possibly other radios such as bluetooth or WiFi may have also been
  ///   turned off</li>
  /// </ul>
  ///
  /// <p class="note">This is a protected intent that can only be sent by the system.</p>

  static const String ACTION_AIRPLANE_MODE_CHANGED =
      "android.intent.action.AIRPLANE_MODE";

  /// Broadcast Action: Some content providers have parts of their namespace
  /// where they publish new events or items that the user may be especially
  /// interested in. For these things, they may broadcast this action when the
  /// set of interesting items change.
  ///
  /// For example, GmailProvider sends this notification when the set of unread
  /// mail in the inbox changes.
  ///
  /// <p>The data of the intent identifies which part of which provider
  /// changed. When queried through the content resolver, the data URI will
  /// return the data set in question.
  ///
  /// <p>The intent will have the following extra values:
  /// <ul>
  ///   <li><em>count</em> - The number of items in the data set. This is the
  ///       same as the number of items in the cursor returned by querying the
  ///       data URI. </li>
  /// </ul>
  ///
  /// This intent will be sent at boot (if the count is non-zero) and when the
  /// data set changes. It is possible for the data set to change without the
  /// count changing (for example, if a new unread message arrives in the same
  /// sync operation in which a message is archived). The phone should still
  /// ring/vibrate/etc as normal in this case.

  static const String ACTION_PROVIDER_CHANGED =
      "android.intent.action.PROVIDER_CHANGED";

  /// Broadcast Action: Wired Headset plugged in or unplugged.
  ///
  /// Same as {@link android.media.AudioManager#ACTION_HEADSET_PLUG}, to be consulted for value
  ///   and documentation.
  /// <p>If the minimum SDK version of your application is
  /// {@link android.os.Build.VERSION_CODES#LOLLIPOP}, it is recommended to refer
  /// to the <code>AudioManager</code> constant in your receiver registration code instead.

  static const String ACTION_HEADSET_PLUG = AudioManager.ACTION_HEADSET_PLUG;

  /// <p>Broadcast Action: The user has switched on advanced settings in the settings app:</p>
  /// <ul>
  ///   <li><em>state</em> - A boolean value indicating whether the settings is on or off.</li>
  /// </ul>
  ///
  /// <p class="note">This is a protected intent that can only be sent
  /// by the system.
  ///
  /// @hide
  //
  static const String ACTION_ADVANCED_SETTINGS_CHANGED =
      "android.intent.action.ADVANCED_SETTINGS";

  ///  Broadcast Action: Sent after application restrictions are changed.
  ///
  /// <p class="note">This is a protected intent that can only be sent
  /// by the system.</p>

  static const String ACTION_APPLICATION_RESTRICTIONS_CHANGED =
      "android.intent.action.APPLICATION_RESTRICTIONS_CHANGED";

  /// Broadcast Action: An outgoing call is about to be placed.
  ///
  /// <p>The Intent will have the following extra value:</p>
  /// <ul>
  ///   <li><em>{@link android.content.Intent#EXTRA_PHONE_NUMBER}</em> -
  ///       the phone number originally intended to be dialed.</li>
  /// </ul>
  /// <p>Once the broadcast is finished, the resultData is used as the actual
  /// number to call.  If  <code>null</code>, no call will be placed.</p>
  /// <p>It is perfectly acceptable for multiple receivers to process the
  /// outgoing call in turn: for example, a parental control application
  /// might verify that the user is authorized to place the call at that
  /// time, then a number-rewriting application might add an area code if
  /// one was not specified.</p>
  /// <p>For consistency, any receiver whose purpose is to prohibit phone
  /// calls should have a priority of 0, to ensure it will see the const
  /// phone number to be dialed.
  /// Any receiver whose purpose is to rewrite phone numbers to be called
  /// should have a positive priority.
  /// Negative priorities are reserved for the system for this broadcast;
  /// using them may cause problems.</p>
  /// <p>Any BroadcastReceiver receiving this Intent <em>must not</em>
  /// abort the broadcast.</p>
  /// <p>Emergency calls cannot be intercepted using this mechanism, and
  /// other calls cannot be modified to call emergency numbers using this
  /// mechanism.
  /// <p>Some apps (such as VoIP apps) may want to redirect the outgoing
  /// call to use their own service instead. Those apps should first prevent
  /// the call from being placed by setting resultData to <code>null</code>
  /// and then start their own app to make the call.
  /// <p>You must hold the
  /// {@link android.Manifest.permission#PROCESS_OUTGOING_CALLS}
  /// permission to receive this Intent.</p>
  ///
  /// <p class="note">This is a protected intent that can only be sent
  /// by the system.
  ///
  /// <p class="note">If the user has chosen a {@link android.telecom.CallRedirectionService} to
  /// handle redirection of outgoing calls, this intent will NOT be sent as an ordered broadcast.
  /// This means that attempts to re-write the outgoing call by other apps using this intent will
  /// be ignored.
  /// </p>
  ///
  /// @deprecated Apps that redirect outgoing calls should use the
  /// {@link android.telecom.CallRedirectionService} API.  Apps that perform call screening
  /// should use the {@link android.telecom.CallScreeningService} API.  Apps which need to be
  /// notified of basic call state should use
  /// {@link android.telephony.PhoneStateListener#onCallStateChanged(int, String)} to determine
  /// when a new outgoing call is placed.
  @deprecated
  static const String ACTION_NEW_OUTGOING_CALL =
      "android.intent.action.NEW_OUTGOING_CALL";

  /// Broadcast Action: Have the device reboot.  This is only for use by
  /// system code.
  ///
  /// <p class="note">This is a protected intent that can only be sent
  /// by the system.

  static const String ACTION_REBOOT = "android.intent.action.REBOOT";

  /// Broadcast Action:  A sticky broadcast for changes in the physical
  /// docking state of the device.
  ///
  /// <p>The intent will have the following extra values:
  /// <ul>
  ///   <li><em>{@link #EXTRA_DOCK_STATE}</em> - the current dock
  ///       state, indicating which dock the device is physically in.</li>
  /// </ul>
  /// <p>This is intended for monitoring the current physical dock state.
  /// See {@link android.app.UiModeManager} for the normal API dealing with
  /// dock mode changes.

  static const String ACTION_DOCK_EVENT = "android.intent.action.DOCK_EVENT";

  /// Broadcast Action: A broadcast when idle maintenance can be started.
  /// This means that the user is not interacting with the device and is
  /// not expected to do so soon. Typical use of the idle maintenance is
  /// to perform somehow expensive tasks that can be postponed at a moment
  /// when they will not degrade user experience.
  /// <p>
  /// <p class="note">In order to keep the device responsive in case of an
  /// unexpected user interaction, implementations of a maintenance task
  /// should be interruptible. In such a scenario a broadcast with action
  /// {@link #ACTION_IDLE_MAINTENANCE_END} will be sent. In other words, you
  /// should not do the maintenance work in
  /// {@link BroadcastReceiver#onReceive(Context, Intent)}, rather start a
  /// maintenance service by {@link Context#startService(Intent)}. Also
  /// you should hold a wake lock while your maintenance service is running
  /// to prevent the device going to sleep.
  /// </p>
  /// <p>
  /// <p class="note">This is a protected intent that can only be sent by
  /// the system.
  /// </p>
  ///
  /// @see #ACTION_IDLE_MAINTENANCE_END
  ///
  /// @hide

  static const String ACTION_IDLE_MAINTENANCE_START =
      "android.intent.action.ACTION_IDLE_MAINTENANCE_START";

  /// Broadcast Action:  A broadcast when idle maintenance should be stopped.
  /// This means that the user was not interacting with the device as a result
  /// of which a broadcast with action {@link #ACTION_IDLE_MAINTENANCE_START}
  /// was sent and now the user started interacting with the device. Typical
  /// use of the idle maintenance is to perform somehow expensive tasks that
  /// can be postponed at a moment when they will not degrade user experience.
  /// <p>
  /// <p class="note">In order to keep the device responsive in case of an
  /// unexpected user interaction, implementations of a maintenance task
  /// should be interruptible. Hence, on receiving a broadcast with this
  /// action, the maintenance task should be interrupted as soon as possible.
  /// In other words, you should not do the maintenance work in
  /// {@link BroadcastReceiver#onReceive(Context, Intent)}, rather stop the
  /// maintenance service that was started on receiving of
  /// {@link #ACTION_IDLE_MAINTENANCE_START}.Also you should release the wake
  /// lock you acquired when your maintenance service started.
  /// </p>
  /// <p class="note">This is a protected intent that can only be sent
  /// by the system.
  ///
  /// @see #ACTION_IDLE_MAINTENANCE_START
  ///
  /// @hide

  static const String ACTION_IDLE_MAINTENANCE_END =
      "android.intent.action.ACTION_IDLE_MAINTENANCE_END";

  /// Broadcast Action: a remote intent is to be broadcasted.
  ///
  /// A remote intent is used for remote RPC between devices. The remote intent
  /// is serialized and sent from one device to another device. The receiving
  /// device parses the remote intent and broadcasts it. Note that anyone can
  /// broadcast a remote intent. However, if the intent receiver of the remote intent
  /// does not trust intent broadcasts from arbitrary intent senders, it should require
  /// the sender to hold certain permissions so only trusted sender's broadcast will be
  /// let through.
  /// @hide
  static const String ACTION_REMOTE_INTENT =
      "com.google.android.c2dm.intent.RECEIVE";

  /// Broadcast Action: This is broadcast once when the user is booting after a
  /// system update. It can be used to perform cleanup or upgrades after a
  /// system update.
  /// <p>
  /// This broadcast is sent after the {@link #ACTION_LOCKED_BOOT_COMPLETED}
  /// broadcast but before the {@link #ACTION_BOOT_COMPLETED} broadcast. It's
  /// only sent when the {@link Build#FINGERPRINT} has changed, and it's only
  /// sent to receivers in the system image.
  ///
  /// @hide

  static const String ACTION_PRE_BOOT_COMPLETED =
      "android.intent.action.PRE_BOOT_COMPLETED";

  /// Broadcast to a specific application to query any supported restrictions to impose
  /// on restricted users. The broadcast intent contains an extra
  /// {@link #EXTRA_RESTRICTIONS_BUNDLE} with the currently persisted
  /// restrictions as a Bundle of key/value pairs. The value types can be Boolean, String or
  /// String[] depending on the restriction type.<p/>
  /// The response should contain an extra {@link #EXTRA_RESTRICTIONS_LIST},
  /// which is of type <code>ArrayList&lt;RestrictionEntry&gt;</code>. It can also
  /// contain an extra {@link #EXTRA_RESTRICTIONS_INTENT}, which is of type <code>Intent</code>.
  /// The activity specified by that intent will be launched for a result which must contain
  /// one of the extras {@link #EXTRA_RESTRICTIONS_LIST} or {@link #EXTRA_RESTRICTIONS_BUNDLE}.
  /// The keys and values of the returned restrictions will be persisted.
  /// @see RestrictionEntry
  static const String ACTION_GET_RESTRICTION_ENTRIES =
      "android.intent.action.GET_RESTRICTION_ENTRIES";

  /// Sent the first time a user is starting, to allow system apps to
  /// perform one time initialization.  (This will not be seen by third
  /// party applications because a newly initialized user does not have any
  /// third party applications installed for it.)  This is sent early in
  /// starting the user, around the time the home app is started, before
  /// {@link #ACTION_BOOT_COMPLETED} is sent.  This is sent as a foreground
  /// broadcast, since it is part of a visible user interaction; be as quick
  /// as possible when handling it.
  static const String ACTION_USER_INITIALIZE =
      "android.intent.action.USER_INITIALIZE";

  /// Sent when a user switch is happening, causing the process's user to be
  /// brought to the foreground.  This is only sent to receivers registered
  /// through {@link Context#registerReceiver(BroadcastReceiver, IntentFilter)
  /// Context.registerReceiver}.  It is sent to the user that is going to the
  /// foreground.  This is sent as a foreground
  /// broadcast, since it is part of a visible user interaction; be as quick
  /// as possible when handling it.
  static const String ACTION_USER_FOREGROUND =
      "android.intent.action.USER_FOREGROUND";

  /// Sent when a user switch is happening, causing the process's user to be
  /// sent to the background.  This is only sent to receivers registered
  /// through {@link Context#registerReceiver(BroadcastReceiver, IntentFilter)
  /// Context.registerReceiver}.  It is sent to the user that is going to the
  /// background.  This is sent as a foreground
  /// broadcast, since it is part of a visible user interaction; be as quick
  /// as possible when handling it.
  static const String ACTION_USER_BACKGROUND =
      "android.intent.action.USER_BACKGROUND";

  /// Broadcast sent to the system when a user is added. Carries an extra
  /// EXTRA_USER_HANDLE that has the userHandle of the new user.  It is sent to
  /// all running users.  You must hold
  /// {@link android.Manifest.permission#MANAGE_USERS} to receive this broadcast.
  /// @hide

  static const String ACTION_USER_ADDED = "android.intent.action.USER_ADDED";

  /// Broadcast sent by the system when a user is started. Carries an extra
  /// EXTRA_USER_HANDLE that has the userHandle of the user.  This is only sent to
  /// registered receivers, not manifest receivers.  It is sent to the user
  /// that has been started.  This is sent as a foreground
  /// broadcast, since it is part of a visible user interaction; be as quick
  /// as possible when handling it.
  /// @hide
  static const String ACTION_USER_STARTED =
      "android.intent.action.USER_STARTED";

  /// Broadcast sent when a user is in the process of starting.  Carries an extra
  /// EXTRA_USER_HANDLE that has the userHandle of the user.  This is only
  /// sent to registered receivers, not manifest receivers.  It is sent to all
  /// users (including the one that is being started).  You must hold
  /// {@link android.Manifest.permission#INTERACT_ACROSS_USERS} to receive
  /// this broadcast.  This is sent as a background broadcast, since
  /// its result is not part of the primary UX flow; to safely keep track of
  /// started/stopped state of a user you can use this in conjunction with
  /// {@link #ACTION_USER_STOPPING}.  It is <b>not</b> generally safe to use with
  /// other user state broadcasts since those are foreground broadcasts so can
  /// execute in a different order.
  /// @hide
  static const String ACTION_USER_STARTING =
      "android.intent.action.USER_STARTING";

  /// Broadcast sent when a user is going to be stopped.  Carries an extra
  /// EXTRA_USER_HANDLE that has the userHandle of the user.  This is only
  /// sent to registered receivers, not manifest receivers.  It is sent to all
  /// users (including the one that is being stopped).  You must hold
  /// {@link android.Manifest.permission#INTERACT_ACROSS_USERS} to receive
  /// this broadcast.  The user will not stop until all receivers have
  /// handled the broadcast.  This is sent as a background broadcast, since
  /// its result is not part of the primary UX flow; to safely keep track of
  /// started/stopped state of a user you can use this in conjunction with
  /// {@link #ACTION_USER_STARTING}.  It is <b>not</b> generally safe to use with
  /// other user state broadcasts since those are foreground broadcasts so can
  /// execute in a different order.
  /// @hide
  static const String ACTION_USER_STOPPING =
      "android.intent.action.USER_STOPPING";

  /// Broadcast sent to the system when a user is stopped. Carries an extra
  /// EXTRA_USER_HANDLE that has the userHandle of the user.  This is similar to
  /// {@link #ACTION_PACKAGE_RESTARTED}, but for an entire user instead of a
  /// specific package.  This is only sent to registered receivers, not manifest
  /// receivers.  It is sent to all running users <em>except</em> the one that
  /// has just been stopped (which is no longer running).
  /// @hide
  static const String ACTION_USER_STOPPED =
      "android.intent.action.USER_STOPPED";

  /// Broadcast sent to the system when a user is removed. Carries an extra EXTRA_USER_HANDLE that has
  /// the userHandle of the user.  It is sent to all running users except the
  /// one that has been removed. The user will not be completely removed until all receivers have
  /// handled the broadcast. You must hold
  /// {@link android.Manifest.permission#MANAGE_USERS} to receive this broadcast.
  /// @hide

  static const String ACTION_USER_REMOVED =
      "android.intent.action.USER_REMOVED";

  /// Broadcast sent to the system when the user switches. Carries an extra EXTRA_USER_HANDLE that has
  /// the userHandle of the user to become the current one. This is only sent to
  /// registered receivers, not manifest receivers.  It is sent to all running users.
  /// You must hold
  /// {@link android.Manifest.permission#MANAGE_USERS} to receive this broadcast.
  /// @hide

  static const String ACTION_USER_SWITCHED =
      "android.intent.action.USER_SWITCHED";

  /// Broadcast Action: Sent when the credential-encrypted private storage has
  /// become unlocked for the target user. This is only sent to registered
  /// receivers, not manifest receivers.

  static const String ACTION_USER_UNLOCKED =
      "android.intent.action.USER_UNLOCKED";

  /// Broadcast sent to the system when a user's information changes. Carries an extra
  /// {@link #EXTRA_USER_HANDLE} to indicate which user's information changed.
  /// This is only sent to registered receivers, not manifest receivers. It is sent to all users.
  /// @hide
  static const String ACTION_USER_INFO_CHANGED =
      "android.intent.action.USER_INFO_CHANGED";

  /// Broadcast sent to the primary user when an associated managed profile is added (the profile
  /// was created and is ready to be used). Carries an extra {@link #EXTRA_USER} that specifies
  /// the UserHandle of the profile that was added. Only applications (for example Launchers)
  /// that need to display merged content across both primary and managed profiles need to
  /// worry about this broadcast. This is only sent to registered receivers,
  /// not manifest receivers.
  static const String ACTION_MANAGED_PROFILE_ADDED =
      "android.intent.action.MANAGED_PROFILE_ADDED";

  /// Broadcast sent to the primary user when an associated managed profile is removed. Carries an
  /// extra {@link #EXTRA_USER} that specifies the UserHandle of the profile that was removed.
  /// Only applications (for example Launchers) that need to display merged content across both
  /// primary and managed profiles need to worry about this broadcast. This is only sent to
  /// registered receivers, not manifest receivers.
  static const String ACTION_MANAGED_PROFILE_REMOVED =
      "android.intent.action.MANAGED_PROFILE_REMOVED";

  /// Broadcast sent to the primary user when the credential-encrypted private storage for
  /// an associated managed profile is unlocked. Carries an extra {@link #EXTRA_USER} that
  /// specifies the UserHandle of the profile that was unlocked. Only applications (for example
  /// Launchers) that need to display merged content across both primary and managed profiles
  /// need to worry about this broadcast. This is only sent to registered receivers,
  /// not manifest receivers.
  static const String ACTION_MANAGED_PROFILE_UNLOCKED =
      "android.intent.action.MANAGED_PROFILE_UNLOCKED";

  /// Broadcast sent to the primary user when an associated managed profile has become available.
  /// Currently this includes when the user disables quiet mode for the profile. Carries an extra
  /// {@link #EXTRA_USER} that specifies the UserHandle of the profile. When quiet mode is changed,
  /// this broadcast will carry a boolean extra {@link #EXTRA_QUIET_MODE} indicating the new state
  /// of quiet mode. This is only sent to registered receivers, not manifest receivers.
  static const String ACTION_MANAGED_PROFILE_AVAILABLE =
      "android.intent.action.MANAGED_PROFILE_AVAILABLE";

  /// Broadcast sent to the primary user when an associated managed profile has become unavailable.
  /// Currently this includes when the user enables quiet mode for the profile. Carries an extra
  /// {@link #EXTRA_USER} that specifies the UserHandle of the profile. When quiet mode is changed,
  /// this broadcast will carry a boolean extra {@link #EXTRA_QUIET_MODE} indicating the new state
  /// of quiet mode. This is only sent to registered receivers, not manifest receivers.
  static const String ACTION_MANAGED_PROFILE_UNAVAILABLE =
      "android.intent.action.MANAGED_PROFILE_UNAVAILABLE";

  /// Broadcast sent to the system user when the 'device locked' state changes for any user.
  /// Carries an extra {@link #EXTRA_USER_HANDLE} that specifies the ID of the user for which
  /// the device was locked or unlocked.
  ///
  /// This is only sent to registered receivers.
  ///
  /// @hide
  static const String ACTION_DEVICE_LOCKED_CHANGED =
      "android.intent.action.DEVICE_LOCKED_CHANGED";

  /// Sent when the user taps on the clock widget in the system's "quick settings" area.
  static const String ACTION_QUICK_CLOCK = "android.intent.action.QUICK_CLOCK";

  /// Activity Action: Shows the brightness setting dialog.
  /// @hide
  static const String ACTION_SHOW_BRIGHTNESS_DIALOG =
      "com.android.intent.action.SHOW_BRIGHTNESS_DIALOG";

  /// Broadcast Action:  A global button was pressed.  Includes a single
  /// extra field, {@link #EXTRA_KEY_EVENT}, containing the key event that
  /// caused the broadcast.
  /// @hide

  static const String ACTION_GLOBAL_BUTTON =
      "android.intent.action.GLOBAL_BUTTON";

  /// Broadcast Action: Sent when media resource is granted.
  /// <p>
  /// {@link #EXTRA_PACKAGES} specifies the packages on the process holding the media resource
  /// granted.
  /// </p>
  /// <p class="note">
  /// This is a protected intent that can only be sent by the system.
  /// </p>
  /// <p class="note">
  /// This requires {@link android.Manifest.permission#RECEIVE_MEDIA_RESOURCE_USAGE} permission.
  /// </p>
  ///
  /// @hide
  static const String ACTION_MEDIA_RESOURCE_GRANTED =
      "android.intent.action.MEDIA_RESOURCE_GRANTED";

  /// Broadcast Action: An overlay package has changed. The data contains the
  /// name of the overlay package which has changed. This is broadcast on all
  /// changes to the OverlayInfo returned by {@link
  /// android.content.om.IOverlayManager#getOverlayInfo(String, int)}. The
  /// most common change is a state change that will change whether the
  /// overlay is enabled or not.
  /// @hide
  static const String ACTION_OVERLAY_CHANGED =
      "android.intent.action.OVERLAY_CHANGED";

  /// Activity Action: Allow the user to select and return one or more existing
  /// documents. When invoked, the system will display the various
  /// {@link DocumentsProvider} instances installed on the device, letting the
  /// user interactively navigate through them. These documents include local
  /// media, such as photos and video, and documents provided by installed
  /// cloud storage providers.
  /// <p>
  /// Each document is represented as a {@code content://} URI backed by a
  /// {@link DocumentsProvider}, which can be opened as a stream with
  /// {@link ContentResolver#openFileDescriptor(Uri, String)}, or queried for
  /// {@link android.provider.DocumentsContract.Document} metadata.
  /// <p>
  /// All selected documents are returned to the calling application with
  /// persistable read and write permission grants. If you want to maintain
  /// access to the documents across device reboots, you need to explicitly
  /// take the persistable permissions using
  /// {@link ContentResolver#takePersistableUriPermission(Uri, int)}.
  /// <p>
  /// Callers must indicate the acceptable document MIME types through
  /// {@link #setType(String)}. For example, to select photos, use
  /// {@code image/*}. If multiple disjoint MIME types are acceptable, define
  /// them in {@link #EXTRA_MIME_TYPES} and {@link #setType(String)} to
  /// {@literal *}/*.
  /// <p>
  /// If the caller can handle multiple returned items (the user performing
  /// multiple selection), then you can specify {@link #EXTRA_ALLOW_MULTIPLE}
  /// to indicate this.
  /// <p>
  /// Callers must include {@link #CATEGORY_OPENABLE} in the Intent to obtain
  /// URIs that can be opened with
  /// {@link ContentResolver#openFileDescriptor(Uri, String)}.
  /// <p>
  /// Callers can set a document URI through
  /// {@link DocumentsContract#EXTRA_INITIAL_URI} to indicate the initial
  /// location of documents navigator. System will do its best to launch the
  /// navigator in the specified document if it's a folder, or the folder that
  /// contains the specified document if not.
  /// <p>
  /// Output: The URI of the item that was picked, returned in
  /// {@link #getData()}. This must be a {@code content://} URI so that any
  /// receiver can access it. If multiple documents were selected, they are
  /// returned in {@link #getClipData()}.
  ///
  /// @see DocumentsContract
  /// @see #ACTION_OPEN_DOCUMENT_TREE
  /// @see #ACTION_CREATE_DOCUMENT
  /// @see #FLAG_GRANT_PERSISTABLE_URI_PERMISSION

  static const String ACTION_OPEN_DOCUMENT =
      "android.intent.action.OPEN_DOCUMENT";

  /// Activity Action: Allow the user to create a new document. When invoked,
  /// the system will display the various {@link DocumentsProvider} instances
  /// installed on the device, letting the user navigate through them. The
  /// returned document may be a newly created document with no content, or it
  /// may be an existing document with the requested MIME type.
  /// <p>
  /// Each document is represented as a {@code content://} URI backed by a
  /// {@link DocumentsProvider}, which can be opened as a stream with
  /// {@link ContentResolver#openFileDescriptor(Uri, String)}, or queried for
  /// {@link android.provider.DocumentsContract.Document} metadata.
  /// <p>
  /// Callers must indicate the concrete MIME type of the document being
  /// created by setting {@link #setType(String)}. This MIME type cannot be
  /// changed after the document is created.
  /// <p>
  /// Callers can provide an initial display name through {@link #EXTRA_TITLE},
  /// but the user may change this value before creating the file.
  /// <p>
  /// Callers must include {@link #CATEGORY_OPENABLE} in the Intent to obtain
  /// URIs that can be opened with
  /// {@link ContentResolver#openFileDescriptor(Uri, String)}.
  /// <p>
  /// Callers can set a document URI through
  /// {@link DocumentsContract#EXTRA_INITIAL_URI} to indicate the initial
  /// location of documents navigator. System will do its best to launch the
  /// navigator in the specified document if it's a folder, or the folder that
  /// contains the specified document if not.
  /// <p>
  /// Output: The URI of the item that was created. This must be a
  /// {@code content://} URI so that any receiver can access it.
  ///
  /// @see DocumentsContract
  /// @see #ACTION_OPEN_DOCUMENT
  /// @see #ACTION_OPEN_DOCUMENT_TREE
  /// @see #FLAG_GRANT_PERSISTABLE_URI_PERMISSION

  static const String ACTION_CREATE_DOCUMENT =
      "android.intent.action.CREATE_DOCUMENT";

  /// Activity Action: Allow the user to pick a directory subtree. When
  /// invoked, the system will display the various {@link DocumentsProvider}
  /// instances installed on the device, letting the user navigate through
  /// them. Apps can fully manage documents within the returned directory.
  /// <p>
  /// To gain access to descendant (child, grandchild, etc) documents, use
  /// {@link DocumentsContract#buildDocumentUriUsingTree(Uri, String)} and
  /// {@link DocumentsContract#buildChildDocumentsUriUsingTree(Uri, String)}
  /// with the returned URI.
  /// <p>
  /// Callers can set a document URI through
  /// {@link DocumentsContract#EXTRA_INITIAL_URI} to indicate the initial
  /// location of documents navigator. System will do its best to launch the
  /// navigator in the specified document if it's a folder, or the folder that
  /// contains the specified document if not.
  /// <p>
  /// Output: The URI representing the selected directory tree.
  ///
  /// @see DocumentsContract

  static const String ACTION_OPEN_DOCUMENT_TREE =
      "android.intent.action.OPEN_DOCUMENT_TREE";

  /// Activity Action: Perform text translation.
  /// <p>
  /// Input: {@link #EXTRA_TEXT getCharSequence(EXTRA_TEXT)} is the text to translate.
  /// <p>
  /// Output: nothing.

  static const String ACTION_TRANSLATE = "android.intent.action.TRANSLATE";

  /// Activity Action: Define the meaning of the selected word(s).
  /// <p>
  /// Input: {@link #EXTRA_TEXT getCharSequence(EXTRA_TEXT)} is the text to define.
  /// <p>
  /// Output: nothing.

  static const String ACTION_DEFINE = "android.intent.action.DEFINE";

  /// Broadcast Action: List of dynamic sensor is changed due to new sensor being connected or
  /// exisiting sensor being disconnected.
  ///
  /// <p class="note">This is a protected intent that can only be sent by the system.</p>
  ///
  /// {@hide}

  static const String ACTION_DYNAMIC_SENSOR_CHANGED =
      "android.intent.action.DYNAMIC_SENSOR_CHANGED";

  /// Deprecated - use ACTION_FACTORY_RESET instead.
  /// @hide
  /// @removed
  @deprecated
  static const String ACTION_MASTER_CLEAR =
      "android.intent.action.MASTER_CLEAR";

  /// Broadcast intent sent by the RecoverySystem to inform listeners that a global clear (wipe)
  /// is about to be performed.
  /// @hide

  static const String ACTION_MASTER_CLEAR_NOTIFICATION =
      "android.intent.action.MASTER_CLEAR_NOTIFICATION";

  /// Boolean intent extra to be used with {@link #ACTION_MASTER_CLEAR} in order to force a factory
  /// reset even if {@link android.os.UserManager#DISALLOW_FACTORY_RESET} is set.
  ///
  /// <p>Deprecated - use {@link #EXTRA_FORCE_FACTORY_RESET} instead.
  ///
  /// @hide
  @deprecated
  static const String EXTRA_FORCE_MASTER_CLEAR =
      "android.intent.extra.FORCE_MASTER_CLEAR";

  /// A broadcast action to trigger a factory reset.
  ///
  /// <p>The sender must hold the {@link android.Manifest.permission#MASTER_CLEAR} permission. The
  /// reason for the factory reset should be specified as {@link #EXTRA_REASON}.
  ///
  /// <p>Not for use by third-party applications.
  ///
  /// @see #EXTRA_FORCE_FACTORY_RESET
  ///
  /// {@hide}

  static const String ACTION_FACTORY_RESET =
      "android.intent.action.FACTORY_RESET";

  /// Boolean intent extra to be used with {@link #ACTION_MASTER_CLEAR} in order to force a factory
  /// reset even if {@link android.os.UserManager#DISALLOW_FACTORY_RESET} is set.
  ///
  /// <p>Not for use by third-party applications.
  ///
  /// @hide

  static const String EXTRA_FORCE_FACTORY_RESET =
      "android.intent.extra.FORCE_FACTORY_RESET";

  /// Broadcast action: report that a settings element is being restored from backup. The intent
  /// contains four extras: EXTRA_SETTING_NAME is a string naming the restored setting,
  /// EXTRA_SETTING_NEW_VALUE is the value being restored, EXTRA_SETTING_PREVIOUS_VALUE
  /// is the value of that settings entry prior to the restore operation, and
  /// EXTRA_SETTING_RESTORED_FROM_SDK_INT is the version of the SDK that the setting has been
  /// restored from (corresponds to {@link android.os.Build.VERSION#SDK_INT}). The first three
  /// values are represented as strings, the fourth one as int.
  ///
  /// <p>This broadcast is sent only for settings provider entries known to require special handling
  /// around restore time.  These entries are found in the BROADCAST_ON_RESTORE table within
  /// the provider's backup agent implementation.
  ///
  /// @see #EXTRA_SETTING_NAME
  /// @see #EXTRA_SETTING_PREVIOUS_VALUE
  /// @see #EXTRA_SETTING_NEW_VALUE
  /// @see #EXTRA_SETTING_RESTORED_FROM_SDK_INT
  /// {@hide}
  static const String ACTION_SETTING_RESTORED =
      "android.os.action.SETTING_RESTORED";

  /// {@hide} */
  static const String EXTRA_SETTING_NAME = "setting_name";

  /// {@hide} */
  static const String EXTRA_SETTING_PREVIOUS_VALUE = "previous_value";

  /// {@hide} */
  static const String EXTRA_SETTING_NEW_VALUE = "new_value";

  /// {@hide} */
  static const String EXTRA_SETTING_RESTORED_FROM_SDK_INT =
      "restored_from_sdk_int";

  /// Activity Action: Process a piece of text.
  /// <p>Input: {@link #EXTRA_PROCESS_TEXT} contains the text to be processed.
  /// {@link #EXTRA_PROCESS_TEXT_READONLY} states if the resulting text will be read-only.</p>
  /// <p>Output: {@link #EXTRA_PROCESS_TEXT} contains the processed text.</p>

  static const String ACTION_PROCESS_TEXT =
      "android.intent.action.PROCESS_TEXT";

  /// Broadcast Action: The sim card state has changed.
  /// For more details see TelephonyIntents.ACTION_SIM_STATE_CHANGED. This is here
  /// because TelephonyIntents is an internal class.
  /// The intent will have following extras.</p>
  /// <p>
  /// @see #EXTRA_SIM_STATE
  /// @see #EXTRA_SIM_LOCKED_REASON
  /// @see #EXTRA_REBROADCAST_ON_UNLOCK
  ///
  /// @deprecated Use {@link #ACTION_SIM_CARD_STATE_CHANGED} or
  /// {@link #ACTION_SIM_APPLICATION_STATE_CHANGED}
  ///
  /// @hide
  @deprecated
  static const String ACTION_SIM_STATE_CHANGED =
      "android.intent.action.SIM_STATE_CHANGED";

  /// The extra used with {@link #ACTION_SIM_STATE_CHANGED} for broadcasting SIM STATE.
  /// This will have one of the following intent values.
  /// @see #SIM_STATE_UNKNOWN
  /// @see #SIM_STATE_NOT_READY
  /// @see #SIM_STATE_ABSENT
  /// @see #SIM_STATE_PRESENT
  /// @see #SIM_STATE_CARD_IO_ERROR
  /// @see #SIM_STATE_CARD_RESTRICTED
  /// @see #SIM_STATE_LOCKED
  /// @see #SIM_STATE_READY
  /// @see #SIM_STATE_IMSI
  /// @see #SIM_STATE_LOADED
  /// @hide
  /// @deprecated Use {@link #ACTION_SIM_CARD_STATE_CHANGED}
  static const String EXTRA_SIM_STATE = "ss";

  /// The intent value UNKNOWN represents the SIM state unknown
  /// @hide
  /// @deprecated Use {@link #ACTION_SIM_CARD_STATE_CHANGED}
  static const String SIM_STATE_UNKNOWN = "UNKNOWN";

  /// The intent value NOT_READY means that the SIM is not ready eg. radio is off or powering on
  /// @hide
  /// @deprecated Use {@link #ACTION_SIM_CARD_STATE_CHANGED}
  static const String SIM_STATE_NOT_READY = "NOT_READY";

  /// The intent value ABSENT means the SIM card is missing
  /// @hide
  /// @deprecated Use {@link #ACTION_SIM_CARD_STATE_CHANGED}
  static const String SIM_STATE_ABSENT = "ABSENT";

  /// The intent value PRESENT means the device has a SIM card inserted
  /// @hide
  /// @deprecated Use {@link #ACTION_SIM_CARD_STATE_CHANGED}
  static const String SIM_STATE_PRESENT = "PRESENT";

  /// The intent value CARD_IO_ERROR means for three consecutive times there was SIM IO error
  /// @hide
  /// @deprecated Use {@link #ACTION_SIM_CARD_STATE_CHANGED}
  static const String SIM_STATE_CARD_IO_ERROR = "CARD_IO_ERROR";

  /// The intent value CARD_RESTRICTED means card is present but not usable due to carrier
  /// restrictions
  /// @hide
  /// @deprecated Use {@link #ACTION_SIM_CARD_STATE_CHANGED}
  static const String SIM_STATE_CARD_RESTRICTED = "CARD_RESTRICTED";

  /// The intent value LOCKED means the SIM is locked by PIN or by network
  /// @hide
  /// @deprecated Use {@link #ACTION_SIM_CARD_STATE_CHANGED}
  static const String SIM_STATE_LOCKED = "LOCKED";

  /// The intent value READY means the SIM is ready to be accessed
  /// @hide
  /// @deprecated Use {@link #ACTION_SIM_CARD_STATE_CHANGED}
  static const String SIM_STATE_READY = "READY";

  /// The intent value IMSI means the SIM IMSI is ready in property
  /// @hide
  /// @deprecated Use {@link #ACTION_SIM_CARD_STATE_CHANGED}
  static const String SIM_STATE_IMSI = "IMSI";

  /// The intent value LOADED means all SIM records, including IMSI, are loaded
  /// @hide
  /// @deprecated Use {@link #ACTION_SIM_CARD_STATE_CHANGED}
  static const String SIM_STATE_LOADED = "LOADED";

  /// The extra used with {@link #ACTION_SIM_STATE_CHANGED} for broadcasting SIM STATE.
  /// This extra will have one of the following intent values.
  /// <p>
  /// @see #SIM_LOCKED_ON_PIN
  /// @see #SIM_LOCKED_ON_PUK
  /// @see #SIM_LOCKED_NETWORK
  /// @see #SIM_ABSENT_ON_PERM_DISABLED
  ///
  /// @hide
  /// @deprecated Use {@link #ACTION_SIM_APPLICATION_STATE_CHANGED}
  static const String EXTRA_SIM_LOCKED_REASON = "reason";

  /// The intent value PIN means the SIM is locked on PIN1
  /// @hide
  /// @deprecated Use {@link #ACTION_SIM_APPLICATION_STATE_CHANGED}
  static const String SIM_LOCKED_ON_PIN = "PIN";

  /// The intent value PUK means the SIM is locked on PUK1
  /// @hide
  /// @deprecated Use {@link #ACTION_SIM_APPLICATION_STATE_CHANGED}
  /* PUK means ICC is locked on PUK1 */
  static const String SIM_LOCKED_ON_PUK = "PUK";

  /// The intent value NETWORK means the SIM is locked on NETWORK PERSONALIZATION
  /// @hide
  /// @deprecated Use {@link #ACTION_SIM_APPLICATION_STATE_CHANGED}
  static const String SIM_LOCKED_NETWORK = "NETWORK";

  /// The intent value PERM_DISABLED means SIM is permanently disabled due to puk fails
  /// @hide
  /// @deprecated Use {@link #ACTION_SIM_APPLICATION_STATE_CHANGED}
  static const String SIM_ABSENT_ON_PERM_DISABLED = "PERM_DISABLED";

  /// The extra used with {@link #ACTION_SIM_STATE_CHANGED} for indicating whether this broadcast
  /// is a rebroadcast on unlock. Defaults to {@code false} if not specified.
  ///
  /// @hide
  /// @deprecated Use {@link #ACTION_SIM_CARD_STATE_CHANGED} or
  /// {@link #ACTION_SIM_APPLICATION_STATE_CHANGED}
  static const String EXTRA_REBROADCAST_ON_UNLOCK = "rebroadcastOnUnlock";

  /// Broadcast Action: indicate that the phone service state has changed.
  /// The intent will have the following extra values:</p>
  /// <p>
  /// @see #EXTRA_VOICE_REG_STATE
  /// @see #EXTRA_DATA_REG_STATE
  /// @see #EXTRA_VOICE_ROAMING_TYPE
  /// @see #EXTRA_DATA_ROAMING_TYPE
  /// @see #EXTRA_OPERATOR_ALPHA_LONG
  /// @see #EXTRA_OPERATOR_ALPHA_SHORT
  /// @see #EXTRA_OPERATOR_NUMERIC
  /// @see #EXTRA_DATA_OPERATOR_ALPHA_LONG
  /// @see #EXTRA_DATA_OPERATOR_ALPHA_SHORT
  /// @see #EXTRA_DATA_OPERATOR_NUMERIC
  /// @see #EXTRA_MANUAL
  /// @see #EXTRA_VOICE_RADIO_TECH
  /// @see #EXTRA_DATA_RADIO_TECH
  /// @see #EXTRA_CSS_INDICATOR
  /// @see #EXTRA_NETWORK_ID
  /// @see #EXTRA_SYSTEM_ID
  /// @see #EXTRA_CDMA_ROAMING_INDICATOR
  /// @see #EXTRA_CDMA_DEFAULT_ROAMING_INDICATOR
  /// @see #EXTRA_EMERGENCY_ONLY
  /// @see #EXTRA_IS_DATA_ROAMING_FROM_REGISTRATION
  /// @see #EXTRA_IS_USING_CARRIER_AGGREGATION
  /// @see #EXTRA_LTE_EARFCN_RSRP_BOOST
  ///
  /// <p class="note">
  /// Requires the READ_PHONE_STATE permission.
  ///
  /// <p class="note">This is a protected intent that can only be sent by the system.
  /// @hide
  /// @removed
  /// @deprecated Use {@link android.provider.Telephony.ServiceStateTable} and the helper
  /// functions {@code ServiceStateTable.getUriForSubscriptionIdAndField} and
  /// {@code ServiceStateTable.getUriForSubscriptionId} to subscribe to changes to the ServiceState
  /// for a given subscription id and field with a ContentObserver or using JobScheduler.
  @deprecated
  static const String ACTION_SERVICE_STATE =
      "android.intent.action.SERVICE_STATE";

  /// Used by {@link services.core.java.com.android.server.pm.DataLoaderManagerService}
  /// for querying Data Loader Service providers. Data loader service providers register this
  /// intent filter in their manifests, so that they can be looked up and bound to by
  /// {@code DataLoaderManagerService}.
  ///
  /// <p class="note">This is a protected intent that can only be sent by the system.
  ///
  /// Data loader service providers must be privileged apps.
  /// See {@link com.android.server.pm.PackageManagerShellCommandDataLoader} as an example of such
  /// data loader service provider.
  ///
  /// @hide

  static const String ACTION_LOAD_DATA = "android.intent.action.LOAD_DATA";

  /// An int extra used with {@link #ACTION_SERVICE_STATE} which indicates voice registration
  /// state.
  /// @see android.telephony.ServiceState#STATE_EMERGENCY_ONLY
  /// @see android.telephony.ServiceState#STATE_IN_SERVICE
  /// @see android.telephony.ServiceState#STATE_OUT_OF_SERVICE
  /// @see android.telephony.ServiceState#STATE_POWER_OFF
  /// @hide
  /// @removed
  /// @deprecated Use {@link android.provider.Telephony.ServiceStateTable#VOICE_REG_STATE}.
  @deprecated
  static const String EXTRA_VOICE_REG_STATE = "voiceRegState";

  /// An int extra used with {@link #ACTION_SERVICE_STATE} which indicates data registration state.
  /// @see android.telephony.ServiceState#STATE_EMERGENCY_ONLY
  /// @see android.telephony.ServiceState#STATE_IN_SERVICE
  /// @see android.telephony.ServiceState#STATE_OUT_OF_SERVICE
  /// @see android.telephony.ServiceState#STATE_POWER_OFF
  /// @hide
  /// @removed
  /// @deprecated Use {@link android.provider.Telephony.ServiceStateTable#DATA_REG_STATE}.
  @deprecated
  static const String EXTRA_DATA_REG_STATE = "dataRegState";

  /// An integer extra used with {@link #ACTION_SERVICE_STATE} which indicates the voice roaming
  /// type.
  /// @hide
  /// @removed
  /// @deprecated Use {@link android.provider.Telephony.ServiceStateTable#VOICE_ROAMING_TYPE}.
  @deprecated
  static const String EXTRA_VOICE_ROAMING_TYPE = "voiceRoamingType";

  /// An integer extra used with {@link #ACTION_SERVICE_STATE} which indicates the data roaming
  /// type.
  /// @hide
  /// @removed
  /// @deprecated Use {@link android.provider.Telephony.ServiceStateTable#DATA_ROAMING_TYPE}.
  @deprecated
  static const String EXTRA_DATA_ROAMING_TYPE = "dataRoamingType";

  /// A string extra used with {@link #ACTION_SERVICE_STATE} which represents the current
  /// registered voice operator name in long alphanumeric format.
  /// {@code null} if the operator name is not known or unregistered.
  /// @hide
  /// @removed
  /// @deprecated Use
  /// {@link android.provider.Telephony.ServiceStateTable#VOICE_OPERATOR_ALPHA_LONG}.
  @deprecated
  static const String EXTRA_OPERATOR_ALPHA_LONG = "operator-alpha-long";

  /// A string extra used with {@link #ACTION_SERVICE_STATE} which represents the current
  /// registered voice operator name in short alphanumeric format.
  /// {@code null} if the operator name is not known or unregistered.
  /// @hide
  /// @removed
  /// @deprecated Use
  /// {@link android.provider.Telephony.ServiceStateTable#VOICE_OPERATOR_ALPHA_SHORT}.
  @deprecated
  static const String EXTRA_OPERATOR_ALPHA_SHORT = "operator-alpha-short";

  /// A string extra used with {@link #ACTION_SERVICE_STATE} containing the MCC
  /// (Mobile Country Code, 3 digits) and MNC (Mobile Network code, 2-3 digits) for the mobile
  /// network.
  /// @hide
  /// @removed
  /// @deprecated Use {@link android.provider.Telephony.ServiceStateTable#VOICE_OPERATOR_NUMERIC}.
  @deprecated
  static const String EXTRA_OPERATOR_NUMERIC = "operator-numeric";

  /// A string extra used with {@link #ACTION_SERVICE_STATE} which represents the current
  /// registered data operator name in long alphanumeric format.
  /// {@code null} if the operator name is not known or unregistered.
  /// @hide
  /// @removed
  /// @deprecated Use
  /// {@link android.provider.Telephony.ServiceStateTable#DATA_OPERATOR_ALPHA_LONG}.
  @deprecated
  static const String EXTRA_DATA_OPERATOR_ALPHA_LONG =
      "data-operator-alpha-long";

  /// A string extra used with {@link #ACTION_SERVICE_STATE} which represents the current
  /// registered data operator name in short alphanumeric format.
  /// {@code null} if the operator name is not known or unregistered.
  /// @hide
  /// @removed
  /// @deprecated Use
  /// {@link android.provider.Telephony.ServiceStateTable#DATA_OPERATOR_ALPHA_SHORT}.
  @deprecated
  static const String EXTRA_DATA_OPERATOR_ALPHA_SHORT =
      "data-operator-alpha-short";

  /// A string extra used with {@link #ACTION_SERVICE_STATE} containing the MCC
  /// (Mobile Country Code, 3 digits) and MNC (Mobile Network code, 2-3 digits) for the
  /// data operator.
  /// @hide
  /// @removed
  /// @deprecated Use {@link android.provider.Telephony.ServiceStateTable#DATA_OPERATOR_NUMERIC}.
  @deprecated
  static const String EXTRA_DATA_OPERATOR_NUMERIC = "data-operator-numeric";

  /// A boolean extra used with {@link #ACTION_SERVICE_STATE} which indicates whether the current
  /// network selection mode is manual.
  /// Will be {@code true} if manual mode, {@code false} if automatic mode.
  /// @hide
  /// @removed
  /// @deprecated Use
  /// {@link android.provider.Telephony.ServiceStateTable#IS_MANUAL_NETWORK_SELECTION}.
  @deprecated
  static const String EXTRA_MANUAL = "manual";

  /// An integer extra used with {@link #ACTION_SERVICE_STATE} which represents the current voice
  /// radio technology.
  /// @hide
  /// @removed
  /// @deprecated Use
  /// {@link android.provider.Telephony.ServiceStateTable#RIL_VOICE_RADIO_TECHNOLOGY}.
  @deprecated
  static const String EXTRA_VOICE_RADIO_TECH = "radioTechnology";

  /// An integer extra used with {@link #ACTION_SERVICE_STATE} which represents the current data
  /// radio technology.
  /// @hide
  /// @removed
  /// @deprecated Use
  /// {@link android.provider.Telephony.ServiceStateTable#RIL_DATA_RADIO_TECHNOLOGY}.
  @deprecated
  static const String EXTRA_DATA_RADIO_TECH = "dataRadioTechnology";

  /// A boolean extra used with {@link #ACTION_SERVICE_STATE} which represents concurrent service
  /// support on CDMA network.
  /// Will be {@code true} if support, {@code false} otherwise.
  /// @hide
  /// @removed
  /// @deprecated Use {@link android.provider.Telephony.ServiceStateTable#CSS_INDICATOR}.
  @deprecated
  static const String EXTRA_CSS_INDICATOR = "cssIndicator";

  /// An integer extra used with {@link #ACTION_SERVICE_STATE} which represents the CDMA network
  /// id. {@code Integer.MAX_VALUE} if unknown.
  /// @hide
  /// @removed
  /// @deprecated Use {@link android.provider.Telephony.ServiceStateTable#NETWORK_ID}.
  @deprecated
  static const String EXTRA_NETWORK_ID = "networkId";

  /// An integer extra used with {@link #ACTION_SERVICE_STATE} which represents the CDMA system id.
  /// {@code Integer.MAX_VALUE} if unknown.
  /// @hide
  /// @removed
  /// @deprecated Use {@link android.provider.Telephony.ServiceStateTable#SYSTEM_ID}.
  @deprecated
  static const String EXTRA_SYSTEM_ID = "systemId";

  /// An integer extra used with {@link #ACTION_SERVICE_STATE} represents the TSB-58 roaming
  /// indicator if registered on a CDMA or EVDO system or {@code -1} if not.
  /// @hide
  /// @removed
  /// @deprecated Use {@link android.provider.Telephony.ServiceStateTable#CDMA_ROAMING_INDICATOR}.
  @deprecated
  static const String EXTRA_CDMA_ROAMING_INDICATOR = "cdmaRoamingIndicator";

  /// An integer extra used with {@link #ACTION_SERVICE_STATE} represents the default roaming
  /// indicator from the PRL if registered on a CDMA or EVDO system {@code -1} if not.
  /// @hide
  /// @removed
  /// @deprecated Use
  /// {@link android.provider.Telephony.ServiceStateTable#CDMA_DEFAULT_ROAMING_INDICATOR}.
  @deprecated
  static const String EXTRA_CDMA_DEFAULT_ROAMING_INDICATOR =
      "cdmaDefaultRoamingIndicator";

  /// A boolean extra used with {@link #ACTION_SERVICE_STATE} which indicates if under emergency
  /// only mode.
  /// {@code true} if in emergency only mode, {@code false} otherwise.
  /// @hide
  /// @removed
  /// @deprecated Use {@link android.provider.Telephony.ServiceStateTable#IS_EMERGENCY_ONLY}.
  @deprecated
  static const String EXTRA_EMERGENCY_ONLY = "emergencyOnly";

  /// A boolean extra used with {@link #ACTION_SERVICE_STATE} which indicates whether data network
  /// registration state is roaming.
  /// {@code true} if registration indicates roaming, {@code false} otherwise
  /// @hide
  /// @removed
  /// @deprecated Use
  /// {@link android.provider.Telephony.ServiceStateTable#IS_DATA_ROAMING_FROM_REGISTRATION}.
  @deprecated
  static const String EXTRA_IS_DATA_ROAMING_FROM_REGISTRATION =
      "isDataRoamingFromRegistration";

  /// A boolean extra used with {@link #ACTION_SERVICE_STATE} which indicates if carrier
  /// aggregation is in use.
  /// {@code true} if carrier aggregation is in use, {@code false} otherwise.
  /// @hide
  /// @removed
  /// @deprecated Use
  /// {@link android.provider.Telephony.ServiceStateTable#IS_USING_CARRIER_AGGREGATION}.
  @deprecated
  static const String EXTRA_IS_USING_CARRIER_AGGREGATION =
      "isUsingCarrierAggregation";

  /// An integer extra used with {@link #ACTION_SERVICE_STATE} representing the offset which
  /// is reduced from the rsrp threshold while calculating signal strength level.
  /// @hide
  /// @removed
  @deprecated
  static const String EXTRA_LTE_EARFCN_RSRP_BOOST = "LteEarfcnRsrpBoost";

  /// The name of the extra used to define the text to be processed, as a
  /// CharSequence. Note that this may be a styled CharSequence, so you must use
  /// {@link Bundle#getCharSequence(String) Bundle.getCharSequence()} to retrieve it.
  static const String EXTRA_PROCESS_TEXT = "android.intent.extra.PROCESS_TEXT";

  /// The name of the boolean extra used to define if the processed text will be used as read-only.
  static const String EXTRA_PROCESS_TEXT_READONLY =
      "android.intent.extra.PROCESS_TEXT_READONLY";

  /// Broadcast action: reports when a new thermal event has been reached. When the device
  /// is reaching its maximum temperatue, the thermal level reported
  /// {@hide}

  static const String ACTION_THERMAL_EVENT =
      "android.intent.action.THERMAL_EVENT";

  /// {@hide} */
  static const String EXTRA_THERMAL_STATE =
      "android.intent.extra.THERMAL_STATE";

  /// Thermal state when the device is normal. This state is sent in the
  /// {@link #ACTION_THERMAL_EVENT} broadcast as {@link #EXTRA_THERMAL_STATE}.
  /// {@hide}
  static const int EXTRA_THERMAL_STATE_NORMAL = 0;

  /// Thermal state where the device is approaching its maximum threshold. This state is sent in
  /// the {@link #ACTION_THERMAL_EVENT} broadcast as {@link #EXTRA_THERMAL_STATE}.
  /// {@hide}
  static const int EXTRA_THERMAL_STATE_WARNING = 1;

  /// Thermal state where the device has reached its maximum threshold. This state is sent in the
  /// {@link #ACTION_THERMAL_EVENT} broadcast as {@link #EXTRA_THERMAL_STATE}.
  /// {@hide}
  static const int EXTRA_THERMAL_STATE_EXCEEDED = 2;

  /// Broadcast Action: Indicates the dock in idle state while device is docked.
  ///
  /// <p class="note">This is a protected intent that can only be sent
  /// by the system.
  ///
  /// @hide
  static const String ACTION_DOCK_IDLE = "android.intent.action.DOCK_IDLE";

  /// Broadcast Action: Indicates the dock in active state while device is docked.
  ///
  /// <p class="note">This is a protected intent that can only be sent
  /// by the system.
  ///
  /// @hide
  static const String ACTION_DOCK_ACTIVE = "android.intent.action.DOCK_ACTIVE";

  /// Broadcast Action: Indicates that a new device customization has been
  /// downloaded and applied (packages installed, runtime resource overlays
  /// enabled, xml files copied, ...), and that it is time for components that
  /// need to for example clear their caches to do so now.
  ///
  /// @hide

  static const String ACTION_DEVICE_CUSTOMIZATION_READY =
      "android.intent.action.DEVICE_CUSTOMIZATION_READY";

  /// Activity Action: Display an activity state associated with an unique {@link LocusId}.
  ///
  /// <p>For example, a chat app could use the context to resume a conversation between 2 users.
  ///
  /// <p>Input: {@link #EXTRA_LOCUS_ID} specifies the unique identifier of the locus in the
  /// app domain. Should be stable across reboots and backup / restore.
  /// <p>Output: nothing.

  static const String ACTION_VIEW_LOCUS = "android.intent.action.VIEW_LOCUS";

  /// Broadcast Action: Sent to the integrity component when a package
  /// needs to be verified. The data contains the package URI along with other relevant
  /// information.
  ///
  /// <p class="note">
  /// This is a protected intent that can only be sent by the system.
  /// </p>
  ///
  /// @hide

  static const String ACTION_PACKAGE_NEEDS_INTEGRITY_VERIFICATION =
      "android.intent.action.PACKAGE_NEEDS_INTEGRITY_VERIFICATION";
  // ---------------------------------------------------------------------
  // ---------------------------------------------------------------------
  // Standard intent categories (see addCategory()).
  /// Set if the activity should be an option for the default action
  /// (center press) to perform on a piece of data.  Setting this will
  /// hide from the user any activities without it set when performing an
  /// action on some data.  Note that this is normally -not- set in the
  /// Intent when initiating an action -- it is for use in intent filters
  /// specified in packages.

  static const String CATEGORY_DEFAULT = "android.intent.category.DEFAULT";

  /// Activities that can be safely invoked from a browser must support this
  /// category.  For example, if the user is viewing a web page or an e-mail
  /// and clicks on a link in the text, the Intent generated execute that
  /// link will require the BROWSABLE category, so that only activities
  /// supporting this category will be considered as possible actions.  By
  /// supporting this category, you are promising that there is nothing
  /// damaging (without user intervention) that can happen by invoking any
  /// matching Intent.

  static const String CATEGORY_BROWSABLE = "android.intent.category.BROWSABLE";

  /// Categories for activities that can participate in voice interaction.
  /// An activity that supports this category must be prepared to run with
  /// no UI shown at all (though in some case it may have a UI shown), and
  /// rely on {@link android.app.VoiceInteractor} to interact with the user.

  static const String CATEGORY_VOICE = "android.intent.category.VOICE";

  /// Set if the activity should be considered as an alternative action to
  /// the data the user is currently viewing.  See also
  /// {@link #CATEGORY_SELECTED_ALTERNATIVE} for an alternative action that
  /// applies to the selection in a list of items.
  ///
  /// <p>Supporting this category means that you would like your activity to be
  /// displayed in the set of alternative things the user can do, usually as
  /// part of the current activity's options menu.  You will usually want to
  /// include a specific label in the &lt;intent-filter&gt; of this action
  /// describing to the user what it does.
  ///
  /// <p>The action of IntentFilter with this category is important in that it
  /// describes the specific action the target will perform.  This generally
  /// should not be a generic action (such as {@link #ACTION_VIEW}, but rather
  /// a specific name such as "com.android.camera.action.CROP.  Only one
  /// alternative of any particular action will be shown to the user, so using
  /// a specific action like this makes sure that your alternative will be
  /// displayed while also allowing other applications to provide their own
  /// overrides of that particular action.

  static const String CATEGORY_ALTERNATIVE =
      "android.intent.category.ALTERNATIVE";

  /// Set if the activity should be considered as an alternative selection
  /// action to the data the user has currently selected.  This is like
  /// {@link #CATEGORY_ALTERNATIVE}, but is used in activities showing a list
  /// of items from which the user can select, giving them alternatives to the
  /// default action that will be performed on it.

  static const String CATEGORY_SELECTED_ALTERNATIVE =
      "android.intent.category.SELECTED_ALTERNATIVE";

  /// Intended to be used as a tab inside of a containing TabActivity.

  static const String CATEGORY_TAB = "android.intent.category.TAB";

  /// Should be displayed in the top-level launcher.

  static const String CATEGORY_LAUNCHER = "android.intent.category.LAUNCHER";

  /// Indicates an activity optimized for Leanback mode, and that should
  /// be displayed in the Leanback launcher.

  static const String CATEGORY_LEANBACK_LAUNCHER =
      "android.intent.category.LEANBACK_LAUNCHER";

  /// Indicates the preferred entry-point activity when an application is launched from a Car
  /// launcher. If not present, Car launcher can optionally use {@link #CATEGORY_LAUNCHER} as a
  /// fallback, or exclude the application entirely.
  /// @hide

  static const String CATEGORY_CAR_LAUNCHER =
      "android.intent.category.CAR_LAUNCHER";

  /// Indicates a Leanback settings activity to be displayed in the Leanback launcher.
  /// @hide

  static const String CATEGORY_LEANBACK_SETTINGS =
      "android.intent.category.LEANBACK_SETTINGS";

  /// Provides information about the package it is in; typically used if
  /// a package does not contain a {@link #CATEGORY_LAUNCHER} to provide
  /// a front-door to the user without having to be shown in the all apps list.

  static const String CATEGORY_INFO = "android.intent.category.INFO";

  /// This is the home activity, that is the first activity that is displayed
  /// when the device boots.

  static const String CATEGORY_HOME = "android.intent.category.HOME";

  /// This is the home activity that is displayed when the device is finished setting up and ready
  /// for use.
  /// @hide

  static const String CATEGORY_HOME_MAIN = "android.intent.category.HOME_MAIN";

  /// The home activity shown on secondary displays that support showing home activities.

  static const String CATEGORY_SECONDARY_HOME =
      "android.intent.category.SECONDARY_HOME";

  /// This is the setup wizard activity, that is the first activity that is displayed
  /// when the user sets up the device for the first time.
  /// @hide

  static const String CATEGORY_SETUP_WIZARD =
      "android.intent.category.SETUP_WIZARD";

  /// This is the home activity, that is the activity that serves as the launcher app
  /// from there the user can start other apps. Often components with lower/higher
  /// priority intent filters handle the home intent, for example SetupWizard, to
  /// setup the device and we need to be able to distinguish the home app from these
  /// setup helpers.
  /// @hide

  static const String CATEGORY_LAUNCHER_APP =
      "android.intent.category.LAUNCHER_APP";

  /// This activity is a preference panel.

  static const String CATEGORY_PREFERENCE =
      "android.intent.category.PREFERENCE";

  /// This activity is a development preference panel.

  static const String CATEGORY_DEVELOPMENT_PREFERENCE =
      "android.intent.category.DEVELOPMENT_PREFERENCE";

  /// Capable of running inside a parent activity container.

  static const String CATEGORY_EMBED = "android.intent.category.EMBED";

  /// This activity allows the user to browse and download new applications.

  static const String CATEGORY_APP_MARKET =
      "android.intent.category.APP_MARKET";

  /// This activity may be exercised by the monkey or other automated test tools.

  static const String CATEGORY_MONKEY = "android.intent.category.MONKEY";

  /// To be used as a test (not part of the normal user experience).
  static const String CATEGORY_TEST = "android.intent.category.TEST";

  /// To be used as a unit test (run through the Test Harness).
  static const String CATEGORY_UNIT_TEST = "android.intent.category.UNIT_TEST";

  /// To be used as a sample code example (not part of the normal user
  /// experience).
  static const String CATEGORY_SAMPLE_CODE =
      "android.intent.category.SAMPLE_CODE";

  /// Used to indicate that an intent only wants URIs that can be opened with
  /// {@link ContentResolver#openFileDescriptor(Uri, String)}. Openable URIs
  /// must support at least the columns defined in {@link OpenableColumns} when
  /// queried.
  ///
  /// @see #ACTION_GET_CONTENT
  /// @see #ACTION_OPEN_DOCUMENT
  /// @see #ACTION_CREATE_DOCUMENT

  static const String CATEGORY_OPENABLE = "android.intent.category.OPENABLE";

  /// Used to indicate that an intent filter can accept files which are not necessarily
  /// openable by {@link ContentResolver#openFileDescriptor(Uri, String)}, but
  /// at least streamable via
  /// {@link ContentResolver#openTypedAssetFileDescriptor(Uri, String, Bundle)}
  /// using one of the stream types exposed via
  /// {@link ContentResolver#getStreamTypes(Uri, String)}.
  ///
  /// @see #ACTION_SEND
  /// @see #ACTION_SEND_MULTIPLE

  static const String CATEGORY_TYPED_OPENABLE =
      "android.intent.category.TYPED_OPENABLE";

  /// To be used as code under test for framework instrumentation tests.
  static const String CATEGORY_FRAMEWORK_INSTRUMENTATION_TEST =
      "android.intent.category.FRAMEWORK_INSTRUMENTATION_TEST";

  /// An activity to run when device is inserted into a car dock.
  /// Used with {@link #ACTION_MAIN} to launch an activity.  For more
  /// information, see {@link android.app.UiModeManager}.

  static const String CATEGORY_CAR_DOCK = "android.intent.category.CAR_DOCK";

  /// An activity to run when device is inserted into a car dock.
  /// Used with {@link #ACTION_MAIN} to launch an activity.  For more
  /// information, see {@link android.app.UiModeManager}.

  static const String CATEGORY_DESK_DOCK = "android.intent.category.DESK_DOCK";

  /// An activity to run when device is inserted into a analog (low end) dock.
  /// Used with {@link #ACTION_MAIN} to launch an activity.  For more
  /// information, see {@link android.app.UiModeManager}.

  static const String CATEGORY_LE_DESK_DOCK =
      "android.intent.category.LE_DESK_DOCK";

  /// An activity to run when device is inserted into a digital (high end) dock.
  /// Used with {@link #ACTION_MAIN} to launch an activity.  For more
  /// information, see {@link android.app.UiModeManager}.

  static const String CATEGORY_HE_DESK_DOCK =
      "android.intent.category.HE_DESK_DOCK";

  /// Used to indicate that the activity can be used in a car environment.

  static const String CATEGORY_CAR_MODE = "android.intent.category.CAR_MODE";

  /// An activity to use for the launcher when the device is placed in a VR Headset viewer.
  /// Used with {@link #ACTION_MAIN} to launch an activity.  For more
  /// information, see {@link android.app.UiModeManager}.

  static const String CATEGORY_VR_HOME = "android.intent.category.VR_HOME";

  /// The accessibility shortcut is a global gesture for users with disabilities to trigger an
  /// important for them accessibility feature to help developers determine whether they want to
  /// make their activity a shortcut target.
  /// <p>
  /// An activity of interest to users with accessibility needs may request to be the target of
  /// the accessibility shortcut. It handles intent {@link #ACTION_MAIN} with this category,
  /// which will be dispatched by the system when the user activates the shortcut when it is
  /// configured to point at this target.
  /// </p>
  /// <p>
  /// An activity declared itself to be a target of the shortcut in AndroidManifest.xml. It must
  /// also do two things:
  /// <ul>
  ///     <ol>
  ///         Specify that it handles the <code>android.intent.action.MAIN</code>
  ///         {@link android.content.Intent}
  ///         with category <code>android.intent.category.ACCESSIBILITY_SHORTCUT_TARGET</code>.
  ///     </ol>
  ///     <ol>
  ///         Provide a meta-data entry <code>android.accessibilityshortcut.target</code> in the
  ///         manifest when declaring the activity.
  ///     </ol>
  /// </ul>
  /// If either of these items is missing, the system will ignore the accessibility shortcut
  /// target. Following is an example declaration:
  /// </p>
  /// <pre>
  /// &lt;activity android:name=".MainActivity"
  /// . . .
  ///   &lt;intent-filter&gt;
  ///       &lt;action android:name="android.intent.action.MAIN" /&gt;
  ///       &lt;category android:name="android.intent.category.ACCESSIBILITY_SHORTCUT_TARGET" /&gt;
  ///   &lt;/intent-filter&gt;
  ///   &lt;meta-data android:name="android.accessibilityshortcut.target"
  ///                   android:resource="@xml/accessibilityshortcut" /&gt;
  /// &lt;/activity&gt;
  /// </pre>
  /// <p> This is a sample XML file configuring a accessibility shortcut target: </p>
  /// <pre>
  /// &lt;accessibility-shortcut-target
  ///     android:description="@string/shortcut_target_description"
  ///     android:summary="@string/shortcut_target_summary"
  ///     android:animatedImageDrawable="@drawable/shortcut_target_animated_image"
  ///     android:htmlDescription="@string/shortcut_target_html_description"
  ///     android:settingsActivity="com.example.android.shortcut.target.SettingsActivity" /&gt;
  /// </pre>
  /// <p>
  /// Both description and summary are necessary. The system will ignore the accessibility
  /// shortcut target if they are missing. The animated image and html description are supported
  /// to help users understand how to use the shortcut target. The settings activity is a
  /// component name that allows the user to modify the settings for this accessibility shortcut
  /// target.
  /// </p>

  static const String CATEGORY_ACCESSIBILITY_SHORTCUT_TARGET =
      "android.intent.category.ACCESSIBILITY_SHORTCUT_TARGET";
  // ---------------------------------------------------------------------
  // ---------------------------------------------------------------------
  // Application launch intent categories (see addCategory()).
  /// Used with {@link #ACTION_MAIN} to launch the browser application.
  /// The activity should be able to browse the Internet.
  /// <p>NOTE: This should not be used as the primary key of an Intent,
  /// since it will not result in the app launching with the correct
  /// action and category.  Instead, use this with
  /// {@link #makeMainSelectorActivity(String, String)} to generate a main
  /// Intent with this category in the selector.</p>

  static const String CATEGORY_APP_BROWSER =
      "android.intent.category.APP_BROWSER";

  /// Used with {@link #ACTION_MAIN} to launch the calculator application.
  /// The activity should be able to perform standard arithmetic operations.
  /// <p>NOTE: This should not be used as the primary key of an Intent,
  /// since it will not result in the app launching with the correct
  /// action and category.  Instead, use this with
  /// {@link #makeMainSelectorActivity(String, String)} to generate a main
  /// Intent with this category in the selector.</p>

  static const String CATEGORY_APP_CALCULATOR =
      "android.intent.category.APP_CALCULATOR";

  /// Used with {@link #ACTION_MAIN} to launch the calendar application.
  /// The activity should be able to view and manipulate calendar entries.
  /// <p>NOTE: This should not be used as the primary key of an Intent,
  /// since it will not result in the app launching with the correct
  /// action and category.  Instead, use this with
  /// {@link #makeMainSelectorActivity(String, String)} to generate a main
  /// Intent with this category in the selector.</p>

  static const String CATEGORY_APP_CALENDAR =
      "android.intent.category.APP_CALENDAR";

  /// Used with {@link #ACTION_MAIN} to launch the contacts application.
  /// The activity should be able to view and manipulate address book entries.
  /// <p>NOTE: This should not be used as the primary key of an Intent,
  /// since it will not result in the app launching with the correct
  /// action and category.  Instead, use this with
  /// {@link #makeMainSelectorActivity(String, String)} to generate a main
  /// Intent with this category in the selector.</p>

  static const String CATEGORY_APP_CONTACTS =
      "android.intent.category.APP_CONTACTS";

  /// Used with {@link #ACTION_MAIN} to launch the email application.
  /// The activity should be able to send and receive email.
  /// <p>NOTE: This should not be used as the primary key of an Intent,
  /// since it will not result in the app launching with the correct
  /// action and category.  Instead, use this with
  /// {@link #makeMainSelectorActivity(String, String)} to generate a main
  /// Intent with this category in the selector.</p>

  static const String CATEGORY_APP_EMAIL = "android.intent.category.APP_EMAIL";

  /// Used with {@link #ACTION_MAIN} to launch the gallery application.
  /// The activity should be able to view and manipulate image and video files
  /// stored on the device.
  /// <p>NOTE: This should not be used as the primary key of an Intent,
  /// since it will not result in the app launching with the correct
  /// action and category.  Instead, use this with
  /// {@link #makeMainSelectorActivity(String, String)} to generate a main
  /// Intent with this category in the selector.</p>

  static const String CATEGORY_APP_GALLERY =
      "android.intent.category.APP_GALLERY";

  /// Used with {@link #ACTION_MAIN} to launch the maps application.
  /// The activity should be able to show the user's current location and surroundings.
  /// <p>NOTE: This should not be used as the primary key of an Intent,
  /// since it will not result in the app launching with the correct
  /// action and category.  Instead, use this with
  /// {@link #makeMainSelectorActivity(String, String)} to generate a main
  /// Intent with this category in the selector.</p>

  static const String CATEGORY_APP_MAPS = "android.intent.category.APP_MAPS";

  /// Used with {@link #ACTION_MAIN} to launch the messaging application.
  /// The activity should be able to send and receive text messages.
  /// <p>NOTE: This should not be used as the primary key of an Intent,
  /// since it will not result in the app launching with the correct
  /// action and category.  Instead, use this with
  /// {@link #makeMainSelectorActivity(String, String)} to generate a main
  /// Intent with this category in the selector.</p>

  static const String CATEGORY_APP_MESSAGING =
      "android.intent.category.APP_MESSAGING";

  /// Used with {@link #ACTION_MAIN} to launch the music application.
  /// The activity should be able to play, browse, or manipulate music files
  /// stored on the device.
  /// <p>NOTE: This should not be used as the primary key of an Intent,
  /// since it will not result in the app launching with the correct
  /// action and category.  Instead, use this with
  /// {@link #makeMainSelectorActivity(String, String)} to generate a main
  /// Intent with this category in the selector.</p>

  static const String CATEGORY_APP_MUSIC = "android.intent.category.APP_MUSIC";

  /// Used with {@link #ACTION_MAIN} to launch the files application.
  /// The activity should be able to browse and manage files stored on the device.
  /// <p>NOTE: This should not be used as the primary key of an Intent,
  /// since it will not result in the app launching with the correct
  /// action and category.  Instead, use this with
  /// {@link #makeMainSelectorActivity(String, String)} to generate a main
  /// Intent with this category in the selector.</p>

  static const String CATEGORY_APP_FILES = "android.intent.category.APP_FILES";
  // ---------------------------------------------------------------------
  // ---------------------------------------------------------------------
  // Standard extra data keys.
  /// The initial data to place in a newly created record.  Use with
  /// {@link #ACTION_INSERT}.  The data here is a Map containing the same
  /// fields as would be given to the underlying ContentProvider.insert()
  /// call.
  static const String EXTRA_TEMPLATE = "android.intent.extra.TEMPLATE";

  /// A constant CharSequence that is associated with the Intent, used with
  /// {@link #ACTION_SEND} to supply the literal data to be sent.  Note that
  /// this may be a styled CharSequence, so you must use
  /// {@link Bundle#getCharSequence(String) Bundle.getCharSequence()} to
  /// retrieve it.
  static const String EXTRA_TEXT = "android.intent.extra.TEXT";

  /// A constant String that is associated with the Intent, used with
  /// {@link #ACTION_SEND} to supply an alternative to {@link #EXTRA_TEXT}
  /// as HTML formatted text.  Note that you <em>must</em> also supply
  /// {@link #EXTRA_TEXT}.
  static const String EXTRA_HTML_TEXT = "android.intent.extra.HTML_TEXT";

  /// A content: URI holding a stream of data associated with the Intent,
  /// used with {@link #ACTION_SEND} to supply the data being sent.
  static const String EXTRA_STREAM = "android.intent.extra.STREAM";

  /// A String[] holding e-mail addresses that should be delivered to.
  static const String EXTRA_EMAIL = "android.intent.extra.EMAIL";

  /// A String[] holding e-mail addresses that should be carbon copied.
  static const String EXTRA_CC = "android.intent.extra.CC";

  /// A String[] holding e-mail addresses that should be blind carbon copied.
  static const String EXTRA_BCC = "android.intent.extra.BCC";

  /// A constant string holding the desired subject line of a message.
  static const String EXTRA_SUBJECT = "android.intent.extra.SUBJECT";

  /// An Intent describing the choices you would like shown with
  /// {@link #ACTION_PICK_ACTIVITY} or {@link #ACTION_CHOOSER}.
  static const String EXTRA_INTENT = "android.intent.extra.INTENT";

  /// An int representing the user id to be used.
  ///
  /// @hide
  static const String EXTRA_USER_ID = "android.intent.extra.USER_ID";

  /// An int representing the task id to be retrieved. This is used when a launch from recents is
  /// intercepted by another action such as credentials confirmation to remember which task should
  /// be resumed when complete.
  ///
  /// @hide
  static const String EXTRA_TASK_ID = "android.intent.extra.TASK_ID";

  /// An Intent[] describing additional, alternate choices you would like shown with
  /// {@link #ACTION_CHOOSER}.
  ///
  /// <p>An app may be capable of providing several different payload types to complete a
  /// user's intended action. For example, an app invoking {@link #ACTION_SEND} to share photos
  /// with another app may use EXTRA_ALTERNATE_INTENTS to have the chooser transparently offer
  /// several different supported sending mechanisms for sharing, such as the actual "image/*"
  /// photo data or a hosted link where the photos can be viewed.</p>
  ///
  /// <p>The intent present in {@link #EXTRA_INTENT} will be treated as the
  /// first/primary/preferred intent in the set. Additional intents specified in
  /// this extra are ordered; by default intents that appear earlier in the array will be
  /// preferred over intents that appear later in the array as matches for the same
  /// target component. To alter this preference, a calling app may also supply
  /// {@link #EXTRA_CHOOSER_REFINEMENT_INTENT_SENDER}.</p>
  static const String EXTRA_ALTERNATE_INTENTS =
      "android.intent.extra.ALTERNATE_INTENTS";

  /// A {@link ComponentName ComponentName[]} describing components that should be filtered out
  /// and omitted from a list of components presented to the user.
  ///
  /// <p>When used with {@link #ACTION_CHOOSER}, the chooser will omit any of the components
  /// in this array if it otherwise would have shown them. Useful for omitting specific targets
  /// from your own package or other apps from your organization if the idea of sending to those
  /// targets would be redundant with other app functionality. Filtered components will not
  /// be able to present targets from an associated <code>ChooserTargetService</code>.</p>
  static const String EXTRA_EXCLUDE_COMPONENTS =
      "android.intent.extra.EXCLUDE_COMPONENTS";

  /// A {@link android.service.chooser.ChooserTarget ChooserTarget[]} for {@link #ACTION_CHOOSER}
  /// describing additional high-priority deep-link targets for the chooser to present to the user.
  ///
  /// <p>Targets provided in this way will be presented inline with all other targets provided
  /// by services from other apps. They will be prioritized before other service targets, but
  /// after those targets provided by sources that the user has manually pinned to the front.</p>
  ///
  /// @see #ACTION_CHOOSER
  static const String EXTRA_CHOOSER_TARGETS =
      "android.intent.extra.CHOOSER_TARGETS";

  /// An {@link IntentSender} for an Activity that will be invoked when the user makes a selection
  /// from the chooser activity presented by {@link #ACTION_CHOOSER}.
  ///
  /// <p>An app preparing an action for another app to complete may wish to allow the user to
  /// disambiguate between several options for completing the action based on the chosen target
  /// or otherwise refine the action before it is invoked.
  /// </p>
  ///
  /// <p>When sent, this IntentSender may be filled in with the following extras:</p>
  /// <ul>
  ///     <li>{@link #EXTRA_INTENT} The first intent that matched the user's chosen target</li>
  ///     <li>{@link #EXTRA_ALTERNATE_INTENTS} Any additional intents that also matched the user's
  ///     chosen target beyond the first</li>
  ///     <li>{@link #EXTRA_RESULT_RECEIVER} A {@link ResultReceiver} that the refinement activity
  ///     should fill in and send once the disambiguation is complete</li>
  /// </ul>
  static const String EXTRA_CHOOSER_REFINEMENT_INTENT_SENDER =
      "android.intent.extra.CHOOSER_REFINEMENT_INTENT_SENDER";

  /// An {@code ArrayList} of {@code String} annotations describing content for
  /// {@link #ACTION_CHOOSER}.
  ///
  /// <p>If {@link #EXTRA_CONTENT_ANNOTATIONS} is present in an intent used to start a
  /// {@link #ACTION_CHOOSER} activity, the first three annotations will be used to rank apps.</p>
  ///
  /// <p>Annotations should describe the major components or topics of the content. It is up to
  /// apps initiating {@link #ACTION_CHOOSER} to learn and add annotations. Annotations should be
  /// learned in advance, e.g., when creating or saving content, to avoid increasing latency to
  /// start {@link #ACTION_CHOOSER}. Names of customized annotations should not contain the colon
  /// character. Performance on customized annotations can suffer, if they are rarely used for
  /// {@link #ACTION_CHOOSER} in the past 14 days. Therefore, it is recommended to use the
  /// following annotations when applicable.</p>
  /// <ul>
  ///     <li>"product" represents that the topic of the content is mainly about products, e.g.,
  ///     health & beauty, and office supplies.</li>
  ///     <li>"emotion" represents that the topic of the content is mainly about emotions, e.g.,
  ///     happy, and sad.</li>
  ///     <li>"person" represents that the topic of the content is mainly about persons, e.g.,
  ///     face, finger, standing, and walking.</li>
  ///     <li>"child" represents that the topic of the content is mainly about children, e.g.,
  ///     child, and baby.</li>
  ///     <li>"selfie" represents that the topic of the content is mainly about selfies.</li>
  ///     <li>"crowd" represents that the topic of the content is mainly about crowds.</li>
  ///     <li>"party" represents that the topic of the content is mainly about parties.</li>
  ///     <li>"animal" represent that the topic of the content is mainly about animals.</li>
  ///     <li>"plant" represents that the topic of the content is mainly about plants, e.g.,
  ///     flowers.</li>
  ///     <li>"vacation" represents that the topic of the content is mainly about vacations.</li>
  ///     <li>"fashion" represents that the topic of the content is mainly about fashion, e.g.
  ///     sunglasses, jewelry, handbags and clothing.</li>
  ///     <li>"material" represents that the topic of the content is mainly about materials, e.g.,
  ///     paper, and silk.</li>
  ///     <li>"vehicle" represents that the topic of the content is mainly about vehicles, like
  ///     cars, and boats.</li>
  ///     <li>"document" represents that the topic of the content is mainly about documents, e.g.
  ///     posters.</li>
  ///     <li>"design" represents that the topic of the content is mainly about design, e.g. arts
  ///     and designs of houses.</li>
  ///     <li>"holiday" represents that the topic of the content is mainly about holidays, e.g.,
  ///     Christmas and Thanksgiving.</li>
  /// </ul>
  static const String EXTRA_CONTENT_ANNOTATIONS =
      "android.intent.extra.CONTENT_ANNOTATIONS";

  /// A {@link ResultReceiver} used to return data back to the sender.
  ///
  /// <p>Used to complete an app-specific
  /// {@link #EXTRA_CHOOSER_REFINEMENT_INTENT_SENDER refinement} for {@link #ACTION_CHOOSER}.</p>
  ///
  /// <p>If {@link #EXTRA_CHOOSER_REFINEMENT_INTENT_SENDER} is present in the intent
  /// used to start a {@link #ACTION_CHOOSER} activity this extra will be
  /// {@link #fillIn(Intent, int) filled in} to that {@link IntentSender} and sent
  /// when the user selects a target component from the chooser. It is up to the recipient
  /// to send a result to this ResultReceiver to signal that disambiguation is complete
  /// and that the chooser should invoke the user's choice.</p>
  ///
  /// <p>The disambiguator should provide a Bundle to the ResultReceiver with an intent
  /// assigned to the key {@link #EXTRA_INTENT}. This supplied intent will be used by the chooser
  /// to match and fill in the const Intent or ChooserTarget before starting it.
  /// The supplied intent must {@link #filterEquals(Intent) match} one of the intents from
  /// {@link #EXTRA_INTENT} or {@link #EXTRA_ALTERNATE_INTENTS} passed to
  /// {@link #EXTRA_CHOOSER_REFINEMENT_INTENT_SENDER} to be accepted.</p>
  ///
  /// <p>The result code passed to the ResultReceiver should be
  /// {@link android.app.Activity#RESULT_OK} if the refinement succeeded and the supplied intent's
  /// target in the chooser should be started, or {@link android.app.Activity#RESULT_CANCELED} if
  /// the chooser should finish without starting a target.</p>
  static const String EXTRA_RESULT_RECEIVER =
      "android.intent.extra.RESULT_RECEIVER";

  /// A CharSequence dialog title to provide to the user when used with a
  /// {@link #ACTION_CHOOSER}.
  static const String EXTRA_TITLE = "android.intent.extra.TITLE";

  /// A Parcelable[] of {@link Intent} or
  /// {@link android.content.pm.LabeledIntent} objects as set with
  /// {@link #putExtra(String, Parcelable[])} of additional activities to place
  /// a the front of the list of choices, when shown to the user with a
  /// {@link #ACTION_CHOOSER}.
  static const String EXTRA_INITIAL_INTENTS =
      "android.intent.extra.INITIAL_INTENTS";

  /// A {@link IntentSender} to start after instant app installation success.
  /// @hide

  static const String EXTRA_INSTANT_APP_SUCCESS =
      "android.intent.extra.INSTANT_APP_SUCCESS";

  /// A {@link IntentSender} to start after instant app installation failure.
  /// @hide

  static const String EXTRA_INSTANT_APP_FAILURE =
      "android.intent.extra.INSTANT_APP_FAILURE";

  /// The host name that triggered an instant app resolution.
  /// @hide

  static const String EXTRA_INSTANT_APP_HOSTNAME =
      "android.intent.extra.INSTANT_APP_HOSTNAME";

  /// An opaque token to track instant app resolution.
  /// @hide

  static const String EXTRA_INSTANT_APP_TOKEN =
      "android.intent.extra.INSTANT_APP_TOKEN";

  /// The action that triggered an instant application resolution.
  /// @hide

  static const String EXTRA_INSTANT_APP_ACTION =
      "android.intent.extra.INSTANT_APP_ACTION";

  /// An array of {@link Bundle}s containing details about resolved instant apps..
  /// @hide

  static const String EXTRA_INSTANT_APP_BUNDLES =
      "android.intent.extra.INSTANT_APP_BUNDLES";

  /// A {@link Bundle} of metadata that describes the instant application that needs to be
  /// installed. This data is populated from the response to
  /// {@link android.content.pm.InstantAppResolveInfo#getExtras()} as provided by the registered
  /// instant application resolver.
  /// @hide

  static const String EXTRA_INSTANT_APP_EXTRAS =
      "android.intent.extra.INSTANT_APP_EXTRAS";

  /// A boolean value indicating that the instant app resolver was unable to state with certainty
  /// that it did or did not have an app for the sanitized {@link Intent} defined at
  /// {@link #EXTRA_INTENT}.
  /// @hide

  static const String EXTRA_UNKNOWN_INSTANT_APP =
      "android.intent.extra.UNKNOWN_INSTANT_APP";

  /// The version code of the app to install components from.
  /// @deprecated Use {@link #EXTRA_LONG_VERSION_CODE).
  /// @hide
  @deprecated
  static const String EXTRA_VERSION_CODE = "android.intent.extra.VERSION_CODE";

  /// The version code of the app to install components from.
  /// @hide

  static const String EXTRA_LONG_VERSION_CODE =
      "android.intent.extra.LONG_VERSION_CODE";

  /// The app that triggered the instant app installation.
  /// @hide

  static const String EXTRA_CALLING_PACKAGE =
      "android.intent.extra.CALLING_PACKAGE";

  /// Optional calling app provided bundle containing additional launch information the
  /// installer may use.
  /// @hide

  static const String EXTRA_VERIFICATION_BUNDLE =
      "android.intent.extra.VERIFICATION_BUNDLE";

  /// A Bundle forming a mapping of potential target package names to different extras Bundles
  /// to add to the default intent extras in {@link #EXTRA_INTENT} when used with
  /// {@link #ACTION_CHOOSER}. Each key should be a package name. The package need not
  /// be currently installed on the device.
  ///
  /// <p>An application may choose to provide alternate extras for the case where a user
  /// selects an activity from a predetermined set of target packages. If the activity
  /// the user selects from the chooser belongs to a package with its package name as
  /// a key in this bundle, the corresponding extras for that package will be merged with
  /// the extras already present in the intent at {@link #EXTRA_INTENT}. If a replacement
  /// extra has the same key as an extra already present in the intent it will overwrite
  /// the extra from the intent.</p>
  ///
  /// <p><em>Examples:</em>
  /// <ul>
  ///     <li>An application may offer different {@link #EXTRA_TEXT} to an application
  ///     when sharing with it via {@link #ACTION_SEND}, augmenting a link with additional query
  ///     parameters for that target.</li>
  ///     <li>An application may offer additional metadata for known targets of a given intent
  ///     to pass along information only relevant to that target such as account or content
  ///     identifiers already known to that application.</li>
  /// </ul></p>
  static const String EXTRA_REPLACEMENT_EXTRAS =
      "android.intent.extra.REPLACEMENT_EXTRAS";

  /// An {@link IntentSender} that will be notified if a user successfully chooses a target
  /// component to handle an action in an {@link #ACTION_CHOOSER} activity. The IntentSender
  /// will have the extra {@link #EXTRA_CHOSEN_COMPONENT} appended to it containing the
  /// {@link ComponentName} of the chosen component.
  ///
  /// <p>In some situations this callback may never come, for example if the user abandons
  /// the chooser, switches to another task or any number of other reasons. Apps should not
  /// be written assuming that this callback will always occur.</p>
  static const String EXTRA_CHOSEN_COMPONENT_INTENT_SENDER =
      "android.intent.extra.CHOSEN_COMPONENT_INTENT_SENDER";

  /// The {@link ComponentName} chosen by the user to complete an action.
  ///
  /// @see #EXTRA_CHOSEN_COMPONENT_INTENT_SENDER
  static const String EXTRA_CHOSEN_COMPONENT =
      "android.intent.extra.CHOSEN_COMPONENT";

  /// A {@link android.view.KeyEvent} object containing the event that
  /// triggered the creation of the Intent it is in.
  static const String EXTRA_KEY_EVENT = "android.intent.extra.KEY_EVENT";

  /// Set to true in {@link #ACTION_REQUEST_SHUTDOWN} to request confirmation from the user
  /// before shutting down.
  ///
  /// {@hide}
  static const String EXTRA_KEY_CONFIRM = "android.intent.extra.KEY_CONFIRM";

  /// Set to true in {@link #ACTION_REQUEST_SHUTDOWN} to indicate that the shutdown is
  /// requested by the user.
  ///
  /// {@hide}
  static const String EXTRA_USER_REQUESTED_SHUTDOWN =
      "android.intent.extra.USER_REQUESTED_SHUTDOWN";

  /// Used as a boolean extra field in {@link android.content.Intent#ACTION_PACKAGE_REMOVED} or
  /// {@link android.content.Intent#ACTION_PACKAGE_CHANGED} intents to override the default action
  /// of restarting the application.
  static const String EXTRA_DONT_KILL_APP =
      "android.intent.extra.DONT_KILL_APP";

  /// A String holding the phone number originally entered in
  /// {@link android.content.Intent#ACTION_NEW_OUTGOING_CALL}, or the actual
  /// number to call in a {@link android.content.Intent#ACTION_CALL}.
  static const String EXTRA_PHONE_NUMBER = "android.intent.extra.PHONE_NUMBER";

  /// Used as an int extra field in {@link android.content.Intent#ACTION_UID_REMOVED}
  /// intents to supply the uid the package had been assigned.  Also an optional
  /// extra in {@link android.content.Intent#ACTION_PACKAGE_REMOVED} or
  /// {@link android.content.Intent#ACTION_PACKAGE_CHANGED} for the same
  /// purpose.
  static const String EXTRA_UID = "android.intent.extra.UID";

  /// @hide String array of package names.

  static const String EXTRA_PACKAGES = "android.intent.extra.PACKAGES";

  /// Used as a boolean extra field in {@link android.content.Intent#ACTION_PACKAGE_REMOVED}
  /// intents to indicate whether this represents a full uninstall (removing
  /// both the code and its data) or a partial uninstall (leaving its data,
  /// implying that this is an update).
  static const String EXTRA_DATA_REMOVED = "android.intent.extra.DATA_REMOVED";

  /// @hide
  /// Used as a boolean extra field in {@link android.content.Intent#ACTION_PACKAGE_REMOVED}
  /// intents to indicate that at this point the package has been removed for
  /// all users on the device.
  static const String EXTRA_REMOVED_FOR_ALL_USERS =
      "android.intent.extra.REMOVED_FOR_ALL_USERS";

  /// Used as a boolean extra field in {@link android.content.Intent#ACTION_PACKAGE_REMOVED}
  /// intents to indicate that this is a replacement of the package, so this
  /// broadcast will immediately be followed by an add broadcast for a
  /// different version of the same package.
  static const String EXTRA_REPLACING = "android.intent.extra.REPLACING";

  /// Used as an int extra field in {@link android.app.AlarmManager} intents
  /// to tell the application being invoked how many pending alarms are being
  /// delievered with the intent.  For one-shot alarms this will always be 1.
  /// For recurring alarms, this might be greater than 1 if the device was
  /// asleep or powered off at the time an earlier alarm would have been
  /// delivered.
  static const String EXTRA_ALARM_COUNT = "android.intent.extra.ALARM_COUNT";

  /// Used as an int extra field in {@link android.content.Intent#ACTION_DOCK_EVENT}
  /// intents to request the dock state.  Possible values are
  /// {@link android.content.Intent#EXTRA_DOCK_STATE_UNDOCKED},
  /// {@link android.content.Intent#EXTRA_DOCK_STATE_DESK}, or
  /// {@link android.content.Intent#EXTRA_DOCK_STATE_CAR}, or
  /// {@link android.content.Intent#EXTRA_DOCK_STATE_LE_DESK}, or
  /// {@link android.content.Intent#EXTRA_DOCK_STATE_HE_DESK}.
  static const String EXTRA_DOCK_STATE = "android.intent.extra.DOCK_STATE";

  /// Used as an int value for {@link android.content.Intent#EXTRA_DOCK_STATE}
  /// to represent that the phone is not in any dock.
  static const int EXTRA_DOCK_STATE_UNDOCKED = 0;

  /// Used as an int value for {@link android.content.Intent#EXTRA_DOCK_STATE}
  /// to represent that the phone is in a desk dock.
  static const int EXTRA_DOCK_STATE_DESK = 1;

  /// Used as an int value for {@link android.content.Intent#EXTRA_DOCK_STATE}
  /// to represent that the phone is in a car dock.
  static const int EXTRA_DOCK_STATE_CAR = 2;

  /// Used as an int value for {@link android.content.Intent#EXTRA_DOCK_STATE}
  /// to represent that the phone is in a analog (low end) dock.
  static const int EXTRA_DOCK_STATE_LE_DESK = 3;

  /// Used as an int value for {@link android.content.Intent#EXTRA_DOCK_STATE}
  /// to represent that the phone is in a digital (high end) dock.
  static const int EXTRA_DOCK_STATE_HE_DESK = 4;

  /// Boolean that can be supplied as meta-data with a dock activity, to
  /// indicate that the dock should take over the home key when it is active.
  static const String METADATA_DOCK_HOME = "android.dock_home";

  /// Used as a parcelable extra field in {@link #ACTION_APP_ERROR}, containing
  /// the bug report.
  static const String EXTRA_BUG_REPORT = "android.intent.extra.BUG_REPORT";

  /// Used in the extra field in the remote intent. It's astring token passed with the
  /// remote intent.
  static const String EXTRA_REMOTE_INTENT_TOKEN =
      "android.intent.extra.remote_intent_token";

  /// @deprecated See {@link #EXTRA_CHANGED_COMPONENT_NAME_LIST}; this field
  /// will contain only the first name in the list.
  @deprecated
  static const String EXTRA_CHANGED_COMPONENT_NAME =
      "android.intent.extra.changed_component_name";

  /// This field is part of {@link android.content.Intent#ACTION_PACKAGE_CHANGED},
  /// and contains a string array of all of the components that have changed.  If
  /// the state of the overall package has changed, then it will contain an entry
  /// with the package name itself.
  static const String EXTRA_CHANGED_COMPONENT_NAME_LIST =
      "android.intent.extra.changed_component_name_list";

  /// This field is part of
  /// {@link android.content.Intent#ACTION_EXTERNAL_APPLICATIONS_AVAILABLE},
  /// {@link android.content.Intent#ACTION_EXTERNAL_APPLICATIONS_UNAVAILABLE},
  /// {@link android.content.Intent#ACTION_PACKAGES_SUSPENDED},
  /// {@link android.content.Intent#ACTION_PACKAGES_UNSUSPENDED}
  /// and contains a string array of all of the components that have changed.
  static const String EXTRA_CHANGED_PACKAGE_LIST =
      "android.intent.extra.changed_package_list";

  /// This field is part of
  /// {@link android.content.Intent#ACTION_EXTERNAL_APPLICATIONS_AVAILABLE},
  /// {@link android.content.Intent#ACTION_EXTERNAL_APPLICATIONS_UNAVAILABLE}
  /// and contains an integer array of uids of all of the components
  /// that have changed.
  static const String EXTRA_CHANGED_UID_LIST =
      "android.intent.extra.changed_uid_list";

  /// An integer denoting a bitwise combination of restrictions set on distracting packages via
  /// {@link PackageManager#setDistractingPackageRestrictions(String[], int)}
  ///
  /// @hide
  /// @see PackageManager.DistractionRestriction
  /// @see PackageManager#setDistractingPackageRestrictions(String[], int)
  static const String EXTRA_DISTRACTION_RESTRICTIONS =
      "android.intent.extra.distraction_restrictions";

  /// @hide
  /// Magic extra system code can use when binding, to give a label for
  /// who it is that has bound to a service.  This is an integer giving
  /// a framework string resource that can be displayed to the user.
  static const String EXTRA_CLIENT_LABEL = "android.intent.extra.client_label";

  /// @hide
  /// Magic extra system code can use when binding, to give a PendingIntent object
  /// that can be launched for the user to disable the system's use of this
  /// service.
  static const String EXTRA_CLIENT_INTENT =
      "android.intent.extra.client_intent";

  /// Extra used to indicate that an intent should only return data that is on
  /// the local device. This is a boolean extra; the default is false. If true,
  /// an implementation should only allow the user to select data that is
  /// already on the device, not requiring it be downloaded from a remote
  /// service when opened.
  ///
  /// @see #ACTION_GET_CONTENT
  /// @see #ACTION_OPEN_DOCUMENT
  /// @see #ACTION_OPEN_DOCUMENT_TREE
  /// @see #ACTION_CREATE_DOCUMENT
  static const String EXTRA_LOCAL_ONLY = "android.intent.extra.LOCAL_ONLY";

  /// Extra used to indicate that an intent can allow the user to select and
  /// return multiple items. This is a boolean extra; the default is false. If
  /// true, an implementation is allowed to present the user with a UI where
  /// they can pick multiple items that are all returned to the caller. When
  /// this happens, they should be returned as the {@link #getClipData()} part
  /// of the result Intent.
  ///
  /// @see #ACTION_GET_CONTENT
  /// @see #ACTION_OPEN_DOCUMENT
  static const String EXTRA_ALLOW_MULTIPLE =
      "android.intent.extra.ALLOW_MULTIPLE";

  /// The integer userHandle (i.e. userId) carried with broadcast intents related to addition,
  /// removal and switching of users and managed profiles - {@link #ACTION_USER_ADDED},
  /// {@link #ACTION_USER_REMOVED} and {@link #ACTION_USER_SWITCHED}.
  ///
  /// @hide
  static const String EXTRA_USER_HANDLE = "android.intent.extra.user_handle";

  /// The UserHandle carried with intents.
  static const String EXTRA_USER = "android.intent.extra.USER";

  /// Extra used in the response from a BroadcastReceiver that handles
  /// {@link #ACTION_GET_RESTRICTION_ENTRIES}. The type of the extra is
  /// <code>ArrayList&lt;RestrictionEntry&gt;</code>.
  static const String EXTRA_RESTRICTIONS_LIST =
      "android.intent.extra.restrictions_list";

  /// Extra sent in the intent to the BroadcastReceiver that handles
  /// {@link #ACTION_GET_RESTRICTION_ENTRIES}. The type of the extra is a Bundle containing
  /// the restrictions as key/value pairs.
  static const String EXTRA_RESTRICTIONS_BUNDLE =
      "android.intent.extra.restrictions_bundle";

  /// Extra used in the response from a BroadcastReceiver that handles
  /// {@link #ACTION_GET_RESTRICTION_ENTRIES}.
  static const String EXTRA_RESTRICTIONS_INTENT =
      "android.intent.extra.restrictions_intent";

  /// Extra used to communicate a set of acceptable MIME types. The type of the
  /// extra is {@code String[]}. Values may be a combination of concrete MIME
  /// types (such as "image/png") and/or partial MIME types (such as
  /// "audio/*").
  ///
  /// @see #ACTION_GET_CONTENT
  /// @see #ACTION_OPEN_DOCUMENT
  static const String EXTRA_MIME_TYPES = "android.intent.extra.MIME_TYPES";

  /// Optional extra for {@link #ACTION_SHUTDOWN} that allows the sender to qualify that
  /// this shutdown is only for the user space of the system, not a complete shutdown.
  /// When this is true, hardware devices can use this information to determine that
  /// they shouldn't do a complete shutdown of their device since this is not a
  /// complete shutdown down to the kernel, but only user space restarting.
  /// The default if not supplied is false.
  static const String EXTRA_SHUTDOWN_USERSPACE_ONLY =
      "android.intent.extra.SHUTDOWN_USERSPACE_ONLY";

  /// Optional extra specifying a time in milliseconds since the Epoch. The value must be
  /// non-negative.
  /// <p>
  /// Type: long
  /// </p>
  static const String EXTRA_TIME = "android.intent.extra.TIME";

  /// Extra sent with {@link #ACTION_TIMEZONE_CHANGED} specifying the new time zone of the device.
  ///
  /// <p>Type: String, the same as returned by {@link TimeZone#getID()} to identify time zones.

  static const String EXTRA_TIMEZONE = "time-zone";

  /// Optional int extra for {@link #ACTION_TIME_CHANGED} that indicates the
  /// user has set their time format preference. See {@link #EXTRA_TIME_PREF_VALUE_USE_12_HOUR},
  /// {@link #EXTRA_TIME_PREF_VALUE_USE_24_HOUR} and
  /// {@link #EXTRA_TIME_PREF_VALUE_USE_LOCALE_DEFAULT}. The value must not be negative.
  ///
  /// @hide for internal use only.
  static const String EXTRA_TIME_PREF_24_HOUR_FORMAT =
      "android.intent.extra.TIME_PREF_24_HOUR_FORMAT";

  /// @hide */
  static const int EXTRA_TIME_PREF_VALUE_USE_12_HOUR = 0;

  /// @hide */
  static const int EXTRA_TIME_PREF_VALUE_USE_24_HOUR = 1;

  /// @hide */
  static const int EXTRA_TIME_PREF_VALUE_USE_LOCALE_DEFAULT = 2;

  /// Intent extra: the reason that the operation associated with this intent is being performed.
  ///
  /// <p>Type: String
  /// @hide

  static const String EXTRA_REASON = "android.intent.extra.REASON";

  /// {@hide}
  /// This extra will be send together with {@link #ACTION_FACTORY_RESET}
  static const String EXTRA_WIPE_EXTERNAL_STORAGE =
      "android.intent.extra.WIPE_EXTERNAL_STORAGE";

  /// {@hide}
  /// This extra will be set to true when the user choose to wipe the data on eSIM during factory
  /// reset for the device with eSIM. This extra will be sent together with
  /// {@link #ACTION_FACTORY_RESET}
  static const String EXTRA_WIPE_ESIMS =
      "com.android.internal.intent.extra.WIPE_ESIMS";

  /// Optional {@link android.app.PendingIntent} extra used to deliver the result of the SIM
  /// activation request.
  /// TODO: Add information about the structure and response data used with the pending intent.
  /// @hide
  static const String EXTRA_SIM_ACTIVATION_RESPONSE =
      "android.intent.extra.SIM_ACTIVATION_RESPONSE";

  /// Optional index with semantics depending on the intent action.
  ///
  /// <p>The value must be an integer greater or equal to 0.
  /// @see #ACTION_QUICK_VIEW
  static const String EXTRA_INDEX = "android.intent.extra.INDEX";

  /// Tells the quick viewer to show additional UI actions suitable for the passed Uris,
  /// such as opening in other apps, sharing, opening, editing, printing, deleting,
  /// casting, etc.
  ///
  /// <p>The value is boolean. By default false.
  /// @see #ACTION_QUICK_VIEW
  /// @removed
  @deprecated
  static const String EXTRA_QUICK_VIEW_ADVANCED =
      "android.intent.extra.QUICK_VIEW_ADVANCED";

  /// An optional extra of {@code String[]} indicating which quick view features should be made
  /// available to the user in the quick view UI while handing a
  /// {@link Intent#ACTION_QUICK_VIEW} intent.
  /// <li>Enumeration of features here is not meant to restrict capabilities of the quick viewer.
  /// Quick viewer can implement features not listed below.
  /// <li>Features included at this time are: {@link QuickViewConstants#FEATURE_VIEW},
  /// {@link QuickViewConstants#FEATURE_EDIT}, {@link QuickViewConstants#FEATURE_DELETE},
  /// {@link QuickViewConstants#FEATURE_DOWNLOAD}, {@link QuickViewConstants#FEATURE_SEND},
  /// {@link QuickViewConstants#FEATURE_PRINT}.
  /// <p>
  /// Requirements:
  /// <li>Quick viewer shouldn't show a feature if the feature is absent in
  /// {@link #EXTRA_QUICK_VIEW_FEATURES}.
  /// <li>When {@link #EXTRA_QUICK_VIEW_FEATURES} is not present, quick viewer should follow
  /// internal policies.
  /// <li>Presence of an feature in {@link #EXTRA_QUICK_VIEW_FEATURES}, does not constitute a
  /// requirement that the feature be shown. Quick viewer may, according to its own policies,
  /// disable or hide features.
  ///
  /// @see #ACTION_QUICK_VIEW
  static const String EXTRA_QUICK_VIEW_FEATURES =
      "android.intent.extra.QUICK_VIEW_FEATURES";

  /// Optional boolean extra indicating whether quiet mode has been switched on or off.
  /// When a profile goes into quiet mode, all apps in the profile are killed and the
  /// profile user is stopped. Widgets originating from the profile are masked, and app
  /// launcher icons are grayed out.
  static const String EXTRA_QUIET_MODE = "android.intent.extra.QUIET_MODE";

  /// Optional CharSequence extra to provide a search query.
  /// The format of this query is dependent on the receiving application.
  ///
  /// <p>Applicable to {@link Intent} with actions:
  /// <ul>
  ///      <li>{@link Intent#ACTION_GET_CONTENT}</li>
  ///      <li>{@link Intent#ACTION_OPEN_DOCUMENT}</li>
  /// </ul>
  static const String EXTRA_CONTENT_QUERY =
      "android.intent.extra.CONTENT_QUERY";

  /// Used as an int extra field in {@link #ACTION_MEDIA_RESOURCE_GRANTED}
  /// intents to specify the resource type granted. Possible values are
  /// {@link #EXTRA_MEDIA_RESOURCE_TYPE_VIDEO_CODEC} or
  /// {@link #EXTRA_MEDIA_RESOURCE_TYPE_AUDIO_CODEC}.
  ///
  /// @hide
  static const String EXTRA_MEDIA_RESOURCE_TYPE =
      "android.intent.extra.MEDIA_RESOURCE_TYPE";

  /// Used as a boolean extra field in {@link #ACTION_CHOOSER} intents to specify
  /// whether to show the chooser or not when there is only one application available
  /// to choose from.
  static const String EXTRA_AUTO_LAUNCH_SINGLE_CHOICE =
      "android.intent.extra.AUTO_LAUNCH_SINGLE_CHOICE";

  /// Used as an int value for {@link #EXTRA_MEDIA_RESOURCE_TYPE}
  /// to represent that a video codec is allowed to use.
  ///
  /// @hide
  static const int EXTRA_MEDIA_RESOURCE_TYPE_VIDEO_CODEC = 0;

  /// Used as an int value for {@link #EXTRA_MEDIA_RESOURCE_TYPE}
  /// to represent that a audio codec is allowed to use.
  ///
  /// @hide
  static const int EXTRA_MEDIA_RESOURCE_TYPE_AUDIO_CODEC = 1;

  /// Intent extra: ID of the context used on {@link #ACTION_VIEW_LOCUS}.
  ///
  /// <p>
  /// Type: {@link LocusId}
  /// </p>
  static const String EXTRA_LOCUS_ID = "android.intent.extra.LOCUS_ID";

  /// If set, the recipient of this Intent will be granted permission to
  /// perform read operations on the URI in the Intent's data and any URIs
  /// specified in its ClipData.  When applying to an Intent's ClipData,
  /// all URIs as well as recursive traversals through data or other ClipData
  /// in Intent items will be granted; only the grant flags of the top-level
  /// Intent are used.
  static const int FLAG_GRANT_READ_URI_PERMISSION = 0x00000001;

  /// If set, the recipient of this Intent will be granted permission to
  /// perform write operations on the URI in the Intent's data and any URIs
  /// specified in its ClipData.  When applying to an Intent's ClipData,
  /// all URIs as well as recursive traversals through data or other ClipData
  /// in Intent items will be granted; only the grant flags of the top-level
  /// Intent are used.
  static const int FLAG_GRANT_WRITE_URI_PERMISSION = 0x00000002;

  /// Can be set by the caller to indicate that this Intent is coming from
  /// a background operation, not from direct user interaction.
  static const int FLAG_FROM_BACKGROUND = 0x00000004;

  /// A flag you can enable for debugging: when set, log messages will be
  /// printed during the resolution of this intent to show you what has
  /// been found to create the const resolved list.
  static const int FLAG_DEBUG_LOG_RESOLUTION = 0x00000008;

  /// If set, this intent will not match any components in packages that
  /// are currently stopped.  If this is not set, then the default behavior
  /// is to include such applications in the result.
  static const int FLAG_EXCLUDE_STOPPED_PACKAGES = 0x00000010;

  /// If set, this intent will always match any components in packages that
  /// are currently stopped.  This is the default behavior when
  /// {@link #FLAG_EXCLUDE_STOPPED_PACKAGES} is not set.  If both of these
  /// flags are set, this one wins (it allows overriding of exclude for
  /// places where the framework may automatically set the exclude flag).
  static const int FLAG_INCLUDE_STOPPED_PACKAGES = 0x00000020;

  /// When combined with {@link #FLAG_GRANT_READ_URI_PERMISSION} and/or
  /// {@link #FLAG_GRANT_WRITE_URI_PERMISSION}, the URI permission grant can be
  /// persisted across device reboots until explicitly revoked with
  /// {@link Context#revokeUriPermission(Uri, int)}. This flag only offers the
  /// grant for possible persisting; the receiving application must call
  /// {@link ContentResolver#takePersistableUriPermission(Uri, int)} to
  /// actually persist.
  ///
  /// @see ContentResolver#takePersistableUriPermission(Uri, int)
  /// @see ContentResolver#releasePersistableUriPermission(Uri, int)
  /// @see ContentResolver#getPersistedUriPermissions()
  /// @see ContentResolver#getOutgoingPersistedUriPermissions()
  static const int FLAG_GRANT_PERSISTABLE_URI_PERMISSION = 0x00000040;

  /// When combined with {@link #FLAG_GRANT_READ_URI_PERMISSION} and/or
  /// {@link #FLAG_GRANT_WRITE_URI_PERMISSION}, the URI permission grant
  /// applies to any URI that is a prefix match against the original granted
  /// URI. (Without this flag, the URI must match exactly for access to be
  /// granted.) Another URI is considered a prefix match only when scheme,
  /// authority, and all path segments defined by the prefix are an exact
  /// match.
  static const int FLAG_GRANT_PREFIX_URI_PERMISSION = 0x00000080;

  /// Flag used to automatically match intents based on their Direct Boot
  /// awareness and the current user state.
  /// <p>
  /// Since the default behavior is to automatically apply the current user
  /// state, this is effectively a sentinel value that doesn't change the
  /// output of any queries based on its presence or absence.
  /// <p>
  /// Instead, this value can be useful in conjunction with
  /// {@link android.os.StrictMode.VmPolicy.Builder#detectImplicitDirectBoot()}
  /// to detect when a caller is relying on implicit automatic matching,
  /// instead of confirming the explicit behavior they want.
  static const int FLAG_DIRECT_BOOT_AUTO = 0x00000100;

  /// {@hide} */
  @deprecated
  static const int FLAG_DEBUG_TRIAGED_MISSING = FLAG_DIRECT_BOOT_AUTO;

  /// Internal flag used to indicate ephemeral applications should not be
  /// considered when resolving the intent.
  ///
  /// @hide
  static const int FLAG_IGNORE_EPHEMERAL = 0x00000200;

  /// If set, the new activity is not kept in the history stack.  As soon as
  /// the user navigates away from it, the activity is finished.  This may also
  /// be set with the {@link android.R.styleable#AndroidManifestActivity_noHistory
  /// noHistory} attribute.
  ///
  /// <p>If set, {@link android.app.Activity#onActivityResult onActivityResult()}
  /// is never invoked when the current activity starts a new activity which
  /// sets a result and finishes.
  static const int FLAG_ACTIVITY_NO_HISTORY = 0x40000000;

  /// If set, the activity will not be launched if it is already running
  /// at the top of the history stack.
  static const int FLAG_ACTIVITY_SINGLE_TOP = 0x20000000;

  /// If set, this activity will become the start of a new task on this
  /// history stack.  A task (from the activity that started it to the
  /// next task activity) defines an atomic group of activities that the
  /// user can move to.  Tasks can be moved to the foreground and background;
  /// all of the activities inside of a particular task always remain in
  /// the same order.  See
  /// <a href="{@docRoot}guide/topics/fundamentals/tasks-and-back-stack.html">Tasks and Back
  /// Stack</a> for more information about tasks.
  ///
  /// <p>This flag is generally used by activities that want
  /// to present a "launcher" style behavior: they give the user a list of
  /// separate things that can be done, which otherwise run completely
  /// independently of the activity launching them.
  ///
  /// <p>When using this flag, if a task is already running for the activity
  /// you are now starting, then a new activity will not be started; instead,
  /// the current task will simply be brought to the front of the screen with
  /// the state it was last in.  See {@link #FLAG_ACTIVITY_MULTIPLE_TASK} for a flag
  /// to disable this behavior.
  ///
  /// <p>This flag can not be used when the caller is requesting a result from
  /// the activity being launched.
  static const int FLAG_ACTIVITY_NEW_TASK = 0x10000000;

  /// This flag is used to create a new task and launch an activity into it.
  /// This flag is always paired with either {@link #FLAG_ACTIVITY_NEW_DOCUMENT}
  /// or {@link #FLAG_ACTIVITY_NEW_TASK}. In both cases these flags alone would
  /// search through existing tasks for ones matching this Intent. Only if no such
  /// task is found would a new task be created. When paired with
  /// FLAG_ACTIVITY_MULTIPLE_TASK both of these behaviors are modified to skip
  /// the search for a matching task and unconditionally start a new task.
  ///
  /// <strong>When used with {@link #FLAG_ACTIVITY_NEW_TASK} do not use this
  /// flag unless you are implementing your own
  /// top-level application launcher.</strong>  Used in conjunction with
  /// {@link #FLAG_ACTIVITY_NEW_TASK} to disable the
  /// behavior of bringing an existing task to the foreground.  When set,
  /// a new task is <em>always</em> started to host the Activity for the
  /// Intent, regardless of whether there is already an existing task running
  /// the same thing.
  ///
  /// <p><strong>Because the default system does not include graphical task management,
  /// you should not use this flag unless you provide some way for a user to
  /// return back to the tasks you have launched.</strong>
  ///
  /// See {@link #FLAG_ACTIVITY_NEW_DOCUMENT} for details of this flag's use for
  /// creating new document tasks.
  ///
  /// <p>This flag is ignored if one of {@link #FLAG_ACTIVITY_NEW_TASK} or
  /// {@link #FLAG_ACTIVITY_NEW_DOCUMENT} is not also set.
  ///
  /// <p>See
  /// <a href="{@docRoot}guide/topics/fundamentals/tasks-and-back-stack.html">Tasks and Back
  /// Stack</a> for more information about tasks.
  ///
  /// @see #FLAG_ACTIVITY_NEW_DOCUMENT
  /// @see #FLAG_ACTIVITY_NEW_TASK
  static const int FLAG_ACTIVITY_MULTIPLE_TASK = 0x08000000;

  /// If set, and the activity being launched is already running in the
  /// current task, then instead of launching a new instance of that activity,
  /// all of the other activities on top of it will be closed and this Intent
  /// will be delivered to the (now on top) old activity as a new Intent.
  ///
  /// <p>For example, consider a task consisting of the activities: A, B, C, D.
  /// If D calls startActivity() with an Intent that resolves to the component
  /// of activity B, then C and D will be finished and B receive the given
  /// Intent, resulting in the stack now being: A, B.
  ///
  /// <p>The currently running instance of activity B in the above example will
  /// either receive the new intent you are starting here in its
  /// onNewIntent() method, or be itself finished and restarted with the
  /// new intent.  If it has declared its launch mode to be "multiple" (the
  /// default) and you have not set {@link #FLAG_ACTIVITY_SINGLE_TOP} in
  /// the same intent, then it will be finished and re-created; for all other
  /// launch modes or if {@link #FLAG_ACTIVITY_SINGLE_TOP} is set then this
  /// Intent will be delivered to the current instance's onNewIntent().
  ///
  /// <p>This launch mode can also be used to good effect in conjunction with
  /// {@link #FLAG_ACTIVITY_NEW_TASK}: if used to start the root activity
  /// of a task, it will bring any currently running instance of that task
  /// to the foreground, and then clear it to its root state.  This is
  /// especially useful, for example, when launching an activity from the
  /// notification manager.
  ///
  /// <p>See
  /// <a href="{@docRoot}guide/topics/fundamentals/tasks-and-back-stack.html">Tasks and Back
  /// Stack</a> for more information about tasks.
  static const int FLAG_ACTIVITY_CLEAR_TOP = 0x04000000;

  /// If set and this intent is being used to launch a new activity from an
  /// existing one, then the reply target of the existing activity will be
  /// transferred to the new activity.  This way, the new activity can call
  /// {@link android.app.Activity#setResult} and have that result sent back to
  /// the reply target of the original activity.
  static const int FLAG_ACTIVITY_FORWARD_RESULT = 0x02000000;

  /// If set and this intent is being used to launch a new activity from an
  /// existing one, the current activity will not be counted as the top
  /// activity for deciding whether the new intent should be delivered to
  /// the top instead of starting a new one.  The previous activity will
  /// be used as the top, with the assumption being that the current activity
  /// will finish itself immediately.
  static const int FLAG_ACTIVITY_PREVIOUS_IS_TOP = 0x01000000;

  /// If set, the new activity is not kept in the list of recently launched
  /// activities.
  static const int FLAG_ACTIVITY_EXCLUDE_FROM_RECENTS = 0x00800000;

  /// This flag is not normally set by application code, but set for you by
  /// the system as described in the
  /// {@link android.R.styleable#AndroidManifestActivity_launchMode
  /// launchMode} documentation for the singleTask mode.
  static const int FLAG_ACTIVITY_BROUGHT_TO_FRONT = 0x00400000;

  /// If set, and this activity is either being started in a new task or
  /// bringing to the top an existing task, then it will be launched as
  /// the front door of the task.  This will result in the application of
  /// any affinities needed to have that task in the proper state (either
  /// moving activities to or from it), or simply resetting that task to
  /// its initial state if needed.
  static const int FLAG_ACTIVITY_RESET_TASK_IF_NEEDED = 0x00200000;

  /// This flag is not normally set by application code, but set for you by
  /// the system if this activity is being launched from history
  /// (longpress home key).
  static const int FLAG_ACTIVITY_LAUNCHED_FROM_HISTORY = 0x00100000;

  /// @deprecated As of API 21 this performs identically to
  /// {@link #FLAG_ACTIVITY_NEW_DOCUMENT} which should be used instead of this.
  @deprecated
  static const int FLAG_ACTIVITY_CLEAR_WHEN_TASK_RESET = 0x00080000;

  /// This flag is used to open a document into a new task rooted at the activity launched
  /// by this Intent. Through the use of this flag, or its equivalent attribute,
  /// {@link android.R.attr#documentLaunchMode} multiple instances of the same activity
  /// containing different documents will appear in the recent tasks list.
  ///
  /// <p>The use of the activity attribute form of this,
  /// {@link android.R.attr#documentLaunchMode}, is
  /// preferred over the Intent flag described here. The attribute form allows the
  /// Activity to specify multiple document behavior for all launchers of the Activity
  /// whereas using this flag requires each Intent that launches the Activity to specify it.
  ///
  /// <p>Note that the default semantics of this flag w.r.t. whether the recents entry for
  /// it is kept after the activity is finished is different than the use of
  /// {@link #FLAG_ACTIVITY_NEW_TASK} and {@link android.R.attr#documentLaunchMode} -- if
  /// this flag is being used to create a new recents entry, then by default that entry
  /// will be removed once the activity is finished.  You can modify this behavior with
  /// {@link #FLAG_ACTIVITY_RETAIN_IN_RECENTS}.
  ///
  /// <p>FLAG_ACTIVITY_NEW_DOCUMENT may be used in conjunction with {@link
  /// #FLAG_ACTIVITY_MULTIPLE_TASK}. When used alone it is the
  /// equivalent of the Activity manifest specifying {@link
  /// android.R.attr#documentLaunchMode}="intoExisting". When used with
  /// FLAG_ACTIVITY_MULTIPLE_TASK it is the equivalent of the Activity manifest specifying
  /// {@link android.R.attr#documentLaunchMode}="always".
  ///
  /// Refer to {@link android.R.attr#documentLaunchMode} for more information.
  ///
  /// @see android.R.attr#documentLaunchMode
  /// @see #FLAG_ACTIVITY_MULTIPLE_TASK
  static const int FLAG_ACTIVITY_NEW_DOCUMENT =
      FLAG_ACTIVITY_CLEAR_WHEN_TASK_RESET;

  /// If set, this flag will prevent the normal {@link android.app.Activity#onUserLeaveHint}
  /// callback from occurring on the current frontmost activity before it is
  /// paused as the newly-started activity is brought to the front.
  ///
  /// <p>Typically, an activity can rely on that callback to indicate that an
  /// explicit user action has caused their activity to be moved out of the
  /// foreground. The callback marks an appropriate point in the activity's
  /// lifecycle for it to dismiss any notifications that it intends to display
  /// "until the user has seen them," such as a blinking LED.
  ///
  /// <p>If an activity is ever started via any non-user-driven events such as
  /// phone-call receipt or an alarm handler, this flag should be passed to {@link
  /// Context#startActivity Context.startActivity}, ensuring that the pausing
  /// activity does not think the user has acknowledged its notification.
  static const int FLAG_ACTIVITY_NO_USER_ACTION = 0x00040000;

  /// If set in an Intent passed to {@link Context#startActivity Context.startActivity()},
  /// this flag will cause the launched activity to be brought to the front of its
  /// task's history stack if it is already running.
  ///
  /// <p>For example, consider a task consisting of four activities: A, B, C, D.
  /// If D calls startActivity() with an Intent that resolves to the component
  /// of activity B, then B will be brought to the front of the history stack,
  /// with this resulting order:  A, C, D, B.
  ///
  /// This flag will be ignored if {@link #FLAG_ACTIVITY_CLEAR_TOP} is also
  /// specified.
  static const int FLAG_ACTIVITY_REORDER_TO_FRONT = 0X00020000;

  /// If set in an Intent passed to {@link Context#startActivity Context.startActivity()},
  /// this flag will prevent the system from applying an activity transition
  /// animation to go to the next activity state.  This doesn't mean an
  /// animation will never run -- if another activity change happens that doesn't
  /// specify this flag before the activity started here is displayed, then
  /// that transition will be used.  This flag can be put to good use
  /// when you are going to do a series of activity operations but the
  /// animation seen by the user shouldn't be driven by the first activity
  /// change but rather a later one.
  static const int FLAG_ACTIVITY_NO_ANIMATION = 0X00010000;

  /// If set in an Intent passed to {@link Context#startActivity Context.startActivity()},
  /// this flag will cause any existing task that would be associated with the
  /// activity to be cleared before the activity is started.  That is, the activity
  /// becomes the new root of an otherwise empty task, and any old activities
  /// are finished.  This can only be used in conjunction with {@link #FLAG_ACTIVITY_NEW_TASK}.
  static const int FLAG_ACTIVITY_CLEAR_TASK = 0X00008000;

  /// If set in an Intent passed to {@link Context#startActivity Context.startActivity()},
  /// this flag will cause a newly launching task to be placed on top of the current
  /// home activity task (if there is one).  That is, pressing back from the task
  /// will always return the user to home even if that was not the last activity they
  /// saw.   This can only be used in conjunction with {@link #FLAG_ACTIVITY_NEW_TASK}.
  static const int FLAG_ACTIVITY_TASK_ON_HOME = 0X00004000;

  /// By default a document created by {@link #FLAG_ACTIVITY_NEW_DOCUMENT} will
  /// have its entry in recent tasks removed when the user closes it (with back
  /// or however else it may finish()). If you would like to instead allow the
  /// document to be kept in recents so that it can be re-launched, you can use
  /// this flag. When set and the task's activity is finished, the recents
  /// entry will remain in the interface for the user to re-launch it, like a
  /// recents entry for a top-level application.
  /// <p>
  /// The receiving activity can override this request with
  /// {@link android.R.attr#autoRemoveFromRecents} or by explcitly calling
  /// {@link android.app.Activity#finishAndRemoveTask()
  /// Activity.finishAndRemoveTask()}.
  static const int FLAG_ACTIVITY_RETAIN_IN_RECENTS = 0x00002000;

  /// This flag is only used for split-screen multi-window mode. The new activity will be displayed
  /// adjacent to the one launching it. This can only be used in conjunction with
  /// {@link #FLAG_ACTIVITY_NEW_TASK}. Also, setting {@link #FLAG_ACTIVITY_MULTIPLE_TASK} is
  /// required if you want a new instance of an existing activity to be created.
  static const int FLAG_ACTIVITY_LAUNCH_ADJACENT = 0x00001000;

  /// If set in an Intent passed to {@link Context#startActivity Context.startActivity()},
  /// this flag will attempt to launch an instant app if no full app on the device can already
  /// handle the intent.
  /// <p>
  /// When attempting to resolve instant apps externally, the following {@link Intent} properties
  /// are supported:
  /// <ul>
  ///     <li>{@link Intent#setAction(String)}</li>
  ///     <li>{@link Intent#addCategory(String)}</li>
  ///     <li>{@link Intent#setData(Uri)}</li>
  ///     <li>{@link Intent#setType(String)}</li>
  ///     <li>{@link Intent#setPackage(String)}</li>
  ///     <li>{@link Intent#addFlags(int)}</li>
  /// </ul>
  /// <p>
  /// In the case that no instant app can be found, the installer will be launched to notify the
  /// user that the intent could not be resolved. On devices that do not support instant apps,
  /// the flag will be ignored.
  static const int FLAG_ACTIVITY_MATCH_EXTERNAL = 0x00000800;

  /// If set in an intent passed to {@link Context#startActivity Context.startActivity()}, this
  /// flag will only launch the intent if it resolves to a result that is not a browser. If no such
  /// result exists, an {@link ActivityNotFoundException} will be thrown.
  static const int FLAG_ACTIVITY_REQUIRE_NON_BROWSER = 0x00000400;

  /// If set in an intent passed to {@link Context#startActivity Context.startActivity()}, this
  /// flag will only launch the intent if it resolves to a single result. If no such result exists
  /// or if the system chooser would otherwise be displayed, an {@link ActivityNotFoundException}
  /// will be thrown.
  static const int FLAG_ACTIVITY_REQUIRE_DEFAULT = 0x00000200;

  /// If set, when sending a broadcast only registered receivers will be
  /// called -- no BroadcastReceiver components will be launched.
  static const int FLAG_RECEIVER_REGISTERED_ONLY = 0x40000000;

  /// If set, when sending a broadcast the new broadcast will replace
  /// any existing pending broadcast that matches it.  Matching is defined
  /// by {@link Intent#filterEquals(Intent) Intent.filterEquals} returning
  /// true for the intents of the two broadcasts.  When a match is found,
  /// the new broadcast (and receivers associated with it) will replace the
  /// existing one in the pending broadcast list, remaining at the same
  /// position in the list.
  ///
  /// <p>This flag is most typically used with sticky broadcasts, which
  /// only care about delivering the most recent values of the broadcast
  /// to their receivers.
  static const int FLAG_RECEIVER_REPLACE_PENDING = 0x20000000;

  /// If set, when sending a broadcast the recipient is allowed to run at
  /// foreground priority, with a shorter timeout interval.  During normal
  /// broadcasts the receivers are not automatically hoisted out of the
  /// background priority class.
  static const int FLAG_RECEIVER_FOREGROUND = 0x10000000;

  /// If set, when sending a broadcast the recipient will be run on the offload queue.
  ///
  /// @hide
  static const int FLAG_RECEIVER_OFFLOAD = 0x80000000;

  /// If this is an ordered broadcast, don't allow receivers to abort the broadcast.
  /// They can still propagate results through to later receivers, but they can not prevent
  /// later receivers from seeing the broadcast.
  static const int FLAG_RECEIVER_NO_ABORT = 0x08000000;

  /// If set, when sending a broadcast <i>before the system has fully booted up
  /// (which is even before {@link #ACTION_LOCKED_BOOT_COMPLETED} has been sent)"</i> only
  /// registered receivers will be called -- no BroadcastReceiver components
  /// will be launched.  Sticky intent state will be recorded properly even
  /// if no receivers wind up being called.  If {@link #FLAG_RECEIVER_REGISTERED_ONLY}
  /// is specified in the broadcast intent, this flag is unnecessary.
  ///
  /// <p>This flag is only for use by system services (even services from mainline modules) as a
  /// convenience to avoid having to implement a more complex mechanism around detection
  /// of boot completion.
  ///
  /// <p>This is useful to system server mainline modules
  ///
  /// @hide
  static const int FLAG_RECEIVER_REGISTERED_ONLY_BEFORE_BOOT = 0x04000000;

  /// Set when this broadcast is for a boot upgrade, a special mode that
  /// allows the broadcast to be sent before the system is ready and launches
  /// the app process with no providers running in it.
  /// @hide
  static const int FLAG_RECEIVER_BOOT_UPGRADE = 0x02000000;

  /// If set, the broadcast will always go to manifest receivers in background (cached
  /// or not running) apps, regardless of whether that would be done by default.  By
  /// default they will only receive broadcasts if the broadcast has specified an
  /// explicit component or package name.
  ///
  /// NOTE: dumpstate uses this flag numerically, so when its value is changed
  /// the broadcast code there must also be changed to match.
  ///
  /// @hide
  static const int FLAG_RECEIVER_INCLUDE_BACKGROUND = 0x01000000;

  /// If set, the broadcast will never go to manifest receivers in background (cached
  /// or not running) apps, regardless of whether that would be done by default.  By
  /// default they will receive broadcasts if the broadcast has specified an
  /// explicit component or package name.
  /// @hide
  static const int FLAG_RECEIVER_EXCLUDE_BACKGROUND = 0x00800000;

  /// If set, this broadcast is being sent from the shell.
  /// @hide
  static const int FLAG_RECEIVER_FROM_SHELL = 0x00400000;

  /// If set, the broadcast will be visible to receivers in Instant Apps. By default Instant Apps
  /// will not receive broadcasts.
  ///
  /// <em>This flag has no effect when used by an Instant App.</em>
  static const int FLAG_RECEIVER_VISIBLE_TO_INSTANT_APPS = 0x00200000;

  /// @hide Flags that can't be changed with PendingIntent.
  static const int IMMUTABLE_FLAGS = FLAG_GRANT_READ_URI_PERMISSION |
      FLAG_GRANT_WRITE_URI_PERMISSION |
      FLAG_GRANT_PERSISTABLE_URI_PERMISSION |
      FLAG_GRANT_PREFIX_URI_PERMISSION;

  String? _action;
  List<String> _categories = [];
  int _flags = 0;
  Uri? _data;
  ComponentName? _component;
  String? _type;
  Bundle? _extras;
  String? _identifier;
  String? _package;

  Intent({String? action, Uri? uri}) {
    this._action = action;
    this._data = uri;
  }

  Intent.fromMap(Map? map) {
    log("Intent.fromMap : $map");
    if (map != null) {
      if (map.containsKey('action')) {
        _action = map['action'];
      }

      if (map.containsKey('categories') && map['categories'] is List) {
        for (var category in map['categories']) {
          addCategory(category);
        }
      }

      if (map.containsKey("extras")) {
        _extras = Bundle.fromMap(map['extras']);
      }
      // if(map['component'])
      // instance.component=
      //instance.data = Uri.parse(map['data']);
    }
  }

  /// Normalize a MIME data type.
  ///
  /// <p>A normalized MIME type has white-space trimmed,
  /// content-type parameters removed, and is lower-case.
  /// This aligns the type with Android best practices for
  /// intent filtering.
  ///
  /// <p>For example, "text/plain; charset=utf-8" becomes "text/plain".
  /// "text/x-vCard" becomes "text/x-vcard".
  ///
  /// <p>All MIME types received from outside Android (such as user input,
  /// or external sources like Bluetooth, NFC, or the Internet) should
  /// be normalized before they are used to create an Intent.
  ///
  /// @param type MIME data type to normalize
  /// @return normalized MIME data type, or null if the input was null
  /// @see #setType
  /// @see #setTypeAndNormalize
  String? normalizeMimeType(String? type) {
    if (type == null) {
      return null;
    }
    type = type.trim().toLowerCase();
    final int semicolonIndex = type.indexOf(';');
    if (semicolonIndex != -1) {
      type = type.substring(0, semicolonIndex);
    }
    return type;
  }

  Intent setAction(String action) {
    _action = action;
    return this;
  }

  String? getAction() {
    return _action;
  }

  Intent setData(Uri uri) {
    _data = uri;
    _type = null;
    return this;
  }

  Intent setDataAndNormalize(Uri data) {
    return setData(data.normalizePath());
  }

  Uri? getData() {
    return _data;
  }

  String? getDataString() {
    return _data?.toString();
  }

  String? getScheme() {
    return _data?.scheme;
  }

  Intent setType(String? type) {
    _data = null;
    _type = type;
    return this;
  }

  Intent setTypeAndNormalize(String? type) {
    return setType(normalizeMimeType(type));
  }

  String? getType() {
    return _type;
  }

  Intent setDataAndType(Uri? data, String? type) {
    _data = data;
    _type = type;
    return this;
  }

  Intent setDataAndTypeAndNormalize(Uri data, String? type) {
    return setDataAndType(data.normalizePath(), normalizeMimeType(type));
  }

  Intent addCategory(String category) {
    _categories.add(category);
    return this;
  }

  void removeCategory(String category) {
    _categories.remove(category);
  }

  bool hasCategory(String category) {
    return _categories.contains(category);
  }

  Intent addFlags(int flags) {
    // if (_flags & IMMUTABLE_FLAGS == IMMUTABLE_FLAGS) return;
    _flags |= flags;
    return this;
  }

  void removeFlags(int flags) {
    _flags &= ~flags;
  }

  Intent setFlags(int flags) {
    // if (_flags & IMMUTABLE_FLAGS == IMMUTABLE_FLAGS) return;
    _flags = flags;
    return this;
  }

  int getFlags() {
    return _flags;
  }

  Intent setIdentifier(String identifier) {
    _identifier = identifier;
    return this;
  }

  String? getIdentifier() {
    return _identifier;
  }

  String? getPackage() {
    return _package;
  }

  Intent setPackage(String? packageName) {
    _package = packageName;
    return this;
  }

  ComponentName? getComponent() {
    return _component;
  }

  Intent setComponent(ComponentName? component) {
    _component = component;
    return this;
  }

  Intent setClassName(String packageName, String className) {
    _component = ComponentName(packageName, className);

    return this;
  }

  /// Completely replace the extras in the Intent with the given Bundle of
  /// extras.
  ///
  /// @param extras The new set of extras in the Intent, or null to erase
  /// all extras.
  Intent replaceExtras(Bundle? extras) {
    _extras = extras != null ? Bundle.fromBundle(extras) : null;
    return this;
  }

  void removeExtra(String key) {
    _extras!.remove(key);
  }

  Intent putExtra(String key, dynamic? value) {
    _extras!.putObject(key, value);
    return this;
  }

  Intent putIntegerArrayListExtra(String name, List<int>? value) {
    _extras!.putIntegerArrayList(name, value);
    return this;
  }

  Intent putStringArrayListExtra(String name, List<String>? value) {
    _extras!.putStringArrayList(name, value);
    return this;
  }

  int getIntExtra(String key, int defaultValue) {
    return _extras!.getInt(key, defaultValue: defaultValue);
  }

  double getDoubleExtra(String key, double defaultValue) {
    return _extras!.getDouble(key, defaultValue: defaultValue);
  }

  double getFloatExtra(String key, double defaultValue) {
    return _extras!.getDouble(key, defaultValue: defaultValue);
  }

  String? getStringExtra(String key) {
    return _extras?.getString(key);
  }

  List<int>? getIntArrayExtra(String key) {
    return getIntListExtra(key);
  }

  List<int>? getIntListExtra(String key) {
    return _extras == null ? null : _extras!.getIntList(key);
  }

  List<int>? getIntegerArrayListExtra(String name) {
    return _extras == null ? null : _extras!.getIntegerArrayList(name);
  }

  List<int>? getIntegerListExtra(String name) {
    return _extras == null ? null : _extras!.getIntegerList(name);
  }

  List<double>? getDoubleArrayExtra(String key) {
    return getDoubleListExtra(key);
  }

  List<double>? getDoubleListExtra(String key) {
    return _extras == null ? null : _extras!.getDoubleList(key);
  }

  List<double>? getFloatArrayExtra(String key) {
    return getDoubleListExtra(key);
  }

  List<double>? getFloatListExtra(String key) {
    return getDoubleListExtra(key);
  }

  List<String>? getStringArrayListExtra(String key) {
    return getStringListExtra(key);
  }

  List<String>? getStringArrayExtra(String key) {
    return getStringListExtra(key);
  }

  List<String>? getStringListExtra(String key) {
    return _extras == null ? null : _extras!.getStringList(key);
  }

  List<bool>? getBooleanArrayExtra(String name) {
    return _extras == null ? null : _extras!.getBooleanArray(name);
  }

  /// Retrieve extended data from the intent.
  ///
  /// @param name The name of the desired item.
  ///
  /// @return the value of an item previously added with putExtra(),
  /// or null if no Bundle value was found.
  ///
  /// @see #putExtra(String, Bundle)
  Bundle? getBundleExtra(String name) {
    return _extras == null ? null : _extras!.getBundle(name);
  }

  /// Retrieve extended data from the intent.
  ///
  /// @param name The name of the desired item.
  /// @param defaultValue The default value to return in case no item is
  /// associated with the key 'name'
  ///
  /// @return the value of an item previously added with putExtra(),
  /// or defaultValue if none was found.
  ///
  /// @see #putExtra
  ///
  /// @deprecated
  /// @hide
  @deprecated
  dynamic getExtra(String name, dynamic defaultValue) {
    var result = defaultValue;
    if (_extras != null) {
      var result2 = _extras!.get(name);
      if (result2 != null) {
        result = result2;
      }
    }
    return result;
  }

  /// Retrieves a map of extended data from the intent.
  ///
  /// @return the map of all extras previously added with putExtra(),
  /// or null if none have been added.
  Bundle? getExtras() {
    return (_extras != null) ? Bundle.fromBundle(_extras!) : null;
  }

  /// Filter extras to only basic types.
  /// @hide
  void removeUnsafeExtras() {
    if (_extras != null) {
      // _extras = _extras!.filterValues();
    }
  }

  bool hasExtra(String name) {
    return (_extras != null) ? _extras!.containsKey(name) : false;
  }

  /**
     * Convert this Intent into a String holding a URI representation of it.
     * The returned URI string has been properly URI encoded, so it can be
     * used with {@link Uri#parse Uri.parse(String)}.  The URI contains the
     * Intent's data as the base URI, with an additional fragment describing
     * the action, categories, type, flags, package, component, and extras.
     *
     * <p>You can convert the returned string back to an Intent with
     * {@link #getIntent}.
     *
     * @param flags Additional operating flags.
     *
     * @return Returns a URI encoding URI string describing the entire contents
     * of the Intent.
     */
  // String toUri(int flags) {
  //   StringBuffer uri = new StringBuffer();
  //   if ((flags & URI_ANDROID_APP_SCHEME) != 0) {
  //     if (_package == null) {
  //       throw Exception(
  //           "Intent must include an explicit package name to build an android-app: ${this}");
  //     }
  //     uri.write("android-app://");
  //     uri.write(_package);
  //     String? scheme;
  //     if (_data != null) {
  //       scheme = _data?.scheme;
  //       if (scheme != null) {
  //         uri.write('/');
  //         uri.write(scheme);
  //         String? authority = _data?.getEncodedAuthority();
  //         if (authority != null) {
  //           uri.write('/');
  //           uri.write(authority);
  //           String? path = _data?.getEncodedPath();
  //           if (path != null) {
  //             uri.write(path);
  //           }
  //           String? queryParams = _data?.getEncodedQuery();
  //           if (queryParams != null) {
  //             uri.write('?');
  //             uri.write(queryParams);
  //           }
  //           String? fragment = _data?.getEncodedFragment();
  //           if (fragment != null) {
  //             uri.write('#');
  //             uri.write(fragment);
  //           }
  //         }
  //       }
  //     }
  //     toUriFragment(
  //         uri,
  //         null,
  //         scheme == null ? Intent.ACTION_MAIN : Intent.ACTION_VIEW,
  //         mPackage,
  //         flags);
  //     return uri.toString();
  //   }

  //   String? scheme;
  //   if (_data != null) {
  //     String data = _data.toString();
  //     if ((flags & URI_INTENT_SCHEME) != 0) {
  //       final int N = data.length;
  //       for (int i = 0; i < N; i++) {
  //         var c = data[i];
  //         if ((c >= 'a' && c <= 'z') ||
  //             (c >= 'A' && c <= 'Z') ||
  //             (c >= '0' && c <= '9') ||
  //             c == '.' ||
  //             c == '-' ||
  //             c == '+') {
  //           continue;
  //         }
  //         if (c == ':' && i > 0) {
  //           // Valid scheme.
  //           scheme = data.substring(0, i);
  //           uri.append("intent:");
  //           data = data.substring(i + 1);
  //           break;
  //         }
  //         // No scheme.
  //         break;
  //       }
  //     }
  //     uri.append(data);
  //   } else if ((flags & URI_INTENT_SCHEME) != 0) {
  //     uri.append("intent:");
  //   }
  //   toUriFragment(uri, scheme, Intent.ACTION_VIEW, null, flags);
  //   return uri.toString();
  // }

  Map toMap() {
    var map = Map();
    map['action'] = _action;
    map['categories'] = _categories;
    map['component'] = _component?.toMap();
    map['extras'] = _extras?.toMap();
    map['package'] = _package;
    map['identifier'] = _identifier;
    map['flags'] = _flags;
    map['type'] = _type;
    map['data'] = _data?.toString();
    return map;
  }
}
