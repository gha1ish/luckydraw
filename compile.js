const path = require("path");
const fs = require("fs");
const solc = require("solc");

const luckydrawPath = path.resolve(__dirname, "contracts", "Luckydraw.sol");
const source = fs.readFileSync(luckydrawPath, "utf8");

const input = {
  language: "Solidity",
  sources: {
    "Luckydraw.sol": {
      content: source,
    },
  },
  settings: {
    outputSelection: {
      "*": {
        "*": ["*"],
      },
    },
  },
};

const compiledContract = JSON.parse(solc.compile(JSON.stringify(input)));
const contract = compiledContract.contracts["Luckydraw.sol"]["Luckydraw"];

module.exports = {
  abi: contract.abi,
  evm: contract.evm,
};
