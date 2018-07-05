import QtQuick 2.10
import QtQuick.Window 2.10
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.0

Window {
    visible: true
    width: 640
    height: 480
    title: qsTr("Hello World")


    Item{

        id:root

        anchors.fill: parent
        //focus:true
        //        property bool ctrlPressed: false

        //        Keys.onPressed: {
        //            if (event.key == Qt.Key_Control){
        //                root.ctrlPressed = true;
        //            }
        //        }
        //        Keys.onReleased: {
        //            root.ctrlPressed=false;
        //        }



        Flickable {
            id:flick
            boundsBehavior: Flickable.StopAtBounds


            anchors.fill: parent
            interactive: true
            //property bool fitVie: value
            contentHeight: pic1.height;
            contentWidth: pic1.width;





            Image {
                //   anchors.fill: parent
                id: pic1
                source: "pic1.jpg"


                transform: Scale{
                    id:imagescale
                    xScale: 1
                    yScale: 1
                }

                onProgressChanged: {

                }

                Rectangle{
                    id:roi
                    property real xScale: pic1.width/pic1.implicitWidth
                    property real yScale: pic1.height/pic1.implicitHeight

                    property real itemX: 100
                    property real itemY: 100



                    property real itemWidth: 1000
                    property real itemHeight: 1000


                    onXChanged: {
                        if(dragArea.pressed){
                            itemX=x/xScale

                        }


                    }

                    onYChanged: {
                        if(dragArea.pressed){
                            itemY=y/yScale
                        }


                    }

                    color: "transparent"

                    border.width: 2
                    border.color: "green"

                    onXScaleChanged: {
                        if(xScale){
                            x=itemX*xScale;


                            width=itemWidth*xScale


                        }
                    }

                    onYScaleChanged: {

                        if(yScale){
                            y=itemY*yScale
                            height=itemHeight*yScale
                        }
                    }


                    MouseArea {
                        id: dragArea
                        anchors.fill: parent
                        drag.axis: Drag.XAndYAxis

                        drag.target: parent

                        enabled: false



                    }
                    x:itemX
                    y:itemX
                    width: itemWidth
                    height: itemHeight

                }


            }

            ScrollIndicator.vertical: ScrollIndicator {
                active: pincharea.pinchStarted
            }
            ScrollIndicator.horizontal: ScrollIndicator {
                active: pincharea.pinch.active
                // active: pincharea.pinchStarted
            }

            PinchArea{
                id:pincharea

                property bool pinchStarted: false
                visible: true
                anchors.fill: parent
                pinch.dragAxis:  Drag.XAndYAxis
                //        width: scrollview.contentWidth

                //         pinch.target: pic1

                onPinchStarted: {
                    flick.interactive=false;
                    pinchStarted=true
                }

                onPinchUpdated: {


                    //            flick.contentX+=pinch.previousCenter.x - pinch.center.x

                    //            flick.contentY+=pinch.previousCenter.y - pinch.center.y



                }

                onPinchFinished: {
                    flick.interactive=true;
                    pinchStarted=false
                    flick.returnToBounds();
                }


                MouseArea{
                    anchors.fill: parent

                    scrollGestureEnabled: false
                    onWheel: {
                        if(wheel.modifiers & Qt.ControlModifier){
                            wheel.accepted=true
                            // imagescale.xScale-=0.1
                        }
                        else{
                            wheel.accepted=false
                        }



                    }
                }


                //pinch.target: scrollview.contentItem
            }


        }

    }
}
