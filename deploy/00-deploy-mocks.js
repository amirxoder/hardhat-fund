const { network } = require("hardhat");
const {
  developmentChain,
  DECIMAL,
  INITIAL_ASNWER,
} = require("../helper-hardhat-config");

module.exports.default = async ({ getNamedAccounts, deployments }) => {
  const { deploy, log } = deployments;
  const { deployer } = await getNamedAccounts();
  if (developmentChain.includes(network.name)) {
    log("Local network detected! Deploying Mocks...");
    await deploy("MockV3Aggregator", {
      contract: "MockV3Aggregator",
      from: deployer,
      args: [DECIMAL, INITIAL_ASNWER],
      log: true,
    });
    log("Mocks Deployed!");
    log("___________________________________________________");
  }
};

module.exports.tags = ["all", "mocks"];
