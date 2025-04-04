FROM python:3.10-slim

# Install dependencies
RUN apt-get update && apt-get install -y \
    nmap \
    exploitdb \
    git \
 && rm -rf /var/lib/apt/lists/*

# Setup ExploitDB
RUN mkdir -p /usr/share/exploitdb \
 && git clone https://github.com/offensive-security/exploitdb.git /usr/share/exploitdb \
 && ln -s /usr/share/exploitdb/searchsploit /usr/local/bin/searchsploit

WORKDIR /app
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt
COPY . .

# Create reports directory
RUN mkdir -p /app/reports

CMD ["python", "./scanner.py"]
