import QtQuick 2.5
import QtTest 1.1

AnimationTypesExample {
    id: root

    TestCase {
        id: testCase
        name: 'animationTypesExample'
        when: windowShown
        property int counter: 0
        property int shots: 0

        function grab(destination) {
            var index = ++counter
            root.grabToImage(function(result) {
                result.saveToFile(destination);
                console.log('save screen shot to: ' + destination);
                shots++;
            });
            tryCompare(testCase, "shots", index);
        }

        function test_shoot() {
            grab("../../assets/animationtypes_start.png")
        }

        function test_shoot_running() {
            mouseClick(root, 60, 220)
            wait(600)
            mouseClick(root, 240, 220)
            wait(400)
            mouseClick(root, 340, 220)
            grab("../../assets/animationtypes.png")
        }
    }
}
