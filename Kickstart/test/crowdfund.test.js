const assert = require('assert');
const ganache = require('ganache-cli');
const Web3 = require('web3');
const web3 = new Web3(ganache.provider());

const compiledFactory = require('../Ethereum/build/CrowdfundFactory.json');
const compiledCrowdfund = require('../Ethereum/build/Crowdfund.json');

let accounts;
let factory;
let crowdfundAddress;
let crowdfund;


beforeEach(async () => {
    accounts = await web3.eth.getAccounts();

    factory = await new web3.eth.Contract(JSON.parse(compiledFactory.interface))
        .deploy({ data: compiledFactory.bytecode })
        .send({ from: accounts[0], gas: 1000000 });

    await factory.methods.createCrowdfund('100').send({
        from: accounts[0],
        gas: '1000000'
    });

    [crowdfundAddress] = await factory.methods.getDeployedCrowdfunds().call();
    crowdfund = await new web3.eth.Contract(
        JSON.parse(compiledCrowdfund.interface),
        crowdfundAddress
    );
});


describe('Crowdfunds', () => {
    it('Deploys a factory and a crowdfund', () => {
        assert.ok(factory.options.address);
        assert.ok(crowdfund.options.address);
    });

    it('Marks caller as the crowdfund manager', async () => {
        const manager = await crowdfund.methods.manager().call();
        assert.equal(accounts[0], manager);   // manager account and accounts at 0 doesn't match
    });

    it('Allows people to contribute money and marks them as approvers', async () => {
        await crowdfund.methods.contribute().send({
            value: '200',
            from: accounts[1]
        });
        const isContributor = await crowdfund.methods.approvers(accounts[1]).call();
        assert(isContributor);
    });

    it('Requires a minimum contribution', async () => {
        try {
            await crowdfund.methods.contribute().send({
            value: '15',
        from: accounts[1]
        });
        assert(false);
        }
        catch (err) {
        assert(err);
        }
    });

    it('Allows a manager to make a payment request', async () => {
        await crowdfund.methods
            .createRequest('Buy batteries', '100', accounts[1])
            .send({
                from: accounts[0],
                gas: '1000000'
            });
        const request = await crowdfund.methods.requests(0).call();
        assert.equal('Buy batteries', request.description);
    });
});