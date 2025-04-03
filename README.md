# menu11kde6
Based on https://github.com/adhec/OnzeMenuKDE working menu11

In KDE6 after some updates shutdown & lock button stops working, so in order to fix that I modified the Footer.qml

Code added: 
```
import org.kde.plasma.private.sessions as Sessions

Sessions.SessionManagement {
        id: sm
    }
//Modified:

onClicked: {
           sm.lock()
        }
onClicked:   {
            sm.requestLogoutPrompt()
        }
```
Instructions:
You can just copy Footer.qml file to  ~/.local/share/plasma/plasmoids/adhe.menu.11/contents/ui/ and replace it or you can copy 
everything to ~/.local/share/plasma/plasmoids. 
    
