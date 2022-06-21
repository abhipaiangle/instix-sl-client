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

// Authorization URLs
String GET_TOKEN_URL = "https://gymkhana.iitb.ac.in/profiles/oauth/token/";
String REVOKE_TOKEN_URL =
    "https://gymkhana.iitb.ac.in/profiles/oauth/revoke_token/";
String AUTH_URL =
    "https://gymkhana.iitb.ac.in/profiles/oauth/authorize/?client_id=HB3tge5tnYH51x6f8PEXtYcXA7f3hT4oAlyRj2Yp&response_type=code&scope=basic%20profile%20phone%20insti_address&redirect_uri=https://smartlaundry.iitb&state=initial";
String RESOURCES_URL =
    "https://gymkhana.iitb.ac.in/profiles/user/api/user/?fields=first_name,last_name,type,mobile,insti_address";
