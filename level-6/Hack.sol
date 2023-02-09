// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "hardhat/console.sol";

contract Hack {
    function getsig() public pure returns (bytes memory) {
        return abi.encodeWithSignature("pwn()"); // returns "0xdd365b8b"
    }
}
