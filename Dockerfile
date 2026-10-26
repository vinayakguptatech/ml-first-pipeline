# Start with a lightweight python image
#This gives our container a python runtime
FROM python:3.14-slim

# Set the working directory inside the container
WORKDIR /app

#Copy the dependency list before copying application code
COPY requirements.txt .

#avoid retaining pip's downlaod cache in the image 
RUN pip install --nocache-dir -r requirements.txt

# Copy the application code and saved model into/app, first . source, second .  destination
COPY . . 

#Document the port used by FastAPI application
EXPOSE 8000

#start the API server when the container launches
#0.0.0.0 allows connections through the container's interface
CMD["unicorn", "main:app","--host","0.0.0.0","--port",8000]
