import fs from "fs/promises";
import {abs} from "mathjs"

(async () => {
    let total = 0;
    let reading = 1;
    (await fs.readFile("./input.txt")).toString().match(/mul\(([0-9]{0,3}),([0-9]{0,3})\)|do\(\)|don\'t\(\)/g)
    .map((m) => {
        console.log(m)
        let mr = 1;
        let is_mul = 1
        m.match(/do\(\)/g)?.forEach((n)=>{
            is_mul -= 1
            reading -= (reading - 1)
            console.log("Reading",reading)
        })
        m.match(/don\'t\(\)/g)?.forEach((n)=>{
            is_mul -= 1
            reading -= (reading + 1)
            console.log("Reading",reading)
        })
        m.match(/[0-9]{1,3}/g)?.forEach((n) => {
            console.log((0.5 * (parseInt(n) + (reading * parseInt(n)) - 2)) + 1)
            mr *= (0.5 * (parseInt(n) + (reading * parseInt(n)) - 2)) + 1
        })
        console.log("o:",mr * is_mul)
        return mr * is_mul
    }).forEach((t) => { total += t })
    console.log("Result:",total);
})()