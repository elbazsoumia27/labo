# Stage 1 — Build
FROM node:18-alpine AS builder
WORKDIR /app
COPY . .
RUN npm install --omit=dev 2>/dev/null || true

# Stage 2 — Serve
FROM nginx:alpine
WORKDIR /usr/share/nginx/html
COPY --from=builder /app /usr/share/nginx/html

# Expose port
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]