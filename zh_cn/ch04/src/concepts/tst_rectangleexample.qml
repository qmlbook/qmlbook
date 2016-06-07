import QtQuick 2.5
import QtTest 1.1

RectangleExample {
    id: root

    TestCase {
        id: testCase
        name: 'rectangleExample'
        when: windowShown
        property int counter: 0
        property int shots: 0

        function grab(destination) {
            var index = ++counter
            root.grabToImage(function(result) {
                result.saveToFile(destination);
                shots++;
            });
            tryCompare(testCase, "shots", index);
        }

        function test_shoot() {
            grab("../../assets/qmltree.png")
        }
    }
}
