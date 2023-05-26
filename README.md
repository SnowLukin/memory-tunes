# MemoryTunes
## A Memory Game App for Practicing ReSwift

MemoryTunes is a memory game app built using the ReSwift framework, inspired by a RayWenderlich tutorial. The app leverages unidirectional data flow and Redux-like architecture to create a scalable and easy-to-understand codebase.

## Features

Asynchronous programming support for fetching images from the iTunes API raywenderlich.com.
Unidirectional data flow for predictable state management and easier debugging raywenderlich.com.
Platform-independent components for reuse in iOS, macOS, or tvOS.


## Implementation:

MemoryTunes uses the ReSwift framework to create a Redux-like architecture with the following components:

- Views: React to store changes and display them on screen.
- Actions: Initiate state changes in the app.
- Reducers: Directly change the application state, which is stored in the store.
- State Management: The game state includes an array of MemoryCard objects, which contain an imageUrl to be displayed on the card, isFlipped to identify if the front of the card is visible, and isAlreadyGuessed to identify if the card was already matched.

