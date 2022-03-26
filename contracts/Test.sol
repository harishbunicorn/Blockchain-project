// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

contract Test {
    function test(uint testNum) external pure returns(uint) {
        assembly{       // lower level code
            let _num := 4
            let _fmp := mload(0x40)   //fmp = free memory pointer
        }
        return testNum;
        // assembly {
            // data := mload(add(0x90, 0x20))
        // }
    }
}
 