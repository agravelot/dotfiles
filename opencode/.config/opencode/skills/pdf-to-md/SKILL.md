---
name: pdf-to-md
description: Convert PDF files to Markdown using the markitdown Docker image. Use when the user wants to convert a PDF to Markdown format.
---

## What I do
- Convert PDF files to Markdown format using the `markitdown` Docker image
- Preserve document structure and formatting as much as possible

## Usage
The user must first build the Docker image:
```bash
docker pull ghcr.io/anomalyco/markitdown:latest
# or build locally
docker build -t markitdown:latest .
```

Then use this command to convert:
```bash
docker run --rm -i markitdown:latest < /path/to/file.pdf > output.md
```

## When to use me
Use this when the user asks to convert a PDF file to Markdown.
