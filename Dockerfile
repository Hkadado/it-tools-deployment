# build stage
FROM node:22-alpine AS builder

WORKDIR /app

RUN corepack enable

COPY app/package.json app/pnpm-lock.yaml ./
RUN pnpm install --frozen-lockfile

COPY app/ .
RUN pnpm build

# runtime stage
FROM node:22-alpine AS runtime

WORKDIR /app

RUN corepack enable

COPY app/package.json app/pnpm-lock.yaml ./
RUN pnpm install --prod --frozen-lockfile

COPY --from=builder /app/dist ./dist
COPY --from=builder /app/server.js ./server.js

ENV PORT=8080

EXPOSE 8080

USER node

CMD ["node", "server.js"]