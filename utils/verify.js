const { run } = require("hardhat");

const verify = async (contractAddress, args) => {
  console.log("verifying contract...");
  try {
    await run("verify:verify", {
      address: contractAddress,
      constructorArguments: args,
    });
  } catch (err) {
    if (err.message.toLowerCase.includes("already verified!")) {
      console.log("Already Verify");
    } else {
      console.log(err);
    }
  }
};

module.exports = { verify };
