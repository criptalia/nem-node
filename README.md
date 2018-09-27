NEM NODE (NIS) Docker
=========

To run for **mainnet**:

`docker run -d -p -p 7890:7890 -p 7778:7778 -v ./nem-node/mainnet:/root/nem --name nem-mainnet criptalia/nem-node`

To run **testnet**:

`docker run -e NEM_NETWORK=testnet -d -p 7890:7890 -p 7778:7778 -v ./nem-node/testnet:/root/nem --name nem-testnet criptalia/nem-node`

To run with `docker-compose`:

```yaml
---
version: '3'

services:

  nem-node:
    image: criptalia/nem-node
    volumes:
      - ./docker_nem_data:/root/nem
    environment:
      NEM_NETWORK: testnet
    ports:
      - '7890:7890'
      - '7778:7778'
```

### Environment variables

- `NEM_NETWORK` (default: mainnet) - Set to 'mainnet' to use the live network or 'testnet' for testing.
- `JAVA_OPTS` (default: -Xms512M -Xmx1G) - Java Virtual Machine optional parameters
