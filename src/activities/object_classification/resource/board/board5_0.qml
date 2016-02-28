/* GCompris
 *
 * Copyright (C) 2015 Bruno Coudoin <bruno.coudoin@gcompris.net>
 *
 * Authors:
 *   Bruno Coudoin <bruno.coudoin@gcompris.net> (GTK+ version)
 *   Pulkit Gupta <pulkitgenius@gmail.com> (Qt Quick port)
 *
 *   This program is free software; you can redistribute it and/or modify
 *   it under the terms of the GNU General Public License as published by
 *   the Free Software Foundation; either version 3 of the License, or
 *   (at your option) any later version.
 *
 *   This program is distributed in the hope that it will be useful,
 *   but WITHOUT ANY WARRANTY; without even the implied warranty of
 *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *   GNU General Public License for more details.
 *
 *   You should have received a copy of the GNU General Public License
 *   along with this program; if not, see <http://www.gnu.org/licenses/>.
 */
import QtQuick 2.0

QtObject {
    property string instruction: qsTr("Arrange the Cuboids in increasing order of their Volumes.")
    property variant levels : [
        {
            "pixmapfile": "img/yellowCuboidSmall.png",
            "x": "0.20",
            "y": "0.5",
            "height": "0.4",
            "width": "0.4"
        },
        {
            "pixmapfile": "img/blueCuboidSmall.png",
            "x": "0.40",
            "y": "0.5",
            "height": "0.4",
            "width": "0.4"
        },
        {
            "pixmapfile": "img/yellowCuboid.png",
            "x": "0.60",
            "y": "0.5",
            "height": "0.4",
            "width": "0.4"
        },
        {
            "pixmapfile": "img/blueCuboid.png",
            "x": "0.80",
            "y": "0.5",
            "height": "0.4",
            "width": "0.4"
        }
    ]
}
