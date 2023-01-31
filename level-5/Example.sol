// SPDX-License-Identifier: GPL-3.0

// TOTO 0: define the license and compiler version to develop against
pragma solidity >=0.6.0 <0.9.0;

// (I've added the hardhat console library in order to be able to log to console in Remix).

// to be run on REMIX IDE so ignore the error
import "hardhat/console.sol";

contract Test {
    constructor() public {
        uint8 small = 0;
        small--;

        uint8 large = 255;
        large++;
        console.log(small); // prints 255
        console.log(large); // prints 0
    }
}
