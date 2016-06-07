import QtQuick 2.5
import QtTest 1.1

TransformationExample {
    id: root

    TestCase {
        id: testCase
        name: 'transformationExample'
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
            grab("../../assets/objects.png")
            root._test_transformed()
            grab("../../assets/objects_transformed.png")
            root._test_overlap()
            grab("../../assets/objects_overlap.png")
        }
    }
}
