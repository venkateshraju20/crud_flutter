const String BASE_URL = "http://localhost:8080/crudspring"; // change to local ip address
const String API_USER = "/api/user";

// User Sign up
const String USER_SIGNUP_URL = "$BASE_URL$API_USER/create-user";

// User Sign in
const String USER_SIGNIN_URL = "$BASE_URL$API_USER/login-user";

// User Forgot password
const String USER_RESET_FIND_URL = "$BASE_URL$API_USER/reset-find-user";
const String USER_RESET_PASSWORD_URL = "$BASE_URL$API_USER/reset-user-password";