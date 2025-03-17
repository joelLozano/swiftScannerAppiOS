# Scanner App

This project contains the code to scan QR codes.

## Features

- Register:
  This screen allows users to register with their name, email, and password.
  The password is saved in the keychain and is hashable.

- Login:
  Users can log in with their email and password, or use Face ID if available.

- Table of Results:
  Once users scan QR codes, they can view all the codes in this section.
  There is also a detailed view of each code.

- Scanner:
  Using the camera, users can scan any QR code. They can choose to save or skip the code.

## TODO:

- Remove Detail view and implement the methodChannel to call detail flutter view
- improve the QR model. to show the Date, and identify the type of QR.
- Unit testo to View models.
