import core from "@actions/core";
import { execSync } from "node:child_process";

try {
    execSync('dart analyze', { encoding: 'utf-8' });
    core.setOutput("analyze", '✅ - Static analysis passed.');
    core.info('✅')
}
catch (error) {
    if (error.stdout) {
        const stdout = error.stdout;
        const arr = stdout.trim().split('\n');
        const issuesList = arr.slice(2, -2).map(e => e.split('-').slice(0, -1).map(e => e.trim()))
        const errors = [];
        const warnings = []
        const infos = []

        issuesList.forEach(e => {
            if (e[0].toLowerCase() == 'error') {
                errors.push(e);

            } else if (e[0].toLowerCase() == 'warning') {
                warnings.push(e)

            } else {
                infos.push(e)
            }
        })
        const errorString = errors.map(e => {
            return `<tr>
                <td>⛔️</td><td>Error</td><td>${e[1]}</td><td>${e[2]}</td>
            </tr>`
        })
        const warningString = warnings.map(e => {
            return `<tr>
                <td>⚠️</td><td>Warning</td><td>${e[1]}</td><td>${e[2]}</td>
            </tr>`
        })
        const infoString = infos.map(e => {
            return `<tr>
                <td>ℹ️</td><td>Info</td><td>${e[1]}</td><td>${e[2]}</td>
            </tr>`
        })

        const issuesFound = arr.at(-1)

        let output = `⛔️ - Static analysis failed; ${issuesFound}</br>
        <details><summary>See details</summary>
        <table>
        <tr><th></th><th>Type</th><th>File name</th><th>Details</th></tr>
            ${errorString.join('')}
            ${warningString.join('')}
            ${infoString.join('')}
        </table>
        </details>
        `
        output = output.replace(/(\r\n|\n|\r)/gm, "");

        core.setOutput("analyze", output);
        core.setOutput("err", 'true');
        core.info('⛔️')
    }

}