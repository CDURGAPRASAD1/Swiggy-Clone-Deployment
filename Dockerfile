FROM node:20.18.0-slim

WORKDIR /app

# Copy only package files first (better caching)
COPY package*.json ./

RUN npm install

# Copy remaining app files
COPY . .

# Build React app
RUN npm run build

# Install serve
RUN npm install -g serve

# Create non-root user (IMPORTANT)
RUN useradd -m appuser
USER appuser

EXPOSE 3000

CMD ["serve", "-s", "build", "-l", "3000"]
