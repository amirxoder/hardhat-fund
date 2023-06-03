const networkConfig = {
  11155111: {
    name: "sepolia",
    ethUsdPriceFeedAddress: "0x694aa1769357215de4fac081bf1f309adc325306",
  },
  5: {
    name: "goerli",
    ethUsdPriceFeedAddress: "0xD4a33860578De61DBAbDc8BFdb98FD742fA7028e",
  },
};

const developmentChain = ["hardhat", "localhost"];
const DECIMAL = 8;
const INITIAL_ASNWER = 200000000000;

module.exports = {
  networkConfig,
  developmentChain,
  DECIMAL,
  INITIAL_ASNWER,
};
