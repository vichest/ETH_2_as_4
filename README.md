# ETH_2_as_4
Sure! Here's the README file for your Solidity contract:

```
# DegenToken

DegenToken is an ERC20 token contract that allows users to mint, transfer, and burn tokens. It also provides functionality for redeeming tokens for different items.

## SPDX-License-Identifier

MIT

## Prerequisites

- Solidity ^0.8.18
- OpenZeppelin Contracts v4.3.0

## Getting Started

1. Clone the repository: `git clone https://github.com/your-repo.git`
2. Install the dependencies: `npm install`
3. Compile the contract: `npx hardhat compile`
4. Deploy the contract to a network of your choice: `npx hardhat run scripts/deploy.js --network <network>`
5. Interact with the contract using the provided functions.

## Contract Overview

The `DegenToken` contract is inherited from `ERC20`, `Ownable`, and `ERC20Burnable` contracts. It provides the following functionalities:

- `mint`: Allows the contract owner to mint new tokens and assign them to a specific address.
- `getBalance`: Retrieves the token balance of the caller.
- `transferTokens`: Transfers tokens from the caller's address to a specified receiver, with additional checks to prevent transfers from the `bank` address.
- `StoreItem`: Returns a list of available items for redemption.
- `RedeemToken`: Allows users to redeem tokens for specific items by providing a choice parameter.

## Usage

### Minting Tokens

To mint new tokens, call the `mint` function with the address and amount of tokens to be minted. Only the contract owner can perform this action.

```solidity
function mint(address to, uint256 amount) public onlyOwner {
    _mint(to, amount);
}
```

### Checking Token Balance

To check the token balance of an address, call the `getBalance` function with the desired address. This function returns the balance as a `uint256` value.

```solidity
function getBalance() external view returns (uint256) {
    return this.balanceOf(msg.sender);
}
```

### Transferring Tokens

To transfer tokens to another address, call the `transferTokens` function with the receiver's address and the amount of tokens to be transferred. This function performs additional checks to prevent transfers from the `bank` address and verifies if the sender has enough tokens.

```solidity
function transferTokens(address _receiver, uint256 _value) public {
    require(msg.sender != bank);
    require(balanceOf(msg.sender) >= _value, "You do not have enough Degen Tokens");
    approve(msg.sender, _value);
    transferFrom(msg.sender, _receiver, _value);
}
```

### Storing Item Choices

The `StoreItem` function returns a string representing a list of available items for redemption.

```solidity
function StoreItem() public pure returns (string memory items) {
    return "a : gun ||\n b : sword \n||c : knife";
}
```

### Redeeming Tokens

To redeem tokens for an item, call the `RedeemToken` function with the desired choice parameter. The function accepts strings 'a', 'b', or 'c' as choices and transfers a specific amount of tokens to the `bank` address.

```solidity
function RedeemToken(string memory choice) public payable {
    if (keccak256(abi.encodePacked(choice)) == (keccak256(abi.encodePacked('a')))) {
        transferTokens(bank, 200);
    }
    if (keccak256(abi.encodePacked(choice)) == (keccak256(abi.encodePacked('b')))) {
