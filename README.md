# VehicleDashboard


A small SwiftUI iOS app for the SimpleEnergy iOS Developer L1 technical assignment. 

## Features

- Vehicle list showing name, model, battery percentage, range, and online/offline status
- Tappable vehicle rows that open a detail screen after a one-second loading indicator
- Vehicle detail screen with battery, estimated range, speed, odometer, connectivity, and last-updated time
- Battery progress bar: green at 50% or above, yellow from 20% to 49%, and red below 20%
- Loading state while the vehicle list or details screen is loading
- Empty-state demo from the `Empty` button in the Vehicles screen navigation bar


## Architecture

The project uses a small MVVM structure, with feature folders similar to KentServiceApp:

```text
SwiftUI Views
    -> ViewModels
    -> WebServiceManager.serviceManager(...)
    -> URLSession
    -> LocalMockURLProtocol
    -> vehicles.json
```

## Run the App

1. Open `VehicleDashboard.xcodeproj` in Xcode.
2. Select the `VehicleDashboard` scheme.
3. Select an iPhone simulator with iOS 16 or later.
4. Press Run.

The deployment target is iOS 16.0.
