# 使用官方Node.js镜像作为基础镜像
FROM node:20.4

# 设置容器的工作目录
WORKDIR /app

# 将时区设置为上海（中国标准时间，CST，UTC+8）
ENV TZ=Asia/Shanghai
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
COPY . .
RUN sed -i -E '/res\.write\(`<!DOCTYPE html>.*<\/html>`\);/d' /app/clewd.js

# 安装依赖
RUN npm install --no-audit --fund false

# 更改lib/bin目录中文件的所有权并设置权限
RUN chown -R node:node lib/bin/* && \
    chmod u+x lib/bin/* && \
    chmod -R 777 /app

# 以"node"用户运行，以提高安全性
USER node

RUN ls -la

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

EXPOSE 7860

# 启动应用程序
CMD ["node", "clewd.js"]
