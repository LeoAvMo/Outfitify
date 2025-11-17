# Outfitify

Keynote: [Google Drive File for Outfitify Keynote](https://drive.google.com/file/d/1GtXELS5GV5-K_5Am8i02udjmHSQJJmjW/view?usp=sharing)

## 👕 What is Outfitify?
**Outfitify** is an app made with the purpose of helping people build their own outfits with their clothes and accessories. It also lets the user generate new clothing with the use of Apple's new [Image Playground framework](https://developer.apple.com/documentation/imageplayground). An interactive way the app let's the user track their style is by having daily outfits which they can upload to see later.

## 📱 Technologies
It uses [SwiftData](https://developer.apple.com/documentation/swiftdata) for making the relations between clothing, accessories, outfits and daily fits. Even if you can share images of your outfits, your data is secure, since everything is stored locally.

## 📁 Architecture
The app doesn't follow an specific architecture, but it is close to MVVM, just without the View Controller. It uses sort of a MV architecture due to how Swift concurrency works. 

## 🙌 Credits
The app is heavily based on an already existing app called [Whering](https://whering.co.uk), an outfit builder with social media-like functionalities where users can share their outfits. Outfitify doesn't have that functionality, since it focuses more on journaling and planning outfits.

### ✍️ Notes and future changes
The app is still on beta, so there are changes that need to be made:
- It is required to save images in a server since SwiftData can be messy with images saved locally.
- Users cannot take photos when they want to register a new clothing, outfit or accessory.
