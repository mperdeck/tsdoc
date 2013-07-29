/**
Runs a series of tests.

@param categoryName    In messages, will be shown as category name
@param testFunc        Will be run against each testValue. Throws exception if test fails.
@param testValue       Array of test values
@returns               true if all tests passed, false otherwise.
*/
export function runTests<T>(categoryName: string, testFunc: (testData: T)=>void, testValues: T[]): boolean {
    var success: boolean = true;

    testValues.forEach(function(testDatum: T, index: number, testData: T[]) {
        try {
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

/**
Deep compares two objects. If they are not the same, throws an exception with the JSON of the 
object passed via the "actual" parameter. 
*/
export function deepEqual(actual: any, expected: any): void {
    var actualJson: string = JSON.stringify(actual, null, '..');
    var expectedJson: string = JSON.stringify(expected, null, '..');

    if (actualJson != expectedJson)
    {
        throw actualJson;
    }
}


