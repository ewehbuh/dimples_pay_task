# Dimplespay Card Management App

## Overview

The  Card Management App is a Flutter-based application designed to manage  cards. Users can view card details, perform top-up and deduction transactions, and manage card status (e.g., freeze/unfreeze). The app uses a mock JSON server as the backend for testing.

---

## Features

- **List  Cards**: View a list of cards with ID, balance, status, and serial number.
- **Card Details**: See detailed information for individual cards.
- **Top-Up/Deduct Balance**: Perform transactions securely with user inputs.
- **Freeze/Unfreeze**: Change the card's operational status.
- **Error Handling**: Handle invalid inputs or server errors gracefully.

---

## Prerequisites

To run this project, ensure you have the following installed:

1. **Flutter SDK**: [Install Flutter](https://flutter.dev/docs/get-started/install).

Here is the content formatted as a **README.md** file:

```markdown
# Dimplespay Card Management App

## Setup Instructions

### Step 1: Clone the Repository
Clone the repository to your local machine:
```bash
git clone https://github.com/ewehbuh/dimples_pay_task.git
cd dimples_pay_task
```

### Step 2: Install Flutter Dependencies
Run the following command to install all required Flutter dependencies:
```bash
flutter pub get
```

### Step 4: Run the Application
Launch the Flutter app on an emulator or physical device:
```bash
flutter run
```

---

## How to Use the App

### View  Cards
- The home screen lists all available  cards.
- Each card displays its ID, serial number, balance, and current status.

### Card Actions
- Tap on a card to open its details.
- Perform actions like top-up, deduction, and freezing/unfreezing from the details screen.

### Top-Up and Deduct Balance
- Enter the desired amount and confirm the transaction.
- Deduction requires PIN verification.

### Freeze/Unfreeze Card
- If a card is frozen, you'll be prompted to unfreeze it before proceeding.

---

## Testing the App

### Manual Testing
Verify the following functionalities:
- Listing of cards.
- Correct details display.
- Top-up and deduction transactions.
- Freeze/unfreeze functionality.
- Error handling for invalid inputs or server issues.

### Automated Testing
Run unit and widget tests using the Flutter testing framework:
```bash
flutter test
```

---

## Project Structure

```plaintext
dimples_pay_task/
├── lib/
│   ├── api/              # API service definitions
│   ├── models/           # Data models for  cards
│   ├── providers/        # State management with Provider
│   ├── views/            # UI components and screens
│   ├── main.dart         # Application entry point
├── test/                 # Unit and widget tests
├── db.json               # Mock JSON database
├── pubspec.yaml          # Dependencies configuration
└── README.md             # Project documentation
```

---




