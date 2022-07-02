// User Interface Variables
double subHeadingTextSize = 20.0;
double buttonTextSize = 18.0;
double borderRadius = 15.0;

// HIVE IDENTIFIERS
String COLLECTION_NAME = "SL_DATABASE";

// Profile Data Box
String PROFILE_BOX = "PROFILE_BOX";

// Auth Data Box
String AUTH_DATA = "AUTH_DATA";
String access_token_key = "access_token";
String refresh_token_key = "refresh_token";
// END HIVE IDENTIFIERS

// Authorization URLs
String GET_TOKEN_URL = "https://gymkhana.iitb.ac.in/profiles/oauth/token/";
String REVOKE_TOKEN_URL =
    "https://gymkhana.iitb.ac.in/profiles/oauth/revoke_token/";
String AUTH_URL =
    "https://gymkhana.iitb.ac.in/profiles/oauth/authorize/?client_id=HB3tge5tnYH51x6f8PEXtYcXA7f3hT4oAlyRj2Yp&response_type=code&scope=basic%20profile%20phone%20insti_address&redirect_uri=https://smartlaundry.iitb&state=initial";
String RESOURCES_URL =
    "https://gymkhana.iitb.ac.in/profiles/user/api/user/?fields=first_name,last_name,type,mobile,insti_address";

// Constant Strings
String SMART_LAUNDRY = "Smart Laundry";
String WASHING_MACHINE = "Washing Machine";
String FLOOR = "Floor";
String HOSTEL = "Hostel";
String TODAY_BOOKED_SLOTS = "Today's Booked Slots";
String BOOK_SLOT = "Book a Slot";
String SLOT_START_TIME = "Slot Start Time";
String SLOT_END_TIME = "Slot End Time";
String CONFLICT = "Conflict";
String HOURS = "Hours";
String MINUTES = "Minutes";
String BOOK_SLOT_BTN = "Book Slot";
String SLOT_CONFLICT = "Slot Conflict";

String PROFILE = "Profile";
String SIGNIN = "Sign In";
String SIGNOUT = "Sign Out";
String PASSWORD = "Password";
String YOUR_BOOKINGS = "Your Bookings";
String UPCOMING = "Upcoming";
String PAST = "Past";
String ACTIVATE = "Activate";
String ENTER_CREDS_CONTINUE = "Please enter your credentials\n and continue";
String EMIAL_EXAMPLE = "eg. ldap@iitb.ac.in";
String PASSWORD_CONDITION =
    "Password must contain one uppercase, one lowercase, one numerical, one special character and must 8 characters in length.";
String PROCEED = "Proceed";

String LOGIN_SSO_CONTINUE = "Please login with IITB SSO to continue";
String LOGIN_SSO = "Please login with IITB SSO to continue";
