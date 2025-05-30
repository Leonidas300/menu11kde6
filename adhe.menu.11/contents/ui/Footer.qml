import QtQuick 2.4
import QtQuick.Layouts 1.1
import QtQuick.Controls 2.12

import org.kde.plasma.plasmoid 2.0
import org.kde.plasma.core 2.0 as PlasmaCore

import org.kde.plasma.extras 2.0 as PlasmaExtras

import org.kde.plasma.private.kicker 0.1 as Kicker
import org.kde.coreaddons 1.0 as KCoreAddons // kuser
import org.kde.plasma.private.shell 2.0

import org.kde.kwindowsystem 1.0
//import QtGraphicalEffects 1.0
import org.kde.kquickcontrolsaddons 2.0

import org.kde.plasma.components 3.0 as PlasmaComponents3
import org.kde.plasma.private.quicklaunch 1.0

import org.kde.kirigami as Kirigami
import org.kde.plasma.plasma5support 2.0 as P5Support

import org.kde.plasma.private.sessions as Sessions

RowLayout{

    spacing: Kirigami.Units.largeSpacing

    KCoreAddons.KUser {   id: kuser  }
    Logic {   id: logic }

    P5Support.DataSource {
        id: pmEngine
        engine: "powermanagement"
        connectedSources: ["PowerDevil", "Sleep States"]
        function performOperation(what) {
            var service = serviceForSource("PowerDevil")
            var operation = service.operationDescription(what)
            service.startOperationCall(operation)
        }
    }


    Image {
        id: iconUser
        source: kuser.faceIconUrl.toString() || "user-identity"
        cache: false
        visible: source !== ""
        sourceSize.height: parent.height * 0.9
        sourceSize.width:  parent.height * 0.9
        fillMode: Image.PreserveAspectFit
        Layout.alignment: Qt.AlignVCenter

        // Crop the avatar to fit in a circle, like the lock and login screens
        // but don't on software rendering where this won't render
        layer.enabled:true // iconUser.GraphicsInfo.api !== GraphicsInfo.Software
        //layer.effect: OpacityMask {
        //    // this Rectangle is a circle due to radius size
        //    maskSource: Rectangle {
        //        width: iconUser.width
        //        height: iconUser.height
        //        radius: height / 2
        //        visible: false
        //    }
        //}
    }


    PlasmaExtras.Heading {
        wrapMode: Text.NoWrap
        color: Kirigami.Theme.textColor
        level: 3
        font.bold: true
        //font.weight: Font.Bold
        text: qsTr(kuser.fullName)
    }

    Item{
        Layout.fillWidth: true
    }

    PlasmaComponents3.ToolButton {
        icon.name:  "user-home"
        onClicked: logic.openUrl("file:///usr/share/applications/org.kde.dolphin.desktop")
        ToolTip.delay: 1000
        ToolTip.timeout: 1000
        ToolTip.visible: hovered
        ToolTip.text: i18n("User Home")
    }

    PlasmaComponents3.ToolButton {
        icon.name:  "configure"
        onClicked: logic.openUrl("file:///usr/share/applications/systemsettings.desktop")
        ToolTip.delay: 1000
        ToolTip.timeout: 1000
        ToolTip.visible: hovered
        ToolTip.text: i18n("System Preferences")
    }

    Sessions.SessionManagement {
        id: sm
    }

    PlasmaComponents3.ToolButton {
        icon.name:   "system-lock-screen"
                
        onClicked: {
           sm.lock()
        }
        ToolTip.delay: 1000
        ToolTip.timeout: 1000
        ToolTip.visible: hovered
        ToolTip.text: i18n("Lock Screen")
        visible: pmEngine.data["Sleep States"]["LockScreen"]
    }

    PlasmaComponents3.ToolButton {
        icon.name:  "system-shutdown"
        onClicked:   {
            sm.requestLogoutPrompt()
        }
        //Layout.rightMargin: 10
        ToolTip.delay: 1000
        ToolTip.timeout: 1000
        ToolTip.visible: hovered
        ToolTip.text: i18n("Leave ...")
    }
}
