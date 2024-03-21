import React, { useState, useEffect } from 'react';
import './App.css';
import Web3 from 'web3';
import VotingContract from './contracts/Voting.json';

function App() {
  const [web3, setWeb3] = useState(null);
  const [accounts, setAccounts] = useState([]);
  const [contract, setContract] = useState(null);

  useEffect(() => {
    const loadBlockchainData = async () => {
      if (window.ethereum) {
        const web3 = new Web3(window.ethereum);
        await window.ethereum.enable();
        const accounts = await web3.eth.getAccounts();
        const networkId = await web3.eth.net.getId();
        const deployedNetwork = VotingContract.networks[networkId];
        const contract = new web3.eth.Contract(
          VotingContract.abi,
          deployedNetwork && deployedNetwork.address
        );
        setWeb3(web3);
        setAccounts(accounts);
        setContract(contract);
      } else {
        window.alert('Please install MetaMask extension!');
      }
    };
    loadBlockchainData();
  }, []);

  if (!web3) {
    return <div>Loading Web3, accounts, and contract...</div>;
  }

  return (
    <div className="App">
      <header className="App-header">
        <h1>Decentralized Voting DApp</h1>
        <p>Connected Account: {accounts[0]}</p>
      </header>
    </div>
  );
}

export default App;
