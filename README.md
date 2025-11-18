# R & LaTeX Environment

This image lets you build R reports with Rnw / Rmd files without installing R, LaTeX or any other extra packages locally.

---

## Getting Started

### Prerequisites

You only need:

- Docker installed. [How to install docker](https://docs.docker.com/get-started/introduction/get-docker-desktop/)
- Your project folder (containing your Rnw/Rmd, data, etc.)

---

### Installation

1. Open your terminal and run `docker run hello-world` to test docker installation. If you see a "Hello from Docker!" message, you are good to go.

2. Open your terminal and navigate to your project directory where you have your files.

3. Run the container by typing

    ```bash
    docker run -it \
        --name tinytex \
        -v "$PWD":/home/project \
        agravlin/tinytex-lite-env:latest
    ```

    The `-v "$PWD":/home/project` part mounts your current directory into the container, so the container can read and write your files in this directory. This is normally safe and convenient. If you however want full isolation see [Optional: Extra Isolation](#optional-extra-isolation).

    The first run may take a few minutes to download the image.

4. Now you can build your files using the environment inside the container. You can try the followings:

    ```bash
    Rscript -e "knitr::knit('yourfile.Rnw')"
    latexmk -pdf yourfile.tex
    ```

- Or use the predefined alias for the command above

    ```bash
    knit yourfile.Rnw
    ```

- Or simply

    ```bash
    make
    ```

    If you have a `Makefile` available

The resulting `yourfile.pdf` will appear in your local project folder

---

## Troubleshooting

If you get an error like:

```r
Error in library(ggplot2): there is no package called 'ggplot2'
```

install the missing package inside the container:

```bash
Rscript -e "install.packages('ggplot2')"
```

If this is a package used in STA472 or is broadly useful, feel free to open an issue or a pull request to add it to the image.

For other problems, you can open an issue [here](https://github.com/Agravlin/tinytex-lite-env/issues/new). Pull requests are also very welcome :)

---

## Optional: Extra Isolation

If you prefer maximum isolation, you can start the container without mounting your folder:

```bash
docker run -it --name tinytex agravlin/tinytex-lite-env:latest
```

Then you need to copy files manually:

- From your machine to the container
`docker cp <path_to_your_file> tinytex:<path_to_your_file>`

- From the container to your machine
`docker cp tinytex:<path_to_your_file> <path_to_your_file>`
