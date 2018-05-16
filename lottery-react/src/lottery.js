import web3 from './web3';

const address = '0xe7BCC15d89855657cd98e6f2574933B2ec9Dba68';

const abi = [{"constant":false,"inputs":[],"name":"Enter","outputs":[],"payable":true,
"stateMutability":"payable","type":"function"},{"constant":true,"inputs":[],
"name":"manager","outputs":[{"name":"","type":"address"}],"payable":false,
"stateMutability":"view","type":"function"},{"constant":false,"inputs":[],"name":"pickWinner",
"outputs":[],"payable":false,"stateMutability":"nonpayable","type":"function"},
{"constant":true,"inputs":[],"name":"Random","outputs":[{"name":"","type":"uint256"
}],"payable":false,"stateMutability":"view","type":"function"},{"constant":true,
"inputs":[],"name":"getPlayers","outputs":[{"name":"","type":"address[]"}],
"payable":false,"stateMutability":"view","type":"function"},{"constant":true,"inputs"
:[{"name":"","type":"uint256"}],"name":"players","outputs":[{"name":"","type":
"address"}],"payable":false,"stateMutability":"view","type":"function"},{"inputs":
[],"payable":false,"stateMutability":"nonpayable","type":"constructor"}];


export default new web3.eth.Contract(abi, address);
