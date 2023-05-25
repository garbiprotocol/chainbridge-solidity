/**
 * Copyright 2020 ChainSafe Systems
 * SPDX-License-Identifier: LGPL-3.0-only
 */

const GarbiBridge = artifacts.require("GarbiBridge");
const ERC20Handler = artifacts.require("ERC20Handler");

const domainID = 42170;
const initialRelayers = ["0x632414bbF1C1DE108Aec3Ff3B716ace89e582063", "0xeA3AA95e4E7E71e554d6c1E4717bb17992d6d75a", "0xc1Ad8A92e248a89Ee47b1705D9bfCD4798c97b4a"];
const initialRelayerThreshold = 1;
const fee = ""+3*10**18;
const expiry = 100;

const bridgeAddress = "0x0e99bb96880ed959324615d0e9cd05ec7f7eb004";
const GRB = "0x90f72cc2bdfaf3ab5ac61a7f7b6759e25b844f1a";

module.exports = function(deployer) {
  //deployer.deploy(GarbiBridge, domainID, initialRelayers, initialRelayerThreshold, fee, expiry, GRB);
  deployer.deploy(ERC20Handler, bridgeAddress);
};
