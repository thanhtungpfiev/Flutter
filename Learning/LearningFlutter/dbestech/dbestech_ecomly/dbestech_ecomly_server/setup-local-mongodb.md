# Local MongoDB Setup Guide

## Option 1: Install MongoDB Community Server (Recommended)

### For Windows:
1. Download MongoDB Community Server from: https://www.mongodb.com/try/download/community
2. Run the installer and follow the setup wizard
3. Make sure to install MongoDB as a Windows Service
4. MongoDB will start automatically after installation

### Quick Installation with Chocolatey (Windows):
```powershell
# Install Chocolatey if you don't have it
# Then install MongoDB
choco install mongodb

# Start MongoDB service
net start MongoDB
```

### Quick Installation with Winget (Windows):
```powershell
winget install MongoDB.Server
```

## Option 2: Docker (Cross-platform)

### Install and run MongoDB with Docker:
```bash
# Pull MongoDB image
docker pull mongo:latest

# Run MongoDB container
docker run -d --name mongodb-local -p 27017:27017 mongo:latest

# To stop: docker stop mongodb-local
# To start: docker start mongodb-local
```

## Option 3: MongoDB Atlas Local (MongoDB Compass)

1. Download MongoDB Compass: https://www.mongodb.com/products/compass
2. Install and use the built-in local instance feature

## Verify Installation

### Check if MongoDB is running:
```powershell
# Check if MongoDB service is running
Get-Service -Name MongoDB

# Or check if port 27017 is listening
netstat -an | findstr :27017
```

### Test connection with MongoDB Shell:
```bash
# Connect to local MongoDB
mongosh mongodb://localhost:27017

# In the MongoDB shell:
show dbs
use ecomly_local
db.test.insertOne({message: "Hello MongoDB!"})
db.test.find()
```

## Switch Between Local and Cloud

### Use Local MongoDB:
In your `.env` file, set:
```
MONGO_ENV=local
```

### Use MongoDB Atlas (Cloud):
In your `.env` file, set:
```
MONGO_ENV=cloud
```

### Enable Proxy for Cloud (if needed):
Uncomment and configure proxy settings in `.env`:
```
HTTP_PROXY=http://your-proxy-server:port
HTTPS_PROXY=http://your-proxy-server:port
```

## Troubleshooting

### MongoDB Service Issues:
```powershell
# Start MongoDB service
net start MongoDB

# Stop MongoDB service
net stop MongoDB

# Restart MongoDB service
net stop MongoDB && net start MongoDB
```

### Port Issues:
- Default MongoDB port is 27017
- Make sure no other service is using this port
- Check Windows Firewall settings if needed

### Connection String Format:
- Local: `mongodb://localhost:27017/database_name`
- Cloud: `mongodb+srv://username:password@cluster.mongodb.net/database_name`