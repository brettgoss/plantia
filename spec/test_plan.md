# This document describes the test plan for Plantia

## The goal is to identify a list of areas with low/no test coverage and then create tests to support those flows

### Signup Flow: As a new user...
- I can see the signup form at the index
- Any other page redirects to the signup form
- Signing up for a new account logs me in after signup

- I can sign up for a Plantia account...
  - With all the required fields
  - With Redis (Analytics) down

- I can't sign up for a Plantia Account...
  - If I'm missing any of the fields
  - If the email has already been taken
  - If I'm already logged in

### Login Flow: As an existing user
- If I'm not logged in...
  - I can click a link on the index to get to the login page
  - I can log in with the correct email and password
  - Clicking 'Remember Me' sets a cookie
  - I can't log in with incorrect credentials

### Password Reset Flow:
  - I can view 'Forgot My Password'
  - I can reset my password
  - Password reset link works to reset password
  - I can't reset my password with an invalid link/token

### Plant Creation

### Plant Watering