# Vibiend - Social Media App
The goals of the project
Vibiend is designed to create a social platform that connects people with matching vibes or interests. The main goals include:

* Creating a user-friendly social media platform
* Implementing different categories of interaction through "vibes"
* Integrating external APIs for enhanced features (Apple Music (TBD), Food recipes)
* Building a robust friend system with activity tracking
* Providing a seamless photo-sharing experience

## Functionalities

1. User Posts

- Create text posts
- Share photos
- Like and comment on posts
- Edit and delete posts

2. Vibe Button

- Music vibe (Apple Music integration)
- Food vibe (Recipe search and sharing)
- Activity vibe (Location sharing)
- Just chatting vibe
- Therapy vibe

3. Friend System

- Add/remove friends
- View friend suggestions
- Track friend activities
- Search for users

4. Profile Management

- Edit profile information
- Update profile picture
- Customize bio

## Architechture and Design
- Frontend: Leveraging SwiftUI to build modern, simple, and declarative UI with smooth transitions
- UI Components
  * PostCell: handles interactions
  * FeedView: Manages the main view (posts, edit posts, likes and comments)
  * VibeSelectionView: Manages the vibes categories (Sharing music, locations, etc.)
  * ActivityFeedView: Display friends list as well as their activities
- Modular Design
  * Separate modules for each major feature (Feed, Profile, Friends)
  * Reusable components (PostCell, FriendRow)
  * Clear separation of concerns with MVVM pattern
 
# To run this project
1. Setup the project into your local machine
```
git clone https://github.com/khoitran590/Vibiend.git
cd cpsc411proj
```
2. Open the project
```
open cpsc411proj.xcodeproj
```
3. Set your device simulator or connect your own ios device
4. Run the project using Command + R
