require("@nomiclabs/hardhat-etherscan");
require("@nomiclabs/hardhat-truffle5");
require("@nomiclabs/hardhat-waffle");
require('dotenv').config();
require("@nomiclabs/hardhat-ethers");
require("hardhat-gas-reporter");
require('hardhat-contract-sizer');
require('solidity-coverage');

module.exports = {
  solidity: {
       version: "0.8.9",
       settings: {
           optimizer: {
               enabled: true,
               runs: 1500
           },
       },
  },
  defaultNetwork: "hardhat",
  networks: {
    hardhat: {
      blockGasLimit: 1000000000000000,
      gasPrice: 0.01,
      timeout: 1000000000000000
    }
  }
}