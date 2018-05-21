module.exports = {
  solc: {
    optimizer: {
      enabled: true,
      runs: 200
    }
  },
  networks: {
    development: {
      host: "localhost",
      port: 8545,
      network_id: "*" // Match any network id
    },
    ropsten:  {
     network_id: 3,
     host: "localhost",
     port:  8545,
     gas: 4650004,
     from: "0xfe4bae1004c686a51e7b59c23feb8fb86cef7947"
     //from: "0x80ec244fbb53da9c9fb55eb382429df750023e8c"
    },
    ganache: {
      host: "localhost",
      port: 7545,
      network_id: "*", // Match any network id
      gas: 5650004,
      from: "0x627306090abaB3A6e1400e9345bC60c78a8BEf57"
    },
  },
   rpc: {
 host: 'localhost',
 post:8080
   }
};