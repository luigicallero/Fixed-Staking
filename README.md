# Fixed Staking Smart Contract

This repository contains the `FixedStaking` smart contract, a simple implementation of a fixed staking mechanism using Solidity. The contract allows users to stake tokens, earn rewards over time, and withdraw their staked tokens along with any earned rewards.

## Overview

The `FixedStaking` contract is built using the Solidity programming language and leverages the OpenZeppelin ERC20 token standard. It is designed to facilitate fixed staking, where users can deposit tokens, accrue rewards based on the staking duration, and withdraw their staked tokens and rewards.

### Contract Details

- **Token Name**: Fixed Staking
- **Token Symbol**: FSTK
- **Solidity Version**: ^0.8.19
- **License**: MIT

## Features

- **Staking Deposit**: Users can deposit a specified amount of tokens into the staking contract.
- **Staking Withdrawal**: Users can withdraw a specified amount of their staked tokens along with any rewards.
- **Staking Harvest**: Users can claim their rewards without withdrawing their staked tokens. Rewards are calculated based on the duration of staking.

## Functions

### `stakingDeposit(uint amount)`

- **Description**: Allows users to deposit tokens into the staking contract.
- **Parameters**: 
  - `amount`: The amount of tokens to deposit.
- **Requirements**:
  - The `amount` must be greater than zero.
  - The user's balance must be sufficient to cover the deposit.

### `stakingWithdrawall(uint amount)`

- **Description**: Allows users to withdraw a specified amount of their staked tokens along with any accrued rewards.
- **Parameters**:
  - `amount`: The amount of staked tokens to withdraw.
- **Requirements**:
  - The `amount` must be greater than zero.
  - The user must have sufficient staked tokens to cover the withdrawal.

### `stakingHarvest() public returns (uint256)`

- **Description**: Allows users to claim their staking rewards without withdrawing their staked tokens.
- **Returns**:
  - `rewards`: The amount of rewards earned since the last staking action.
- **Requirements**:
  - The user must have tokens staked in the contract.

## How It Works

1. **Staking Deposit**: When a user deposits tokens using `stakingDeposit`, the tokens are transferred to the contract, and the user's staked balance is updated. If the user already has tokens staked, any rewards accrued up to that point are harvested automatically.

2. **Staking Withdrawal**: When a user withdraws tokens using `stakingWithdrawall`, any rewards accrued up to that point are harvested, and the specified amount of staked tokens is returned to the user.

3. **Staking Harvest**: Rewards are calculated based on the duration of staking (in seconds). The rewards formula is:
   ```
   rewards = stakedAmount * secondsStaked / 3.154e7
   ```
   This formula approximates a yearly reward distribution.

## Installation

1. Clone the repository:
   ```bash
   git clone https://github.com/luigicallero/Fixed-Staking.git
   cd Fixed-Staking
   ```

2. Install dependencies:
   ```bash
   forge install
   ```

3. Compile the contract:
   ```bash
   forge build
   ```

4. Run tests:
   ```bash
   forge test -vvv
   ```

## Disclaimer

**Security Notice**: This smart contract has not undergone any formal auditing or security checks. It is provided as-is, and the primary focus was on the mechanics of token rewards. Use it at your own risk.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Acknowledgments

- The contract is based on the tutorial from [James Bachini's website](https://jamesbachini.com/fixed-rate-staking/) with modifications and tests added by me.
- Special thanks to OpenZeppelin for their ERC20 implementation.

## Connect

Feel free to connect with me on [LinkedIn](https://www.linkedin.com/in/luisignaciocallero/) or check out my other projects on [GitHub](https://github.com/luigicallero).
```