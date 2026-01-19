#  Tagly - Your simple name tag creator

Tagly is a free and simple **watchOS** only app which allows the user to display a name badge with date on the watch screen. 
It allows some configurations like selecting the foreground and background color of the name badge.


## Development

This is a watchOS only app.
We still need a container app for iOS though.
There are some special settings in the `Info.plist` files for the watchOS and iOS app. 
For watchOS only apps, ensure they are set the way as in this project. 


### Testing in simulator

- Select the `Name badge Watch App` target and run it on an watch simulator


### Deployment to AppStore

- Select the `Name badge` target which is usually for iPhone
- Create the archive as usual
- Upload to AppStore
