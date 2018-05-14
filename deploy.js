const HDWalletProvider = require('truffle-hdwallet-provider');
const Web3 = require('web3');
const { interface, bytecode } = require('./compile');

const provider = new HDWalletProvider(
    'test raccoon cousin practice impose scatter tobacco embark recycle happy edit whale',
    'https://rinkeby.infura.io/BnRqltkAu1O4WXfrXhMN'
);
const web3 = new Web3(provider);