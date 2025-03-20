# Use the official Node.js image as the base image
FROM node:20.4

# Set the working directory in the container
WORKDIR /app
# 将时区设置为上海（中国标准时间，CST，UTC+8）
ENV TZ=Asia/Shanghai
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
# 设置环境变量
ENV PORT=7860
ENV xmlPlot=false
ENV padtxt=0
ENV ClearFlags=false
ENV FullColon=false
ENV LogMessages=false
ENV PassParams=false
ENV PreventImperson=false
ENV PromptExperiments=false
ENV SystemExperiments=false
COPY package*.json ./

# Install the dependencies
RUN npm install --no-audit --fund false

# Copy the rest of the files to the container
COPY . .

# Change ownership of files in lib/bin and set permissions
RUN chown -R node:node lib/bin/* && \
    chmod u+x lib/bin/* && \
    chmod -R 777 /app

# Run as the "node" user for better security practices
USER node

RUN ls -la

# Start the application
CMD ["node", "clewd.js"]
