// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract FixedStaking is ERC20 {
    mapping(address => uint) public staked;
    mapping(address => uint) private stakedSince;
    
    constructor() ERC20("Fixed Staking", "FSTK") {
        _mint(msg.sender,1000000000000000000);
    }

    function stakingDeposit(uint amount) external {
        require(amount > 0, "amount is <= 0");
        require(balanceOf(msg.sender) >= amount, "balance is <= amount");
        _transfer(msg.sender, address(this), amount);
        if (staked[msg.sender] > 0) {
            stakingHarvest();
        }
        stakedSince[msg.sender] = block.timestamp;
        staked[msg.sender] += amount;
    }

    function stakingWithdrawall(uint amount) external {
        require(amount > 0, "amount is <= 0");
        require(staked[msg.sender] >= amount, "amount is > staked");
        stakingHarvest();
        staked[msg.sender] -= amount;
        _transfer(address(this), msg.sender, amount);
    }

    function stakingHarvest() public returns(uint256){
        require(staked[msg.sender] > 0, "staked is <= 0");
        uint secondsStaked = block.timestamp - stakedSince[msg.sender];
        uint rewards = staked[msg.sender] * secondsStaked / 3.154e7; // approx a year in seconds
        _mint(msg.sender,rewards);
        stakedSince[msg.sender] = block.timestamp;
        return rewards;
    }
}