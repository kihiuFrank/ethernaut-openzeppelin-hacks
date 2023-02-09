# Level 6: Delegation

This is the level 6 of Ethernaut

## The Hack

Let's try to hack this level. If you read the explanation above you noticed that I failed at hacking the contract via remix, because that would set the owner of the Delegation contract to the address of the remix contract, not the address of our personal account in Ethernaut.

So that led me to look at other options of calling the pwn() function on the Delegation contract directly. The only option left was to use the web3 client library in the Ethernaut console. In order to call a method on a contract, we can use the the sendTransaction() method.

I was not too familiar with this method but after doing some digging in the docs, I found that we could pass in the ABI byte string of the function we'd like to call. Ok, so now we just needed to figure out how to get the byte string of the function. There are other methods (like doing this with web3 I suppose) but I opted to create a function in my remix contract to do just that. It looks like this:

```
Hack.sol
```

When you deploy the contract on Remix and call the getSig() method, you'll get the string you see above in the comments.

Now, we can call this method on our Delegation contract in the ethernaut console like so:

```
contract.sendTransaction({data: "0xdd365b8b"});
```

This will:

- try to call the pwn() function on the Delegation contract, which doesn't exist
- the fallback() method in Delegation will be called, calling pwn() in Delegate
- the pwn() method from Delegate will run as if it was running in Delegation
- that will set the owner of Delegation to the msg.sender, being the player address

Done.

## Security lessons learned

I actually learned a lot about what delegatecall() does exactly and how it works. This pattern is really handy if you want to create a Library structure where you have a contract that has code you can now reuse easily from other contracts by calling the method as if it was running right inside your own contract.

Of course that poses a risk, especially because the delegate contract has access to the full state or your contract. Here is an explanation of how this technique was used in a [30 million dollar hack](https://blog.openzeppelin.com/on-the-parity-wallet-multisig-hack-405a8c12e8f7/) of the Parity Wallet.

The combination of using delegatecall() in combination with fallback methods, is a dangerous one. It's better to only allow specific methods to be able to use delegatecall on a contract.
