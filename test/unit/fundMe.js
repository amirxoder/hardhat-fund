const { assert } = require("chai");
const { deployments, ethers, getNamedAccounts } = require("hardhat");

describe("FundMe", () => {
  let fundMe;
  let mockV3Aggregator;
  let deployer;
  const sendValue = ethers.utils.parseEther("1");
  beforeEach(async () => {
    // const accounts = await ethers.getSigners();
    // deployer = accounts[0];
    deployer = (await getNamedAccounts()).deployer;
    await deployments.fixture(["all"]);
    fundMe = await ethers.getContract("FundMe", deployer);
    mockV3Aggregator = await ethers.getContract("MockV3Aggregator", deployer);
  });

  describe("construcotor", () => {
    it("sets ths aggregator addresses correctly", async () => {
      const response = await fundMe.priceFeed();
      assert.equal(response, mockV3Aggregator.address);
    });
  });
});
