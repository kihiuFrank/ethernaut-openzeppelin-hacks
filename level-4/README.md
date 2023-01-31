# Level 4: Fallout

This is the level 4 of Ethernaut

## Hack

Given contract:

```
Telephone.sol
```

`player` has to claim this contract's ownership.

We'll make an intermediate contract (named `TelephoneHack`) with the same method `changeOwner` on Remix. `TelephoneHack`'s `changeOwner` will simply call `Telephone` contract's `changeOwner`.

`player` will call `TelephoneHack` contract's `changeOwner`, which in turn will call `Telephone`'s `changeOwner` with `msg.sender` (which is `player`) as param. In that case `tx.origin` is `player` and `msg.sender` is `TelephoneHack`'s address. And since now `tx.origin` != `msg.sender`, `player` has claimed the ownership.

Go to remix, deplop the `TelephoneHack` contract, call changeOwner and pass the contract instance address as param.

Done.
