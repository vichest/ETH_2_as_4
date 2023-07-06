// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";

contract DegenToken is ERC20, Ownable,ERC20Burnable {
    address bank = 0xdD870fA1b7C4700F2BD7f44238821C26f7392148;  

    constructor() ERC20("Degen", "DGN") {}

        function mint(address to, uint256 amount) public onlyOwner {
            _mint(to, amount);
        }
        function decimals() override public pure returns (uint8) {
            return 0;
        }
        function getBalance() external view returns (uint256) {
            return this.balanceOf (msg. sender);
        }
        function transferTokens(address _receiver, uint256 _value) public  {
            require(msg.sender!=bank);
            require(balanceOf(msg .sender)>=_value,"You do not have enough Degen Tokens");
            approve(msg. sender,_value);
            transferFrom(msg.sender,_receiver,_value);
        }
        function StoreItem()public pure returns(string memory items)
        {
       
           return ( "a : gun ||\n b : sword \n||c : knife");
        }
        function RedeemToken(string memory choice)public payable 
        {
            
            if(keccak256(abi.encodePacked(choice))==(keccak256(abi.encodePacked('a'))))
            {
                transferTokens(bank, 200);
            }
            if(keccak256(abi.encodePacked(choice))==(keccak256(abi.encodePacked('b'))))
            {
                transferTokens(bank, 100);
            }
            if(keccak256(abi.encodePacked(choice))==(keccak256(abi.encodePacked('c'))))
            {
                transferTokens(bank, 50);
            }
        }
        
}
