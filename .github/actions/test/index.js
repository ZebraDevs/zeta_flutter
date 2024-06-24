import core from "@actions/core";
import { parse, sum } from 'lcov-utils'
import { execSync } from "node:child_process";
import { readFileSync } from "node:fs";

try {
    const contents = readFileSync('coverage/lcov.info', 'utf8')
    const lcov = parse(contents)
    const digest = sum(lcov)
    let totalPercent = digest.lines;

    core.setOutput('oldCoverage', totalPercent);
} catch (error) {
    core.info('Unable to retrieve old coverage');
}

try {
    execSync('flutter test --coverage --reporter json', { encoding: 'utf-8' });
    core.setOutput("test", '✅ - All tests passed.');
    core.info('✅')
} catch (error) {
    if (error.stdout) {
        const stdout = error.stdout;
        const objStr = '[' + stdout.split('\n').join(',').slice(0, -1) + ']'
        const obj = JSON.parse(objStr)
        let failIds = [];
        obj.forEach(element => {
            if (element.type == 'testDone' && element.result.toLowerCase() == 'error') {
                failIds.push(element.testID);
            }
        });
        let initialString = '';
        if (failIds.length > 1) {
            initialString = `${failIds.length} tests failed`
        } else if (failIds.length == 1) {
            initialString = `${failIds.length} test failed`
        }
        const errorString = [];

        failIds.forEach(e1 => {
            const allEntries = obj.filter(e => (e.hasOwnProperty('testID') && e.testID == e1) || (e.hasOwnProperty('test') && e.test.hasOwnProperty('id') && e.test.id == e1));
            const entry1 = allEntries.find(e => e.hasOwnProperty('test') && e.test.hasOwnProperty('id'));
            let testName = 'Error getting test name';
            if (entry1) {
                testName = entry1.test.name.split('/test/').slice(-1)
            }
            const entry2 = allEntries.find(e => e.hasOwnProperty('stackTrace') && e.stackTrace.length > 1)
            const entry3 = allEntries.find(e => e.hasOwnProperty('message') && e.message.length > 1 && e.message.includes('EXCEPTION CAUGHT BY FLUTTER'))
            const entry4 = allEntries.find(e => e.hasOwnProperty('error') && e.error.length > 1)
            let testDetails = 'Unable to get test details. Run flutter test to replicate'
            if (entry2) {
                testDetails = entry2.stackTrace;
            } else if (entry3) {
                testDetails = entry3.message;
            } else if (entry4) {
                testDetails = entry4.error;
            }

            errorString.push('<details><summary>' + testName + '</br></summary>`' + testDetails + '`</details>');
        })

        let output = `⛔️ - ${initialString}</br >
            <details><summary>See details</summary>
              ${errorString.join('')}
            </details>
        `
        output = output.replace(/`/g, "")
        output = output.replace(/'/g, "")
        output = output.replace(/"/g, "")
        output = output.replace(/(\r\n|\n|\r)/gm, "");
        core.setOutput("test", output);
        core.setOutput("err", 'true');
        core.info('⛔️')

    }
}