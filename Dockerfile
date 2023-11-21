FROM cgr.dev/chainguard/python:latest-dev as builder
LABEL maintainer "LucasHsCarmo"
WORKDIR /giropops-senhas
COPY requirements.txt /giropops-senhas
RUN pip install --no-cache-dir -r requirements.txt
COPY . /giropops-senhas

FROM cgr.dev/chainguard/python:latest
WORKDIR /giropops-senhas
COPY --from=builder ./giropops-senhas/ ./
COPY --from=builder /home/nonroot/.local/lib/python3.12/site-packages /home/nonroot/.local/lib/python3.12/site-packages
ENTRYPOINT [ "python", "-m", "flask", "run", "--host=0.0.0.0" ]
