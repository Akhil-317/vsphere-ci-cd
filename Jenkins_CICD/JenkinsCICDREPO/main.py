from fastapi import FastAPI
from fastapi.responses import JSONResponse
from prometheus_fastapi_instrumentator import Instrumentator

app = FastAPI()

Instrumentator().instrument(app).expose(app)

@app.get("/")
def read_root():
    return {"message": "Hello, Welcome to Jenkins, CI/CD pipeline"}

@app.get("/health")
def health_check():
    return JSONResponse(status_code=200, content={"status": "ok"})
