/**
 * Copyright 2020 ChainSafe Systems
 * SPDX-License-Identifier: LGPL-3.0-only
 */

const Bridge = artifacts.require("Bridge");
const ERC20Handler = artifacts.require("ERC20Handler");

const domainID = 3;
const initialRelayers = ["0x632414bbF1C1DE108Aec3Ff3B716ace89e582063", "0xeA3AA95e4E7E71e554d6c1E4717bb17992d6d75a", "0x8Be27cE5308fc7935B0513c2d71a623588FD78e2", "0xB098F3A963D6E608460f2aDA8f533da9178D72F4"];
const initialRelayerThreshold = 2;
const fee = 0;
const expiry = 100;

const bridgeAddress = "0xaab127696990703c922ad4ccdd5838799e6ba265";

module.exports = function(deployer) {
  deployer.deploy(Bridge, domainID, initialRelayers, initialRelayerThreshold, fee, expiry);
  //deployer.deploy(ERC20Handler, bridgeAddress);
};
