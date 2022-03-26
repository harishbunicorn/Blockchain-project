// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

import "./Owned.sol";
import "./Logger.sol";
import "./IFaucet.sol";

contract Faucet is Owned, Logger, IFaucet {
    // storage variables
    // uint public funds = 1000;  //uint can have only positive values
    // int public counter = -10;  //int can have negative integers
    // uint32 public test = 4294967295;  //this is the max value we can keep.

    //this is a special function
    //its called when you make a tx that doesnt specify
    //function name to call

    uint256 public numOfFunders;
    mapping(address => bool) private funders;
    mapping(uint256 => address) private lutFunders;

    //modifier
    modifier limitWithdraw(uint256 withdrawAmount) {
        require(
            withdrawAmount <= 1000000000000000000,
            "Cannot withdraw more than 0.1 ether"
        ); //next line will only get executed when this condition is met
        _;
    }

    //External function are part of the contract interface
    //which means they can be called via contracts and other txs
    // address[] public funders;   //here we can use private or internal instead of public

    //private -> can  be accessible only within the smart contract
    //internal -> can be accessible within smart contract and also derived smart contract

    receive() external payable {}

    function emitLog() public pure override returns (bytes32) {
        return "Hello World";
    }

    function test1() external onlyOwner {
        //some managing stuff that only admin should have access to
    }

    function test2() external onlyOwner {
        //some managing stuff that only admin should have access to
    }

    function addFunds() external payable override {
        // funders.push(msg.sender);
        // uint index = numOfFunders++;
        address funder = msg.sender;
        test3();

        if (!funders[funder]) {
            uint256 index = numOfFunders++;
            funders[funder] = true;
            lutFunders[index] = funder;
        }
    }

    //modifiers are used when you need to use a piece of code of condition everywhere.

    function withdraw(uint256 withdrawAmount)
        external
        override
        limitWithdraw(withdrawAmount)
    {
        payable(msg.sender).transfer(withdrawAmount); //this function body represents _; in modifier.
    }

    // function getAllFunders() public view returns (address[] memory) {         //to get all funders call instance.getAllFunders()
    //     return funders;                                                          //to get specific instance.funders(0)
    // }

    function getAllFunders() external view returns (address[] memory) {
        address[] memory _funders = new address[](numOfFunders); //(numOfFunders) is for length of array.

        for (uint256 i = 0; i < numOfFunders; i++) {
            _funders[i] = lutFunders[i];
        }

        return _funders;
    }

    function getFunderAtIndex(uint256 index) external view returns (address) {
        // address[] memory _funders = getAllFunders();                            //to access the getAllFunders it has to be public not external
        // return _funders[index];
        return lutFunders[index];
    }
    // function justTesting() external pure returns (uint256) {
    //     return 2 + 2;
    // }

    //pure, view - read-only call, no gas fee
    //view - it indicates the function will not alter the storage state in any way
    //pure - even more strict, indicating that it wont even read the storage state

    // Transactions (can generate state changes) and require gas fee
    // read-only call, no gas free

    // to talk to the node on the network you can make JSON-RPC http calls
}

//Block info
// Nonce - a hash that when combine with the minHash proofs that that block has gone thhrough proof of work(POW)
// 8 bytes => 64 bits

// public vs external
// use public when u have to call function from both outside and inside of smart contract,
// we can use this.getAllFunders() and make it external, but it takes a lot of gas consumption.

//Memory
// |>
