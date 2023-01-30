# Level 3: Coin Flip

This is the level 3 of Ethernaut

## Hack

Given contract:

```
Coinflip.sol
```

Basically, we need to predict outcome of coin flip correctly 10 times in a row to win.

The contract given tries to simulate random coin flip by generating `true` or `false` using the block number of network (Goerli in our case). But this is not actually really random! You can very easily query the network to see the current block number.

Turns out random number generation is one of the serious pitfalls of blockchains due to deterministic nature. That's why there are dedicated services for the purpose like [Chainlink VRF](https://blog.chain.link/random-number-generation-solidity/).

Since this block number can be easily accessible, we can also generate the result of coin flip and feed this result to `flip` function to have a correct guess and increment `consecutiveWins`. We are able to do this because block time of the network will be long enough so that `block.number` doesn't change between function calls.

We'll write a solidity contract (on Remix IDE) with almost same coin-flip generation code `CoinFlipGuess` & call the `flip` of given `CoinFlip` contract at deployed instance address, with already determined result of flip:

```
CoinFlipGuess.sol
```

I'm keeping track of `consecutiveWins` in `CoinFlipGuess` too and returning it from `coinFlipGuess`, just so that I can see it increasing.

Remember to deploy the above contract on Goerli network because the target - `CoinFlip` is on Goerli too.

Get the instance address of give `CoinFlip` instance, so that we can give it to `coinFlipGuess` as param:

```javascript
contract.address();

// Output: <your-instance-address>
```

Now, simply call `coinFlipGuess` method (on Remix) with `<your-instance-address>` as only parameter, 10 times with successful transaction.

Go back to console and query `consecutiveWins` from `CoinFlip` instance:

```javascript
await contract.consecutiveWins().then((v) => v.toString());

// Output: '10'
```

You may be tempted to run a loop to call `coinFlipGuess` 10 times automatically, but it won't work because of the guard `if` statement in `CoinFlip`:

```

if (lastHash == blockValue) {
   revert();
}
```

The invocation will revert if block number was same as in previous invocation. Since `lastHash` / `blockValue` is derived from `block.number`.

Game rigged successfully.
