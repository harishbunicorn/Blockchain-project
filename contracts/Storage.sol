// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

contract Storage {
    //keccak256(key . slot)
    mapping(uint => uint) public aa; //slot 0
    mapping(address => uint) public bb; //slot 1

    // keccak256(slot) + index of the item
    uint[] public cc; //slot 2    //this is dynamic array


    uint8 public a = 7;   //1byte
    uint16 public b = 10;  //2bytes
    address public c = 0xC4562F44F5AA09C5e58be46887070AA00baC6E7f; //20bytes
    bool d = true;  //1byte
    uint64 public e = 15;  //8bytes
    //32 bytes, all values will be stored in slot 3
     //                                                hex(2bytes)      hex of one byte                                                                    // address of deployed contract
    //0x 0f 01 c4562f44f5aa09c5e58be46887070aa00bac6e7f   000a           07  -> this is an o/p of this instance using web3.eth.getStorageAt("0xD61460668631721F77556945F563ae2141B7803C",0)
    //0x0f01c4562f44f5aa09c5e58be46887070aa00bac6e7f000a07                                                                                                                      //u can change above 0 to access different location
    uint256 public f = 200;  // 32bytes -> slot 4
    uint8 public g = 40;  // 1byte   (we can put this down and next declare some uints) ->slot-5
    uint256 public h = 789;  // 32bytes -> slot 6

    constructor() {
        cc.push(1);
        cc.push(10);
        cc.push(100);

        aa[2] = 4;  //below there is method to access this, same should be done for next line, just replace 2 with 3 and  gen hex from keccak256
        aa[3] = 10;

        bb[0xC4562F44F5AA09C5e58be46887070AA00baC6E7f] = 100;     //below u mention slot 1 by replacing 0 with 1 at the end,
    }
}

//in dynamic array we are keeping the size of the slot, here it is '0x03'

// 0x00000000000000000000000000000000000000000000000000000000000000020000000000000000000000000000000000000000000000000000000000000000
// 0x000000000000000000000000C4562F44F5AA09C5e58be46887070AA00baC6E7f0000000000000000000000000000000000000000000000000000000000000001
// the above first 32bytes is keeping key and the next 32 bytes is keeping slot value(i.e; 0)
// web3.eth.getStorageAt("0xC4562F44F5AA09C5e58be46887070AA00baC6E7f","0xabbb5caa7dda850e60932de0934eb1f9d0f59695050f761dc64e443e5030a569")

//storage can be called as Array of slots.
// [[],[],[],....],  (2^256-1->this is the total number of slots that can be allocated in the storage. 1 slot = 32 bytes
//  0 ,1 ,2 ....
// what is storage, how does that work, how values are stored, which database is used?


//why the storage is 2^256-1?

//for dynamic array
// 0x0000000000000000000000000000000000000000000000000000000000000002 // gen keccak for this for slot 2
// web3.eth.getStorageAt("0xC4562F44F5AA09C5e58be46887070AA00baC6E7f","0x405787fa12a823e0f2b7631cc41b3ba8828b3321ca811111fa75cd3aa3bb5ace") // this will return the value of first item in an array. '0x01' 
//405787fa12a823e0f2b7631cc41b3ba8828b3321ca811111fa75cd3aa3bb5ace convert to decimal
//29102676481673041902632991033461445430619272659676223336789171408008386403022 + 1
//29102676481673041902632991033461445430619272659676223336789171408008386403023, now convert to hex and use it to find the value of 2nd item in array. same process for 3rd
//29102676481673041902632991033461445430619272659676223336789171408008386403022 + 2
//29102676481673041902632991033461445430619272659676223336789171408008386403024