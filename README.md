# Ballot Smart Contract

This is a simple ballot smart contract written in Solidity. The contract allows a chairperson to create proposals, authenticate voters, and allow voters to cast their votes. The contract can also determine the winning proposal(s).

## Features

- Chairperson can create proposals and authenticate voters.
- Voters can cast their votes.
- Determine the winning proposal(s).

## Getting Started

To use this contract, you will need a Solidity development environment such as Remix or Truffle.

### Prerequisites

- Solidity compiler version 0.7.0 to 0.9.0

### Using Remix IDE

1. Open [Remix IDE](https://remix.ethereum.org/).
2. Create a new file named `Ballot.sol`.
3. Copy and paste the contents of `Ballot.sol` into the newly created file.
4. Compile the contract by selecting the appropriate compiler version (0.7.0 to 0.9.0) in the Solidity compiler tab.
5. Deploy the contract:
   - Go to the "Deploy & Run Transactions" tab.
   - Select the `Ballot` contract from the dropdown.
   - In the "Deploy" section, input an array of proposal names (e.g., `["Proposal 1", "Proposal 2"]`).
   - Click the "Transact" button to deploy the contract.

### Deployment using Remix IDE

Deploy the contract by passing an array of proposal names to the constructor. Here is an example:

```solidity
string[] memory proposalNames = ["Proposal 1", "Proposal 2"];
Ballot ballot = new Ballot(proposalNames);
