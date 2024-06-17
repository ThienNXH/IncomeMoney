# Stage 1: Build the application
FROM node:16 AS builder

# Set working directory
WORKDIR /app

# Copy package.json and package-lock.json
COPY package*.json ./

# Copy Prisma schema
COPY prisma ./prisma/

# Install dependencies
RUN npm install

# Copy the rest of the application code
COPY . .

# Build the application
RUN npm run build

# Stage 2: Run Prisma migrations
FROM node:16 AS migrator

# Set working directory
WORKDIR /app

# Copy necessary files from the builder stage
COPY --from=builder /app/node_modules ./node_modules
COPY --from=builder /app/package*.json ./
COPY --from=builder /app/prisma ./prisma
COPY --from=builder /app/dist ./dist

# Copy the .env file to set the DATABASE_URL
COPY .env .env

# Run Prisma migrations
RUN npx prisma generate

# Stage 3: Final stage to run the application
FROM node:16

# Set working directory
WORKDIR /app

# Copy necessary files from the migrator stage
COPY --from=migrator /app/node_modules ./node_modules
COPY --from=migrator /app/package*.json ./
COPY --from=migrator /app/dist ./dist

# Copy the .env file to set environment variables at runtime
COPY .env .env

# Expose the application port
EXPOSE 3000

# Start the application
CMD [ "npm", "run", "start:prod" ]
