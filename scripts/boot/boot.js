/*
 * File: boot.ps1
 * Author: Wendel Hammes
 * License: GPL-3.0
*/

console.clear();

const {exec} = require('child_process');

exec('cd ../../ && node .', (error, stdout, stderr) => {
  if (error) {
    console.log(`[ERROR]: ${error.message}`);
    return;
  }
  if (stderr) {
    console.log(`[STDERR]: ${stderr}`);
    return;
  }
  console.log(`${stdout}`);
});