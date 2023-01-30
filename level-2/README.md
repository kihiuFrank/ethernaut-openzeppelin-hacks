# Level 2: Fallout

This is the level 2 of Ethernaut

## Hack

Given contract:

```
Fallout.sol
```

The `player` has to claim ownership of the contract.

Inspecting all the methods, it can be seen there isn't any method that switches the ownership of the contract. Only ownership logic is inside the constructor. But, constructors are called only once at the deployment time!

How? Something about constructor declaration looks unusual -- it "seems" to be defined with same name as the contract i.e. `Fallout` (it is NOT actually). Don't we use `constructor` keyword to declare constructors?

First of all - intended constructor declaration has typo, `Fal1out` instead of `Fallout`. So it is just treated as a normal method not a constructor. Hence we simply call it & claim ownership.

Secondly, even if it wasn't a typo, that is - constructor was declared as `Fallout`, it won't even compile!
Older versions of Solidity had this kind of constructor declaration. If you go through the [docs](https://docs.soliditylang.org/en/v0.8.10/050-breaking-changes.html#constructors) you'll find that `constructor` keyword was favored against contract name as constructor. It was mandated even in `v0.5.0` - _"Constructors must now be defined using the constructor keyword"_. And target contract uses `v0.6.0`.

Anyway, silly mistake.

```javascript
await contract.Fal1out();
```

And `player` has taken over as `owner`. Verify by:

```javascript
(await contract.owner()) === player;

// Output: true
```

Submit instance. Done.
