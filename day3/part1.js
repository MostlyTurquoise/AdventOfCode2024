import fs from "fs/promises";

(async () => {
    let total = 0;
    (await fs.readFile("./input.txt"))
        .toString()
        .match(/mul\(([0-9]{0,3}),([0-9]{0,3})\)/g)
        .map((m) => {
            let mr = 1;
            m.match(/[0-9]{1,3}/g).forEach((n) => {
                mr *= n
            })
            return mr
        }).forEach((t) => { total += t })
    console.log(total);
})()