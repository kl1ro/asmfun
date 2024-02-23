const {readdirSync} = require("fs")
const {execSync} = require("child_process")
readdirSync("16").forEach(f => execSync(`mv 16/${f}/main.asm 16/${f}.asm; rm 16/${f} -r`))
