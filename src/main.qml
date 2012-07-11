import QtQuick 2.0

Item {
    // TODO: Figure out how to adapt this to just be fullscreen
    width: 800
    height: 480
    Image {
        id: wallpaper
        sourceSize.width: parent.width
        sourceSize.height: parent.height
        fillMode: Image.PreserveAspectCrop

        anchors.fill: parent
        source: "wallpaper.jpg"

        Text {
            id: welcome
            text: "Welcome to Mer"
            anchors.fill: parent
            opacity:0

            Behavior on opacity { NumberAnimation { duration: 5000 } }


            MouseArea {
                anchors.fill: parent
                onClicked: {
                    console.log("SPACE");
                    welcome.opacity = 1.0
                }
            }
        }
        Item {
            id: shaderText
            anchors.centerIn: parent
            width: childrenRect.width
            height: childrenRect.height
            //color: "white"
            //opacity: scale
            Column {
                Title { text: "Welcome to Mer"; color: "blue" }
                Body { text: "Brought to you by Stskeeps, lbt"; color: "white" }
                Body { text: "and all the contributors to the mer project "; color: "white" }
            }
        }
	property real time;
	NumberAnimation on time {
            from: 0; to: 40*60*1000; duration: 40*60*1000
            //running: foregroundSlide.currentItem.needsTime
            //onRunningChanged: { console.log("time running",running); }
	}
        ShaderEffect {
            width: shaderText.width
            height: shaderText.height
            anchors.centerIn: parent
            property real shadertime: parent.time
            //onShadertimeChanged: { console.log("sp time:",shadertime); }
            mesh: Qt.size(100,2)
            scale: 1.0+0.5*Math.sin(shadertime*0.001)
            property variant source: ShaderEffectSource { sourceItem: shaderText; hideSource:true; mipmap:false }
            vertexShader: "
              uniform highp mat4 qt_Matrix;
              attribute highp vec4 qt_Vertex;
              attribute highp vec2 qt_MultiTexCoord0;
              varying highp vec2 qt_TexCoord0;
              varying highp vec2 qt_TexCoord1;
              uniform float shadertime;
              void main() {
                qt_TexCoord0 = qt_MultiTexCoord0;
                qt_TexCoord1 = sin(qt_MultiTexCoord0+0.001*shadertime);
                gl_Position = qt_Matrix * qt_Vertex + vec4(0.0,0.1*sin(qt_TexCoord0.x*10.0+shadertime*0.001),0.0,0.0);
              }"
            fragmentShader: "
              uniform highp float qt_Opacity;
              varying highp vec2 qt_TexCoord0;
              varying highp vec2 qt_TexCoord1;
              uniform sampler2D source;
              uniform highp float shadertime;
              void main() {
                gl_FragColor = texture2D(source, qt_TexCoord0)*vec4(qt_TexCoord1.xy,qt_TexCoord1.x*qt_TexCoord1.y,1.0);
              }"
        }
    }
}
