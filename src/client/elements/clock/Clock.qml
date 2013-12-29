/*
 * Copyright 2013 Giulio Camuffo <giuliocamuffo@gmail.com>
 *
 * This file is part of Orbital
 *
 * Orbital is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * Orbital is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with Orbital.  If not, see <http://www.gnu.org/licenses/>.
 */

import QtQuick 2.1
import Orbital 1.0

Element {
    id: element

    property int orientation: (location == 0 || location == 2) ? Qt.Horizontal : Qt.Vertical
    Layout.minimumWidth: time.contentWidth + 10
    Layout.preferredWidth: Layout.minimumWidth
    Layout.minimumHeight: time.contentHeight + 10
    Layout.preferredHeight: time.contentHeight + date.contentHeight

    width: orientation == Qt.Horizontal ? Layout.preferredWidth : 100
    height: 20

    property variant service: Client.service("DateTimeService")
    Connections {
        target: service
        onUpdated: update()
    }

    contentItem: Column {
        anchors.fill: parent
        Text {
            id: time
            width: parent.width
            height: contentHeight
            verticalAlignment: Qt.AlignVCenter
            horizontalAlignment: Qt.AlignHCenter
            color: CurrentStyle.textColor
            wrapMode: orientation == Qt.Horizontal ? Text.NoWrap : Text.WrapAnywhere
        }
        Text {
            id: date
            width: parent.width
            height: contentHeight
            verticalAlignment: Qt.AlignVCenter
            horizontalAlignment: Qt.AlignHCenter
            color: CurrentStyle.textColor
            font.pixelSize: 10
            wrapMode: orientation == Qt.Horizontal ? Text.NoWrap : Text.WrapAnywhere
        }
    }

    Component.onCompleted: update()

    function update()
    {
        time.text = service.time();
        date.text = service.date();
    }
}
