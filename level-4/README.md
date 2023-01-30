## Hack

Given contract:

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

contract Telephone {

  address public owner;

  constructor() public {
    owner = msg.sender;
  }

  function changeOwner(address _owner) public {
    if (tx.origin != msg.sender) {
      owner = _owner;
    }
  }
}
```

`player` has to claim this contract's ownership.

We'll make an intermediate contract (named `IntermediateContract`) with the same method `changeOwner` (or anything else -- name doesn't matter) on Remix. `IntermediateContract`'s `changeOwner` will simply call `Telephone` contract's `changeOwner`.

`player` will call `IntermediateContract` contract's `changeOwner`, which in turn will call `Telephone`'s `changeOwner` with `msg.sender` (which is `player`) as param. In that case `tx.origin` is `player` and `msg.sender` is `IntermediateContract`'s address. And since now `tx.origin` != `msg.sender`, `player` has claimed the ownership.

Done.
