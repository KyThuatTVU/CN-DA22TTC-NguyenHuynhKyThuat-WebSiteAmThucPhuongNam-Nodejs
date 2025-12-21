# Dockerfile cho Backend Node.js
FROM node:18-alpine

WORKDIR /app

# Copy package files
COPY backend/package*.json ./backend/

# Install dependencies
WORKDIR /app/backend
RUN npm ci --only=production

# Copy backend source code
COPY backend/ ./

# Copy frontend files (cùng cấp với backend như cấu trúc gốc)
WORKDIR /app
COPY frontend/ ./frontend/

# Expose port
EXPOSE 3000

# Start server
WORKDIR /app/backend
CMD ["node", "server.js"]
