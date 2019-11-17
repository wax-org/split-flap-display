'use strict';

const chai = require('chai');
const expect = chai.expect;
const assertArrays = require('chai-arrays');
const timetable = require('../timetable').timetable;
chai.use(assertArrays);

describe('timetable', function () {

    it('transforms CAT into DOG', function () {
        const res = flap("CAT", [1, 13, 27]);
        return expect(res).to.be.equalTo("DOG");
    });

    it('calculate rotation from CAT to DOG', function () {
        const res = calcRotations("CAT", "DOG");
        return expect(res).to.be.equalTo([1, 13, 27]);
    });

    it('transforms TEL-AVIV into FUERTEVENTURA', function () {
        const res = flap(
            "PS 0779   18:55    TEL-AVIV         B7    ON TIME",
            [7, 52, 49, 33, 47, 0, 52, 30, 0, 0, 0, 52, 2, 51, 52, 5, 0, 0, 0, 40, 30, 31, 38, 42, 18, 30, 24, 4, 6, 1, 51, 37, 26, 0, 0, 0, 53, 49, 6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]);
        return expect(res).to.be.equalTo("WX XXXX   16:20    FUERTEVENTURA    A1    ON TIME");
    });

    it('calculate rotation from TEL-AVIV into FUERTEVENTURA', function () {
        const res = calculate(
            "PS 0779   18:55    TEL-AVIV         B7    ON TIME",
            "WX XXXX   16:20    FUERTEVENTURA    A1    ON TIME"
            );
        return expect(res).to.be.equalTo([7, 52, 49, 33, 47, 0, 52, 30, 0, 0, 0, 52, 2, 51, 52, 5, 0, 0, 0, 40, 30, 31, 38, 42, 18, 30, 24, 4, 6, 1, 51, 37, 26, 0, 0, 0, 53, 49, 6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]);
    });

});
