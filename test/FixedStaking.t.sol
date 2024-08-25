// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.19;

import {Test, console} from "forge-std/Test.sol";
import {FixedStaking} from "../src/FixedStaking.sol";

contract ContractTest is Test {
    FixedStaking public fixedStaking;
    address private bob = address(0x1);
    address private mary = address(0x2);
// All parameters set up in the setUp function apply for all testXXXX functions
// test should start with "test"
    function setUp() public {
        fixedStaking = new FixedStaking();
        fixedStaking.transfer(bob,1000);
        fixedStaking.transfer(mary,1000);
    }

    function testSetUp() public {
        uint totalCoins = fixedStaking.totalSupply();
        assertEq(totalCoins, 1000000000000000000);
        emit log_string("1 ** 18 of Coins printed"); // "forge test -vvv" to see the logging
        assertEq(fixedStaking.balanceOf(bob),1000);
        assertEq(fixedStaking.balanceOf(mary),1000);
    }

    function testDeposit() public {
        uint amount = 1000;
        vm.startPrank(bob);
        fixedStaking.stakingDeposit(amount);
        assertEq(fixedStaking.staked(bob),1000); // Bob has 1k FSTK staked
        uint balance = fixedStaking.balanceOf(bob);
        assertEq(balance,0); // Bob has 0 FSTK in his account
    }

    function testClaim() public {
        uint amount = 1000;
        vm.startPrank(bob);
        fixedStaking.stakingDeposit(amount);
        skip(3600*12); // skipping 3600 seconds (1h) * 12 = 12hs
        uint rewards = fixedStaking.stakingHarvest();
        uint balance = fixedStaking.balanceOf(bob);
        assertEq(rewards,balance);
        console.log("Rewards harvested by Bob after 12hs is: %s FSTK",balance);
    }

    function testWithdrawall() public {
        uint amount = 1000;
        vm.startPrank(bob);
        uint origBalance = fixedStaking.balanceOf(bob);
        console.log("Bob original balance is: %s FSTK", origBalance);
        fixedStaking.stakingDeposit(amount);
        skip(3600*12); // skipping 3600 seconds (1h) * 12 = 12hs
        uint staked = fixedStaking.staked(bob);
        console.log("Bob's deposits in this contract is: %s FSTK",staked);
        fixedStaking.stakingWithdrawall(1000);
        uint balance = fixedStaking.balanceOf(bob);
        assertEq(balance,1001); // 1000 initially deposited + 1 harvested FSTK
        console.log("Bob widthdraws and new balance after 12hs is: %s FSTK",balance);
    }

    function testWrongWithdrawal() public {
        vm.startPrank(mary);
        vm.expectRevert();
        fixedStaking.stakingWithdrawall(1000);
        uint staked = fixedStaking.staked(mary);
        console.log("Mary's deposits in this contract is: %s FSTK. Nothing for Mary to withdraw",staked);
    }
}
