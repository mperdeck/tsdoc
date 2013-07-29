/**
Runs a series of tests.

@param categoryName    In messages, will be shown as category name
@param testFunc        Will be run against each testValue. Throws exception if test fails.
@param testValue       Array of test values
@returns               true if all tests passed, false otherwise.
*/
function runTests(categoryName, testFunc, testValues) {
    var success = true;

    testValues.forEach(function (testDatum, index, testData) {
        try  {
            testFunc(testDatum);
        } catch (e) {
            console.log("\n----------------------------");
            console.log("*** Category: " + categoryName);
            console.log("*** Test Data:\n" + JSON.stringify(testDatum, null, '..'));
            console.log("*** Actual:\n" + e);

            success = false;
        }
    });

    return success;
}
exports.runTests = runTests;

/**
Deep compares two objects. If they are not the same, throws an exception with the JSON of the
object passed via the "actual" parameter.
*/
function deepEqual(actual, expected) {
    var actualJson = JSON.stringify(actual, null, '..');
    var expectedJson = JSON.stringify(expected, null, '..');

    if (actualJson != expectedJson) {
        throw actualJson;
    }
}
exports.deepEqual = deepEqual;

