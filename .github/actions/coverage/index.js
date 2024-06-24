import core from "@actions/core";
import { parse, sum } from 'lcov-utils'
import { readFileSync } from "node:fs";
let oldCoverage = '';
try {
    oldCoverage = core.getInput('oldCoverage');
    core.info(`Retrieved old coverage ${oldCoverage}`)
} catch (error) {
    core.info(`Unable to retrieve old coverage`)
}
oldCoverage = 12.67;

try {
    const contents = readFileSync('coverage/lcov.info', 'utf8')
    const lcov = parse(contents)
    const digest = sum(lcov)
    let totalPercent = digest.lines;

    const arr = Object.values(lcov).map(e => {
        const fileName = e.sf;
        const percent = Math.round((e.lh / e.lf) * 1000) / 10;
        const passing = percent > 96 ? '✅' : '⛔️';
        return `<tr><td>${fileName}</td><td>${percent}%</td><td>${passing}</td></tr>`;
    })

    if (oldCoverage != null) {

        if (oldCoverage > totalPercent) {
            totalPercent = totalPercent + `% (🔻 down from ` + oldCoverage + `)`
        } else if (oldCoverage < totalPercent) {
            totalPercent = totalPercent + `% (👆 up from ` + oldCoverage + `)`
        } else {
            totalPercent = totalPercent + `% (no change)`
        }

    } else {
        totalPercent = totalPercent + '%';
    }

    const str = `📈 - Code coverage: ${totalPercent}
    <br>
    <details><summary>See details</summary>
    <table>
    <tr><th>File Name</th><th>%</th><th>Passing?</th></tr>
        ${arr.join('')}
    </table>
    </details>`;

    const output = str.replace(/(\r\n|\n|\r)/gm, "");

    core.setOutput("coverage", output);
    core.info('✅')
} catch (error) {
    core.setOutput("coverage", '⚠️ - Coverage check failed');
    core.info('⛔️')
}